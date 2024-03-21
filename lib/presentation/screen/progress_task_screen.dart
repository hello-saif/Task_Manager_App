import 'package:flutter/material.dart';
import 'package:tms/data/services/network_caller.dart';
import 'package:tms/presentation/widgets/empty_list_widget.dart';

import '../../data/modles/response_object.dart';
import '../../data/modles/task_list_wrapper.dart';
import '../../data/utility/urls.dart';
import '../widgets/background_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}
class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool _getallProgressedtaskinprogress=false;
  TaskListWrapper _Progresstasklistwrapper= TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getallprogresstasklist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getallProgressedtaskinprogress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: ()async {
             _getallprogresstasklist();

            },
            child: Visibility(
              visible: _Progresstasklistwrapper.taskList?.isNotEmpty ?? false,
              replacement:  const EmptyListWidget(),
              child: ListView.builder(
                itemCount:_Progresstasklistwrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                return TaskCard(taskItem: _Progresstasklistwrapper.taskList![index],
                 refreshList: () {
                  _getallprogresstasklist();
                 },
                );
                },

            ),

          ),
        ),

        ),
      ),
    );
  }
  Future<void>_getallprogresstasklist()async {
    _getallProgressedtaskinprogress = true;
    setState(() {

    });
    final ResponseObject response = await NetworkCaller.getRequest(
        Urls.ProgressTaskByStatus);
    if (response.isSuccess) {
      _Progresstasklistwrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getallProgressedtaskinprogress = false;
      setState(() {

      });
    } else {
      _getallProgressedtaskinprogress = false;
      setState(() {

      });
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get Progress task list has been failed');
      }
    }
  }
}

