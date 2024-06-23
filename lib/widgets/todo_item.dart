import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/models/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChange;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;

  const TodoItem({super.key, required this.todo,required this.onDeleteItem, required this.onToDoChange});
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        tileColor: Colors.white,
        leading: todo.isDone? const Icon(Icons.check_box,color: tdBlue,) : const Icon(Icons.check_box_outline_blank),
        title:  Text( todo.todoText!,
        style:  TextStyle(fontSize: 16, decoration: todo.isDone ?TextDecoration.lineThrough : null),),
        contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        trailing: Container(
          height: 35,
          width: 35,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5)
          ),
          child:IconButton(
            onPressed: (){
              onDeleteItem(todo.id);
            }, 
            icon: const Icon(Icons.delete,),
            color:Colors.white,
            iconSize: 20,
            ),
        ),
      )
    );
  }
}