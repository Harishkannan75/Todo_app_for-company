import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo/screen/Home/Project%20Folders/Add%20project/add_project_widget.dart';
import 'package:todo/screen/Home/search%20task/search_task.dart';
import '../../common/Provider/todo_class.dart';
import '../../common/Provider/todo_provider.dart';
import 'package:focus_detector/focus_detector.dart';

import 'Settings/settings.dart';
import 'widget/compled_task_list_widget.dart';
import 'widget/home_page_upcomingtask_list_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _username = '';
  int getTaskCountForProject(TodoProvider todoTaskDatas, String projectFolder) {
    List<Todo>? taskList = getTaskDetails(todoTaskDatas, projectFolder);
    return taskList != null ? taskList.length : 0;
  }

  List<Todo>? getTaskDetails(TodoProvider todoTaskDatas, String projectFolder) {
    return [
      ...todoTaskDatas.todoTask,
      ...todoTaskDatas.completedTasks,
    ]
        .where(
          (tasklist) => tasklist.projectFolder == projectFolder,
        )
        .toList();
  }

  // Future<void> checkIfUsernameExists(BuildContext context) async {
  //   final usernameProvider =
  //       Provider.of<UsernameProvider>(context, listen: false);
  //   String savedUsername = usernameProvider.username;

  //   if (savedUsername.isEmpty) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Getusername();
  //       },
  //     );
  //   }
  // }

  // Future<void> getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String savedUsername = prefs.getString('username') ?? '';
  //   setState(() {
  //     _username = savedUsername;
  //   });
  // }
  // Future<void> getUsername(BuildContext context) async {
  //   final usernameProvider =
  //       Provider.of<UsernameProvider>(context, listen: false);
  //   String savedUsername = usernameProvider.username;
  //   setState(() {
  //     _username = savedUsername;
  //   });
  // }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon !';
    }
    return 'Good Evening !';
  }

  Route _createRoute(TodoProvider todotaskmodel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SearchTask(
        taskmodeldata: todotaskmodel,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<TodoProvider>(builder: (context, todotaskmodel, child) {
        return ModalProgressHUD(
          inAsyncCall: TodoProvider().isLoading,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: ListTile(
                hoverColor: Colors.blue,
                title: Align(
                  alignment: const Alignment(-1.2, 0),
                  child: Text(
                    greeting(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                subtitle: Align(
                  alignment: const Alignment(-1.1, 0),
                  child: _username.isNotEmpty
                      ? Text(
                          _username,
                          style: const TextStyle(color: Colors.black),
                        )
                      : const Text("Hello!"),
                ),
              ),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 20.0),
              //     child: GestureDetector(
              //       onTap: () {
              //         //----------------
              //       },
              //       child: const Icon(
              //         Icons.notifications_active,
              //         color: Colors.black,
              //         size: 26.0,
              //       ),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.only(right: 20.0),
              //     child: GestureDetector(
              //       onTap: () {
              //         // Navigator.push(
              //         //     context,
              //         //     MaterialPageRoute(
              //         //         builder: (context) => const SettingsScreens()));
              //       },
              //       child: const Icon(
              //         Icons.settings_outlined,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ],
            ),
            body: FocusDetector(
              onFocusGained: () async {
                await todotaskmodel.fetchtaskdata();
                await todotaskmodel.fetchtodoproject();
                // await checkIfUsernameExists(context);
                // await getUsername(context);
              },
              child: SingleChildScrollView(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Center(
                        child: Text(
                          "Flutter Team",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(_createRoute(todotaskmodel));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 20),
                          child: Container(
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.teal[100]),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Icon(Icons.search_outlined),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Text("Search a Tasks")
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: const Text(
                            "PROJECT FOLDERS",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.16,
                        child: todotaskmodel.todoproject.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: todotaskmodel.todoproject.length + 1,
                                itemBuilder: (context, index) {
                                  bool isLastItem =
                                      index == todotaskmodel.todoproject.length;

                                  if (isLastItem) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18, 0, 30, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Addproject();
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: width * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.teal.withOpacity(0.15),
                                          ),
                                          child: const Center(
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 35,
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    TodoProject todoprojectdata =
                                        todotaskmodel.todoproject[index];
                                    List<Todo>? taskList = getTaskDetails(
                                        todotaskmodel,
                                        todoprojectdata.projectname);

                                    int getTaskCount =
                                        taskList != null ? taskList.length : 0;

                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18, 0, 30, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          //-----------------
                                        },
                                        child: Container(
                                          width: width * 0.40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Colors.teal.withOpacity(0.15),
                                          ),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                todoprojectdata.imagepath !=
                                                        null
                                                    ? Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        height: height * 0.05,
                                                        width: width * 0.09,
                                                        child: Center(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child: Image.file(
                                                                File(todoprojectdata
                                                                    .imagepath!),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      )
                                                    : const Placeholder(
                                                        fallbackHeight: 50,
                                                        fallbackWidth: 80,
                                                      ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                ListTile(
                                                  title: Text(todoprojectdata
                                                      .projectname),
                                                  subtitle: Text(
                                                      '$getTaskCount task'),
                                                  trailing: const Icon(Icons
                                                      .arrow_right_outlined),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            : Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Currently no project"),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Addproject();
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "  Add Task",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: const Text(
                            "TASKS",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: 50,
                        child: PreferredSize(
                          preferredSize: const Size.fromHeight(10.0),
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            bottom: const TabBar(
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Upcoming",
                                    selectionColor: Colors.red,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Completed",
                                    selectionColor: Colors.red,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Missing task",
                                    selectionColor: Colors.red,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        height: 600,
                        child: TabBarView(
                          children: [
                            // first tab bar view widget
                            Container(
                              color: Colors.teal[100],
                              child: Center(
                                  child: UpcomingTaskList(
                                      todotaskdatamodel: todotaskmodel)),
                            ),

                            // second tab bar viiew widget
                            Container(
                              color: Colors.teal[100],
                              child: Center(
                                  child: CompletedTaskList(
                                      completedtasksdata: todotaskmodel)),
                            ),
                            Container(
                              color: Colors.teal[100],
                              child: const Center(
                                child: Text("Display missing tasks"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
