import 'package:flutter/material.dart';
import 'package:workout_app/classes/categorie.dart';

import 'package:workout_app/classes/exercice.dart';
import 'package:workout_app/pages/ajout_modifier_exercice.dart';
import 'package:workout_app/service/db_service.dart';
import 'package:workout_app/widget/customlistitem.dart';
import 'details.dart';

class ListeExercice extends StatefulWidget {
  final int id;

  const ListeExercice({Key? key, required this.id}) : super(key: key);

  @override
  State<ListeExercice> createState() => _ListeExercice();
}

class _ListeExercice extends State<ListeExercice> {
  List<Exercice> exercices = [];

  @override
  void initState() {
    super.initState();
    _refreshExercices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EXERCICES',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF131429),
        foregroundColor: const Color(0xFF40D876),
        elevation: 3,
      ),
      body: Container(
          color: const Color.fromRGBO(19, 20, 41, 1.0),
          padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
          child: Container(
            child: buildListView(),
          ) //Container(color: Colors.blue[600], child: buildListView()),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await _refreshCategories();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditExercice(
                        edit: false,
                        onSave: () {
                          _refreshExercices();
                        },
                        categorie: data,
                      )));
        },
        backgroundColor: const Color(0xFF40D876),
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: exercices.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Details(exercice: exercices[index])));
          },
          child: (CustomListItem(
            id: exercices[index].id!,
            description: exercices[index].description!, //substring(0, 45)
            thumbnail: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(exercices[index].image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: exercices[index].titre!,
            onDeleteSelected: () {
              _refreshExercices();
            },
            exercice: exercices[index],
          )),
        );
      },
    );
  }

  Future<List<Categorie>> _refreshCategories() async {
    final data = await DBService.getCategories();
    return data;
  }

  void _refreshExercices() async {
    final data = await DBService.getExercicesByCat(widget.id);

    setState(() {
      exercices = data;
    });
  }
}
