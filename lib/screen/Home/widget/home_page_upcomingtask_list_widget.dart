import 'package:flutter/material.dart';
import 'package:todo/screen/Home/widget/dispaly_task_details_widget.dart';

import '../../../common/Provider/todo_class.dart';
import '../../../common/Provider/todo_provider.dart';

class UpcomingTaskList extends StatefulWidget {
  final TodoProvider todotaskdatamodel;

  const UpcomingTaskList({super.key, required this.todotaskdatamodel});

  @override
  State<UpcomingTaskList> createState() => _UpcomingTaskListState();
}

class _UpcomingTaskListState extends State<UpcomingTaskList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return widget.todotaskdatamodel.todoTask.isNotEmpty
        ? ListView.builder(
            itemCount: widget.todotaskdatamodel.todoTask.length,
            itemBuilder: (context, index) {
              Todo task = widget.todotaskdatamodel.todoTask[index];
              int totalDurationMinutes =
                  (task.endTime!.hour * 60 + task.endTime!.minute) -
                      (task.startTime!.hour * 60 + task.startTime!.minute);
              if (totalDurationMinutes < 0) {
                totalDurationMinutes += 1440;
              }
              int totalDurationHours = totalDurationMinutes ~/ 60;
              int remainingMinutes = totalDurationMinutes % 60;

              String formattedTotalDuration =
                  '${totalDurationHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
              return InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DispalyTaskDatailsWidget(
                        tasklistdata: task,
                        taskDuration: formattedTotalDuration,
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: height * 0.12,
                    width: width * 0.20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06),
                              child: Text(
                                task.projectFolder,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06),
                              child: Text(
                                task.taskname,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Text(
                                    formattedTotalDuration,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Image.asset(
                                    "Assets/Logs/price_tag.png",
                                    height: 15,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  Text(
                                    task.priority,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.todotaskdatamodel.deleteTask(index);
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                widget.todotaskdatamodel
                                    .markTaskAsCompleted(index);
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text("Currently NO Task"),
          );
  }
}
