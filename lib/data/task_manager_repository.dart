import '../domain/entities/AddTask.dart';
import '../domain/entities/TodoList.dart';
import '../domain/entities/UserLogin.dart';

abstract class TaskManagerRepository {
  Future<UserLogin> signIn(String username, String password);
  Future<List<TodoList>> getTodo();
  Future<AddTask> addTask(String todo, bool completed, int? userId);
}
