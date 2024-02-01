import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  final String tatalWorkingHoursandtaskcountforMonth;
  final String calendarcardname;

  const CalendarCard({
    super.key,
    required this.tatalWorkingHoursandtaskcountforMonth,
    required this.calendarcardname,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.13,
      width: width * 0.28,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                tatalWorkingHoursandtaskcountforMonth.toString(),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(calendarcardname),
          )
        ],
      ),
    );
  }
}
