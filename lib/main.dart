import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testone/mixins/constants.dart';
import 'package:testone/screens/add_task.dart';
import 'package:testone/screens/home.dart';
import 'package:testone/screens/intro.dart';
import 'package:testone/screens/notification.dart';
import 'package:testone/screens/profiles.dart';
import 'package:testone/screens/today_tasks.dart';
import 'package:testone/states/theme_state.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      themeMode: theme,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}

class AppWithBottomNavbar extends StatefulWidget {
  const AppWithBottomNavbar({super.key});

  @override
  State<AppWithBottomNavbar> createState() => _AppWithBottomNavbarState();
}

class _AppWithBottomNavbarState extends State<AppWithBottomNavbar> {
  int _selectedIndex = 0;

  List<NavItem> navItems = [
    NavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_filled,
      page: const Homepage(),
    ),
    NavItem(
      icon: Icons.archive_outlined,
      selectedIcon: Icons.archive_rounded,
      page: const TodaysTask(),
    ),
    NavItem(
      icon: Icons.add,
      selectedIcon: Icons.add,
      page: const Scaffold(),
      center: true,
    ),
    NavItem(
      icon: Icons.notifications_outlined,
      selectedIcon: Icons.notifications,
      page: const NotificationPage(),
    ),
    NavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      page: const ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navItems[_selectedIndex].page,
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              color: kDarkBg.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navItems.asMap().entries.map(
            (e) {
              var index = e.key;
              var current = e.value;

              if (navItems[index].center) {
                return Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        color: kPrimary.withOpacity(0.2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const AddTaskPage()),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  icon: Icon(
                    index == _selectedIndex
                        ? current.selectedIcon
                        : current.icon,
                  ),
                  color: kPrimary,
                );
              }
            },
          ).toList(),
        ),
      ),
    );
  }
}

class NavItem {
  NavItem(
      {required this.icon,
      required this.selectedIcon,
      required this.page,
      this.center = false});

  final IconData selectedIcon;
  final IconData icon;
  final Widget page;
  bool center;
}
