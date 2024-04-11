part of 'delete_task_cubit.dart';

sealed class DeleteTaskState extends Equatable {
  const DeleteTaskState();
}

final class DeleteTaskInitial extends DeleteTaskState {
  @override
  List<Object> get props => [];
}
class DeleteTaskLoading extends DeleteTaskState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteTaskSuccess extends DeleteTaskState {
  final DeleteTodo user;

  DeleteTaskSuccess(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteTaskFailed extends DeleteTaskState {
  final String errorMessage;

  DeleteTaskFailed(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
