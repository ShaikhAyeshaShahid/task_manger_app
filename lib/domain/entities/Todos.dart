/// id : 19
/// todo : "Create a compost pile"
/// completed : true
/// userId : 5

class Todos {
  Todos({
      this.id, 
      this.todo, 
      this.completed, 
      this.userId,});

  Todos.fromJson(dynamic json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['todo'] = todo;
    map['completed'] = completed;
    map['userId'] = userId;
    return map;
  }

}