import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/style/style.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTask extends StatefulWidget {
  MyTask();

  @override
  _MyTaskState createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  DateFormat dateFormat = DateFormat('MMM dd,yyyy');
  int count = 0;

  @override
  // late SharedPreferences prefs;
  // getSharedPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  // }
  //
  // retrieveStringValue() async {
  //   prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString('key');
  //
  //   print(value);
  //   setState(() {
  //     newtodoList = value == null || value.isEmpty ? [] : jsonDecode(value);
  //   });
  // }
  // retrieveIntValue() async {
  //   prefs = await SharedPreferences.getInstance();
  //   int? value = prefs.getInt("status");
  //   print(value);
  // }

  void initState() {
    super.initState();

    retrieveStringValue();
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
            Text(
              "My Tasks",
              style: KTextStyle.headline1,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('$count', style: const TextStyle(color: Colors.grey)),
                const Text(" of ", style: TextStyle(color: Colors.grey)),
                Text(
                  newtodoList.length.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: newtodoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        setState(() {
                          newtodoList.removeAt(index);
                          count--;
                        });
                      },
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Card(
                          child: ListTile(
                            title: Text(
                              newtodoList[index].todo,
                              style: TextStyle(
                                  decoration: newtodoList[index].isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  newtodoList[index].priority,
                                  style: TextStyle(
                                      decoration: newtodoList[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                                Text(
                                  " * ",
                                  style: TextStyle(
                                      decoration: newtodoList[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                                Text(
                                  dateFormat.format(newtodoList[index].date),
                                  style: TextStyle(
                                      decoration: newtodoList[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                )
                              ],
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                setState(() {
                                  newtodoList[index].isChecked =
                                      !newtodoList[index].isChecked;
                                  if (newtodoList[index].isChecked) {
                                    count++;
                                  } else {
                                    count--;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: newtodoList[index].isChecked
                                        ? KColor.k_bg
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: newtodoList[index].isChecked
                                        ? null
                                        : Border.all(
                                            color: Colors.grey, width: 2)),
                                width: 20,
                                height: 20,
                                child: newtodoList[index].isChecked
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
              builder: (_) => AddTask(),
            ),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
