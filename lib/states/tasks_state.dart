import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class Task {
  late String id;
  late String title;
  String desc = "";
  late DateTime start;
  late DateTime end;
  bool done = false;
  List<Task> subTasks = [];

  Task({
    required this.title,
    String? desc,
    required this.start,
    required this.end,
  }) {
    id = const Uuid().v4();
    this.desc = desc ?? "";
  }

  void toggleTask() {
    done = !done;
  }

  void addSubtask(Task task) {
    subTasks = [...subTasks, task];
  }

  void removeSubtask(String id) {
    subTasks = subTasks.where((element) => element.id != id).toList();
  }
}

class TodoList extends StateNotifier<List<Task>> {
  TodoList() : super([]);

  addTask(Task task) {
    state = [...state, task];
  }

  removeTask(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  toggleTask(String id) {
    for (var element in state) {
      if (element.id == id) {
        element.toggleTask();
      }
    }
    state = [...state];
  }
}

final todoProvider =
    StateNotifierProvider<TodoList, List<Task>>((ref) => TodoList());
