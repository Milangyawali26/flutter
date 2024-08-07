import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktodatabase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final uid = user!.uid;
    var time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('usertask')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
    });

     Fluttertoast.showToast(msg: 'Task added Successfully ');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Todo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),

            Text('Add the task you want to do'),

            SizedBox(
              height: 40,
            ),
            // title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),

            // description
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),

            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                addtasktodatabase();
              },
              child: Text(
                "add todo",
              ),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 25),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
