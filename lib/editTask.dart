import 'package:flutter/material.dart';
import 'model/task.dart';

class EditTask extends StatefulWidget {
  EditTask({required this.task});
  final Task task;
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
