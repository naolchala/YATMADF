import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testone/mixins/constants.dart';
import 'package:testone/screens/today_tasks.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String? _selectedType;

  DateTime taskDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);

  List<TaskType> taskTypes = [
    TaskType(title: "Important", color: kSecondary),
    TaskType(title: "Personal", color: kPrimary),
    TaskType(title: "Work", color: Colors.indigoAccent),
  ];

  var textStyle = const TextStyle(
    color: kDarkBg,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_outlined),
          iconSize: 34,
          color: Colors.grey.shade700,
        ),
        title: const Text(
          "Add New Task",
          style: TextStyle(
            color: kDarkBg,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WeekDatePicker(
                  initialDate: taskDate,
                  onChange: (value) {
                    setState(() {
                      taskDate = value;
                    });
                  },
                ),
                titleInput(),
                typeInput(),
                dateTimeInput(context),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Description",
                        style: textStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: kPadding / 2),
                        padding: const EdgeInsets.all(kPadding / 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(kPadding / 2),
                        ),
                        child: const TextField(
                          minLines: 5,
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "About the Task...",
                            contentPadding: EdgeInsets.all(kPadding / 2),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(kPadding / 2),
        height: 70,
        child: Ink(
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(kPadding / 2),
          ),
          child: const Center(
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dateTimeInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Choose date & time", style: textStyle),
          Container(
            margin: const EdgeInsets.only(top: kPadding / 2),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(kPadding / 2),
                    onTap: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );

                      if (selectedTime != null) {
                        setState(() {
                          startTime = selectedTime;
                        });
                      }
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(kPadding / 1.5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(kPadding / 2),
                      ),
                      child: Center(
                        child: Text(
                          startTime.format(context),
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "-",
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(kPadding / 2),
                    onTap: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: endTime,
                      );

                      if (selectedTime != null) {
                        setState(() {
                          endTime = selectedTime;
                        });
                      }
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(kPadding / 1.5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(kPadding / 2),
                      ),
                      child: Center(
                        child: Text(
                          endTime.format(context),
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container titleInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Task Title",
            style: textStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: kPadding / 2),
            // padding: const EdgeInsets.all(kPadding / 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(kPadding / 2),
            ),
            child: const TextField(
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(kPadding / 1.5),
                border: InputBorder.none,
                hintText: "E.g. Website Redesign",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container typeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kPadding / 2),
            child: Text(
              "Task Type",
              style: textStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...taskTypes.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: kPadding / 2,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(kPadding / 2),
                      onTap: (() {
                        setState(() {
                          _selectedType =
                              item.title == _selectedType ? null : item.title;
                        });
                      }),
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          vertical: kPadding / 1.5,
                          horizontal: kPadding * 2,
                        ),
                        decoration: BoxDecoration(
                          color: item.title == _selectedType
                              ? item.color
                              : Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(kPadding / 2),
                        ),
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: item.title == _selectedType
                                ? Colors.white
                                : Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskType {
  TaskType({required this.title, required this.color});
  String title;
  Color color;
}
