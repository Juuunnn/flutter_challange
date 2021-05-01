import 'package:flutter_challange/model_objects/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../Methods.dart';
import '../database_helper.dart';

class FoodFormPage extends StatefulWidget {
  @override
  _FoodFormPageState createState() => _FoodFormPageState();
}

class _FoodFormPageState extends State<FoodFormPage> {
  String _name = "";
  String _calories = "";
  String _idLocal = "";
  String _idServer = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AppBar _appBar() {
    return AppBar(title: Text("Example 5 Task"));
  }

  Widget _inputName() {
    return Container(
        child: TextFormField(
            keyboardType: TextInputType.name,
            onSaved: (val) => _name = val ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
            validator: (val) =>
                (val != null && val.isNotEmpty) ? null : "Issue in Name",
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              prefixIcon: Icon(Icons.person),
              labelText: "Name",
              hintText: "Enter ur Name",
            )));
  }

  Widget _inputCalories() {
    return Container(
        child: TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (val) => _calories = val ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
            validator: (val) =>
                (val != null && val.isNotEmpty && int.tryParse(val) != null)
                    ? null
                    : "Issue in Calories",
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              prefixIcon: Icon(Icons.person),
              labelText: "Calories",
              hintText: "Enter a Calories",
            )));
  }

  Widget _formTask() {
    return Form(
        key: _formKey,
        child: Column(children: [_inputName(), _inputCalories()]));
  }

  Widget _fabSaveTask() {
    return FloatingActionButton.extended(
        onPressed: _saveData, label: Text("Save Task"), icon: Icon(Icons.save));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _formTask(),
      floatingActionButton: _fabSaveTask(),
    );
  }

  void _saveData() async {
    final FormState? _formState = _formKey.currentState;
    if (_formState != null && _formState.validate()) {
      _formState.save();

      try {
        Task _task = Task(idLocal: int.tryParse(_idLocal) , idServer: int.tryParse(_idServer), name: _name, calories:  double.parse(_calories));
        await _insertDataToDB(_task);
        snackMessage(message: "Saved :D", context: context);
        Navigator.of(context).pop();
      } catch (error) {
        snackMessage(
            message: "${error.toString()}", context: context, isError: true);
      }
    } //del if

    else {
      snackMessage(
          message: "Issue Inside the Form", context: context, isError: true);
    }
  }

  Future<void> _insertDataToDB(Task task) async {
    final Database? db = await DatabaseHelper.db.database;
    await db!.insert("task", task.toMapSQL());
  }
}
