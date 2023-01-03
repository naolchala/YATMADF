import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testone/mixins/constants.dart';

class TaskDetails extends HookConsumerWidget {
  const TaskDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        primary: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_outlined),
          iconSize: 34,
          color: Colors.grey.shade700,
        ),
        title: const Text(
          "Task Details",
          style: TextStyle(
            color: kDarkBg,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: kPadding),
                ),
                subHeader("User Experience Design"),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kPadding),
                  padding: const EdgeInsets.all(kPadding / 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dateChips(text: "11-02-2022"),
                      const SizedBox(
                        width: 20,
                      ),
                      dateChips(text: "9:00AM - 12:00PM")
                    ],
                  ),
                ),
                chartDashboard(),
                subHeader("Description"),
                Container(
                  padding: const EdgeInsets.only(
                    top: kPadding / 2,
                    bottom: kPadding * 2,
                  ),
                  child: const Text.rich(
                    TextSpan(
                      text:
                          "Task management is a process in which monitoring your last project tasks through their various stages from start... ",
                      children: [
                        TextSpan(
                          text: "See more",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 2,
                    ),
                  ),
                ),
                subHeader("Sub Task"),
                Container(
                  margin: const EdgeInsets.only(top: kPadding * 1.5),
                  child: Column(
                    children: [
                      TaskTile(
                        title: "Website Redesign",
                        date: DateTime.now(),
                      ),
                      TaskTile(
                        title: "Website Redesign",
                        date: DateTime.now(),
                      ),
                      TaskTile(
                        title: "Website Redesign",
                        date: DateTime.now(),
                      ),
                      TaskTile(
                        title: "Website Redesign",
                        date: DateTime.now(),
                      ),
                      TaskTile(
                        title: "Website Redesign",
                        date: DateTime.now(),
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

  Text subHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: kDarkBg,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container chartDashboard() {
    return Container(
      margin: const EdgeInsets.only(bottom: kPadding * 2, top: kPadding / 4),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 150,
              child: SfCircularChart(
                series: [
                  PieSeries(
                    radius: "60",
                    explodeAll: true,
                    dataSource: <ChartData>[
                      ChartData("Done", 40, kPrimary),
                      ChartData("Past", 20, kSecondary),
                      ChartData("Ongoing", 40, kDarkBg),
                    ],
                    xValueMapper: (data, _) => data.x,
                    yValueMapper: (data, _) => data.y,
                    dataLabelMapper: (datum, index) => "${datum.y}%",
                    pointColorMapper: (datum, index) => datum.color,
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                listItemA(title: "Finish on Time", color: kPrimary),
                listItemA(title: "Past the deadline", color: kSecondary),
                listItemA(title: "Still ongoing", color: kDarkBg),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget listItemA({required String title, Color color = kPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: kPadding / 2),
            child: Icon(
              Icons.play_circle_rounded,
              color: color,
              size: 18,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget dateChips({required String text}) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(kPadding / 2),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: kPadding * 0.8,
            horizontal: kPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(kPadding / 2),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.grey.shade600, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  const TaskTile({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String title;
  final DateTime date;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool done = false;

  void toggle() {
    setState(() {
      done = !done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kPadding),
      child: InkWell(
        splashColor: kPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        onTap: toggle,
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
                  color:
                      done ? kPrimary.withOpacity(0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  !done
                      ? Icons.check_box_outline_blank_outlined
                      : Icons.check_box_outlined,
                  color: done ? kPrimary : Colors.grey,
                  size: 27,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text(
                      DateFormat.yMMMMd().format(widget.date),
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
}

class ChartData {
  final String x;
  final double y;
  final Color? color;

  ChartData(this.x, this.y, [this.color]);
}
