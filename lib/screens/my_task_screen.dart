import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/style/style.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTaskScreen extends StatefulWidget {
  const MyTaskScreen({Key? key}) : super(key: key);

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTaskScreen> {
  DateFormat dateFormat = DateFormat('MMM dd,yyyy');
  int count = 0;

  // TODO :: Study and try to understand what was wrong and how it's been solved
  /// Try uncommenting print statements to debug through code
  read() async {
    final localStorage = await SharedPreferences.getInstance();
    String localTodoList = localStorage.getString('key') ?? '';
    // print('localTodoList = $localTodoList');
    var jsonDecodedValue =
        localTodoList.isEmpty ? [] : json.decode(localTodoList);
    // print(' json decoded value = $jsonDecodedValue');
    setState(() {
      todoList = (jsonDecodedValue as List<dynamic>)
          .map((x) => Todo.fromJson(x))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Tasks", style: KTextStyle.headline1),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('$count', style: const TextStyle(color: Colors.grey)),
                const Text(" of ", style: TextStyle(color: Colors.grey)),
                Text(
                  todoList.length.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        // TODO :: Implement delete from local storage
                        setState(() {
                          todoList.removeAt(index);
                          delete() async {
                            final localStorage =
                                await SharedPreferences.getInstance();
                            var jsonEncodedValue = json.encode(
                                List<dynamic>.from(
                                    todoList.map((x) => x.toJson())));

                            localStorage.setString('key', jsonEncodedValue);
                          }

                          delete();
                          if (count > 0) {
                            count--;
                          }
                        });
                      },
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Card(
                          child: ListTile(
                            title: Text(
                              todoList[index].todo,
                              style: TextStyle(
                                  decoration: todoList[index].isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            subtitle: Text(
                                '${dateFormat.format(DateTime.parse(todoList[index].date))} * ${todoList[index].priority}',
                                style: TextStyle(
                                    decoration: todoList[index].isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none)),
                            trailing: GestureDetector(
                              onTap: () {
                                // TODO :: Store check/uncheck state change in local storage as well
                                setState(() {
                                  todoList[index].isChecked =
                                      !todoList[index].isChecked;
                                  storeChecked() async {
                                    final localStorage =
                                        await SharedPreferences.getInstance();
                                    var jsonEncodedValue = json.encode(
                                        List<dynamic>.from(
                                            todoList.map((x) => x.toJson())));

                                    localStorage.setString(
                                        'key', jsonEncodedValue);
                                    //print(
                                    //'value json decoded = $jsonEncodedValue');
                                  }

                                  storeChecked();
                                  if (todoList[index].isChecked) {
                                    count++;
                                  } else if (count > 0 &&
                                      !todoList[index].isChecked) {
                                    count--;
                                  }
                                  intValueStore() async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setInt('intValue', count);
                                    print(count);
                                    return prefs.getInt('intValue');
                                  }

                                  intValueStore();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: todoList[index].isChecked
                                        ? KColor.k_bg
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: todoList[index].isChecked
                                        ? null
                                        : Border.all(
                                            color: Colors.grey, width: 2)),
                                width: 20,
                                height: 20,
                                child: todoList[index].isChecked
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KColor.k_bg,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTaskScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
