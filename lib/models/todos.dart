import 'package:flutter/material.dart';

class Todos{
  String? title;
  String? description;
  String? category;
  String? toDoDate;
  int? id;


  todosMapp(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['category'] = category;
    mapping['toDoDate'] = toDoDate;
    return mapping;
  }
}