import 'package:flutter/material.dart';
import 'card_filme.dart';
import 'package:obtendo_dados_com_flutter_http/models/filme.dart';

class ListaFilmes extends StatelessWidget {
  const ListaFilmes({
    Key? key,
    required this.filmes,
  }) : super(key: key);

  final List<Filme> filmes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: filmes.length,
      itemBuilder: ((context, index) {
        final filme = filmes[index];
        return CardFilme(
          nome: filme.nome ?? "",
          imagem: filme.imagem ?? "",
        );
      }),
    );
  }
}
