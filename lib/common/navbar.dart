import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testone/mixins/constants.dart';

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
              style: const TextStyle(
                color: kDarkBg,
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
