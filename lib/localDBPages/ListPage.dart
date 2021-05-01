import 'package:flutter_challange/database_helper.dart';
import 'package:flutter_challange/localDBPages/FoodFormPage.dart';
import 'package:flutter_challange/model_objects/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Task>? listTasks;
  AppBar _appBar() {
    return AppBar(title: Text("Example 5"));
  }

  Widget _body() {
    if (listTasks == null) return Center(child: CircularProgressIndicator());
    if (listTasks!.isEmpty) return Center(child: Text("No Data"));
    return ListView(
        children: listTasks!
            .map((task) => Text("${task.name}, calories: ${task.calories}"))
            .toList());
  }

Widget _itemFood




  Widget _fabGoToForm() {
    return FloatingActionButton.extended(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FoodFormPage()))
            .whenComplete(() => _readDataFromDB()),
        label: Text("Add Task"),
        icon: Icon(Icons.add));
  }

  @override
  void initState() {
    _readDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(), 
        body: _body(), 
        floatingActionButton: _fabGoToForm());
  }

  void _readDataFromDB() async {
    final Database? db = await DatabaseHelper.db.database;
    List<dynamic>? results = await db!.query("task");
    if (results == null || results.isEmpty) return null;
    listTasks = results.map((result) => Task.fromMapSQL(result)).toList();
  }
}
