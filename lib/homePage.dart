import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students = FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) {
    return students.doc(id).delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Firebase Crud"),),
        body : StreamBuilder<QuerySnapshot>(
            stream: studentsStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Something went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final List storedocs = [];
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
                a['id'] = document.id;
              }).toList();

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(
                        'Student Data List',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Table(
                        border: TableBorder.all(),

                       // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                             /* TableCell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Text(
                                      'SNo',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),*/
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.greenAccent,
                                  child: const Center(
                                    child: Text(
                                      'Action',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          for (var i = 0; i < storedocs.length; i++) ...[
                            TableRow(
                              children: [
                               /* TableCell(
                                  child: Center(
                                      child: Text((i+1).toString(),
                                          style: const TextStyle(fontSize: 14.0))),
                                ),*/
                                TableCell(
                                  child: Center(
                                      child: Text(storedocs[i]['name'],
                                          style: const TextStyle(fontSize: 14.0))),
                                ),
                                TableCell(
                                  child: Center(
                                      child: Text(storedocs[i]['email'],
                                          style: const TextStyle(fontSize: 12.0))),
                                ),
                                TableCell(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
              children: [
              IconButton(
              onPressed: () => {
              /* Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => UpdateStudentPage(
              id: storedocs[i]['id']),
              ),
              )*/
              },
              icon: Icon(
              Icons.edit,
              color: Colors.orange,
                size: 20,
              ),
              ),
                IconButton(
                  onPressed:()
                  {
                    deleteUser(storedocs[i]['id']);
                    },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ])
                                ),
                              /*  TableCell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () => {
                                         *//* Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateStudentPage(
                                                  id: storedocs[i]['id']),
                                            ),
                                          )*//*
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                              ],
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}