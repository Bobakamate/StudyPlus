import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:manform/Screens/ProEtu/prof/addtodo.dart';
import 'package:provider/provider.dart';

class Devoirs extends StatefulWidget {
  const Devoirs({super.key});

  @override
  State<Devoirs> createState() => _DevoirsState();
}

class _DevoirsState extends State<Devoirs> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
       Align(
  alignment: Alignment.topLeft,
  child: GestureDetector(
    onTap: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTodo(
            OnDevoiradded: (newDevoir) {
              setState(() {
                AppProvider.devoirs.add(newDevoir);
              });
            },
            OnProjetadded: (newProjet) {
              setState(() {
                AppProvider.projets.add(newProjet);
              });
            },
          ),
        ),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 233, 233),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child:const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Color.fromARGB(255, 31, 31, 31)),
          SizedBox(width: 8.0),
          Text(
            'Add new homework or project',

            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color.fromARGB(255, 80, 80, 80),
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  ),
),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: const Text(
                  'Projects',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppProvider.projets.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.all(7),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                             Container(
                               width:300,
                               child:  Text(
                                 "Project : " + AppProvider.projets[index].titre,
                                 style: const TextStyle(
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold,
                                     fontFamily: "Roboto",
                                     fontSize: 18,
                                     decoration: TextDecoration.none),
                               ),
                             )
                              
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 100,
                            child: Text(
                              AppProvider.projets[index].description,
                              style:const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Roboto",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  decoration: TextDecoration.none),
                              maxLines: 4,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Title : " + (AppProvider.projets[index].titre),
                                style:const  TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    Provider.of<AppProvider>(context, listen: false).deleteProjetFromDatabase(AppProvider.projets[index]);
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  setState(() {
                                    showDialog(
                                    context: context,
                                    builder: (context) {
                                      return editProject(context, AppProvider.projets[index]);
                                    },
                                  );
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: const Text(
                  'Homeworks',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: AppProvider.devoirs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {},
                    child: Container(
                      padding: EdgeInsets.all(7),
                      margin: EdgeInsets.all(7),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "Homework : " + (AppProvider.devoirs[index].nom),
                                  style:const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                      fontSize: 18,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                              
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 100,
                            child: Text(
                              AppProvider.devoirs[index].description,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "Roboto",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  decoration: TextDecoration.none),
                              maxLines: 4,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Deadline: " +formatDateWithoutMilliseconds(AppProvider.devoirs[index].dateLimite),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    Provider.of<AppProvider>(context, listen: false).deleteDevoirFromDatabase(AppProvider.devoirs[index]);
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  setState(() {
                                    showDialog(
                                    context: context,
                                    builder: (context) {
                                      return editDevoir(context, AppProvider.devoirs[index]);
                                    },
                                  );
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ]),
    );
  }


  String formatDateWithoutMilliseconds(DateTime date) {
    // Formatage de la date
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    // Formatage de l'heure
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    // Concaténation de la date et de l'heure
    return '$day/$month/$year $hour:$minute';
  }

  Widget editDevoir(BuildContext context, Devoir devoir) {
    TextEditingController nom = TextEditingController(text: devoir.nom);
    TextEditingController description = TextEditingController(text: devoir.description);
    DateTime datel = devoir.dateLimite;


    return AlertDialog(
      title: const Text('Modifier le devoir'),
      content: Column(
        children: [
          TextField(
            controller: nom,
            decoration: const InputDecoration(labelText: 'Nom du devoir'),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(labelText: 'Description du devoir'),
          ),
          DateInputWidget(
            onDateSelected: (date) {
              datel = date;
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Update the devoir in the AppProvider
            devoir.nom = nom.text;
            devoir.description = description.text;
            devoir.dateLimite = datel;
            
            Provider.of<AppProvider>(context, listen: false).updateDevoirInDatabase(devoir);
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  Widget editProject(BuildContext context, Projet projet) {

    TextEditingController titre = TextEditingController(text: projet.titre);
    TextEditingController description = TextEditingController(text: projet.description);
    

    return AlertDialog(
      title: const Text('Modifier le projet'),
      content: Column(
        children: [
          TextField(
            controller: titre,
            decoration: const InputDecoration(labelText: 'Titre du projet'),
          ),
          TextField(
            controller: description,
            decoration: const InputDecoration(labelText: 'Description du projet'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Update the devoir in the AppProvider
            projet.titre = titre.text;
            projet.description = description.text;
            
            Provider.of<AppProvider>(context, listen: false).updateProjetInDatabase(projet);
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

}
