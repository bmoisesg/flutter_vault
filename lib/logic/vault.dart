class Vault {
  late String nombre;
  late String dominio;
  late String contra;
  late bool fav;

  //late categorias categoria;

  Vault(
      {required this.nombre,
      required this.dominio,
      required this.contra,
      this.fav = false});
}

enum categorias { categoria1, categoria2, categoria3 }
