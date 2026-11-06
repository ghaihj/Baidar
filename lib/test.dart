// import 'package:baider_app/bloc/plants%20detalis/plant_details_cubit.dart';
// import 'package:baider_app/core/constant/app_colors.dart';
// import 'package:baider_app/data/datasource/remote/favourite_data.dart';
// import 'package:baider_app/di/injection.dart';
// import 'package:baider_app/view/widget/plant_details/plant_details_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Test page')),
//       body: Container(
//         decoration: BoxDecoration(color: AppColors.primarycolor),
//         child: MaterialButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               builder: (sheetContext) => BlocProvider(
//                 create: (_) => PlantDetailsCubit(
//                   getIt<FavoriteData>(),
//                   state.plants[index], // ← النبتة المضغوطة
//                 )..loadDetails(),
//                 child: const PlantDetailsSheet(),
//               ),
//             );
//           },
//           child: Text("move to cards"),
//         ),
//       ),
//     );
//   }
// }
