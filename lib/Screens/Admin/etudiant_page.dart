import 'package:flutter/material.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:manform/Screens/Admin/main_admin.dart';
import 'package:sqflite/sqflite.dart';

class StudentsPage extends StatefulWidget {
  final String? specialist;
  const StudentsPage({
    Key? key,
    String? Specialist,
  })  : specialist = Specialist,
        super(key: key);

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Utilisateur> _students = [];
  
  get specialist => StudentsPage().specialist;

  @override
  void initState() {
    super.initState();
    _students = DatabaseManager.getProStu(specialist);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _students.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_students[index].nom),
            //subtitle: Text(_students[index].specialty),
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
                    // delete from the database
                    final Database db =
                        await DatabaseManager.initializeDatabase();
                    await db.delete('Utilisateur',
                        where: 'id = ?', whereArgs: [_students[index].id]);
                    _students = DatabaseManager.getProStu(specialist!)
                        as List<Utilisateur>;
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
