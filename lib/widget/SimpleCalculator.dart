import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCalculator extends StatefulWidget {
  final int score;
  final List<String> scoreDetail;

  const SimpleCalculator(
      {super.key, required this.score, required this.scoreDetail});

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  int _currentInput = 0;
  List<String> _calculationHistory = [];
  late int _currentResult;

  @override
  void initState() {
    super.initState();
    _calculationHistory = widget.scoreDetail;
    _currentResult = widget.score;
  }

  void _onNumberPressed(int number) {
    setState(() {
      _currentInput = _currentInput * 10 + number;
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (operation == "+") {
        _calculationHistory.add("$_currentInput +");
        _currentInput = 0;
      } else if (operation == "-") {
        _calculationHistory.add("$_currentInput -");
        _currentInput = 0;
      } else if (operation == "=") {
        int result = 0;
        String currentOperation = "+";
        for (String entry in _calculationHistory) {
          if (entry.endsWith("+") || entry.endsWith("-")) {
            currentOperation = entry.substring(entry.length - 1);
          } else {
            int value = int.parse(entry);
            if (currentOperation == "+") {
              result += value;
            } else if (currentOperation == "-") {
              result -= value;
            }
          }
        }
        _calculationHistory.add("$_currentInput");
        _currentInput = result;
        _calculationHistory.add("= $result");
      } else if (operation == "C") {
        _currentInput = 0;
        _calculationHistory.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("简单计算器"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xffb44f33),
              child: Row(
                children: [
                  Text(
                    "$_currentResult",
                    style: GoogleFonts.pressStart2p(
                        // fontWeight: FontWeight.w900,
                        fontSize: 25.sp,
                        color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _calculationHistory.join("\n"),
                          style: GoogleFonts.pressStart2p(
                              fontSize: 8.sp, color: const Color(0xfff5ddaf)),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "$_currentInput",
                          style: TextStyle(color: Colors.white, fontSize: 36),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                if (index < 10) {
                  return _buildButton("$index", () => _onNumberPressed(index));
                } else {
                  String operation;
                  switch (index) {
                    case 10:
                      operation = "+";
                      break;
                    case 11:
                      operation = "-";
                      break;
                    case 12:
                      operation = "=";
                      break;
                    case 13:
                      operation = "C";
                      break;
                    default:
                      return SizedBox.shrink();
                  }
                  return _buildButton(
                      operation, () => _onOperationPressed(operation));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
