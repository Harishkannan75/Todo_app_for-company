import 'package:flutter/material.dart';

import '../../../common/Provider/todo_class.dart';
import '../../../common/Provider/todo_provider.dart';
import 'dispaly_task_details_widget.dart';

class CompletedTaskList extends StatelessWidget {
  const CompletedTaskList({super.key, required this.completedtasksdata});
  final TodoProvider completedtasksdata;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return completedtasksdata.completedTasks.isNotEmpty
        ? ListView.builder(
            itemCount: completedtasksdata.completedTasks.length,
            itemBuilder: (context, index) {
              Todo completedtask = completedtasksdata.completedTasks[index];
              int totalDurationMinutes = (completedtask.endTime!.hour * 60 +
                      completedtask.endTime!.minute) -
                  (completedtask.startTime!.hour * 60 +
                      completedtask.startTime!.minute);
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
                          tasklistdata: completedtask,
                          taskDuration: formattedTotalDuration,
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: height * 0.12,
                    width: width * 0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
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
                                completedtask.projectFolder,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.06),
                              child: Text(completedtask.taskname),
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
                                  Text(formattedTotalDuration),
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
                                  Text(completedtask.priority)
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Container(
                        //       height: height * 0.05,
                        //       width: width * 0.10,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: Colors.red,
                        //       ),
                        //       child: const Center(
                        //         child: Icon(
                        //           Icons.delete,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text("Currently NO completed Task"),
          );
  }
}
