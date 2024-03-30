import 'package:get/get.dart';
import 'package:tms/presentation/controller/CountTaskByStatusController.dart';
import 'package:tms/presentation/controller/NewTaskController.dart';
import 'package:tms/presentation/controller/SignInController.dart';
import 'package:tms/presentation/controller/SignUpController.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => SignUpController());
  }
}