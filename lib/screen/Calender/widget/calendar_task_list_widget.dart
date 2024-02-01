import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:todo/common/Provider/todo_class.dart';
import 'package:todo/common/Provider/todo_provider.dart';

class ShoetasKdatalist extends StatelessWidget {
  final TodoProvider todotaskdata;
  final DateTime? currentDay;
  const ShoetasKdatalist(
      {super.key, required this.todotaskdata, required this.currentDay});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Todo>? taskList = getTaskDetails(currentDay!);
    return FocusDetector(
      onFocusGained: () {
        getTaskDetails(currentDay!);
      },
      child: SizedBox(
        height: 420,
        child: taskList == null || taskList.isEmpty
            ? const SizedBox(
                height: 100,
                width: 200,
                child: Center(
                  child: Text("No Data",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              )
            : ListView.builder(
                itemCount: taskList.length,
                // physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Todo task = taskList[index];
                  int descriptionlenght = task.description.length;

                  return ListTile(
                    title: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 5,
                                        color: Colors.teal,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                 ),
                                Text(
                                    '${task.startTime!.format(context)} - ${task.endTime!.format(context)} - ${task.projectFolder}')
                              ],
                            ),
                          ),
                          SizedBox(
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            width: 3,
                                            height:
                                                descriptionlenght.toDouble(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.77,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.teal[50],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: task.taskname,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const TextSpan(
                                                          text: ' - ',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: task.priority,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 0),
                                                child: Text(
                                                  task.description,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.08,
                                          decoration: BoxDecoration(
                                            color: task.completed == true
                                                ? Colors.green[400]
                                                : Colors.orange[400],
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Center(
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: Text(
                                                task.completed
                                                    ? "Completed"
                                                    : "Pending",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  List<Todo>? getTaskDetails(DateTime currentDate) {
    List<Todo> matchingDaysTasks = [];

    for (var tasklist in [
      ...todotaskdata.todoTask,
      ...todotaskdata.completedTasks,
    ]) {
      if (tasklist.date.day == currentDate.day &&
          tasklist.date.month == currentDate.month &&
          tasklist.date.year == currentDate.year) {
        matchingDaysTasks.add(tasklist);
      }
    }
    return matchingDaysTasks;
  }
}
