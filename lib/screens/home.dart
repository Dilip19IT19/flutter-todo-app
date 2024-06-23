import 'package:flutter/material.dart';

import 'package:myapp/constants/colors.dart';
import 'package:myapp/models/todo.dart';
import 'package:myapp/widgets/todo_item.dart';

class Home extends StatefulWidget {


   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final todoList=ToDo.todoList();
   List<ToDo> _foundToDo=[];
   final _todoController=TextEditingController();

   @override
  void initState() {
    _foundToDo=todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
               searchBox(),
               Expanded(
                 child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 10),
                      child:  const Text('All ToDos',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,letterSpacing: 1),),
                    ),
          
                    for(ToDo todoo in _foundToDo.reversed)
                      TodoItem(
                        todo: todoo,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                        key: ValueKey(todoo.id))
                   
                  ],
                 ),
               )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(color: tdGrey,blurRadius: 10,)],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add new todo',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5)
                    ),
                  ),
                )),
                Container(
                 
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                  onPressed: (){
                    _addToDoItem(_todoController.text);
                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: const Size(50, 53),
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    
                  ),
                  child: const Text("+",style: TextStyle(fontSize: 35,color: Colors.white),),
                  ),
                  
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo)
  {
    setState(() {
      todo.isDone=!todo.isDone;
    });
  }

  void _deleteToDoItem(String id)
  {
    setState(() {
      todoList.removeWhere((item)=>item.id==id);
    });
  }

  void _addToDoItem(String todo)
  {
    setState(() {
      todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));      
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword)
  {
    List<ToDo> results=[];
    if(enteredKeyword.isEmpty)
    {
      results=todoList;
    }
    else
    {
      results=todoList.where((item)=>item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      setState(() {
        _foundToDo=results;
      });
    }
  }

 Widget searchBox()
 {
    return  Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child:  TextField(
                onChanged: (value)=>_runFilter(value),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(2),
                  prefixIcon: Icon(Icons.search,color: tdBlack,size: 20,),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25,
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: tdGrey),
                  border: InputBorder.none
                ),
              ),
            );
 }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      toolbarHeight: 75,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/profile2.jpg'),
              ),
            )
        ],
      ),
    );
  }
}