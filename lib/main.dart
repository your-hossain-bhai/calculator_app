import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  CalculatorHomeState createState() => CalculatorHomeState();
}

class CalculatorHomeState extends State<CalculatorHome> {
  String input = "";
  String result = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "";
        result = "0";
      } else if (buttonText == "=") {
        // Evaluate the expression
        try {
          Parser p = Parser();
          Expression exp = p.parse(
            input.replaceAll('x', '*').replaceAll('÷', '/'),
          );
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        input += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 32, color: Colors.black54),
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("÷"),
            ],
          ),
          Row(
            children: [
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("x"),
            ],
          ),
          Row(
            children: [
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            children: [
              buildButton("C"),
              buildButton("0"),
              buildButton("="),
              buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}
