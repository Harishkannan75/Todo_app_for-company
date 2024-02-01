import 'package:flutter/material.dart';

class Todo {
  final String taskname;
  final String description;
  final String priority;
  final DateTime date;
  final String timeDuration;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String projectFolder;
  bool completed;

  Todo(
      {required this.description,
      required this.taskname,
      required this.priority,
      required this.date,
      required this.timeDuration,
      required this.projectFolder,
      required this.startTime,
      required this.endTime,
      this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        date: DateTime.parse(json['Date']),
        description: json['Descp'],
        priority: json['Priority'],
        projectFolder: json['ProjectFolder'],
        timeDuration: json['TimeDuration'],
        completed: json['Completed'] ?? false,
        taskname: json['TaskName'],
        endTime: _stringToTimeOfDay(json['EndTime']),
        startTime: _stringToTimeOfDay(json['StartTime']));
  }
}

TimeOfDay? _stringToTimeOfDay(String? formattedTime) {
  if (formattedTime == null || formattedTime.isEmpty) return null;
  final parts = formattedTime.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
  return time;
}

class TodoProject {
  final String? imagepath;
  final String projectname;

  TodoProject({required this.imagepath, required this.projectname});

  factory TodoProject.fromJson(Map<String, dynamic> json) {
    return TodoProject(
      imagepath: json['imagepath'],
      projectname: json['projectname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': imagepath,
      'projectname': projectname,
    };
  }
}

class TodoUser {
  final String? userimagepath;
  final String username;
  TodoUser({required this.username, required this.userimagepath});

  factory TodoUser.fromjson(Map<String, dynamic> json) {
    return TodoUser(
        username: json['userimagepath'], userimagepath: json['username']);
  }
  Map<String, dynamic> toJson() {
    return {
      'image': userimagepath,
      'projectname': username,
    };
  }
}
