import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'In the making',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text('sample test **',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                  const Text(
                    'Trainee Software Developer (Flutter)',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      '#Flutter',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add your navigation logic here
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text('View Profile'),
                  ),
                ],
              ),
            ),
          ),

          //Circle Avatar
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: -75,
            child: CircleAvatar(
              radius: 75,
              backgroundColor: Colors.transparent,
              child: ClipOval(child: Image.asset("Assets/profile_picture.png")),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class Page1 extends StatelessWidget {
//   const Page1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).push(_createRoute());
//           },
//           child: const Text('Go!'),
//         ),
//       ),
//     );
//   }
// }

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

// class Page2 extends StatelessWidget {
//   const Page2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(
//         child: Text('Page 2'),
//       ),
//     );
//   }
// }



//==========================Navigation animation========================

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// class FirstPage extends StatefulWidget {
//   @override
//   _FirstPageState createState() => new _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Goto Second Page'),
//           onPressed: () {
//             Navigator.of(context).push(SecondPageRoute());
//           },
//         ),
//       ),
//     );
//   }
// }

// class SecondPageRoute extends CupertinoPageRoute {
//   SecondPageRoute() : super(builder: (BuildContext context) => SecondPage());

//   // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation,
//       Animation<double> secondaryAnimation) {
//     return FadeTransition(opacity: animation, child: SecondPage());
//   }
// }

// class SecondPage extends StatefulWidget {
//   @override
//   _SecondPageState createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: const Center(
//         child: Text('This is the second page'),
//       ),
//     );
//   }
// }











// import 'package:flutter/material.dart';

// import 'common/Provider/todo_class.dart';

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: getMonthTaskListWidget(),
//       ),
//     );
//   }
//   Widget getMonthTaskListWidget() {
//   Map<int, int> dayTotalDurationMap = {};

//   void updateDayTotalDuration(Todo task) {
//     int totalDurationMinutes = calculateTotalDuration(task);
//     dayTotalDurationMap.update(
//       task.date.day,
//       (value) => value + totalDurationMinutes,
//       ifAbsent: () => totalDurationMinutes,
//     );
//   }

//   for (var tasklist in [
//     ...widget.todotaskdatamodel.todoTask,
//     ...widget.todotaskdatamodel.completedTasks
//   ]) {
//     if (tasklist.date.month == widget.currentCalendarDateTime.month &&
//         tasklist.date.year == widget.currentCalendarDateTime.year) {
//       updateDayTotalDuration(tasklist);
//     }
//   }

//   int monthlyTotalDuration = dayTotalDurationMap.values.fold(0, (a, b) => a + b);

//   return Column(
//     children: [
//       Text(
//         'Monthly Total: ${formatDuration(monthlyTotalDuration)}',
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 10),
//       ...dayTotalDurationMap.entries.map((entry) {
//         return Text(
//           'Day ${entry.key}: ${formatDuration(entry.value)}',
//           style: const TextStyle(fontSize: 12),
//         );
//       }),
//     ],
//   );
// }
// }












































// import 'package:flutter/material.dart';

// class Todo {
//   final DateTime date;
//   final TimeOfDay startTime;
//   final TimeOfDay endTime;

//   Todo({
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//   });
// }

// class YourWidget extends StatefulWidget {
//   @override
//   _YourWidgetState createState() => _YourWidgetState();
// }

// class _YourWidgetState extends State<YourWidget> {
//   late DateTime currentCalendarDateTime;
//   late int currentDay;
//   late TodoTaskDataModel todotaskdatamodel;
//   late Map<int, int> dayTotalDurationMap;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize your variables here
//     currentCalendarDateTime = DateTime.now();
//     currentDay = DateTime.now().day;
//     todotaskdatamodel = TodoTaskDataModel(); // Initialize your data model
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Month Total Working Hours:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             FutureBuilder<int>(
//               future: calculateMonthTotalDuration(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Text(
//                     formatDuration(snapshot.data ?? 0),
//                     style: TextStyle(fontSize: 16),
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Day-wise Working Hours:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//               child: getMonthTaskListWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<int> calculateMonthTotalDuration() async {
//     int totalMonthDurationMinutes = 0;

//     for (var tasklist in [
//       ...todotaskdatamodel.todoTask,
//       ...todotaskdatamodel.completedTasks
//     ]) {
//       if (isTaskInCurrentMonth(tasklist)) {
//         int totalDayDurationMinutes =
//             dayTotalDurationMap[tasklist.date.day] ?? 0;
//         totalMonthDurationMinutes += totalDayDurationMinutes;
//       }
//     }

//     return totalMonthDurationMinutes;
//   }

//   Widget getMonthTaskListWidget() {
//     Map<int, int> dayTotalDurationMap = calculateDayTotalDurations();

//     return ListView.builder(
//       itemCount: dayTotalDurationMap.length,
//       itemBuilder: (context, index) {
//         var entry = dayTotalDurationMap.entries.elementAt(index);
//         return ListTile(
//           title: Text(
//             'Day ${entry.key}',
//             style: TextStyle(fontSize: 16),
//           ),
//           subtitle: Text(
//             formatDuration(entry.value),
//             style: TextStyle(fontSize: 14),
//           ),
//         );
//       },
//     );
//   }

//   Map<int, int> calculateDayTotalDurations() {
//     Map<int, int> dayTotalDurationMap = {};

//     for (var tasklist in [
//       ...todotaskdatamodel.todoTask,
//       ...todotaskdatamodel.completedTasks
//     ]) {
//       if (isTaskInCurrentMonth(tasklist)) {
//         updateDayTotalDuration(dayTotalDurationMap, tasklist);
//       }
//     }

//     return dayTotalDurationMap;
//   }

//   bool isTaskInCurrentMonth(Todo task) {
//     return task.date.month == currentCalendarDateTime.month &&
//         task.date.year == currentCalendarDateTime.year;
//   }

//   void updateDayTotalDuration(Map<int, int> dayTotalDurationMap, Todo task) {
//     int totalDurationMinutes = calculateTotalDuration(task);
//     dayTotalDurationMap.update(
//       task.date.day,
//       (value) => value + totalDurationMinutes,
//       ifAbsent: () => totalDurationMinutes,
//     );
//   }

//   int calculateTotalDuration(Todo task) {
//     int taskDurationMinutes = (task.endTime!.hour * 60 + task.endTime!.minute) -
//         (task.startTime!.hour * 60 + task.startTime!.minute);

//     if (taskDurationMinutes < 0) {
//       taskDurationMinutes += 1440;
//     }

//     return taskDurationMinutes;
//   }

//   String formatDuration(int totalMinutes) {
//     int totalHours = totalMinutes ~/ 60;
//     int remainingMinutes = totalMinutes % 60;

//     return '${totalHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
//   }
// }

// class TodoTaskDataModel {
//   final List<Todo> todoTask;
//   final List<Todo> completedTasks;

//   TodoTaskDataModel({
//     this.todoTask = const [],
//     this.completedTasks = const [],
//   });
// }



































































































// import 'package:flutter/material.dart';

// class test extends StatefulWidget {
//   const test(bool completed, {super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Center(
//                     child: Column(
//                       children: [
//                         Container(
//                           width: double.infinity,
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 50,
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                   width: 20,
//                                   height: 20,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           width: 5,
//                                           color: Colors.red,
//                                           style: BorderStyle.solid)),
//                                 ),
//                               ),
//                               const Text('9:00 am - 9:15 am')
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: IntrinsicHeight(
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   width: 50,
//                                   alignment: Alignment.center,
//                                   child: IntrinsicHeight(
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                             color: Colors.grey,
//                                             width: 3,
//                                             height: 100),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     margin: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 20, horizontal: 10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Column(
//                                       children: const [
//                                         Text('Titre'),
//                                         Text('Info 1'),
//                                         Text('Info 2')
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





  //  ListTile(
  //           title: Center(
  //             child: Column(
  //               children: [
  //                 Container(
  //                     width: double.infinity,
  //                     child: Row(
  //                       children: [
  //                         Container(
  //                           width: 50,
  //                           alignment: Alignment.center,
  //                           child: Container(
  //                             width: 20,
  //                             height: 20,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(40),
  //                                 border: Border.all(
  //                                     width: 5,
  //                                     color: Colors.blue,
  //                                     style: BorderStyle.solid)),
  //                           ),
  //                         ),
  //                         const Text('9:00 am - 10:15 am')
  //                       ],
  //                     )),
  //                 Container(
  //                   child: IntrinsicHeight(
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.stretch,
  //                       children: [
  //                         Container(
  //                           width: 50,
  //                           alignment: Alignment.center,
  //                           child: IntrinsicHeight(
  //                             child: Row(
  //                               crossAxisAlignment: CrossAxisAlignment.stretch,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Container(
  //                                     color: Colors.grey,
  //                                     width: 3,
  //                                     height:
  //                                         100 // if I remove the size it desappear
  //                                     ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: Container(
  //                             margin: EdgeInsets.symmetric(vertical: 10),
  //                             padding: const EdgeInsets.symmetric(
  //                                 vertical: 20, horizontal: 10),
  //                             color: Colors.grey,
  //                             child: Column(
  //                               children: [
  //                                 Text('Titre'),
  //                                 Text('Info 1'),
  //                                 Text('Info 2')
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),


























// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:matcher/matcher.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/screen/Calender/model/calenar_model.dart';
// import 'package:todo/screen/Calender/widget/calendar_cell.dart';

// import 'screen/Calender/widget/calendar_header.dart';

// class Testpage extends StatefulWidget {
//   const Testpage({super.key});

//   @override
//   State<Testpage> createState() => _TestpageState();
// }

// class _TestpageState extends State<Testpage> {
//   List<Widget> getCalendarWidget() {
//     int numberOfDaysInMonth = 30;
//     const int startDate = 1;
//     final int endDate = numberOfDaysInMonth;

//     int startIdx = 1;
//     int endIdx = numberOfDaysInMonth;

//     // CommonFunction.console(numberOfDaysInMonth);
//     List<Widget> rowList = [];

//     // int weekDayStart = DateTime(_currentCalendarDateTime.year,
//     //         _currentCalendarDateTime.month, startDate)
//     //     .weekday;
//     // int weekDayEnd = DateTime(_currentCalendarDateTime.year,
//     //         _currentCalendarDateTime.month, endDate)
//     //     .weekday;

//     // CommonFunction.console("WeekDay Start : $weekDayStart");
//     // CommonFunction.console("WeekDay End : $weekDayEnd");
//     // CommonFunction.console("End Idx : $endIdx");
//     // CommonFunction.console("End Date : $endDate");
//     // CommonFunction.console("Current Datetime : $_currentCalendarDateTime");

//     int currentIdx = 1;
//     endIdx = 7;
//     late Widget calendarWidget = Container();
//     int cellCount = 1;
//     List<Widget> currentRow = [];
//     while (currentIdx <= endIdx) {
//       if (currentIdx >= startDate && currentIdx <= endDate) {
//         // currentRow.add(CalendarCell(currentDay: currentIdx));
//       } else {
//         // currentRow.add(
//         //   const CalendarCell(
//         //     currentDay: null,
//         //     isActive: false,
//         //   ),
//         // );
//       }
//       if (cellCount == 7) {
//         cellCount = 1;
//         double width = MediaQuery.of(context).size.width;

//         rowList.add(
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: SizedBox(
//               width: width * 0.85,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: currentRow,
//               ),
//             ),
//           ),
//         );
//         currentRow = [];
//       } else {
//         cellCount += 1;
//       }
//       currentIdx += 1;
//     }

//     return rowList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Navigationcalendar>(builder: (context, model, child) {
//       // List<Widget> calendarwidget = model.getCalendarWidget();
//       return SafeArea(
//         child: Scaffold(
//           body: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   height: 400,
//                   width: 380,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.grey,
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 0),
//                         child: SizedBox(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: const [
//                               CalendarHeader(
//                                 child: Text(
//                                   "Mon",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Tue",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Wed",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Thu",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Fri",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Sat",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Color(0xffCD4841)),
//                                 ),
//                               ),
//                               CalendarHeader(
//                                 child: Text(
//                                   "Sun",
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(color: Color(0xffCD4841)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 0.00),
//                         child: Column(children: getCalendarWidget()),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';

// class DynamicEvent extends StatefulWidget {
//   @override
//   _DynamicEventState createState() => _DynamicEventState();
// }

// class _DynamicEventState extends State<DynamicEvent> {
//   CalendarController _controller;
//   Map<DateTime, List<dynamic>> _events;
//   List<dynamic> _selectedEvents;
//   TextEditingController _eventController;
//   SharedPreferences prefs;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CalendarController();
//     _eventController = TextEditingController();
//     _events = {};
//     _selectedEvents = [];
//     prefsData();
//   }

//   prefsData() async {
//     prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _events = Map<DateTime, List<dynamic>>.from(
//           decodeMap(json.decode(prefs.getString("events") ?? "{}")));
//     });
//   }

//   Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
//     Map<String, dynamic> newMap = {};
//     map.forEach((key, value) {
//       newMap[key.toString()] = map[key];
//     });
//     return newMap;
//   }
//   Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
//     Map<DateTime, dynamic> newMap = {};
//     map.forEach((key, value) {
//       newMap[DateTime.parse(key)] = map[key];
//     });
//     return newMap;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black,
//         title: Text('Flutter Dynamic Event Calendar'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TableCalendar(
//               events: _events,
//               initialCalendarFormat: CalendarFormat.week,
//               calendarStyle: CalendarStyle(
//                   canEventMarkersOverflow: true,
//                   todayColor: Colors.orange,
//                   selectedColor: Theme.of(context).primaryColor,
//                   todayStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0,
//                       color: Colors.white)),
//               headerStyle: HeaderStyle(
//                 centerHeaderTitle: true,
//                 formatButtonDecoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 formatButtonTextStyle: TextStyle(color: Colors.white),
//                 formatButtonShowsNext: false,
//               ),
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               onDaySelected: (date, events,holidays) {
//                 setState(() {
//                   _selectedEvents = events;
//                 });
//               },
//               builders: CalendarBuilders(
//                 selectedDayBuilder: (context, date, events) => Container(
//                     margin: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: BorderRadius.circular(10.0)),
//                     child: Text(
//                       date.day.toString(),
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 todayDayBuilder: (context, date, events) => Container(
//                     margin: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(10.0)),
//                     child: Text(
//                       date.day.toString(),
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ),
//               calendarController: _controller, ,
//             ),
//             ..._selectedEvents.map((event) => Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: MediaQuery.of(context).size.height/20,
//                 width: MediaQuery.of(context).size.width/2,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey)
//                 ),
//                 child: Center(
//                     child: Text(event,
//                       style: TextStyle(color: Colors.blue,
//                           fontWeight: FontWeight.bold,fontSize: 16),)
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         child: Icon(Icons.add),
//         onPressed: _showAddDialog,
//       ),
//     );
//   }

//   _showAddDialog() async {
//     await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           backgroundColor: Colors.white70,
//           title: Text("Add Events"),
//           content: TextField(
//             controller: _eventController,
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text("Save",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
//               onPressed: () {
//                 if (_eventController.text.isEmpty) return;
//                 setState(() {
//                   if (_events[_controller.selectedDay] != null) {
//                     _events[_controller.selectedDay]
//                         .add(_eventController.text);
//                   } else {
//                     _events[_controller.selectedDay] = [
//                       _eventController.text
//                     ];
//                   }
//                   prefs.setString("events", json.encode(encodeMap(_events)));
//                   _eventController.clear();
//                   Navigator.pop(context);
//                 });

//               },
//             )
//           ],
//         ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class HomeCalendarPage extends StatefulWidget {
//   @override
//   _HomeCalendarPageState createState() => _HomeCalendarPageState();
// }

// class _HomeCalendarPageState extends State<HomeCalendarPage> {
//   CalendarController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CalendarController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Calendar Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TableCalendar(
//               initialCalendarFormat: CalendarFormat.month,
//               calendarStyle: CalendarStyle(
//                   todayColor: Colors.blue,
//                   selectedColor: Theme.of(context).primaryColor,
//                   todayStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22.0,
//                       color: Colors.white)),
//               headerStyle: HeaderStyle(
//                 centerHeaderTitle: true,
//                 formatButtonDecoration: BoxDecoration(
//                   color: Colors.brown,
//                   borderRadius: BorderRadius.circular(22.0),
//                 ),
//                 formatButtonTextStyle: TextStyle(color: Colors.white),
//                 formatButtonShowsNext: false,
//               ),
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               onDaySelected: (date, events) {
//                 print(date.toUtc());
//               },
//               builders: CalendarBuilders(
//                 selectedDayBuilder: (context, date, events) => Container(
//                     margin: const EdgeInsets.all(5.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: BorderRadius.circular(8.0)),
//                     child: Text(
//                       date.day.toString(),
//                       style: TextStyle(color: Colors.white),
//                     )),
//                 todayDayBuilder: (context, date, events) => Container(
//                     margin: const EdgeInsets.all(5.0),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8.0)),
//                     child: Text(
//                       date.day.toString(),
//                       style: TextStyle(color: Colors.white),
//                     )),
//               ),
//               calendarController: _controller,
//               firstDay: null,
//               focusedDay: null,
//               lastDay: null,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);

// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   List categoryItemlist = [];

// //   Future getAllCategory() async {
// //     var baseUrl = "https://gssskhokhar.com/api/classes/";

// //     http.Response response = await http.get(Uri.parse(baseUrl));

// //     if (response.statusCode == 200) {
// //       var jsonData = json.decode(response.body);
// //       setState(() {
// //         categoryItemlist = jsonData;
// //       });
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     getAllCategory();
// //   }

// //   var dropdownvalue;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("DropDown List"),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             DropdownButton(
// //               hint: Text('hooseNumber'),
// //               items: categoryItemlist.map((item) {
// //                 return DropdownMenuItem(
// //                   value: item['ClassCode'].toString(),
// //                   child: Text(item['ClassName'].toString()),
// //                 );
// //               }).toList(),
// //               onChanged: (newVal) {
// //                 setState(() {
// //                   dropdownvalue = newVal;
// //                 });
// //               },
// //               value: dropdownvalue,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';

// // class TimePickerWidget extends StatefulWidget {
// //   @override
// //   _TimePickerWidgetState createState() => _TimePickerWidgetState();
// // }

// // class _TimePickerWidgetState extends State<TimePickerWidget> {
// //   TimeOfDay _startTime = TimeOfDay.now();
// //   TimeOfDay _endTime = TimeOfDay.now();

// //   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
// //     TimeOfDay? pickedTime = await showTimePicker(
// //       context: context,
// //       initialTime: isStartTime ? _startTime : _endTime,
// //     );

// //     if (pickedTime != null && isStartTime) {
// //       setState(() {
// //         _startTime = pickedTime;
// //       });
// //     } else if (pickedTime != null && !isStartTime) {
// //       setState(() {
// //         _endTime = pickedTime;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         ElevatedButton(
// //           onPressed: () => _selectTime(context, true),
// //           child: Text('Select Start Time'),
// //         ),
// //         SizedBox(height: 20),
// //         Text('Start Time: ${_startTime.format(context)}'),
// //         SizedBox(height: 20),
// //         ElevatedButton(
// //           onPressed: () => _selectTime(context, false),
// //           child: Text('Select End Time'),
// //         ),
// //         SizedBox(height: 20),
// //         Text('End Time: ${_endTime.format(context)}'),
// //       ],
// //     );
// //   }
// // }

// // // import 'dart:async';

// // // import 'package:flutter/material.dart';

// // // class NewStopWatch extends StatefulWidget {
// // //   @override
// // //   _NewStopWatchState createState() => _NewStopWatchState();
// // // }

// // // class _NewStopWatchState extends State<NewStopWatch> {
// // //   Stopwatch watch = Stopwatch();
// // //   Timer? timer;
// // //   bool startStop = true;

// // //   String elapsedTime = '';

// // //   updateTime(Timer timer) {
// // //     if (watch.isRunning) {
// // //       setState(() {
// // //         print("startstop Inside=$startStop");
// // //         elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
// // //       });
// // //     }
// // //     print(elapsedTime);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: Container(
// // //           padding: EdgeInsets.all(20.0),
// // //           child: Column(
// // //             children: <Widget>[
// // //               Text(elapsedTime, style: TextStyle(fontSize: 25.0)),
// // //               SizedBox(height: 20.0),
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: <Widget>[
// // //                   FloatingActionButton(
// // //                       heroTag: "btn1",
// // //                       backgroundColor: Colors.red,
// // //                       onPressed: () => startOrStop(),
// // //                       child: Icon(Icons.pause)),
// // //                   SizedBox(width: 20.0),
// // //                   FloatingActionButton(
// // //                       heroTag: "btn2",
// // //                       backgroundColor: Colors.green,
// // //                       onPressed: null, //resetWatch,
// // //                       child: Icon(Icons.check)),
// // //                 ],
// // //               )
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   startOrStop() {
// // //     if (startStop) {
// // //       startWatch();
// // //     } else {
// // //       stopWatch();
// // //     }
// // //   }

// // //   startWatch() {
// // //     setState(() {
// // //       startStop = false;
// // //       watch.start();
// // //       timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
// // //     });
// // //   }

// // //   stopWatch() {
// // //     setState(() {
// // //       startStop = true;
// // //       watch.stop();
// // //       setTime();
// // //     });
// // //   }

// // //   setTime() {
// // //     var timeSoFar = watch.elapsedMilliseconds;
// // //     setState(() {
// // //       elapsedTime = transformMilliSeconds(timeSoFar);
// // //     });
// // //   }

// // //   transformMilliSeconds(int milliseconds) {
// // //     int hundreds = (milliseconds / 10).truncate();
// // //     int seconds = (hundreds / 100).truncate();
// // //     int minutes = (seconds / 60).truncate();
// // //     int hours = (minutes / 60).truncate();

// // //     String hoursStr = (hours % 60).toString().padLeft(2, '0');
// // //     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
// // //     String secondsStr = (seconds % 60).toString().padLeft(2, '0');

// // //     return "$hoursStr:$minutesStr:$secondsStr";
// // //   }
// // // }

// // // // import 'dart:io';

// // // // import 'package:checkmark/checkmark.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:image_picker/image_picker.dart';

// // // // class profilePage extends StatefulWidget {
// // // //   @override
// // // //   profilePageState createState() => profilePageState();
// // // // }

// // // // class profilePageState extends State<profilePage> {
// // // //   final ImagePicker picker = ImagePicker();
// // // //   XFile? image;

// // // //   Future getImage(ImageSource source) async {
// // // //     var pickedFile = await picker.pickImage(source: source);

// // // //     setState(
// // // //       () {
// // // //         if (pickedFile != null) {
// // // //           image = XFile(pickedFile.path);
// // // //           print('image selected.');
// // // //         } else {
// // // //           print('No image selected.');
// // // //         }
// // // //       },
// // // //     );
// // // //   }

// // // //   Widget buildImageButton(String text, ImageSource source) {
// // // //     return InkWell(
// // // //       onTap: () {
// // // //         getImage(source);
// // // //       },
// // // //       child: Container(
// // // //         padding: const EdgeInsets.all(10),
// // // //         decoration: BoxDecoration(
// // // //           borderRadius: BorderRadius.circular(15),
// // // //           border: Border.all(color: Colors.black),
// // // //         ),
// // // //         child: Text(text),
// // // //       ),
// // // //     );
// // // //   }

// // // //   bool checked = false;

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     double width = MediaQuery.of(context).size.width;
// // // //     double height = MediaQuery.of(context).size.height;

// // // //     return Scaffold(
// // // //         body: Center(
// // // //       child: Container(
// // // //         height: MediaQuery.of(context).size.height,
// // // //         width: MediaQuery.of(context).size.width,
// // // //         alignment: Alignment.center,
// // // //         child: GestureDetector(
// // // //           onTap: () {
// // // //             setState(() {
// // // //               checked = !checked;
// // // //             });
// // // //           },
// // // //           child: SizedBox(
// // // //             height: 50,
// // // //             width: 50,
// // // //             child: CheckMark(
// // // //               active: checked,
// // // //               activeColor: Colors.green,
// // // //               inactiveColor: Colors.blueGrey,
// // // //               strokeJoin: StrokeJoin.bevel,
// // // //               strokeWidth: 8,
// // // //               strokeCap: StrokeCap.butt,
// // // //               curve: Curves.decelerate,
// // // //               duration: const Duration(milliseconds: 1000),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     ));
// // // //   }
// // // // }

// // // // // body: Center(
// // // //       //   child: ElevatedButton(
// // // //       //       onPressed: () {
// // // //       //         showDialog(
// // // //       //             context: context,
// // // //       //             builder: (context) {
// // // //       //               return Dialog(
// // // //       //                 backgroundColor: Colors.transparent,
// // // //       //                 elevation: 0,
// // // //       //                 insetPadding: const EdgeInsets.all(20),
// // // //       //                 shape: RoundedRectangleBorder(
// // // //       //                     borderRadius: BorderRadius.circular(20)),
// // // //       //                 child: SingleChildScrollView(
// // // //       //                   child: Container(
// // // //       //                     decoration: BoxDecoration(
// // // //       //                         color: Colors.white,
// // // //       //                         borderRadius: BorderRadius.circular(20)),
// // // //       //                     child: Column(
// // // //       //                       mainAxisSize: MainAxisSize.min,
// // // //       //                       children: [
// // // //       //                         // SizedBox(
// // // //       //                         //   width: double.infinity,
// // // //       //                         //   child: IconButton(
// // // //       //                         //     onPressed: () {
// // // //       //                         //       Navigator.pop(context);
// // // //       //                         //     },
// // // //       //                         //     icon: const Icon(Icons.cancel),
// // // //       //                         //     alignment: Alignment.centerRight,
// // // //       //                         //     color: Colors.grey,
// // // //       //                         //   ),
// // // //       //                         // ),
// // // //       //                         SizedBox(
// // // //       //                           height: height * 0.02,
// // // //       //                         ),
// // // //       //                         const Text(
// // // //       //                           "Add Project",
// // // //       //                           style: TextStyle(
// // // //       //                             color: Colors.black,
// // // //       //                             fontSize: 18,
// // // //       //                             fontWeight: FontWeight.bold,
// // // //       //                           ),
// // // //       //                         ),
// // // //       //                         SizedBox(
// // // //       //                           height: height * 0.03,
// // // //       //                         ),
// // // //       //                         Padding(
// // // //       //                           padding:
// // // //       //                               const EdgeInsets.symmetric(horizontal: 20),
// // // //       //                           child: Container(
// // // //       //                             decoration: BoxDecoration(
// // // //       //                               borderRadius: BorderRadius.circular(10),
// // // //       //                               color: Colors.grey[300],
// // // //       //                             ),
// // // //       //                             child: Column(
// // // //       //                               children: [
// // // //       //                                 SizedBox(height: height * 0.01),
// // // //       //                                 const Text(
// // // //       //                                   "Select your image",
// // // //       //                                   style: TextStyle(
// // // //       //                                     fontSize: 15,
// // // //       //                                     color: Colors.black,
// // // //       //                                     fontWeight: FontWeight.w400,
// // // //       //                                   ),
// // // //       //                                 ),
// // // //       //                                 SizedBox(height: height * 0.02),
// // // //       //                                 Row(
// // // //       //                                   mainAxisAlignment:
// // // //       //                                       MainAxisAlignment.center,
// // // //       //                                   children: [
// // // //       //                                     buildImageButton("Gallery image",
// // // //       //                                         ImageSource.gallery),
// // // //       //                                     SizedBox(width: width * 0.10),
// // // //       //                                     buildImageButton("Take picture",
// // // //       //                                         ImageSource.camera),
// // // //       //                                   ],
// // // //       //                                 ),
// // // //       //                                 SizedBox(height: height * 0.02),
// // // //       //                                 Container(
// // // //       //                                   height: 200,
// // // //       //                                   width: 300,
// // // //       //                                   decoration: BoxDecoration(
// // // //       //                                       color: Colors.white,
// // // //       //                                       borderRadius:
// // // //       //                                           BorderRadiusDirectional
// // // //       //                                               .circular(10)),
// // // //       //                                   child: image != null
// // // //       //                                       ? Image.file(
// // // //       //                                           File(image!.path),
// // // //       //                                           fit: BoxFit.fill,
// // // //       //                                         )
// // // //       //                                       : const Center(
// // // //       //                                           child: Text("No image"),
// // // //       //                                         ),
// // // //       //                                 ),
// // // //       //                                 SizedBox(height: height * 0.02),
// // // //       //                               ],
// // // //       //                             ),
// // // //       //                           ),
// // // //       //                         ),
// // // //       //                         // SizedBox(
// // // //       //                         //   height: height * 0.02,
// // // //       //                         // ),
// // // //       //                         // Padding(
// // // //       //                         //   padding: const EdgeInsets.only(right: 20, left: 20),
// // // //       //                         //   child: TextFormField(
// // // //       //                         //     controller: projectnamecontroller,
// // // //       //                         //     validator: (value) {
// // // //       //                         //       if (value!.isEmpty) {
// // // //       //                         //         return 'Enter a Task Name ';
// // // //       //                         //       } else {
// // // //       //                         //         return null;
// // // //       //                         //       }
// // // //       //                         //     },
// // // //       //                         //     decoration: InputDecoration(
// // // //       //                         //       filled: true,
// // // //       //                         //       fillColor: Colors.grey[300],
// // // //       //                         //       hintText: "Task Name",
// // // //       //                         //       contentPadding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
// // // //       //                         //       border: OutlineInputBorder(
// // // //       //                         //           borderRadius: BorderRadius.circular(10),
// // // //       //                         //           borderSide: BorderSide.none),
// // // //       //                         //     ),
// // // //       //                         //   ),
// // // //       //                         // ),
// // // //       //                         // SizedBox(
// // // //       //                         //   height: height * 0.03,
// // // //       //                         // ),
// // // //       //                         // Row(
// // // //       //                         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //       //                         //   children: [
// // // //       //                         //     InkWell(
// // // //       //                         //       onTap: () {
// // // //       //                         //         Navigator.pop(context);
// // // //       //                         //       },
// // // //       //                         //       child: Container(
// // // //       //                         //         height: height * 0.06,
// // // //       //                         //         width: width * 0.30,
// // // //       //                         //         decoration: BoxDecoration(
// // // //       //                         //             borderRadius: BorderRadius.circular(10),
// // // //       //                         //             border: Border.all(color: Colors.red)),
// // // //       //                         //         child: const Center(
// // // //       //                         //           child: Text(
// // // //       //                         //             "Cancle",
// // // //       //                         //             style: TextStyle(
// // // //       //                         //               color: Colors.red,
// // // //       //                         //               fontSize: 18,
// // // //       //                         //               fontWeight: FontWeight.bold,
// // // //       //                         //             ),
// // // //       //                         //           ),
// // // //       //                         //         ),
// // // //       //                         //       ),
// // // //       //                         //     ),
// // // //       //                         //     // InkWell(
// // // //       //                         //     //   onTap: () {
// // // //       //                         //     //     addproject(context);
// // // //       //                         //     //   },
// // // //       //                         //     //   child: Container(
// // // //       //                         //     //     height: height * 0.06,
// // // //       //                         //     //     width: width * 0.30,
// // // //       //                         //     //     decoration: BoxDecoration(
// // // //       //                         //     //         borderRadius: BorderRadius.circular(10),
// // // //       //                         //     //         border: Border.all(
// // // //       //                         //     //           color: Colors.lightGreen,
// // // //       //                         //     //         )),
// // // //       //                         //     //     child: const Center(
// // // //       //                         //     //       child: Text(
// // // //       //                         //     //         "ADD",
// // // //       //                         //     //         style: TextStyle(
// // // //       //                         //     //           color: Colors.green,
// // // //       //                         //     //           fontSize: 15,
// // // //       //                         //     //           fontWeight: FontWeight.bold,
// // // //       //                         //     //         ),
// // // //       //                         //     //       ),
// // // //       //                         //     //     ),
// // // //       //                         //     //   ),
// // // //       //                         //     // ),
// // // //       //                         //   ],
// // // //       //                         // ),
// // // //       //                         SizedBox(height: 30),
// // // //       //                       ],
// // // //       //                     ),
// // // //       //                   ),
// // // //       //                 ),
// // // //       //               );
// // // //       //               ;
// // // //       //             });

// // // //       //         print('Add icon clicked!');
// // // //       //       },
// // // //       //       child: Text("Text Button")),
// // // //       // ),
