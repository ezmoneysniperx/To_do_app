import 'package:flutter/material.dart';
import 'package:to_do_app/models/todos.dart';
import 'package:to_do_app/services/todos_service.dart';

class TodosByCategory extends StatefulWidget {
  final String category;
  const TodosByCategory({Key? key, required this.category}) : super(key: key);
  //TodosByCategory.category({required this.category});

  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todos> _todoList = List<Todos>.empty(growable: true);
  TodosService _todosService = TodosService();

  @override
  void initState(){
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async{
    var todos= await _todosService.readTodosByCategory(this.widget.category);
    todos.forEach((todo){
      setState((){
        var model = Todos();
        model.title = todo['title'];
        model.description = todo['description'];
        model.toDoDate = todo['todoDate'];

        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do(s) List by Category'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView.builder(itemCount: _todoList.length, itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                elevation: 8,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_todoList[index].title!)
                    ],
                  ),
                  subtitle: Text(_todoList[index].description!),
                  trailing: Text(_todoList[index].toDoDate!),
                ),
              ),
            );
          }))
        ],
      ),
    );
  }
}
