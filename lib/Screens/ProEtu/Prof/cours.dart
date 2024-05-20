import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';

// Replace with your actual model classes
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:provider/provider.dart';

import 'chapterdetails.dart';
import 'addcours.dart';

class ModuleCourses extends StatefulWidget {
  const ModuleCourses({Key? key}) : super(key: key);

  @override
  State<ModuleCourses> createState() => _ModuleCoursesState();
}

class _ModuleCoursesState extends State<ModuleCourses> {
  List<Cours> courses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    // Replace with your actual data fetching logic
    final fetchedCourses =
        await DatabaseManager.getCoursForModule(AppProvider.cours[0].id!);
    DatabaseManager.displayDatabase();

    setState(() {
      courses = fetchedCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  AppProvider.cours[0].nom,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                ),
                //btn for adding new course
                Spacer(),
                IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        addChapter();
                      });
                    }),
              ],
            ),
          ),
          SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (courses.length).ceil(), // Nombre de lignes
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final updatedCourse = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChapterDetails(
                                    course: courses[index],
                                    onCourseUpdated: (updatedCourse) {
                                      // Update the course in the courses list
                                      courses[index] = updatedCourse;
                                      setState(() {});
                                    },
                                    onCourseDeleted: (deletedCourse) {
                                      // Remove the deleted course from the courses list
                                      courses.remove(deletedCourse);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        courses[index].nom,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto",
                                          fontSize: 20,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void addChapter(){
    TextEditingController _nom = TextEditingController();
    TextEditingController _resume = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ajouter un Chapitre"),
          content: Column(
            children: [
              TextField(
                controller: _nom,
                decoration: InputDecoration(hintText: "Titre de chapitre"),
              ),
              TextField(
                controller: _resume,
                decoration: InputDecoration(hintText: "contenu"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                Cours newCourse = Cours(
                  nom: _nom.text,
                  resume: _resume.text,
                  idModule: AppProvider.cours[0].id!,
                );
                Provider.of<AppProvider>(context, listen: false).addCours(newCourse);
                _fetchCourses();
                Navigator.pop(context);
              },
              child: Text("Ajouter"),
            ),
          ],
        );
      }
    );
  }
}

