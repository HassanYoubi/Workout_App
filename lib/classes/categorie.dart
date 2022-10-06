class Categorie {
  static String table = "categories";

  final int id;
  final String name;
  final String image;

  Categorie({required this.id, required this.name, required this.image});

  static Categorie fromMap(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
