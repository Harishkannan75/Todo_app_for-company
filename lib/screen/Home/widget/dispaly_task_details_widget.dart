import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../common/Provider/todo_class.dart';
import '../search task/widget/Filter_task_list_widget.dart';

class DispalyTaskDatailsWidget extends StatelessWidget {
  final Todo tasklistdata;
  final String taskDuration;
  const DispalyTaskDatailsWidget(
      {super.key, required this.tasklistdata, required this.taskDuration});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                  alignment: Alignment.centerRight,
                  color: Colors.grey,
                ),
              ),
              const Text(
                "Task Details",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                filedName: "Project Name     ",
                taskdata: tasklistdata.projectFolder,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                filedName: "Task Name          ",
                taskdata: tasklistdata.taskname,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                  filedName: "Task Date            ",
                  taskdata: DateFormat('MMMM dd, yyyy')
                      .format(tasklistdata.date)
                      .toString()),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                filedName: "Task Duration     ",
                taskdata: taskDuration,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                filedName: "Task Priority       ",
                taskdata: tasklistdata.priority,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              FilterDataListwidegt(
                filedName: "Task Description",
                taskdata: tasklistdata.description,
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
