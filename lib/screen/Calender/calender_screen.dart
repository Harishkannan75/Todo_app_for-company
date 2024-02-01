import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/screen/Calender/widget/calendar_card_widget.dart';
import 'package:todo/screen/Calender/widget/calendar_cell.dart';
import 'package:todo/screen/Calender/widget/calendar_header.dart';

import '../../common/Provider/todo_class.dart';
import '../../common/Provider/todo_provider.dart';

// ignore: must_be_immutable
class Calenderscreen extends StatefulWidget {
  Calenderscreen({
    Key? key,
    required this.tabindex,
  }) : super(
          key: key,
        );
  CupertinoTabController tabindex;
  @override
  // ignore: library_private_types_in_public_api
  _CalenderscreenState createState() => _CalenderscreenState();
}

class _CalenderscreenState extends State<Calenderscreen> {
  late DateTime _currentCalendarDateTime;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    _currentCalendarDateTime = DateTime.now();
  }

  int getMonthlyTotalDuration(TodoProvider todotaskdatamodel) {
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
      ...todotaskdatamodel.todoTask,
      ...todotaskdatamodel.completedTasks
    ]) {
      if (tasklist.date.month == _currentCalendarDateTime.month &&
          tasklist.date.year == _currentCalendarDateTime.year) {
        updateDayTotalDuration(tasklist);
      }
    }

    int monthlyTotalDuration =
        dayTotalDurationMap.values.fold(0, (a, b) => a + b);
    return monthlyTotalDuration;
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

  Object formatingcurrentmonthdata(TodoProvider taskmodeldata) {
    for (var tasklist in [
      ...taskmodeldata.todoTask,
      ...taskmodeldata.completedTasks
    ]) {
      if (tasklist.date.month == _currentCalendarDateTime.month &&
          tasklist.date.year == _currentCalendarDateTime.year) {
        return tasklist;
      }
    }
    return 0;
  }

  int getNoOfDaysInMonth(DateTime dateTime) {
    DateTime firstDayOfMonth = DateTime(dateTime.year, dateTime.month, 1);
    DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
    return lastDayOfMonth.day - firstDayOfMonth.day + 1;
  }

  bool isTaskInCurrentMonthAndYear(TodoProvider taskmodeldata) {
    for (var todotask in [
      ...taskmodeldata.todoTask,
      ...taskmodeldata.completedTasks
    ]) {
      return todotask.date.month == _currentCalendarDateTime.month &&
          todotask.date.year == _currentCalendarDateTime.year;
    }
    return false;
  }

  List<Widget> getCalendarWidget(TodoProvider taskdatamodel) {
    int numberOfDaysInMonth = getNoOfDaysInMonth(_currentCalendarDateTime);
    List<Widget> rowList = [];
    const int startDate = 1;
    final int endDate = numberOfDaysInMonth;

    int startIdx = 1;
    int endIdx = numberOfDaysInMonth;

    // CommonFunction.console(numberOfDaysInMonth);

    int weekDayStart = DateTime(_currentCalendarDateTime.year,
            _currentCalendarDateTime.month, startDate)
        .weekday;
    int weekDayEnd = DateTime(_currentCalendarDateTime.year,
            _currentCalendarDateTime.month, endDate)
        .weekday;
    int cellCount = 1;

    int currentIdx = startIdx - weekDayStart + 1;
    endIdx += 7 - weekDayEnd;
    List<Widget> currentRow = [];
    while (currentIdx <= endIdx) {
      if (currentIdx >= startDate && currentIdx <= endDate) {
        currentRow.add(CalendarCell(
          currentDay: currentIdx,
          currentCalendarDateTime: _currentCalendarDateTime,
          todotaskdatamodel: taskdatamodel,
        ));
      } else {
        currentRow.add(
          CalendarCell(
            currentDay: null,
            currentCalendarDateTime: DateTime.now(),
            todotaskdatamodel: taskdatamodel,
          ),
        );
      }
      if (cellCount == 7) {
        cellCount = 1;
        double width = MediaQuery.of(context).size.width;
        rowList.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              width: width * 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: currentRow,
              ),
            ),
          ),
        );
        currentRow = [];
      } else {
        cellCount += 1;
      }
      currentIdx += 1;
    }

    return rowList;
  }

  void goToPreviousMonth() {
    setState(() {
      _currentCalendarDateTime = DateTime(
        _currentCalendarDateTime.year,
        _currentCalendarDateTime.month - 1,
      );
    });
  }

  void goToNextMonth() {
    setState(() {
      _currentCalendarDateTime = DateTime(
        _currentCalendarDateTime.year,
        _currentCalendarDateTime.month + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text(
          "Calendar",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        //     child: InkWell(
        //       onTap: () {
        //         widget.tabindex.index = 2;
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => AddTaskpage()));
        //       },
        //       child: Container(
        //         width: 70,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.blue,
        //         ),
        //         child: const Center(
        //           child: Text(
        //             "ADD",
        //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<TodoProvider>(
              builder: (context, todotaskdatamodel, child) {
            int currentMonthWorkDuration =
                getMonthlyTotalDuration(todotaskdatamodel);
            return FocusDetector(
              onFocusGained: () {
                getMonthlyTotalDuration(todotaskdatamodel);
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.03),
                      child: Container(
                        width: width,
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.0, vertical: width * 0.02),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              width: width * 0.85,
                              decoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: IconButton(
                                  onPressed: () {
                                    goToPreviousMonth();
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_left_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.MMMM()
                                          .format(_currentCalendarDateTime),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Text(
                                      _currentCalendarDateTime.year.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: IconButton(
                                    onPressed: () {
                                      goToNextMonth();
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_right,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width * 0.04),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01),
                              child: SizedBox(
                                width: width * 0.85,
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CalendarHeader(
                                        child: Text(
                                      "MON",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    )),
                                    CalendarHeader(
                                      child: Text(
                                        "TUE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CalendarHeader(
                                      child: Text(
                                        "WED",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CalendarHeader(
                                      child: Text(
                                        "THU",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CalendarHeader(
                                      child: Text(
                                        "FRI",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    CalendarHeader(
                                      child: Text(
                                        "SAT",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(
                                              0xffCD4841,
                                            ),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    CalendarHeader(
                                      child: Text(
                                        "SUN",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xffCD4841),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: width * 0.04),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.00),
                              child: Column(
                                children: getCalendarWidget(todotaskdatamodel),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CalendarCard(
                            tatalWorkingHoursandtaskcountforMonth:
                                formatDuration(currentMonthWorkDuration),
                            calendarcardname:
                                'Current Month total working Hours',
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          CalendarCard(
                            tatalWorkingHoursandtaskcountforMonth:
                                isTaskInCurrentMonthAndYear(todotaskdatamodel)
                                    ? todotaskdatamodel.todoTask.length
                                        .toString()
                                    : '0',
                            calendarcardname:
                                'Current Month total Pedding tasks',
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          CalendarCard(
                            tatalWorkingHoursandtaskcountforMonth:
                                isTaskInCurrentMonthAndYear(todotaskdatamodel)
                                    ? todotaskdatamodel.completedTasks.length
                                        .toString()
                                    : '0',
                            calendarcardname:
                                'Current Month total completed tasks',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
