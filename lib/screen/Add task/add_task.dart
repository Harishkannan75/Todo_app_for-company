import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/Provider/todo_class.dart';
import '../../common/Provider/todo_provider.dart';

class AddTaskpage extends StatefulWidget {
  const AddTaskpage({super.key});

  @override
  State<AddTaskpage> createState() => _AddTaskpageState();
}

class _AddTaskpageState extends State<AddTaskpage> {
  bool isVisible = false;
  String selectedPriority = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = const TimeOfDay(hour: 10, minute: 00);
  TimeOfDay selectedEndtime = const TimeOfDay(hour: 19, minute: 00);
  TextEditingController descpcontroller = TextEditingController();
  TextEditingController taskNamecontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var selectProjectOption;
  Future<void> datePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> timePicker(
      BuildContext context, bool isSelectedTypeOfTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isSelectedTypeOfTime ? selectedStartTime : selectedEndtime,
    );
    // print(_selectedTime);
    if (pickedTime != null && isSelectedTypeOfTime) {
      setState(() {
        selectedStartTime = pickedTime;
      });
    }
    if (pickedTime != null && !isSelectedTypeOfTime) {
      setState(() {
        selectedEndtime = pickedTime;
      });
    }
  }

  Duration _selectedDuration = const Duration(hours: 0, minutes: 0);

  // Future<void> _selectDuration(BuildContext context) async {
  //   final pickedDuration = await showDurationPicker(
  //     context: context,
  //     initialTime: _selectedDuration,
  //   );

  //   if (pickedDuration != null && pickedDuration != _selectedDuration) {
  //     setState(() {
  //       _selectedDuration = pickedDuration;
  //     });
  //   }
  // }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    if (hours > 0) {
      return '$hours h $minutes min';
    } else {
      return '$hours h $minutes min';
    }
  }

  Future<void> addtask(BuildContext context) async {
    final String selecedproject = selectProjectOption!;
    final String taskDescription = descpcontroller.text;
    final DateTime date = selectedDate;
    final Duration selecteddurationtime = _selectedDuration;
    final String priority = selectedPriority;
    final String taskname = taskNamecontroller.text;

    if (taskDescription.isNotEmpty &&
        // ignore: unnecessary_null_comparison
        date != null &&
        // ignore: unnecessary_null_comparison
        selecteddurationtime != null &&
        priority.isNotEmpty &&
        selecedproject != "") {
      final Todo todotask = Todo(
        date: date,
        description: taskDescription,
        priority: priority,
        projectFolder: selecedproject,
        timeDuration: selecteddurationtime.toString(),
        taskname: taskname,
        endTime: selectedEndtime,
        startTime: selectedStartTime,
      );

      Provider.of<TodoProvider>(context, listen: false).addtask(todotask);

      setState(() {
        selectProjectOption = null;
        _selectedDuration = const Duration();
        selectedPriority = "";
        descpcontroller.clear();
        taskNamecontroller.clear();
        selectedDate = DateTime.now();
        selectedEndtime = const TimeOfDay(hour: 19, minute: 00);
        selectedStartTime = const TimeOfDay(hour: 10, minute: 00);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task added successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please fill all fields.'),
        ),
      );
    }
  }

  List<String> getProjectName(BuildContext context) {
    List<TodoProject> todoProjects =
        Provider.of<TodoProvider>(context, listen: false).todoproject;
    List<String> projectNames =
        todoProjects.map((project) => project.projectname).toList();

    if (projectNames != []) {
      return projectNames;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please Add Project.'),
        ),
      );
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> priorityItems = ['High', 'Medium', 'Low'];

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.teal[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.2,
          title: const Text(
            "Add Task ",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    addtask(context);
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  child: const Center(
                    child: Text(
                      "ADD",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: FocusDetector(
            onFocusGained: () async {
              getProjectName(context);
            },
            child: Form(
              key: formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "   Select project",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CircleAvatar(
                            backgroundColor: Colors.teal.withOpacity(0.15),
                            child: const Icon(
                              Icons.folder_copy_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 18, 15, 18),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 243, 243, 243),
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      dropdownColor: Colors.white,
                      value: selectProjectOption,
                      borderRadius: BorderRadius.circular(10),
                      alignment: Alignment.center,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectProjectOption = value;
                        });
                      },
                      items:
                          getProjectName(context).map<DropdownMenuItem<String>>(
                        (projectnameslist) {
                          return DropdownMenuItem<String>(
                            value: projectnameslist,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                projectnameslist,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: TextFormField(
                      controller: taskNamecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Task Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        prefixIcon: Align(
                          widthFactor: 1.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.teal.withOpacity(0.15),
                              child: const Icon(
                                Icons.task_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        hintText: "Task Name",
                        helperStyle: const TextStyle(
                          color: Colors.black,
                          // fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.withOpacity(0.15),
                              child: Image.asset(
                                "Assets/Logs/price_tag.png",
                                height: 25,
                                color: Colors.black,
                              ),
                            ),
                            title: const Text("Priority"),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          SizedBox(
                            height: height * 0.05,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: priorityItems.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedPriority = priorityItems[index];
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: width * 0.04),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.07),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.black),
                                      color: selectedPriority ==
                                              priorityItems[index]
                                          ? Colors.teal
                                          : Colors.transparent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        priorityItems[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: selectedPriority ==
                                                  priorityItems[index]
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: InkWell(
                      onTap: () {
                        datePicker();
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal.withOpacity(0.15),
                            child: Image.asset(
                              "Assets/calendar_icon.png",
                              width: 30,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            DateFormat("MMMM, dd, yyyy").format(selectedDate),
                          ),
                          trailing: const Icon(Icons.arrow_drop_down_sharp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          timePicker(context, true);
                        },
                        child: Container(
                          width: 160,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // ignore: unnecessary_null_comparison
                              selectedStartTime == null
                                  ? const Text("Start Time")
                                  // ignore: unnecessary_null_comparison
                                  : Text(selectedStartTime != null
                                      ? selectedStartTime.format(context)
                                      : "00:00"),
                              CircleAvatar(
                                backgroundColor: Colors.teal.withOpacity(0.15),
                                radius: 20,
                                child: const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          timePicker(context, false);
                        },
                        child: Container(
                          width: 160,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              selectedEndtime == null
                                  ? const Text("end Time")
                                  // ignore: unnecessary_null_comparison
                                  : Text(selectedEndtime != null
                                      ? selectedEndtime.format(context)
                                      : "0:00"),
                              CircleAvatar(
                                backgroundColor: Colors.teal.withOpacity(0.15),
                                radius: 20,
                                child: const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Notes ';
                        } else {
                          return null;
                        }
                      },
                      controller: descpcontroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Add a new task..",
                        contentPadding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 20,
                      minLines: 11,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
