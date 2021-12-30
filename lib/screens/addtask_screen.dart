import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/style/style.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

// class Todo {
//   Todo(
//       {required this.todo,
//       required this.priority,
//       required this.date,
//       required this.isChecked});
//   final String todo, priority;
//   bool isChecked;
//   DateTime date;
//   //bool checked;
// }

List<Todo> newtodoList = [];
TextEditingController _todoController = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _categoryController = TextEditingController();
DateFormat dateFormat = DateFormat('MMM dd,yyyy');
late SharedPreferences sharedPreferences;

// saveStringValue() async {
//   sharedPreferences = await SharedPreferences.getInstance();
//   // print(jsonEncode(newtodoList));
//   // sharedPreferences.setString('key', jsonEncode(newtodoList));
//   // print(sharedPreferences);
// }
// saveIntValue() async {
//   sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.setInt("status", 20);
//   print(sharedPreferences.getInt("status"));
// }

save(String key) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  //print('newtodoList = $newtodoList');
  var jsonEncodedValue =
      (newtodoList as List<dynamic>).map((x) => Todo.fromJson(x)).toList();
  json.encode(List<dynamic>.from(newtodoList.map((x) => x.toJson())));
  print('value json decoded = $jsonEncodedValue');

  sharedPreferences.setString('key', json.encode(newtodoList));
}

class _AddTaskState extends State<AddTask> {
  List category = [
    "Low",
    "Medium",
    "High",
  ];
  bool showDropdown = false;
  void clearText() {
    _todoController.clear();
    _dateController.clear();
    _categoryController.clear();
  }

  DateTime taskDate = DateTime.now();
  datePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: taskDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    setState(() {
      taskDate = date!;
    });
    _dateController.text = dateFormat.format(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.k_white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColor.k_white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(left: 18),
            child: Icon(
              Icons.arrow_back_ios,
              color: KColor.k_bg,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: KTextStyle.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: KTextFields(
                readonly: false,
                controller: _todoController,
                obsecuretext: false,
                keyboardtype: TextInputType.text,
                decoration: InputDecoration(
                    label: Text(
                      'Todo',
                      style: TextStyle(color: KColor.k_brderOutline),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    )),
              )),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: KTextFields(
                obsecuretext: false,
                readonly: true,
                onTap: datePicker,
                controller: _dateController,
                decoration: InputDecoration(
                    label: Text(
                      'Date',
                      style: TextStyle(color: KColor.k_brderOutline),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    )),
              )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (showDropdown) {
                              showDropdown = false;
                            } else {
                              showDropdown = true;
                            }
                          });
                        },
                        child: TextFormField(
                          readOnly: true,
                          controller: _categoryController,
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: "Priority",
                              labelStyle: TextStyle(
                                  fontSize: 15, color: KColor.k_brderOutline),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              suffixIcon: Icon(
                                showDropdown
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                size: 18,
                              )),
                        ),
                      ),
                      showDropdown
                          ? Container(
                              width: MediaQuery.of(context).size.width - 50,
                              margin: const EdgeInsets.only(top: 5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      List.generate(category.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _categoryController.text =
                                              category[index];
                                          showDropdown = false;
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "${category[index]}",
                                              style: const TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                            )
                          : Container(),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    newtodoList.add(Todo(
                        todo: _todoController.text,
                        priority: _categoryController.text,
                        date: DateFormat('MMM dd,yyyy')
                            .parse(_dateController.text)
                            .toString(),
                        isChecked: false));
                    save('key');
                    clearText();
                    Navigator.pop(context);
                  });
                },
                child: Button(
                  color: KColor.k_bg,
                  button: 'Add',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
