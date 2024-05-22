import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/data.dart';
import 'package:provider/provider.dart';


class AddTodo extends StatefulWidget {

  final Function(Devoir) OnDevoiradded;
  final Function(Projet) OnProjetadded;

  const AddTodo({super.key, required this.OnDevoiradded, required this.OnProjetadded});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  //dovoir fields
  TextEditingController nom = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime? dateLimite;
  //projet fields
  TextEditingController nomProjet = TextEditingController();
  TextEditingController descriptionProjet = TextEditingController();
  TextEditingController imageProjet = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff0000FF),
      appBar: AppBar(
        backgroundColor:  Color(0xff0000FF),
        title: Text("Add new homework or project",style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          decoration: TextDecoration.none
        ),
        )
      ),
      
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: addDevoir(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * .9,
                
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text('Add new homework',style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.none),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: addProjet(),
                      ),
                    );
                  },
                );
              },
              child: Container(
                 height: 100,
                width: MediaQuery.of(context).size.width * .9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text('Add new Project',style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.none
                ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget addDevoir() {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Homework name",
            ),
            controller: nom,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Content",
            ),
            controller: description,
          ),
          //datefield
          DateInputWidget(
            onDateSelected: (date) {
              dateLimite = date;
            },
          ),
          ElevatedButton(
            onPressed: () {
              print('dateLimite: $dateLimite');
              Devoir newDevoir = Devoir(
                nom: nom.text,
                description: description.text,
                dateLimite: dateLimite!,
                idModule: AppProvider.cours[0].id!,
                rendue: 0,
                isProjet: 0,
              );
              Provider.of<AppProvider>(context, listen: false).addDevoir(newDevoir);
              widget.OnDevoiradded(newDevoir);
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  Widget addProjet() {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "project name",
            ),
            controller: nomProjet,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "content",
            ),
            controller: descriptionProjet,
          ),
          
          ElevatedButton(
            onPressed: () {
              Projet newProjet = Projet(
                titre: nomProjet.text,
                description: descriptionProjet.text,
                idModule: AppProvider.cours[0].id!,
                image: 'assets/images/c1.jpg',
                idEtudiant: AppProvider.utilisateurCourant.id!,
              );
              widget.OnProjetadded(newProjet);
              Provider.of<AppProvider>(context, listen: false).addProjet(newProjet);
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }
  
}



class DateInputWidget extends StatefulWidget {

  final Function(DateTime)? onDateSelected;

  const DateInputWidget({Key? key, this.onDateSelected}) : super(key: key);
  @override

  _DateInputWidgetState createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : 'Select a date'),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}