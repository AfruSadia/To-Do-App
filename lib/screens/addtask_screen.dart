import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.k_white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KColor.k_white,
        title: Container(
          margin: const EdgeInsets.all(5),
          child: Icon(
            Icons.arrow_back_ios,
            color: KColor.k_bg,
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
                keyboardtype: TextInputType.datetime,
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
              DropDown(),
            ],
          ),
        ),
      ),
    );
  }
}
