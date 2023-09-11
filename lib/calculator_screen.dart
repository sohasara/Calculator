import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var input = '';
  var output = '';
  var operation = '';
  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userinput = input;
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
      }
    } else {
      input = input + value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(29, 56, 73, 1),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    output,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              buttonStyle('C'),
              buttonStyle('<'),
              buttonStyle(''),
              buttonStyle('/'),
            ],
          ),
          Row(
            children: [
              buttonStyle('7'),
              buttonStyle('8'),
              buttonStyle('9'),
              buttonStyle('*'),
            ],
          ),
          Row(
            children: [
              buttonStyle('4'),
              buttonStyle('5'),
              buttonStyle('6'),
              buttonStyle('-'),
            ],
          ),
          Row(
            children: [
              buttonStyle('1'),
              buttonStyle('2'),
              buttonStyle('3'),
              buttonStyle('+'),
            ],
          ),
          Row(
            children: [
              buttonStyle('%'),
              buttonStyle('0'),
              buttonStyle('.'),
              buttonStyle('='),
            ],
          ),
        ],
      ),
    );
  }

  buttonStyle(var text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(22),
            backgroundColor: Colors.white,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
