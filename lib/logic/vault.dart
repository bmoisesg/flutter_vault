class Vault {
  late String nombre;
  late String dominio;
  late String contra;
  late String category;
  late bool fav;

  Vault(
      {required this.nombre,
      required this.dominio,
      required this.contra,
      required this.category,
      this.fav = false});
}
