import 'package:flutter/material.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:sqflite/sqflite.dart';

class ProfessorsPage extends StatefulWidget {
  final String? specialist;
  const ProfessorsPage({
    Key? key,
    String? Specialist,
  })  : specialist = Specialist,
        super(key: key);

  @override
  _ProfessorsPageState createState() => _ProfessorsPageState();
}

class _ProfessorsPageState extends State<ProfessorsPage> {
  List<Utilisateur> _professors = [];

  @override
  void initState() {
    super.initState();
    //_professors = DatabaseManager.getProStu('professor') as List<Utilisateur>;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _professors.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_professors[index].nom),
            //subtitle: Text(_professors[index].module as String),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Implement edit functionality
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Implement delete functionality

                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}