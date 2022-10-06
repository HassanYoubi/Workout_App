import 'package:workout_app/classes/categorie.dart';
import 'package:workout_app/classes/exercice.dart';
import 'package:workout_app/service/db_helper.dart';

class DBService {
  static Future<List<Categorie>> getCategories() async {
    await DBHelper.init();
    List<Map<String, dynamic>> categories =
        await DBHelper.query(Categorie.table);
    return categories.map((item) => Categorie.fromMap(item)).toList();
  }

  // static Future<List<Exercice>> getExercices() async {
  //   await DBHelper.init();
  //   List<Map<String, dynamic>> exercices = await DBHelper.query(Exercice.table);
  //   return exercices.map((item) => Exercice.fromMap(item)).toList();
  // }
  static Future<List<Exercice>> getExercicesByCat(int idCategorie) async {
    await DBHelper.init();
    List<Map<String, dynamic>> exercices =
        await DBHelper.reqExercicesByCategorie(idCategorie);
    return exercices.map((item) => Exercice.fromMap(item)).toList();
  }

  static Future<bool> addExercice(Exercice model) async {
    await DBHelper.init();
    int retourReq = await DBHelper.insert(Exercice.table, model);
    return retourReq > 0 ? true : false;
  }

  static Future<bool> updateExercice(Exercice model) async {
    await DBHelper.init();
    int retourReq = await DBHelper.update(Exercice.table, model);
    return retourReq > 0 ? true : false;
  }

  static Future<bool> deleteExercice(int id) async {
    await DBHelper.init();
    int retourReq = await DBHelper.delete(Exercice.table, id);
    return retourReq > 0 ? true : false;
  }
}
