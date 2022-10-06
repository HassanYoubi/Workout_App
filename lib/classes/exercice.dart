class Exercice {
  static String table = "exercices";
  int? id; // Declare id, initially null
  String? titre;
  String? image;
  int? temps;
  int? repetition;
  int? categorieId;
  String? description;
  String? video;

  Exercice(
      {this.id,
      this.titre,
      this.image,
      this.temps,
      this.repetition,
      this.categorieId,
      this.description,
      this.video});

  static Exercice fromMap(Map<String, dynamic> json) {
    return Exercice(
      id: json['id'],
      titre: json['titre'],
      image: json['image'],
      temps: json['temps'],
      repetition: json['repetition'],
      categorieId: json['categorieId'],
      description: json['description'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'titre': titre,
      'image': image,
      'temps': temps,
      'repetition': repetition,
      'categorieId': categorieId,
      'description': description,
      'video': video,
    };
   
    return map;
  }

  
}
