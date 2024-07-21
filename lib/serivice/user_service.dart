import 'package:reminder/db/repositry.dart';
import 'package:reminder/model/user.dart';

class UserService{
  late Repository _repository;
  UserService(){
    _repository = Repository();
  }

  SaveUser(User user) async{
    return await _repository.insetData("users", user.userMap());
  }

  readAllUser() async{
    return await _repository.readData("users");
  }
}