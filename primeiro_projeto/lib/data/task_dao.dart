import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tableName ($_name TEXT, $_difficulty INTEGER, $_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {}

  Future<List<Task>> findAll() async {
    print('findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    print('procurando dados no banco de dados... encontrado: $result');
    throw Exception();
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    throw Exception();
  }

  delete(String nomeDaTarefa) {}
}
