import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.timer_sharp,
          size: 50.sp,
        ),
        Text(
          Duration(seconds: _seconds).toString().split('.').first,
          style: GoogleFonts.pressStart2p(
            fontWeight: FontWeight.w300,
            fontSize: 23.sp,
            // color: const Color(0xfff5ddaf)
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isRunning ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded),
              iconSize: 30.sp,
              onPressed: () {
                if (_isRunning) {
                  _pauseTimer();
                } else {
                  _startTimer();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
