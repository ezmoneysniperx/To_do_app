import 'package:to_do_app/models/todos.dart';
import 'package:to_do_app/repositories/repository.dart';

class TodosService{
  Repository? _repository;
  TodosService(){
    _repository = Repository();
  }
  saveTodos(Todos todos) async{
    return await _repository?.insertData('todos', todos.todosMapp());
  }
  readTodos() async{
    return await _repository?.readData('todos');
  }
  readTodosById(todosId) async{
    return await _repository?.readDataById('todos', todosId);
  }
  updateTodos(Todos todos) async{
    return await _repository?.updateData('todos', todos.todosMapp());
  }
  deleteTodos(todosId) async{
    return await _repository?.deleteData('todos', todosId);
  }
  readTodosByCategory(category) async {
    return await _repository?.readDataByColumnName(
        'todos', 'category', category);
  }

}