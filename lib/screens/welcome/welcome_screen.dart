import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OnBoardingScreen(
      onSkip: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('step', 1);
        Navigator.pushReplacementNamed(context, '/login'); //ปิดปุ่ม back
      },
      showPrevNextButton: true,
      showIndicator: true,
      backgourndColor: Colors.white,
      activeDotColor: Colors.blue,
      deactiveDotColor: Colors.grey,
      iconColor: Colors.black,
      leftIcon: Icons.arrow_circle_left_rounded,
      rightIcon: Icons.arrow_circle_right_rounded,
      iconSize: 30,
      pages: [
        OnBoardingModel(
          image: Image.asset("assets/images/leadership-pana.png"),
          title: "Business Chat",
          body:
              "First impressions are everything in business, even in chat service. It’s important to show professionalism and courtesy from the start",
        ),
        // OnBoardingModel(
        //   image: Image.asset("assets/images/landing-img-2.png"),
        //   title: "Coffee With Friends",
        //   body:
        //       "When your morning starts with a cup of coffee and you are used to survive the day with the same, then all your Instagram stories and snapchat streaks would stay filled up with coffee pictures",
        // ),
        OnBoardingModel(
          image: Column(
            children: [
              Image.asset("assets/images/landing-img.png"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt('step', 1);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 20.0),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
          title: "",
          body: "",
        ),
        // OnBoardingModel(
        //   image: Image.asset("assets/images/landing-img.png"),
        //   title: "Content Team",
        //   body: "No two content marketing teams look the same.",
        // ),
      ],
    );
  }
}
