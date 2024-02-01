import 'package:flutter/material.dart';
import 'package:todo/common/Provider/todo_provider.dart';
import 'package:todo/screen/Home/search%20task/widget/filter_display_list.dart';

import '../../../common/Provider/todo_class.dart';

class SearchTask extends StatefulWidget {
  final TodoProvider taskmodeldata;
  const SearchTask({super.key, required this.taskmodeldata});

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  List<String> priorityItems = ['Pending', 'completed'];
  String selectedFildertask = 'Pending';
  TextEditingController searchcontrollertext = TextEditingController();

  List<Todo>? getTaskDetails(TodoProvider todotaskdata) {
    List<Todo> taskslist = [];

    for (var tasklist in [
      ...todotaskdata.todoTask,
      ...todotaskdata.completedTasks,
    ]) {
      taskslist.add(tasklist);
    }
    return taskslist;
  }

  List<Todo>? filteredTasksList(String searchQuery, List<Todo>? allTasks) {
    if (searchQuery.isEmpty || allTasks == null) {
      return allTasks;
    }

    return allTasks
        .where((task) =>
            task.projectFolder.toLowerCase().contains(searchQuery) ||
            task.taskname.toLowerCase().contains(searchQuery) ||
            task.priority.toLowerCase().contains(searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Todo>? taskList = getTaskDetails(widget.taskmodeldata);
    List<Todo>? filteredTasks =
        filteredTasksList(searchcontrollertext.text.toLowerCase(), taskList);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(right: 0, left: 0),
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                controller: searchcontrollertext,
                onChanged: (value) {
                  setState(() {
                    filteredTasks =
                        filteredTasksList(value.toLowerCase(), taskList);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: const Icon(Icons.search_outlined),
                  hintText: "Enter a Tasks",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal, width: 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
                child: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: Container(
            child: filteredTasks != null && filteredTasks!.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredTasks!.length,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Todo tasklists = filteredTasks![index];
                      int totalDurationMinutes = (tasklists.endTime!.hour * 60 +
                              tasklists.endTime!.minute) -
                          (tasklists.startTime!.hour * 60 +
                              tasklists.startTime!.minute);
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
                                return FilterListwidgt(
                                  tasklistdata: tasklists,
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
                                color: Colors.teal[50]),
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
                                        tasklists.projectFolder,
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
                                      child: Text(tasklists.taskname),
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
                                          Text(tasklists.priority)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width * 0.08,
                                  decoration: BoxDecoration(
                                    color: tasklists.completed == true
                                        ? Colors.green[400]
                                        : Colors.orange[400],
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: RotatedBox(
                                      quarterTurns: -1,
                                      child: Text(
                                        tasklists.completed
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
                                // SizedBox(
                                //   width: width * 0.01,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("No tasks match the search criteria"),
                  ),
          ),
        ),
      ),
    );
  }
}
