import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/data.dart';
import 'package:provider/provider.dart';

class addcours extends StatefulWidget {
  final Function(Cours) onCourseAdded;

  const addcours({Key? key, required this.onCourseAdded}) : super(key: key);

  @override
  State<addcours> createState() => _addcoursState();
}

class _addcoursState extends State<addcours> {
  TextEditingController nom = TextEditingController();
  TextEditingController resume = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff674dde),
      appBar: AppBar(
        backgroundColor: Color(0xff674dde),
        title:const Text("Ajouter un cours",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            decoration: TextDecoration.none),
        )
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Nom du cours",
              ),
              controller: nom,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Resume",
              ),
              controller: resume,
            ),
            ElevatedButton(
              onPressed: () {
                Cours newCourse = Cours(
                  nom: nom.text,
                  resume: resume.text,
                  idModule: AppProvider.cours[0].id!,
                );
                Provider.of<AppProvider>(context, listen: false).addCours(newCourse);
                widget.onCourseAdded(newCourse);
                Navigator.pop(context);
              },
              child: Text("Ajouter"),
            )
          ],
        ),
      ),
    );
  }
}