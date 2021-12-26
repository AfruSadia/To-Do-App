import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  TextEditingController categoryController = new TextEditingController();
  List category = [
    "High",
    "Medium",
    "Low",
  ];
  bool showDropdown = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10, left: 10),
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
                enabled: true,
                controller: categoryController,
                decoration: InputDecoration(
                    labelText: "Priority",
                    labelStyle: TextStyle(color: KColor.k_brderOutline),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: Icon(
                      showDropdown ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                    )),
              ),
            ),
            showDropdown
                ? Container(
                    width: MediaQuery.of(context).size.width - 50,
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(category.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                categoryController.text = category[index];
                                showDropdown = false;
                              });
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "${category[index]}",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  )
                : Container(),
          ],
        ));
  }
}
