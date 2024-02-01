// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FilterDataListwidegt extends StatelessWidget {
  final String filedName;
  final String taskdata;
  const FilterDataListwidegt(
      {super.key, required this.filedName, required this.taskdata});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              filedName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            const Text(
              ":",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Container(
                width: width * 0.45,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal[50]),
                child: Text(taskdata))
          ],
        ),
      ),
    );
  }
}
