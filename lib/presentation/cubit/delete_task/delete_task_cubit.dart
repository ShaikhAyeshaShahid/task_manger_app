import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manger_app/domain/entities/DeleteTodo.dart';

import '../../../constants/logger.dart';
import '../../../domain/usecases/delete_task/delete_task_usecase.dart';
import '../../../domain/usecases/update_task/update_task_usecase.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  final DeleteTaskUsecase deleteTaskUsecase;

  DeleteTaskCubit(this.deleteTaskUsecase) : super(DeleteTaskInitial());
  void deleteTask() async {
    try {
      emit(DeleteTaskLoading());
      DeleteTodo deleteTask = await deleteTaskUsecase.deleteTask();
      LogManager.info(
        'cubit::deleteTask::deleteTask = $deleteTask',
      );
      emit(DeleteTaskSuccess(deleteTask));
    } on Exception catch (e) {
      emit(DeleteTaskFailed(e.toString().substring(11)));
      LogManager.error('deleteTask::deleteTask::exception =', e);
    }
  }
}
