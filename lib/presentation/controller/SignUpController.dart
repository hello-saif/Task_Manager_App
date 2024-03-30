import 'package:get/get.dart';
import '../../data/modles/login_response.dart';
import '../../data/modles/response_object.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class SignUpController extends GetxController{
  bool _inProgress =false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Registration failed! Try again.';

  Future<bool> signUp(String email,String firstname,String lastname, String mobile, String password)async{
    _inProgress=true;
    update();
    Map<String, dynamic> inputParams = {
      'email': email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
      "password": password,
    };
    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.registration, inputParams,
        fromSignIn: true);
    _inProgress =false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
      LoginResponse.fromJson(response.responseBody);

      /// Save the data to local cache
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);


      update();
      return true;

    } else {
     _errorMessage =response.errorMessage;
     update();
     return false;
    }



  }
}