import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/routing/routes.dart';

import '../widgets/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 134,
              width: 134,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(80),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/start.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Shoppe",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 52, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 18),
            Text(
              "Beautiful eCommerce UI Kit\nfor your online store",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 100),
            CustomButton(
              text: "Let's get started",
              onPressed: () {
               context.pushReplacementNamed(Routes.registerScreen);
              },
            ),
            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I already have an account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),

                IconButton(
                  onPressed: () {
                   context.pushNamed(Routes.loginScreen);
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_rounded,
                    color: Color(0xff004CFF),
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
