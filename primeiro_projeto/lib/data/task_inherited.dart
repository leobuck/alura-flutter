import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required this.child}) : super(child: child);

  final Widget child;
  final List<Task> taskList = [
    Task('Aprender Flutter', 'assets/images/dash.png', 3, 0),
    Task('Andar de bike', 'assets/images/bike.webp', 2, 0),
    Task('Meditar', 'assets/images/meditar.jpeg', 5, 0),
    Task('Ler', 'assets/images/livro.jpg', 4, 0),
    Task('Jogar', 'assets/images/jogar.jpg', 1, 0),
  ];

  void newTask(String name, String photo, int difficulty, int level) {
    taskList.add(Task(name, photo, difficulty, level));
  }

  static TaskInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInherited>();
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
