import 'package:flutter/material.dart';
import 'package:workout_app/classes/categorie.dart';
import 'package:workout_app/pages/listeexercice.dart';
import '../service/db_service.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  List<Categorie> categories = [];

  @override
  void initState() {
    super.initState();
    _refreshCategories(); // Loading the categories when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MUSCULATION',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFF40D876),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 20, 41, 1),
        elevation: 3,
      ),
      body: Container(
        color: const Color.fromRGBO(19, 20, 41, 1),
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 15.0),
        child: buildGrid(),
      ), //Container(color: Colors.blue[600], child: buildGrid()),
    );
  }

  Widget buildGrid() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 5,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final Categorie item = categories[index];

          return InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListeExercice(id: item.id)))
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(categories[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: const Color.fromRGBO(19, 20, 41, 0.6),
                title: Center(
                    child: Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w400),
                )),
              ),
            ),
          );
        });
  }

  void _refreshCategories() async {
    final data = await DBService.getCategories();

    setState(() {
      categories = data;
    });
  }
}
