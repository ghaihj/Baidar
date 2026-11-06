import 'package:baider_app/bloc/home/homecubit.dart';
import 'package:baider_app/bloc/home/homestate.dart';
import 'package:baider_app/bloc/settings/locale_cubit.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:baider_app/view/widget/home/catergorisecard.dart';
import 'package:baider_app/view/widget/home/coustombuildHeader.dart';
import 'package:baider_app/view/widget/home/coustombuildbanner.dart';
import 'package:baider_app/view/widget/home/coustombuildsearchbox.dart';
import 'package:baider_app/view/widget/home/coustombuildsectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // تحميل الفئات أول ما تفتح الصفحة
    context.read<HomeCubit>().loadCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is HomeLoaded) {
                final loadedState = state as HomeLoaded;
                // ✅ فلترة الفئات حسب الاسم
                final filteredCategories = loadedState.categories.where((
                  category,
                ) {
                  final name = category.getLocalizedName(locale).toLowerCase();
                  return name.contains(_searchQuery.toLowerCase());
                }).toList();
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: CoustombuildHeader()),
                    SliverToBoxAdapter(child: CustomBuildBanner()),
                    SliverToBoxAdapter(
                      child: CustomBuildSearchBox(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            // لو فاضي، ارجع جيب كل الفئات
                            context.read<HomeCubit>().loadCategories();
                          } else {
                            // لو فيه قيمة، ابحث بالباك
                            context.read<HomeCubit>().searchCategories(value);
                          }
                        },
                      ),
                    ),
                    SliverToBoxAdapter(child: Coustombuildsectiontitle()),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.0,
                            ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => CategoryCard(
                            categoryModel:
                                filteredCategories[index], // ← filtered
                            locale: locale,
                            onTap: () {
                              context.push(
                                '${AppRoute.plants}?category_id=${loadedState.categories[index].id}',
                                extra: loadedState.categories[index],
                              );
                            },
                          ),
                          childCount:
                              filteredCategories.length, // ← filtered count
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
