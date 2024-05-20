import 'package:flutter/material.dart';
import 'package:manform/Provider/AppProvider.dart';
import 'package:manform/SQlite/data.dart';
import 'package:provider/provider.dart';

class ChapterDetails extends StatefulWidget {
  final Cours course;
  final Function(Cours) onCourseUpdated;
  final Function(Cours) onCourseDeleted;

  ChapterDetails({
    required this.course,
    required this.onCourseUpdated,
    required this.onCourseDeleted,
  });

  @override
  _ChapterDetailsState createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails> {
  late Cours currentChapter;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentChapter = widget.course;
    _nameController.text = currentChapter.nom;
    _descriptionController.text = currentChapter.resume;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditChapterDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteChapter();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentChapter.nom,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              currentChapter.resume,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditChapterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Chapter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Chapter Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Chapter Description',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _updateChapter();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updateChapter() {
    String newName = _nameController.text;
    String newDescription = _descriptionController.text;

    // Update the chapter in the AppProvider
    currentChapter.nom = newName;
    currentChapter.resume = newDescription;

    // Update the chapter in the database
    Provider.of<AppProvider>(context, listen: false)
        .updateCourseInDatabase(currentChapter);

    // Refresh the UI
    widget.onCourseUpdated(currentChapter);
    Navigator.of(context).pop(currentChapter);
  }

  void _deleteChapter() async {
  // Delete the chapter from the database
  Provider.of<AppProvider>(context, listen: false)
    .deleteCourseFromDatabase(currentChapter);

  // Call the callback function to notify the parent widget
  widget.onCourseDeleted(currentChapter);

  // Navigate back to the previous screen
  Navigator.of(context).pop();
}
}
