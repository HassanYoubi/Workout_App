import 'package:flutter/material.dart';
import 'package:workout_app/classes/categorie.dart';
import 'package:workout_app/classes/exercice.dart';
import 'package:workout_app/pages/ajout_modifier_exercice.dart';
import 'package:workout_app/service/db_service.dart';
import 'package:readmore/readmore.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {Key? key,
      required this.id,
      required this.thumbnail,
      required this.title,
      required this.description,
      required this.onDeleteSelected,
      this.exercice})
      : super(key: key);

  final int id;
  final Widget thumbnail;
  final String title;
  final String description;
  final VoidCallback onDeleteSelected;
  final Exercice? exercice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Expanded(
          flex: 2,
          child: thumbnail,
        ),
        Expanded(
          flex: 3,
          child: _VideoDescription(
            title: title,
            description: description,
            // viewCount: viewCount,
          ),
        ),
        Column(
          children: [
            IconButton(
                iconSize: 20,
                onPressed: () async {
                  //print("update $id");

                  final categories = await _refreshCategories();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditExercice(
                              edit: true,
                              onSave: () {
                                onDeleteSelected();
                              },
                              exercice: exercice,
                              categorie: categories)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            IconButton(
                iconSize: 20,
                onPressed: () async {
                  await DBService.deleteExercice(id);
                  onDeleteSelected();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Exercice $title a été supprimé'),
                  ));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          ],
        )
      ]),
    );
  }

  Future<List<Categorie>> _refreshCategories() async {
    final data = await DBService.getCategories();
    return data;
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key? key,
    required this.title,
    required this.description,
    //required this.viewCount,
  }) : super(key: key);

  final String title;
  final String description;
  //final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: Color(0xFF40D876),
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
          ReadMoreText(
            description,
            trimLines: 3,
            colorClickableText: const Color(0xFF40D876),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'plus',
            trimExpandedText: 'moins',
            style: const TextStyle(
              fontSize: 18.0,
              //fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            moreStyle: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF40D876),
            ),
          ),
        ],
      ),
    );
  }
}
