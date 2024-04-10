import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/logger.dart';
import '../../../domain/entities/TodoList.dart';
import '../../../domain/usecases/todo_list/get_todo_list_usecase.dart';

part 'get_todo_list_state.dart';

class GetTodoListCubit extends Cubit<GetTodoListState> {
  final GetTodoListUsecase usecase;
  GetTodoListCubit(this.usecase) : super(GetTodoListInitial());
  void loadTodoList() async {
    try {
      emit(GetTodoListLoading());
      List<TodoList> todoList = await usecase.fetchTodoList();
      LogManager.info("get todo List from Api cubit: ${todoList.length}");
      emit(GetTodoListLoaded(getTodoList: todoList));
    } on Exception catch (e) {
      LogManager.error('cubit::loadTodoList::exception =', e);
      emit(GetTodoListNotLoaded(e.toString().substring(11)));
    }
  }
}
