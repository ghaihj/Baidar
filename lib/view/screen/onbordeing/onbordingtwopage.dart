import 'package:baider_app/core/constant/app_images.dart';
import 'package:baider_app/core/constant/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onbordingtwopage extends StatelessWidget {
  const Onbordingtwopage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(AppImages.onbordingtwo, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 24,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  context.go(AppRoute.chooselanguage);
                },
                child: Text(
                  "skip",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 60,
              child: Column(
                children: [
                  Text(
                    "A smart mind ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " managing your land",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
