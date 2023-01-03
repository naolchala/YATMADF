// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testone/mixins/constants.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Navbar(title: "Notification"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Mark all as read",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: kPadding / 2),
                  child: Column(
                    children: [
                      notificationTile(
                        title: "Rate us on google play",
                        hour: 1,
                        icon: Icons.star_rounded,
                      ),
                      notificationTile(
                        title: "Your project is successfully completed",
                        hour: 2,
                        icon: Icons.check_circle_sharp,
                        color: kPrimary,
                      ),
                      notificationTile(
                        title:
                            "Your grocery app design on scheduled on 20 Feb 2022",
                        hour: 2,
                        icon: Icons.alarm,
                        color: Colors.indigo,
                      ),
                      notificationTile(
                        title: "Your payment process & booking is completed",
                        hour: 1,
                        icon: Icons.payment,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: kPadding / 2),
                  child: Text(
                    "Yesterday",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: kPadding / 2),
                  child: Column(
                    children: [
                      notificationTile(
                        title: "Your visiting location is successful changed.",
                        hour: 25,
                        icon: Icons.location_on,
                        color: Colors.cyan,
                      ),
                      notificationTile(
                        title: "You have canceled your project",
                        hour: 2,
                        icon: Icons.cancel,
                        color: Colors.indigoAccent,
                      ),
                      notificationTile(
                        title:
                            "Your grocery app design on scheduled on 20 Feb 2022",
                        hour: 2,
                        icon: Icons.alarm,
                        color: Colors.indigo,
                      ),
                      notificationTile(
                        title: "Your payment process & booking is completed",
                        hour: 1,
                        icon: Icons.payment,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationTile({
    required String title,
    required int hour,
    required IconData icon,
    Color color = kSecondary,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: kPadding * 1.5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(kPadding / 2),
            margin: const EdgeInsets.only(right: kPadding),
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(kPadding / 2),
            ),
            child: Icon(
              icon,
              size: kPadding * 1.5,
              color: color,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: kPadding / 6,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  "$hour hour ago",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Navbar extends HookConsumerWidget {
  const Navbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kPadding),
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            left: 0,
            child: Container(
              height: 60,
              width: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kPadding),
              ),
              child: Image.asset(
                "assets/user.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
