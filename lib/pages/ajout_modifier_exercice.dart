import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:workout_app/classes/categorie.dart';
import 'package:workout_app/classes/exercice.dart';
import 'package:workout_app/service/db_service.dart';

// ignore: must_be_immutable
class AddEditExercice extends StatefulWidget {
  final bool edit;
  final VoidCallback onSave;
  final Exercice? exercice;
  final List<Categorie>? categorie;

  const AddEditExercice(
      {Key? key,
      required this.edit,
      required this.onSave,
      this.exercice,
      this.categorie})
      : super(key: key);

  @override
  State<AddEditExercice> createState() => _AddEditExerciceState();
}

class _AddEditExerciceState extends State<AddEditExercice> {
  String _titre = '';
  String _description = '';
  String _urlVideo = '';
  final String _image = 'assets/images/background/gymdefault.jpg';
  int _duree = 0;
  final int _repetition = 15;
  int _idCategorie = 0;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  // List<Categorie> categories = [];

  @override
  void initState() {
    print('initState');
    super.initState();
    // _refreshCategories(); // Loading the categories when the app starts
  }

  @override
  Widget build(BuildContext context) {
    print('Build Contexte');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.edit ? 'MODIFIER' : 'AJOUTER',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(19, 20, 41, 1.0),
          foregroundColor: const Color(0xFF40D876),
          elevation: 3,
        ),
        body: Form(
          key: globalKey,
          child: buildForm(),
        ));
  }

  Widget buildForm() {
    return SingleChildScrollView(
      child: Container(
        color: const Color.fromRGBO(19, 20, 41, 1.0),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTitre(),
            const SizedBox(height: 24),
            buildDescription(),
            const SizedBox(height: 25),
            buildUrlVideo(),
            const SizedBox(height: 25),
            buildCategories(),
            const SizedBox(height: 25),
            buildDuree(),
            const SizedBox(height: 50),
            buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitre() {
    return TextFormField(
      initialValue: widget.edit ? widget.exercice?.titre : '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.title,
          color: Color(0xFF40D876),
          size: 32,
        ),
        border: OutlineInputBorder(),
        labelText: "Titre",
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: (titre) {
        if (titre!.isEmpty) {
          return 'Entrer titre valide';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _titre = value!;
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      initialValue: widget.edit ? widget.exercice?.description : '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.description,
            color: Color(0xFF40D876),
            size: 32,
          ),
          border: OutlineInputBorder(),
          labelText: "Description",
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w500,
          )),
      validator: (description) {
        if (description!.isEmpty) {
          return 'champ description vide';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _description = value!;
      },
    );
  }

  Widget buildUrlVideo() {
    return TextFormField(
      initialValue: widget.edit ? widget.exercice?.video : '',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.video_file,
            color: Color(0xFF40D876),
            size: 32,
          ),
          border: OutlineInputBorder(),
          labelText: "Lien video ",
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          )),
      validator: (videoUrl) {
        if (videoUrl!.isEmpty) {
          return 'Entrer lien video valid';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _urlVideo = value!;
      },
    );
  }

  Widget buildCategories() {
    return FormBuilderDropdown(
      initialValue: widget.edit
          ? widget.categorie!.firstWhere(
              (element) => element.id == widget.exercice?.categorieId)
          : null,
      name: 'dropdown',
      dropdownColor: const Color.fromRGBO(19, 20, 41, 1.0),
      style: const TextStyle(
        color: Colors.white,

        fontSize: 24,
        fontWeight: FontWeight.w300,
        //color: Colors.black,
      ),
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.category,
            color: Color(0xFF40D876),
            size: 32,
          ),
          border: OutlineInputBorder(),
          labelText: "Categorie ",
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          )),
      isExpanded: true,
      validator: FormBuilderValidators.compose(
          [FormBuilderValidators.required(errorText: 'entrer catégorie')]),
      items: widget.categorie!.map((option) {
        return DropdownMenuItem(
          child: Text(option.name),
          value: option,
        );
      }).toList(),
      onSaved: (Categorie? value) {
        _idCategorie = value!.id;
      },
    );
  }

  Widget buildDuree() {
    return TextFormField(
      initialValue: widget.edit ? widget.exercice?.temps.toString() : '',
      keyboardType: TextInputType.number,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.timer,
            color: Color(0xFF40D876),
            size: 32,
          ),
          border: OutlineInputBorder(),
          labelText: "Duree ",
          labelStyle: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          )),
      validator: (value) {
        int? time = int.tryParse(value!);
        if (time == null || time <= 0) {
          return 'Entrer un numero valid';
        }
        return null;
      },
      onSaved: (value) {
        _duree = int.parse(value!);
      },
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ButtonStyle(
              // backgroundColor: colors
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF40D876),
              ),
            ),
            onPressed: () async {
              // Validate returns true if the form is valid, or false otherwise.
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();
                if (widget.edit) {
                  widget.exercice!.titre = _titre;
                  widget.exercice!.description = _description;
                  widget.exercice!.categorieId = _idCategorie;
                  widget.exercice!.temps = _duree;
                  widget.exercice!.video = _urlVideo;

                  if (await DBService.updateExercice(widget.exercice!)) {
                    showSnackBar();
                    Navigator.of(context).pop();
                  }
                } else {
                  if (await DBService.addExercice(Exercice(
                      //id: 100,
                      titre: _titre,
                      image: _image,
                      temps: _duree,
                      repetition: _repetition,
                      categorieId: _idCategorie,
                      description: _description,
                      video: _urlVideo))) {
                    print('categorie: $_idCategorie');
                    print('titre: $_titre');

                    showSnackBar();
                    Navigator.of(context).pop();
                    //widget.onSave();
                  }
                }
              }
            },
            child: const Text('Enregistrer',
                style: TextStyle(
                  color: Color.fromRGBO(19, 20, 41, 1.0),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Expanded(
          flex: 1,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2.0, color: Color(0xFF40D876)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Annuler',
                style: TextStyle(
                  color: Color(0xFF40D876),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
      ],
    );
  }

  void showSnackBar() {
    String message = '';
    message = widget.edit ? 'modifié' : 'ajouté';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        'Exercice $_titre $message avec succes',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      )),
    );
  }

  // void _refreshCategories() async {
  //   final data = await DBService.getCategories();

  //   setState(() {
  //     categories = data;
  //   });
  // }
}
