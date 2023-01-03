// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testone/main.dart';
import 'package:testone/mixins/constants.dart';
import 'package:testone/screens/home.dart';

class IntroScreen extends HookConsumerWidget {
  const IntroScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              buildImage(size),
              Container(
                padding: const EdgeInsets.symmetric(vertical: kPadding),
                child: Column(
                  children: [
                    const Text(
                      "Manage Your Task",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: kPadding / 2,
                        horizontal: kPadding,
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    startButton(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container startButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kPadding * 3),
      child: Ink(
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(kPadding),
          boxShadow: [
            BoxShadow(
              blurRadius: 40,
              color: kPrimaryLight.withAlpha(150),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppWithBottomNavbar(),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding * 3,
              vertical: kPadding,
            ),
            child: Text(
              "Let's Start",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildImage(Size size) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: size.width * 0.9,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 54,
                      color: kPrimaryLight.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 54,
                      color: kPrimaryLight.withAlpha(50),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                "assets/intro.svg",
                width: size.width * 0.8,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: kPadding * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                drawDot(),
                drawDot(),
                drawDot(primary: true),
                drawDot(),
                drawDot()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container drawDot({bool primary = false}) {
    var size = primary ? kPadding / 2 : kPadding / 3;
    var color = primary ? kPrimary : Colors.grey.shade200;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.7),
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}
