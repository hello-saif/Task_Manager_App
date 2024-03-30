import 'package:get/get.dart';
import '../../data/modles/count_by_status_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CountTaskByStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  bool get inProgress => _inProgress;

  String get errorMessage =>
      _errorMessage ?? 'Fetch count by task status failed!';

  CountByStatusWrapper get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getCountByTaskStatus() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
