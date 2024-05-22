import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:provider/provider.dart';
import 'package:manform/SQlite/data.dart';

class Bultain extends StatefulWidget {

  const Bultain({Key? key}) : super(key: key);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Bultain> {
 

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                "Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  fontSize: 25,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff0000FF),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: AppProvider.students.length,
                    itemBuilder: (context, index) {
                      String studentName = AppProvider.students[index].nom;
                      var grade = getgradebystudentid(AppProvider.students[index].id!);
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            if (grade != -1) {
                              print('Note de l\'étudiant ${studentName} : ${grade}');
                              setState(() {
                                editNote(AppProvider.students[index].id!, grade: grade.toString());
                              });
                            }
                            else {
                              print('Note de l\'étudiant ${studentName} : Aucune note');
                              setState(() {
                                addNote(AppProvider.students[index].id!);
                              });
                            }
                          },
                          child: ListTile(
                            title: Text(studentName),
                            trailing: grade != -1 ? Text(grade.toStringAsFixed(2),style: TextStyle(fontSize: 18),): Text(''), // Note sur 20 avec une décimale
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  double getgradebystudentid(int id) {
    for (var note in AppProvider.notes) {
      if (note.idEtudiant == id) {
        return note.note;
      }
    }
    return -1;
  }

  void editNote(int note, {String grade = ""}) {
    TextEditingController newNote = TextEditingController(text: grade);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit note"),
          content: TextField(
            controller: newNote,
            decoration: InputDecoration(hintText: "Note"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                  Provider.of<AppProvider>(context, listen: false).updateNote(note, double.parse(newNote.text));
                  Navigator.pop(context);
              },
              child: Text("Validate"),
            ),
          ],
        );
      },
    );
  }

  void addNote(int studentid) {
    TextEditingController newNote = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add note"),
          content: TextField(
            controller: newNote,
            decoration: InputDecoration(hintText: "Note"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).addNoteInDatabase(
                  Notes(
                    idEtudiant: studentid,
                    note: double.parse(newNote.text),
                    idModule: AppProvider.cours[0].id!,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text("Validate"),
            ),
          ],
        );
      },
    );
  }

}

