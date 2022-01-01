import 'package:flutter/material.dart';
import 'package:todoapp/style/style.dart';

class KDropdownField extends StatefulWidget {
  const KDropdownField({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<KDropdownField> {
  TextEditingController categoryController = TextEditingController();
  List category = ["High", "Medium", "Low"];
  bool showDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
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
                controller: categoryController,
                enabled: false,
                decoration: InputDecoration(
                    labelText: "Priority",
                    labelStyle: TextStyle(fontSize: 15, color: KColor.borderOutline),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                    margin: const EdgeInsets.only(top: 5),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "${category[index]}",
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
                  )
                : Container(),
          ],
        ));
  }
}
