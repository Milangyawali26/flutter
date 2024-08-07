import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/screens/AddTodo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';

  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      uid = user?.uid ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text("Todo "),
            Text(
              "List ",
              style: TextStyle(color: Colors.blue),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/auth');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: uid.isEmpty
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(uid)
                    .collection('usertask')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var task = snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                            title: Text(task['title']),
                            subtitle: Text(task['description']),
                            trailing: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(uid)
                                    .collection('usertask')
                                    .doc(task.id)
                                    .delete();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTodo()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
