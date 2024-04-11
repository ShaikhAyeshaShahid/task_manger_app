import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/logger.dart';
import '../../../domain/entities/UpdateTodo.dart';
import '../../../domain/usecases/update_task/update_task_usecase.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  final UpdateTaskUsecase updateTaskUsecase;

  UpdateTaskCubit(this.updateTaskUsecase) : super(UpdateTaskInitial());

  void updateTask(bool completed) async {
    try {
      emit(UpdateTaskLoading());
      UpdateTodo updateTask = await updateTaskUsecase.updateTask(completed);
      LogManager.info(
        'cubit::addTask::addTask = $updateTask',
      );
      emit(UpdateTaskSuccess(updateTask));
    } on Exception catch (e) {
      emit(UpdateTaskFailed(e.toString().substring(11)));
      LogManager.error('addTask::addTask::exception =', e);
    }
  }
}
