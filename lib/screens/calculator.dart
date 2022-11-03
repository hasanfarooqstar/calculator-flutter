import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List btnList = [
    "C",
    "%",
    "CLR",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "="
  ];
  List actionBtns = [
    "C",
    "%",
    "CLR",
  ];
  List operators = [
    "÷",
    "x",
    "-",
    "+",
    "=",
  ];
  List digits = [
    "7",
    "8",
    "9",
    "4",
    "5",
    "6",
    "1",
    "2",
    "3",
    "00",
    "0",
    ".",
  ];

  // String label1 = "";
  // String label2 = "";
  // String label3 = "";
  //equation will collect total equation printed on screen
  List equation = [];

  String currentNum = "";
  liveCalculation() {
    if (equation.length < 3) {
      return;
    }
    while (equation.contains("+")) {
      for (int i = 0; i < equation.length; i++) {
        if (equation[i] == "+") {
          String tempResult = (double.parse(equation[i] - 1) + double.parse(equation[i] + 1)).toString();
          equation.removeRange(i - 1, i + 2);
          equation.insert(i - 1, tempResult);
          break;
        }
      }
    }
  }

  buttonTap(String btn) {
    if (btn == "C") {
      equation = [];
      currentNum = "";
    } else {
      if (digits.contains(btn)) {
        currentNum += btn;
      } else if (btn == "%" || btn == "÷" || btn == "x" || btn == "-" || btn == "+") {
        if (currentNum == "÷" || currentNum == "%" || currentNum == "x" || currentNum == "-" || currentNum == "+") {
          currentNum = btn;
        } else {
          equation.add(currentNum);
          currentNum = btn;
        }
      } else if (btn == "=") {
        if (currentNum == "÷" || currentNum == "%" || currentNum == "x" || currentNum == "-" || currentNum == "+") {
          currentNum = "";
        }
        liveCalculation();
      }
    }

    setState(() {});
  }

  Color? getBtnBgColor(String btn) {
    if (actionBtns.contains(btn)) {
      return Colors.red[200];
    } else if (digits.contains(btn)) {
      return Colors.blue[200];
    } else {
      return Colors.amber[200];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        equation.join() + currentNum,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        "Ans:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ))),
        Expanded(
            flex: 2,
            child: InkWell(
                child: Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: btnList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      buttonTap(btnList[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.all(7),
                      decoration:
                          BoxDecoration(color: getBtnBgColor(btnList[index]), borderRadius: BorderRadius.circular(50)),
                      child: Center(
                          child: Text(
                        btnList[index],
                        style: new TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                          // color: Colors.yellow,
                        ),
                      )),
                    ),
                  );
                },
              ),
            )))
      ]),
    );
  }
}
