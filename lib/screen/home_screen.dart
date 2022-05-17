import 'package:flutter/material.dart';
import 'package:to_do_app/helpers/drawer_navigation.dart';
import 'package:to_do_app/models/todos.dart';
import 'package:to_do_app/screen/todo_screen.dart';
import 'package:to_do_app/services/todos_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _todosService;
  List<Todos> _todosList = List<Todos>.empty(growable: true);
  @override
  void initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todosService = TodosService();
    var todos = await _todosService.readTodos();
    todos.forEach((todo){
      setState((){
        var model = Todos();
        model.title = todo['title'];
        model.description = todo['description'];
        model.id = todo['id'];
        model.category = todo['category'];
        model.toDoDate = todo['todoDate'];
        _todosList.add(model);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ), //AppBar
      drawer: DrawerNavigation(),
      body: ListView.builder(itemCount: _todosList.length,itemBuilder: (context,index){
        return Padding(
          padding: EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            ),
            child: ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
              Text(_todosList[index].title ?? 'No Title')
                  ],
              ),
              subtitle: Text(_todosList[index].category ?? 'No Category'),
              trailing: Text(_todosList[index].toDoDate ?? 'No Date'),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(Icons.add),
      ),
    ); //Scaffold
  }
}