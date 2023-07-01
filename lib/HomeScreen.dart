import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];
  _HomeScreenState();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: resultWidget(),
        ),
        Expanded(child: buttonWidget())
      ],
    )));
  }

  Widget resultWidget() {
    return Container(
        color: Color.fromARGB(255, 216, 163, 163),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(userInput,
                  style: TextStyle(
                    fontSize: 32,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text(result,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  Widget buttonWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Color.fromARGB(66, 233, 232, 232),
      child: GridView.builder(
        itemCount: buttonList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return button(buttonList[index]);
        },
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "c" ||
        text == "(" ||
        text == ")") {
      return Color.fromARGB(255, 255, 82, 194);
    }
    if (text == "=" || text == "AC") {
      return Colors.white;
    }
    return Colors.indigo;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Color.fromARGB(255, 192, 122, 189);
    }
    if (text == "=") {
      return Color.fromARGB(255, 76, 138, 190);
    }
    return Colors.white;
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    ;
    if (text == "c") {
      if (userInput.length > 0) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var eveluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eveluation.toString();
    } catch (e) {
      return "error";
    }
  }
}
