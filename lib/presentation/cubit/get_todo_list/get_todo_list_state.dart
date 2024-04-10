part of 'get_todo_list_cubit.dart';

sealed class GetTodoListState extends Equatable {
  const GetTodoListState();
}

final class GetTodoListInitial extends GetTodoListState {
  @override
  List<Object> get props => [];
}
class GetTodoListLoading extends GetTodoListState {
  @override
  List<Object> get props => [];
}

class GetTodoListLoaded extends GetTodoListState {
  final List<TodoList> getTodoList;

  const GetTodoListLoaded({required this.getTodoList});

  @override
  List<Object> get props => [getTodoList];
}

class GetTodoListNotLoaded extends GetTodoListState {
  final String errorMessage;

  const GetTodoListNotLoaded(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

