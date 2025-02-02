import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SimpleCalculator',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 48.0;
        resultFontSize = 38.0;
      } else if (buttonText == "DEL") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      padding: EdgeInsets.all(4.0),
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),

          //padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tran Anh Khoa 20161328')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.black26),
                      buildButton("DEL", 1, Colors.black26),
                      buildButton("÷", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black26),
                      buildButton("8", 1, Colors.black26),
                      buildButton("9", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black26),
                      buildButton("5", 1, Colors.black26),
                      buildButton("6", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black26),
                      buildButton("2", 1, Colors.black26),
                      buildButton("3", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.black26),
                      buildButton("0", 1, Colors.black26),
                      buildButton("00", 1, Colors.black26),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.black26),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.black26),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
