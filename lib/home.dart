import 'package:createdb_sqllite/service/database.dart';
import 'package:createdb_sqllite/note_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppDataBase appDB;

  List<NotesModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDB = AppDataBase.instance;
    getAllNotes();
  }

  void getAllNotes() async {
    data = await appDB.fetchNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CREATE DATABASE"),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("EDIT"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("DELETE"),
                value: 2,
              ),
            ];
          }, onSelected: (value) {
            // if value 1 show dialog
            if (value == 1) {
              print("1");
              // _showDialog(context);
              // if value 2 show dialog
            } else if (value == 2) {
              print("2");
              // _showDialog(context);
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Pressed");
          return appDB.insertNotes(NotesModel(
              id: 0, title: "title", desc: "desc ", priority: "medium"));
          getAllNotes();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              return print(data[index]);
            },
            leading: Icon(Icons.label_important_sharp,
                color: data[index].priority == "low"
                    ? Colors.blue
                    : data[index].priority == "medium"
                        ? Colors.yellow
                        : Colors.red,
                size: 31),
            title: Text("${data[index].title}"),
            subtitle: Text("${data[index].desc}"),
            trailing: InkWell(
              child: Icon(
                Icons.delete,
                size: 31,
                color: Colors.red,
              ),
              onTap: () {
                print("EDIT ${data[index].id}");

                // end pop up
              },
            ),
          );
        },
      ),
    );
  }
}
