import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testone/mixins/validation.dart';
import 'package:testone/states/tasks_state.dart';

class AddTaskPage extends HookConsumerWidget with ValidationMixin {
  AddTaskPage({super.key});
  final formKey = GlobalKey<FormState>();
  final startDateStream = BehaviorSubject<DateTime>();
  final endDateStream = BehaviorSubject<DateTime>();
  String title = '';
  String desc = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = useStream<DateTime>(startDateStream.stream);
    final endDate = useStream<DateTime>(endDateStream.stream);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Task"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => vEmpty(value, "Title is empty"),
                      onSaved: (newValue) => (title = newValue!),
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: "Task Title",
                        hintText: "e.g. Do Homework",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      onSaved: (newValue) => (desc = newValue!),
                      maxLines: 10,
                      minLines: 4,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: "Task Description",
                        filled: true,
                        hintText:
                            "e.g. Finish Doing math homework with clear details and explanation",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: startDate.data ?? DateTime.now(),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(2040),
                        );

                        if (date != null) {
                          startDateStream.sink.add(date);
                        }
                      },
                      child: Text(
                        startDate.data != null
                            ? DateFormat.yMMMd("en_US").format(startDate.data!)
                            : 'Start Date',
                      ),
                    ),
                  ),
                  const Icon(Icons.remove),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: endDate.data ?? DateTime.now(),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(2040),
                        );

                        if (date != null) {
                          endDateStream.sink.add(date);
                        }
                      },
                      child: Text(
                        endDate.hasData
                            ? DateFormat.yMMMd().format(endDate.data!)
                            : "End Date",
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      startDate.hasData &&
                      endDate.hasData) {
                    formKey.currentState!.save();

                    if (endDate.data!.isBefore(startDate.data!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Start date should be before End date"),
                        ),
                      );
                    }

                    Task newTask = Task(
                      title: title,
                      start: startDate.data!,
                      end: endDate.data!,
                      desc: desc,
                    );
                    ref.read(todoProvider.notifier).addTask(newTask);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Create Task"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
