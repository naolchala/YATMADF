import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:testone/mixins/constants.dart';
import 'package:testone/screens/task_details.dart';

enum TaskFilters {
  all,
  completed,
  ongoing,
}

final Map<TaskFilters, String> FilterLabels = {
  TaskFilters.all: "All",
  TaskFilters.completed: "Completed",
  TaskFilters.ongoing: "Ongoing",
};

class Homepage extends HookConsumerWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildNavbar(),
                upperDashboard(),
                sectionHeader("Today's Task"),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: kPadding),
                    child: Row(
                      children: [
                        todayTaskCard(
                          context,
                          title: "User experience design",
                          value: 0.4,
                          icon: Icons.aod_outlined,
                        ),
                        todayTaskCard(
                          context,
                          color: kSecondary,
                          title: "Meeting with a designer",
                          value: 0.7,
                          icon: Icons.people_outlined,
                        ),
                        todayTaskCard(
                          context,
                          title: "Fix deployment Issues",
                          value: 0.5,
                          icon: Icons.webhook_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
                sectionHeader("Upcoming Task"),
                Column(
                  children: [
                    taskTile(
                      title: "Website Design",
                      date: DateTime.now(),
                    ),
                    taskTile(
                      icon: Icons.account_balance_wallet_outlined,
                      title: "Send Money to John",
                      date: DateTime.now(),
                    ),
                    taskTile(
                      icon: Icons.people_outline,
                      title: "Meeting With Designers",
                      date: DateTime.now(),
                    ),
                    taskTile(
                      icon: Icons.desktop_mac_outlined,
                      title: "UI/UX Development",
                      date: DateTime.now(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container taskTile({
    IconData icon = Icons.now_widgets_outlined,
    required String title,
    required DateTime date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: kPadding),
      child: InkWell(
        splashColor: kDarkBg.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Ink(
          padding: const EdgeInsets.all(kPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: kPrimary.withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(kPadding / 1.5),
                margin: const EdgeInsets.only(right: kPadding),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: kPrimary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text(
                      DateFormat.yMMMMd().format(date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_outlined,
                  color: kDarkBg,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget todayTaskCard(
    BuildContext context, {
    Color color = kPrimary,
    required String title,
    required double value,
    required IconData icon,
  }) {
    return Container(
      width: 210,
      margin: const EdgeInsets.only(right: kPadding),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetails(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(kPadding),
        child: Ink(
          padding: const EdgeInsets.all(kPadding),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(kPadding),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: color.withOpacity(0.3),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(kPadding / 2 + 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: kPadding * 1.5),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Progress",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${(value * 100)}%",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container sectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding / 2, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(onPressed: () {}, child: const Text("See All")),
        ],
      ),
    );
  }

  Container upperDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding + 10),
      padding: const EdgeInsets.all(kPadding * 1.2),
      decoration: BoxDecoration(
        color: kDarkBg,
        borderRadius: BorderRadius.circular(kPadding * 2),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 25,
            color: kDarkBg.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your daily task almost done!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: kPadding * 1.5),
                  padding: const EdgeInsets.symmetric(
                    vertical: kPadding / 2,
                    horizontal: kPadding,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryLight.withOpacity(0.2),
                          blurRadius: 10),
                    ],
                  ),
                  child: const Text(
                    "View Task",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: 0.85,
                      semanticsLabel: "85%",
                      strokeWidth: 7,
                      color: kPrimaryLight,
                    ),
                  ),
                  Text(
                    "85%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildNavbar() {
    return Container(
      padding: const EdgeInsets.only(top: kPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: kPadding * 3,
            height: kPadding * 3,
            margin: const EdgeInsets.only(right: kPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kPadding),
            ),
            child: Image.asset(
              'assets/user.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hi, Shahinur",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "18 Feb 2022",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Ink(
              padding: const EdgeInsets.all(kPadding / 1.8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.search,
                color: Colors.grey.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
