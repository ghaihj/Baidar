import 'package:baider_app/core/constant/app_colors.dart';
import 'package:baider_app/core/constant/app_images.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primarycolor,
              child: Image.asset(AppImages.logo),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  context.go(AppRoute.onbordingtwo);
                },
                child: Text(
                  "skip",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
