import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testone/mixins/constants.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                profile(),
                Container(
                  margin: const EdgeInsets.only(top: kPadding),
                  child: Column(children: [
                    settingTile(
                      title: "User Details",
                      icon: Icons.person_rounded,
                    ),
                    settingTile(
                      title: "Help & Support",
                      icon: Icons.help_center_rounded,
                      color: kPrimary,
                    ),
                    settingTile(
                      title: "User Agreement",
                      icon: Icons.notes_rounded,
                      color: Colors.indigo,
                    ),
                    settingTile(
                      title: "Settings",
                      icon: Icons.settings,
                      color: kSecondaryAccent,
                    ),
                    settingTile(
                      title: "Logout",
                      icon: Icons.logout,
                      color: kDarkBg,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingTile({
    required String title,
    required IconData icon,
    Color color = kSecondary,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: kPadding,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(kPadding / 2),
        splashColor: kPrimary.withAlpha(20),
        onTap: () {},
        child: Ink(
          padding: const EdgeInsets.all(kPadding * 0.75),
          decoration: BoxDecoration(
            color: kPrimaryLight.withAlpha(20),
            borderRadius: BorderRadius.circular(kPadding / 2),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(kPadding / 2),
                margin: const EdgeInsets.only(right: kPadding),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(kPadding / 2),
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: kDarkBg,
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox profile() {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimary.withOpacity(0.6),
                            spreadRadius: 10,
                          ),
                          const BoxShadow(
                            color: Colors.white,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: kPrimary.withOpacity(0.5),
                            blurRadius: 140,
                            spreadRadius: 12,
                          )
                        ]),
                    child: Image.asset(
                      'assets/user.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(kPadding / 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: kDarkBg.withOpacity(0.4),
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: kDarkBg.withOpacity(0.4),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mode_edit_outlined,
                        color: kPrimary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Text(
            "Jane Doe",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: kDarkBg,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: kPadding),
            child: Text(
              "UI/UX Designer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
