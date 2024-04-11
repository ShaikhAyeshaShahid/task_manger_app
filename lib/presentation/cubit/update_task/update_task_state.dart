part of 'update_task_cubit.dart';

sealed class UpdateTaskState extends Equatable {
  const UpdateTaskState();
}

final class UpdateTaskInitial extends UpdateTaskState {
  @override
  List<Object> get props => [];
}
class UpdateTaskLoading extends UpdateTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UpdateTaskSuccess extends UpdateTaskState {
  final UpdateTodo user;

  UpdateTaskSuccess(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UpdateTaskFailed extends UpdateTaskState {
  final String errorMessage;

  UpdateTaskFailed(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
