import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingText extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final VoidCallback onComplete;
  final bool isMovingUp;

  const FloatingText(
      {super.key,
      required this.text,
      required this.onComplete,
      required this.color,
      required this.fontSize,
      required this.isMovingUp});

  @override
  State<FloatingText> createState() => FloatingTextState();
}

class FloatingTextState extends State<FloatingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, widget.isMovingUp?-1:1),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward().whenComplete(widget.onComplete);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _positionAnimation,
        child: Text(
          widget.text,
          style: GoogleFonts.pressStart2p(
            decoration: TextDecoration.none,
            fontSize: widget.fontSize,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
