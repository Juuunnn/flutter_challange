import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Challange extends StatefulWidget {
  @override
  _ChallangeState createState() => _ChallangeState();
}

class _ChallangeState extends State<Challange> {
    AppBar _appBar(){
	return AppBar(title: Text("Challange"));
	}  
  Widget _body(){
	return Container(
    child: Center(
      child: Text("", 
        style: TextStyle(
          fontSize: 30, 
          color: Colors.blue),
        ),
      )
    );
	}  

  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
	    body: _body(),
    );
  }
}