void main() {
  String nome = "Laranja";
  double peso = 100.2;
  String corFruta = "Verde e Amarela";
  String sabor = "Doce e cítrica";
  int diasDesdeColheita = 20;
  bool isMadura = funcEstaMadura(diasDesdeColheita);
  print(isMadura);
}

bool funcEstaMadura(int dias) {
  if (dias >= 30) {
    return true;
  } else {
    return false;
  }
}
