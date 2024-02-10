import 'package:flutter/material.dart';
import 'package:primeiro_projeto/components/task.dart';
import 'package:primeiro_projeto/data/task_dao.dart';
import 'package:primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        title: const Text('Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? tarefas = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
              case ConnectionState.active:
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && tarefas != null) {
                  if (tarefas.isNotEmpty) {
                    return ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final Task tarefa = tarefas[index];
                        return tarefa;
                      },
                    );
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('Erro ao carregar tarefas');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then(
            (value) => setState(
              () {
                print('Recarregando a tela inicial');
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
