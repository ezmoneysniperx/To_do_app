import 'package:flutter/material.dart';
import 'package:to_do_app/models/todos.dart';
import 'package:to_do_app/screen/home_screen.dart';
import 'package:to_do_app/src/app.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/services/category_service.dart';
import 'package:to_do_app/services/todos_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  var todos;

  /*
  var _editTodosTitleController = TextEditingController();
  var _editTodosDescriptionController = TextEditingController();
  var _editTodosCategoryController = TextEditingController();
  var _editTodosToDoDateController = TextEditingController();
  */

  var _todos = Todos();
  var _todosService = TodosService();

  var _selectedValue;
  var _categories = <DropdownMenuItem>[];

  @override
  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
            child: Text(category['name']),
            value: (category['name']),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create To Do'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'title',
                hintText: 'write todo title'
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'desc',
                  hintText: 'write todo desc'
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                  labelText: 'date',
                  hintText: 'pick todo date',
                prefixIcon: InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      print(
                          pickedDate);
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate);
                      print(
                          formattedDate);

                      setState(() {
                        todoDateController.text =
                            formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                  child: Icon(Icons.calendar_today),
                )
              ),
            ),
            DropdownButtonFormField(
                items: _categories,
                value: _selectedValue,
                onChanged: (value){
                  setState(() {
                    _selectedValue = value;
                  });
                }),SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                //_todos.id = todos[0]['id'];
                _todos.title = todoTitleController.text;
                _todos.description = todoDescriptionController.text;
                _todos.category = _selectedValue.toString();
                _todos.toDoDate = todoDateController.text;
                var result = await _todosService.saveTodos(_todos);
                print(result);
                if (result > 0) {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute
                  (builder: (context) => HomeScreen()), (Route<dynamic> route) => false); //MaterialPageRoute
                }
              },
            color: Colors.blue,
                child: Text('Save', style: TextStyle(color: Colors.white)),)
          ],
        ),
      ),
    );
  }
}
