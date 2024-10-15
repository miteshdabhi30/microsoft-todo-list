import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatefulWidget {
  final Function(String) passTaskList;
  const MyFloatingActionButton({super.key, required this.passTaskList});

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  final TextEditingController _addTaskController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  final List<String> taskList = [];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              FocusScope.of(context).requestFocus(focusNode);
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle_outlined,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: _addTaskController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Add a task'),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if(_addTaskController.text.isNotEmpty){
                                      final task = _addTaskController.text.trim();
                                      widget.passTaskList(task);
                                      _addTaskController.clear();
                                    }

                                  },
                                  icon: const Icon(Icons.arrow_upward))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.grey,
                              ),
                              Text(
                                "Set due date",
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.notifications_active_outlined,
                                color: Colors.grey,
                              ),
                              Text("Remind me",
                                  style: TextStyle(color: Colors.black54)),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.repeat,
                                color: Colors.grey,
                              ),
                              Text("Repeat",
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }
}




