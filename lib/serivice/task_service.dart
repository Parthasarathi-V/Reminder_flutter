import 'package:reminder/db/repositry.dart';
import 'package:reminder/model/task.dart';

class TaskService{
  late Repository _repository;
  TaskService(){
    _repository = Repository();
  }

  SaveTask(Task task) async{
    return await _repository.insetData("task", task.TaskMap());
  }

  readAllTasks() async{
    return await _repository.readData('task');
  }
}