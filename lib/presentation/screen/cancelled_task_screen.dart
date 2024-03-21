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

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => CancelledTaskScreenState();
}
class CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool _getallCancelledtaskinprogress=false;
  TaskListWrapper _Cancelledtasklistwrapper= TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getallCancelledtasklist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getallCancelledtaskinprogress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: ()async {
              _getallCancelledtasklist();

            },
            child: Visibility(
              visible: _Cancelledtasklistwrapper.taskList?.isNotEmpty ?? false,
              replacement:  const EmptyListWidget(),
              child: ListView.builder(
                itemCount:_Cancelledtasklistwrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(taskItem: _Cancelledtasklistwrapper.taskList![index],
                    refreshList: () {
                      _getallCancelledtasklist();
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
  Future<void>_getallCancelledtasklist()async {
    _getallCancelledtaskinprogress = true;
    setState(() {

    });
    final ResponseObject response = await NetworkCaller.getRequest(
        Urls.CancelledTaskByStatus);
    if (response.isSuccess) {
      _Cancelledtasklistwrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getallCancelledtaskinprogress = false;
      setState(() {

      });
    } else {
      _getallCancelledtaskinprogress = false;
      setState(() {

      });
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get Cancelled task list has been failed');
      }
    }
  }
}

