import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manform/SQlite/bdd.dart';
import 'package:manform/SQlite/data.dart';
import 'package:manform/Screens/Admin/etudiant_page.dart';
import 'package:manform/Screens/Admin/professeur_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Plus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String specialist = "";
  int role = 1;

  List<Map<Utilisateur, String>> _S_1 = [];
  List<Map<Utilisateur, String>> _S_2 = [];
  List<Map<Utilisateur, String>> _AD = [];
  List<Map<Utilisateur, String>> _IDAI = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _moduleController = TextEditingController();

  /*
  void _refresh() {
    
    final data_1 = DatabaseManager.getProMod('S1');
    final data_2 = DatabaseManager.getProMod('S2');

    final data_3 = DatabaseManager.getStuSec('AD');
    final data_4 = DatabaseManager.getStuSec('IDAI');
    
    setState(() { 
      _S_1 = data_1 as List<Map<Utilisateur, String>>;
      _S_2 = data_2 as List<Map<Utilisateur, String>>;
      _AD = data_3 as List<Map<Utilisateur, String>>;
      _IDAI = data_4 as List<Map<Utilisateur, String>>;
    });
  }
  */

  // Add this function to add a professor with a module
  void _addProfessorModule(
    String email, 
    String password, 
    String name,
    String specialty, 
    int role, 
    String module
    ) {
    final professor =
        Utilisateur(nom: email, email: email, password: password, role: role);
    //DatabaseManager.addProfessor(professor , module);
    //_refresh();
  }

  // Add this function to add a student with a sector
  void _addStudentSector(
    String email, 
    String password, 
    String name,
    String specialty, 
    int role
    ) {
    final student =
        Utilisateur(nom: email, email: email, password: password, role: role);
    //DatabaseManager.addStudent(student, specialty);
    //_refresh();
  }

  void changeS(String s) {
    setState(() {
      specialist = s;
    });
  }

  void changeR(int r) {
    setState(() {
      role = r;
    });
  }

  @override
  void initState() {
    super.initState();
    //_refresh();
  }

  // Add this function to show a dialog to add a student or professor
  void _showDialog(BuildContext context, int role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new $role'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              if (role == 1)
                TextField(
                  controller: _moduleController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Module'),
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('add'),
              onPressed: () async {
                if (role == 1) {
                  // Add professor
                  _addProfessorModule(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      specialist,
                      role,
                      _moduleController.text);
                } else {
                  // Add student
                  _addStudentSector(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      specialist,
                      role);
                }

                _moduleController.text = "";
                _nameController.text = "";
                _emailController.text = "";
                _passwordController.text = "";

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Plus'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Specialties',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            FutureBuilder<List<Filiere>>(
              future: DatabaseManager.getSectors(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((sector) {
                      return ListTile(
                        title: Text(sector.specialty),
                        onTap: () {
                          Navigator.pop(context);
                          changeS(sector.specialty);
                        },
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error} ');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black,
              onTap: (index) {
                if (index == 1) {
                  changeR(2);
                } else {
                  changeR(1);
                }
              },
              tabs: const [
                Tab(text: 'Professors'),
                Tab(text: 'Students'),
              ],
            ),
            leading: Container(
                margin: const EdgeInsets.only(top: 0),
                child: Title(
                  color: Colors.white,
                  child: Text(
                    specialist,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          body: const TabBarView(
            children: [
              StudentsPage(),
              ProfessorsPage(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context, role);
        },
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
