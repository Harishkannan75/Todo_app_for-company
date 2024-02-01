import 'package:flutter/material.dart';

import '../../../common/Provider/todo_class.dart';
import '../../../common/Provider/todo_provider.dart';
import 'calendar_task_list_widget.dart';

class CalendarCell extends StatefulWidget {
  final int? currentDay;
  final DateTime currentCalendarDateTime;
  final TodoProvider todotaskdatamodel;

  const CalendarCell({
    Key? key,
    required this.currentDay,
    required this.currentCalendarDateTime,
    required this.todotaskdatamodel,
  }) : super(key: key);

  @override
  State<CalendarCell> createState() => _CalendarCellState();
}

class _CalendarCellState extends State<CalendarCell> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (widget.currentDay == null) {
      return SizedBox(
        // width: width * 0.115,
        width: (width * 0.85) / 8,
        height: width * 0.165,
      );
    }

    DateTime now = DateTime.now();

    DateTime selectedDateTime = DateTime(widget.currentCalendarDateTime.year,
        widget.currentCalendarDateTime.month, widget.currentDay!);
    bool isToday = selectedDateTime.isAtSameMomentAs(
      DateTime(now.year, now.month, now.day),
    );

    Widget buildIsActiveIndicator() {
      for (var tasklist in [
        ...widget.todotaskdatamodel.todoTask,
        ...widget.todotaskdatamodel.completedTasks
      ]) {
        if (tasklist.date.day == widget.currentDay &&
            tasklist.date.month == widget.currentCalendarDateTime.month &&
            tasklist.date.year == widget.currentCalendarDateTime.year) {
          return Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: tasklist.completed ? Colors.green : Colors.red,
              ),
            ),
          );
        }
      }
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    ShoetasKdatalist(
                      currentDay: selectedDateTime,
                      todotaskdata: widget.todotaskdatamodel,
                    ),
                    // SizedBox(
                    //   height: height * 0.08,
                    // ),
                  ],
                ),
              );
            });
      },
      child: Container(
        width: (width * 0.85) / 8,
        height: width * 0.155,
        decoration: BoxDecoration(
          color: isToday
              ? Colors.teal.withOpacity(0.4)
              : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.53),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 1,
              child: buildIsActiveIndicator(),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(
                child: Center(
                  child: Text(
                    widget.currentDay.toString(),
                    style: const TextStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Flexible(
              flex: 2,
              child: getMonthTaskListWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMonthTaskListWidget() {
    Map<int, int> dayTotalDurationMap = {};

    void updateDayTotalDuration(Todo task) {
      int totalDurationMinutes = calculateTotalDuration(task);
      dayTotalDurationMap.update(
        task.date.day,
        (value) => value + totalDurationMinutes,
        ifAbsent: () => totalDurationMinutes,
      );
    }

    for (var tasklist in [
      ...widget.todotaskdatamodel.todoTask,
      ...widget.todotaskdatamodel.completedTasks
    ]) {
      if (tasklist.date.day == widget.currentDay &&
          tasklist.date.month == widget.currentCalendarDateTime.month &&
          tasklist.date.year == widget.currentCalendarDateTime.year) {
        updateDayTotalDuration(tasklist);
      }
    }

    List<Widget> dayWidgets = dayTotalDurationMap.entries.map((entry) {
      return Text(
        formatDuration(entry.value),
        style: const TextStyle(fontSize: 12),
      );
    }).toList();

    return Column(
      children: dayWidgets,
    );
  }

  int calculateTotalDuration(Todo task) {
    int taskDurationMinutes = (task.endTime!.hour * 60 + task.endTime!.minute) -
        (task.startTime!.hour * 60 + task.startTime!.minute);

    if (taskDurationMinutes < 0) {
      taskDurationMinutes += 1440;
    }

    return taskDurationMinutes;
  }

  String formatDuration(int totalMinutes) {
    int totalHours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;

    return '${totalHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
  }
}
