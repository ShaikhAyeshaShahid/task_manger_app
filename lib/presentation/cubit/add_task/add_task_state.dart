part of 'add_task_cubit.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();
}

final class AddTaskInitial extends AddTaskState {
  @override
  List<Object> get props => [];
}

class AddTaskLoading extends AddTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddTaskSuccess extends AddTaskState {
  final AddTask user;

  AddTaskSuccess(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddTaskFailed extends AddTaskState {
  final String errorMessage;

  AddTaskFailed(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
