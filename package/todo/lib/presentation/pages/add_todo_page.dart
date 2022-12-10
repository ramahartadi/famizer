import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:todo/model/tugas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('families')
      .doc("qLyPcSCHfVJSj8W6QJXJ")
      .collection("todos");

  Future<void> addTodo(Tugas tugas) {
    return collectionReference
        .add({
          'name': tugas.name,
          'description': tugas.description,
          'todoList': [],
        })
        .then((value) => print("todo added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    super.initState();
    nameController.text = "";
    descriptionController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose;
    descriptionController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  var tugasAdd = Tugas(
                      name: nameController.text,
                      description: descriptionController.text,
                      todoList: []);
                  addTodo(tugasAdd);
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Nama Daftar Tugas'),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  color: context.colors.onSurfaceVariant,
                ),
                tooltip: '',
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: descriptionController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Deskripsi'),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  color: context.colors.onSurfaceVariant,
                ),
                tooltip: '',
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            child: ListTile(
              title: Text('Terlihat untuk:'),
              subtitle: Text('Here is a second line'),
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(28),
                          topLeft: Radius.circular(28)),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Icon(Icons.drag_handle),
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Siapa yang bisa melihat list ini?'),
                            ),
                            ListTile(
                              leading: Icon(Icons.lock_outline),
                              title: Text('Hanya saya'),
                            ),
                            ListTile(
                              leading: Icon(Icons.group_outlined),
                              title: Text('Semua orang di keluarga ini'),
                            ),
                            ListTile(
                              leading: Icon(Icons.group_add_outlined),
                              title: Text('Anggota spesifik'),
                              onTap: () => {
                                Navigator.pop(context),
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(28),
                                          topLeft: Radius.circular(28)),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              child: Icon(Icons.drag_handle),
                                              width: double.infinity,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text('Pilih Anggota'),
                                            ),
                                            ListTile(
                                              leading: FlutterLogo(),
                                              title: Text('Ahmad'),
                                              trailing: Icon(Icons.add),
                                            ),
                                            ListTile(
                                              leading: FlutterLogo(),
                                              title: Text('Fathur'),
                                              trailing: Icon(Icons.close),
                                            ),
                                            SizedBox(
                                              height: 52,
                                            )
                                          ],
                                        ),
                                      );
                                    })
                              },
                            ),
                            SizedBox(
                              height: 52,
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
