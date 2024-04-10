import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manger_app/domain/entities/AddTask.dart';

import '../../../constants/logger.dart';
import '../../../domain/usecases/add_task/add_task_usecase.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final AddTaskUsecase addTaskUsecase;
  AddTaskCubit(this.addTaskUsecase) : super(AddTaskInitial());

  void addTask(String todo, bool completed, int? userId) async{
    try{
      emit(AddTaskLoading());
      AddTask addTask = await addTaskUsecase.addTask(todo, completed, userId);
      LogManager.info('cubit::addTask::addTask = $addTask',);
      emit(AddTaskSuccess(addTask));
    } on Exception catch (e) {
      emit(AddTaskFailed(e.toString().substring(11)));
      LogManager.error('addTask::addTask::exception =', e);
    }
  }
}

