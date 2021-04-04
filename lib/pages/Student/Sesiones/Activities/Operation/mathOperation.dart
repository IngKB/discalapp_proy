import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MathOperation extends StatefulWidget {
  MathOperation({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  @override
  MathOperationState createState() => MathOperationState();
}

class MathOperationState extends State<MathOperation> {
  int n1, n2, resultado, respuestaCorrecta;
  String operacion;
  String area;
  String texto;
  int valorOperacion;

  @override
  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      padding: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("Actividad",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          operacionText(),
          respuestaInput()
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
    ));
  }

  Widget operacionText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "$operacion",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n1",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n2",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ],
        ),
        Container(
            width: 200,
            child: Divider(
              thickness: 3,
              color: Colors.orange,
            ))
      ],
    );
  }

  Widget respuestaInput() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              //labelText: 'Respuesta',labelStyle: TextStyle(fontSize: 25)
              hintText: 'Respuesta',
              hintStyle: TextStyle(fontSize: 20)),
          onChanged: (valor) {
            setState(() {
              resultado = int.tryParse(valor);
            });
          },
        ));
  }

  _generarNumeros() {
    var rng = new Random();

    var operation = rng.nextInt(3);

    n1 = rng.nextInt(100);
    n2 = rng.nextInt(10);

    switch (operation) {
      case 0:
        area = "suma";
        operacion = "+";
        texto = "Realiza la siguiente SUMA";
        respuestaCorrecta = n1 + n2;
        break;
      case 1:
        area = "resta";
        operacion = "-";
        texto = "Realiza la siguiente RESTA";
        if (n1 < n2) {
          var temp = n1;
          n1 = n2;
          n2 = temp;
        }
        respuestaCorrecta = n1 - n2;
        break;
      case 2:
        n1 = rng.nextInt(10);
        n2 = rng.nextInt(10);
        area = "multiplicacion";
        operacion = "x";
        texto = "Realiza la siguiente MULTIPLICACIÓN";
        respuestaCorrecta = n1 * n2;
        break;
      default:
        operacion = ".";
        texto = "...";
    }
  }

  validarResultado() {
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    if (resultado == respuestaCorrecta) {
      usuarioResultados.addResults(new ActivityResult(
          area: area,
          resultado: true,
          tiempo: 1));
      showAlertDialog(context, "Respuesta correcta", "¡Genial!");
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: area,
          resultado: false,
          tiempo: 1));
      showAlertDialog(context, "Respuesta incorrecta", "Ups...");
    }
  }

  showAlertDialog(BuildContext context, String mensaje, String titulo) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Siguiente",
      ),
      onPressed: () {
        Navigator.of(context).pop();
        widget.pasarActividad(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        titulo,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Text(
        mensaje,
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
