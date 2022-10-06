import 'package:flutter/material.dart';
import 'package:workout_app/classes/exercice.dart';
import 'package:workout_app/widget/youtubeplayer.dart';

class Details extends StatelessWidget {
  final Exercice? exercice;
  const Details({Key? key, this.exercice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            exercice!.titre!.toUpperCase(),
            style: const TextStyle(
              fontSize: 25,
              color: Color(0xFF40D876),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(19, 20, 41, 1.0),
          foregroundColor: const Color(0xFF40D876),
          elevation: 3,
        ),
        body: Container(
            color: const Color.fromRGBO(19, 20, 41, 1.0),
            child: buildColumn()));
  }

  Widget buildColumn() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        width: double.infinity,
        child: YoutubePlayerWidget(urlVideo: exercice!.video!),
      ),
      Flexible(
        child: buildListView(),
      ),
    ]);
  }

  Widget buildListView() {
    List<String> _items = ['Description', 'Durée', 'Répétition'];
    List<String> descriptions = [
      exercice!.description!,
      (exercice!.temps!.toString() + ' min'),
      (exercice!.repetition!.toString() + ' X')
    ];

    List<Icon> icons = const [
      Icon(
        Icons.description_rounded,
        color: Colors.white,
        size: 25.0,
      ),
      Icon(
        Icons.access_alarm,
        color: Colors.white,
        size: 25.0,
      ),
      Icon(
        Icons.repeat,
        color: Colors.white,
        size: 25.0,
      )
    ];

    List<TextStyle> styles = const [
      TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )
    ];

    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          final item = _items[index];
          return Card(
            // this key is required to save and restore ExpansionTile expanded state
            key: PageStorageKey(index),
            color: Colors.blue[900],
            elevation: 2,

            child: ExpansionTile(
              childrenPadding: const EdgeInsets.symmetric(vertical: 10),
              title: Text(item,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF40D876),
                      fontWeight: FontWeight.bold)),
              children: [
                ListTile(leading: icons[index]),
                ListTile(
                    title: Text(descriptions[index], style: styles[index])),
              ],
            ),
          );
        });
  }
}
