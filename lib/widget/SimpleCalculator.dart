import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCalculator extends StatefulWidget {
  final int score;
  final List<String> scoreDetail;
  final Function(int,List<String>) callback;

  const SimpleCalculator(
      {super.key, required this.score, required this.scoreDetail, required this.callback});

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  int _currentInput = 0;
  String _crurrentProcess = "";
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
      _crurrentProcess += "$number";
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      if (operation == "+" || operation == "-" || operation == "÷" || operation == "×") {
        if (_crurrentProcess.isNotEmpty && "+-×÷".contains(_crurrentProcess[_crurrentProcess.length - 1])) {
          _crurrentProcess = _crurrentProcess.substring(0, _crurrentProcess.length - 1) + operation;
        } else {
          _crurrentProcess += operation;
        }
        _currentInput = 0;
      } else if (operation == "=") {
        // 计算结果
        int result = 0;
        List<String> tokens = [];
        String currentOperation = "+";


        // 将历史记录// 使用正则表达式将_crurrentProcess转化为操作数和操作符的列表
        tokens = RegExp(r'(\d+|[+\-×÷])').allMatches(_crurrentProcess).map((e) => e.group(0)!).toList();

        // 使用栈处理先乘除后加减
        List<int> stack = [];
        for (int i = 0; i < tokens.length; i++) {
          String token = tokens[i];
          if (token == "+" || token == "-") {
            currentOperation = token;
          } else if (token == "×" || token == "÷") {
            int prev = stack.removeLast();
            int value = int.parse(tokens[++i]);
            if (token == "×") {
              stack.add(prev * value);
            } else if (token == "÷") {
              stack.add(prev ~/ value); // 整数除法
            }
          } else {
            int value = int.parse(token);
            if (currentOperation == "+") {
              stack.add(value);
            } else if (currentOperation == "-") {
              stack.add(-value);
            }
          }
        }

        // 计算最终结果
        result = stack.fold(0, (sum, element) => sum + element);

        // 更新历史记录和回调

        _calculationHistory.add("= $result");
        if(result>=0){
          widget.scoreDetail.add("+$result");
        }else{
          widget.scoreDetail.add("-$result");
        }

        widget.callback(result, widget.scoreDetail);

        _currentResult = result;
        _currentInput = 0;
        _crurrentProcess = "$result";
        _calculationHistory.clear();
      } else if (operation == "C") {
        _currentInput = 0;
        _calculationHistory.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff233c4c),
                width: 8.w,
              ),
              color: const Color(0xfff5ddaf),
            ),
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
                        _crurrentProcess,
                        style: GoogleFonts.pressStart2p(
                            fontSize: 22.sp, color: Colors.black87),
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
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
                left: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
                right: BorderSide(
                  color: const Color(0xff233c4c),
                  width: 8.w,
                ),
              ),
              color: const Color(0xff233c4c),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                {
                  switch (index) {
                    case 0:
                      return _buildButton("C", () => _onOperationPressed("C"));
                    case 1:
                      return SizedBox.shrink();
                    case 2:
                      return SizedBox.shrink();
                    case 3:
                      return _buildButton("÷", () => _onOperationPressed("÷"));
                    case 4:
                      return _buildButton("7", () => _onNumberPressed(7));
                    case 5:
                      return _buildButton("8", () => _onNumberPressed(8));
                    case 6:
                      return _buildButton("9", () => _onNumberPressed(9));
                    case 7:
                      return _buildButton("×", () => _onOperationPressed("×"));
                    case 8:
                      return _buildButton("4", () => _onNumberPressed(4));
                    case 9:
                      return _buildButton("5", () => _onNumberPressed(5));
                    case 10:
                      return _buildButton("6", () => _onNumberPressed(6));
                    case 11:
                      return _buildButton("-", () => _onOperationPressed("-"));
                    case 12:
                      return _buildButton("1", () => _onNumberPressed(1));
                    case 13:
                      return _buildButton("2", () => _onNumberPressed(2));
                    case 14:
                      return _buildButton("3", () => _onNumberPressed(3));
                    case 15:
                      return _buildButton("+", () => _onOperationPressed("+"));
                    case 16:
                      return SizedBox.shrink();
                    case 17:
                      return _buildButton("0", () => _onNumberPressed(0));
                    case 18:
                      return SizedBox.shrink();
                    case 19:
                      return _buildButton("=", () => _onOperationPressed("="));
                    default:
                      return SizedBox.shrink();
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffb44f33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(label,
            style: GoogleFonts.pressStart2p(
                fontSize: 28.sp, color: const Color(0xfff5ddaf))),
      ),
    );
  }

  Widget _buildLongButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffb44f33),
                borderRadius: BorderRadius.circular(10)),
            child: Text(label,
                style: GoogleFonts.pressStart2p(
                    fontWeight: FontWeight.w900,
                    fontSize: 25.sp,
                    color: const Color(0xfff5ddaf)))),
      ),
    );
  }
}
