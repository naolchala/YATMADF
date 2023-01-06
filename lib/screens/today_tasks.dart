import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:testone/common/navbar.dart';
import 'package:testone/mixins/constants.dart';

class TodaysTask extends StatefulWidget {
  const TodaysTask({super.key});

  @override
  State<TodaysTask> createState() => _TodaysTaskState();
}

class _TodaysTaskState extends State<TodaysTask> {
  DateTime selected = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              children: [
                const Navbar(title: "Todays Tasks"),
                WeekDatePicker(
                  initialDate: selected,
                  onChange: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                ),
                const TaskFilters(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      EventTile(
                        title: "Landing Page Design",
                        startTime:
                            DateTime.now().subtract(const Duration(hours: 2)),
                        endTime: DateTime.now(),
                        value: 90,
                      ),
                      EventTile(
                        title: "Dashboard Redesign",
                        color: kSecondary,
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(
                          const Duration(hours: 2),
                        ),
                        value: 40,
                      ),
                      EventTile(
                        title: "Educational App Design",
                        color: Colors.indigo,
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(
                          const Duration(hours: 2),
                        ),
                        value: 30,
                      ),
                      EventTile(
                        title: "Landing Page Design",
                        startTime: DateTime.now(),
                        endTime: DateTime.now().add(
                          const Duration(hours: 2),
                        ),
                        value: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget EventTile({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    required int value,
    Color color = kPrimary,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(kPadding / 2),
            child: Text(
              DateFormat.jm().format(startTime),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(kPadding / 2),
              padding: const EdgeInsets.all(kPadding / 1.5),
              decoration: BoxDecoration(
                color: color.withAlpha(50),
                borderRadius: BorderRadius.circular(kPadding / 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: kDarkBg,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: color,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Text(
                          "${DateFormat.jm().format(startTime)}-${DateFormat.jm().format(endTime)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: value / 100,
                          backgroundColor: Colors.white.withAlpha(220),
                          color: color,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Text(
                        '$value %',
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TaskFilters extends StatefulWidget {
  const TaskFilters({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskFilters> createState() => _TaskFiltersState();
}

class _TaskFiltersState extends State<TaskFilters> {
  List<String> filters = ["All", "Ongoing", "Completed"];
  String _currentFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: kPadding),
      padding: const EdgeInsets.all(kPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kPadding),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: kDarkBg.withAlpha(30),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: filters.map((filter) {
          var selected = filter == _currentFilter;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentFilter = filter;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.bounceInOut,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: kPadding * 0.5),
                decoration: BoxDecoration(
                  color: selected ? kSecondary : Colors.transparent,
                  borderRadius: BorderRadius.circular(kPadding / 4),
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceInOut,
                    style: selected
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(
                            color: kDarkBg,
                          ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class WeekDatePicker extends StatefulWidget {
  const WeekDatePicker({
    super.key,
    required this.initialDate,
    required this.onChange,
  });
  final DateTime initialDate;
  final void Function(DateTime value) onChange;

  @override
  State<WeekDatePicker> createState() => _WeekDatePickerState();
}

class _WeekDatePickerState extends State<WeekDatePicker> {
  @override
  Widget build(BuildContext context) {
    var current = widget.initialDate;
    var prevMonthLength = DateTime(current.year, current.month - 1)
        .difference(DateTime(current.year, current.month))
        .abs()
        .inDays;

    var monthLength = DateTime(current.year, current.month)
        .difference(DateTime(current.year, current.month + 1))
        .abs()
        .inDays;

    var startIndex = current.weekday - 1;
    var today = current.day;

    List<DateTime> dates = [];
    List<DateTime> prev = [];

    for (int i = today - startIndex; i < today - startIndex + 7; i++) {
      if (i > 0 && i <= monthLength) {
        dates.add(DateTime(current.year, current.month, i));
      } else if (i <= 0) {
        prev.add(
            DateTime(current.year, current.month - 1, prevMonthLength + i));
      } else {
        dates.add(DateTime(current.year, current.month + 1, i - monthLength));
      }
    }

    dates = [...prev, ...dates];

    var now = DateTime.now();
    var todayDate = DateTime(now.year, now.month, now.day);
    var selectedDate = DateTime(current.year, current.month, current.day);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding),
      padding: const EdgeInsets.all(kPadding / 2),
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(kPadding / 2),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: 30,
            color: kPrimary.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  widget.onChange(
                    current.subtract(
                      const Duration(days: 7),
                    ),
                  );
                },
                icon: const Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat.yMMMM().format(current),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.onChange(current.add(const Duration(days: 7)));
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_right),
                color: Colors.white,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: kPadding),
          ),
          Row(
            children: [
              ...["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map(
                (e) => Expanded(
                  child: Center(
                    child: Text(
                      e,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...dates.map(
                (date) {
                  return day(
                    date,
                    selected: date.compareTo(selectedDate) == 0,
                    today: date.compareTo(todayDate) == 0,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded day(DateTime date, {bool selected = false, bool today = false}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onChange(date);
          });
        },
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: kPadding / 4, horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: kPadding / 2),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : kPrimary,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: today
                      ? [
                          const BoxShadow(
                            spreadRadius: 1,
                            color: Colors.white,
                            blurStyle: BlurStyle.inner,
                          )
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    "${date.day}",
                    style: TextStyle(
                      color: selected ? kPrimary : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
