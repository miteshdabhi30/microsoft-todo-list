import 'package:flutter/material.dart';
import 'package:microsoft_to_do/custom_widgets/photo_list_view.dart';

import 'color_list_view.dart';

class CustomAlert extends StatefulWidget {
  final Function(Color) newColor2;
  final Function(List<String>, Color) updateList;

  const CustomAlert(
      {super.key, required this.newColor2, required this.updateList});

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {

  final TextEditingController _titleController = TextEditingController();
  Color baseColor = Colors.indigo;
  Color changeColor = Colors.grey;
  int _selectedIndex = 0;
  FocusNode focusNode = FocusNode();


  final List<Color> colorList = [
    const Color.fromRGBO(93, 112, 189, 1),
    const Color.fromRGBO(158, 93, 159, 1),
    const Color.fromRGBO(194, 76, 108, 1),
    const Color.fromRGBO(194, 79, 74, 1),
    const Color.fromRGBO(43, 131, 93, 1),
    const Color.fromRGBO(37, 129, 124, 1),
    const Color.fromRGBO(104, 118, 129, 1),
    const Color.fromRGBO(223, 237, 248, 1),
    const Color.fromRGBO(242, 231, 248, 1),
    const Color.fromRGBO(255, 228, 233, 1),
    const Color.fromRGBO(249, 232, 222, 1),
    const Color.fromRGBO(213, 241, 255, 1),
    const Color.fromRGBO(212, 241, 239, 1),
    const Color.fromRGBO(231, 236, 240, 1),
  ];

  final List<String> _listName = [];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    _titleController.removeListener(_updateButtonColor);
    _titleController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      changeColor =
          _titleController.text.isNotEmpty ? Colors.blueAccent : Colors.grey;
    });
  }

  void _newColor(Color color) {
    setState(() {
      baseColor = color;
    });
    widget.newColor2(color);
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return AlertDialog(
      shape: const RoundedRectangleBorder(),
      title: const Text("New list"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_emotions_outlined,
                color: baseColor,
              ),
              const SizedBox(
                width: 12,
              ),

              Expanded(
                  child: TextField(

                controller: _titleController,
                cursorColor: baseColor,
                focusNode: focusNode,
                decoration: InputDecoration(
                    hintText: 'Enter list title',
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: baseColor, width: 2)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: baseColor, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: baseColor, width: 2))),
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: _selectedIndex == 0
                            ? Colors.transparent
                            : Colors.blueGrey,
                        width: 2),
                    color: _selectedIndex == 0 ? Colors.blueGrey : Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    "Color",
                    style: TextStyle(
                        color: _selectedIndex == 0
                            ? Colors.white
                            : Colors.blueGrey),
                  )),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: _selectedIndex == 1
                            ? Colors.transparent
                            : Colors.blueGrey,
                        width: 2),
                    color: _selectedIndex == 1 ? Colors.blueGrey : Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    "Photo",
                    style: TextStyle(
                        color: _selectedIndex == 1
                            ? Colors.white
                            : Colors.blueGrey),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _selectedIndex == 0
              ? ColorListView(
                  newColor: _newColor,
                )
              : const PhotoListView()
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "CANCEL",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            )),
        TextButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                _listName.add(_titleController.text);
                widget.updateList(_listName, baseColor);
                Navigator.pop(context);
              } else {}
            },
            child: Text(
              "CREATE LIST",
              style: TextStyle(color: changeColor),
            ))
      ],
    );
  }
}
