import 'package:flutter/material.dart';

class CalendarHeader extends StatefulWidget {
  final Widget child;

  const CalendarHeader({Key? key, required this.child}) : super(key: key);

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: (width * 0.85) / 8,
      child: widget.child,
    );
  }
}
