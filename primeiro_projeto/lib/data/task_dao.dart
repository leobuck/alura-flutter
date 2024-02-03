import 'package:primeiro_projeto/components/task.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tableName ($_name TEXT, $_difficulty INTEGER, $_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {}

  Future<List<Task>> findAll() async {
    throw Exception();
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    throw Exception();
  }

  delete(String nomeDaTarefa) {}
}
