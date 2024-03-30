import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/modles/login_response.dart';
import '../../data/modles/response_object.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Login failed! Try again';

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      'email': email,
      'password': password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.login, inputParams,
        fromSignIn: true);

    _inProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
      LoginResponse.fromJson(response.responseBody);

      /// Save the data to local cache
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);

      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
