import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/common/Provider/todo_class.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todo = [];
  List<Todo> _completedTasks = [];
  List<Todo> get todoTask => _todo;
  List<Todo> get completedTasks => _completedTasks;
  List<TodoProject> _todoproject = [];
  List<TodoProject> get todoproject => _todoproject;

  List<TodoUser> _todouser = [];

  List<TodoUser> get todouser => _todouser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addtask(Todo task) async {
    _isLoading = true;
    _todo.add(task);
    await saveform();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    _isLoading = true;
    _todo.removeAt(index);
    await saveform();
    _isLoading = true;
    notifyListeners();
  }

  Future<void> markTaskAsCompleted(int index) async {
    _isLoading = true;
    if (index >= 0 && index < _todo.length) {
      Todo completedTask = _todo.removeAt(index);
      completedTask.completed = true;
      _completedTasks.add(completedTask);
      await saveform();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveform() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodedtask = _todo.map((task) {
      return {
        'Descp': task.description,
        'TaskName': task.taskname,
        'Priority': task.priority,
        'Date': task.date.toIso8601String(),
        'StartTime': _timeOfDayToString(task.startTime),
        'EndTime': _timeOfDayToString(task.endTime),
        'TimeDuration': task.timeDuration,
        'ProjectFolder': task.projectFolder,
        'Completed': task.completed,
      };
    }).toList();

    prefs.setString('storedTasks', json.encode(encodedtask));

    List<Map<String, dynamic>> encodedCompletedTasks =
        _completedTasks.map((task) {
      return {
        'Descp': task.description,
        'TaskName': task.taskname,
        'Priority': task.priority,
        'Date': task.date.toIso8601String(),
        'TimeDuration': task.timeDuration,
        'StartTime': _timeOfDayToString(task.startTime),
        'EndTime': _timeOfDayToString(task.endTime),
        'ProjectFolder': task.projectFolder,
        'Completed': task.completed,
      };
    }).toList();
    prefs.setString('completedTasks', json.encode(encodedCompletedTasks));
    _isLoading = false;
  }

  String _timeOfDayToString(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return '';
    return '${timeOfDay.hour}:${timeOfDay.minute}';
  }

  String _formatDuration(int totalMinutes) {
    int totalHours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;

    return '${totalHours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}';
  }

  String get totalWorkingHours {
    int totalWorkingMinutes = _calculateTotalTaskMinutes(_todo);
    return _formatDuration(totalWorkingMinutes);
  }

  String get totalDuration {
    int totalDurationMinutes = _calculateTotalTaskMinutes(_todo);
    return _formatDuration(totalDurationMinutes);
  }

  int _calculateTotalTaskMinutes(List<Todo> tasks) {
    int totalTaskMinutes = 0;

    for (var task in tasks) {
      int taskDurationMinutes =
          (task.endTime!.hour * 60 + task.endTime!.minute) -
              (task.startTime!.hour * 60 + task.startTime!.minute);

      if (taskDurationMinutes < 0) {
        taskDurationMinutes += 1440; // Assuming a day has 1440 minutes
      }

      totalTaskMinutes += taskDurationMinutes;
    }

    return totalTaskMinutes;
  }

  Future<void> fetchtaskdata() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTaskString = prefs.getString('storedTasks');
    String? storedCompletedTasksString = prefs.getString('completedTasks');

    if (storedTaskString != null) {
      List<Map<String, dynamic>> decodedTasks =
          List<Map<String, dynamic>>.from(json.decode(storedTaskString));
      _todo = decodedTasks.map((task) => Todo.fromJson(task)).toList();
    }
    if (storedCompletedTasksString != null) {
      List<Map<String, dynamic>> decodedCompletedTasks =
          List<Map<String, dynamic>>.from(
              json.decode(storedCompletedTasksString));
      _completedTasks =
          decodedCompletedTasks.map((task) => Todo.fromJson(task)).toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addproject(TodoProject project) async {
    _todoproject.add(project);
    _isLoading = true;
    await saveproject();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveproject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodetodoproject =
        _todoproject.map((todoproject) {
      return {
        'imagepath': todoproject.imagepath,
        'projectname': todoproject.projectname
      };
    }).toList();
    prefs.setString('storedtodoproject', json.encode(encodetodoproject));
  }

  Future<void> fetchtodoproject() async {
    _isLoading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedtodoprojectString =
        preferences.getString('storedtodoproject');
    if (storedtodoprojectString != null) {
      List<Map<String, dynamic>> decodedtodoproject =
          List<Map<String, dynamic>>.from(json.decode(storedtodoprojectString));
      _todoproject = decodedtodoproject
          .map((todoprojet) => TodoProject.fromJson(todoprojet))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> adduserdetail(TodoUser userdata) async {
    _todouser.add(userdata);
    _isLoading = true;
    await saveuserdetails();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveuserdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodetodouser = _todouser.map((todouser) {
      return {
        'userimagepath': todouser.userimagepath,
        'username': todouser.username
      };
    }).toList();
    prefs.setString('storedtodouserdeteils', json.encode(encodetodouser));
  }

  Future<void> fetchtodouserdata() async {
    _isLoading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedtodouserdetailsString =
        preferences.getString('storedtodouserdeteils');
    if (storedtodouserdetailsString != null) {
      List<Map<String, dynamic>> decodedtodouserdetails =
          List<Map<String, dynamic>>.from(
              json.decode(storedtodouserdetailsString));
      _todouser = decodedtodouserdetails
          .map((todouser) => TodoUser.fromjson(todouser))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}
