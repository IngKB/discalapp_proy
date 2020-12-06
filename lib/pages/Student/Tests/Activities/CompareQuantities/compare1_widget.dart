import 'dart:ui';

import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';
import 'compare1_list.dart';

class CompareActivity1 extends StatefulWidget {
  CompareActivity1({Key key, @required this.numero}) : super(key: key);
  final int numero;
  @override
  _CompareActivity1State createState() => _CompareActivity1State();
}

class _CompareActivity1State extends State<CompareActivity1> {
  Color colorOPT1 = kAlumnColor;
  Color colorOPT2 = kAlumnColor;
  double borderOPT1 = 1;
  double borderOPT2 = 1;

  String imagen1;
  String imagen2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imagen1 = compareActivities[widget.numero][1];
    imagen2 = compareActivities[widget.numero][2];
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(compareActivities[widget.numero][0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: borderOPT1, color: colorOPT1)),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    seleccionarOPT(1);
                  });
                },
                child: Image(
                  fit: BoxFit.fill,
                  height: 200,
                  image: AssetImage(imagen1),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: borderOPT2, color: colorOPT2)),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    seleccionarOPT(2);
                  });
                },
                child: Image(
                  fit: BoxFit.fill,
                  height: 200,
                  image: AssetImage(imagen2),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[900].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(2, 5), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  seleccionarOPT(int opt) {
    switch (opt) {
      case 1:
        colorOPT1 = kTeacherColor;
        borderOPT1 = 5;
        colorOPT2 = kAlumnColor;
        borderOPT2 = 1;

        break;
      case 2:
        colorOPT1 = kAlumnColor;
        borderOPT1 = 1;
        colorOPT2 = kTeacherColor;
        borderOPT2 = 5;
        break;
    }
  }
}
