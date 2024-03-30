import 'package:get/get.dart';

import '../../data/modles/response_object.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class AddnewTaskController extends GetxController{
  bool _inProgress =false;
  String? _errorMessage;
  bool get inProgress =>_inProgress;
  String get errorMessage=>_errorMessage ?? 'Add new task failed!';


  Future<bool> AddNewTask(String title,String description)async{
    _inProgress=true;
    update();
    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": "New"
    };
    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.createTask, inputParams,
        fromSignIn: true);
    _inProgress=false;

    if (response.isSuccess) {

       // showSnackBarMessage(context, 'New task has been added!');
      update();
      return true;
    } else {
      _errorMessage =response.errorMessage;
      update();
      return false;
    }
  }
}