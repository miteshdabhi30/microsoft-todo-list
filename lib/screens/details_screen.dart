import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../custom_widgets/my_floatingactionbutton.dart';

class DetailScreen extends StatefulWidget {
  final String itemTitle;
  final Color backGroundColor;
  final Function(List<String>) favToImp;


  const DetailScreen({
    super.key,
    required this.itemTitle,
    required this.backGroundColor,
    required this.favToImp

  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<String> _taskList = [];
  final List<String> _taskCompleted = [];
  final List<String> _favTaskList = [];
  bool _isExpansion = true;

  void _passTaskList(String task) {
    setState(() {
      _taskList.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backGroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: const [
            Icon(
              Icons.share,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.white,
            )
          ],
          backgroundColor: widget.backGroundColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.itemTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ReorderableListView.builder(
                  itemCount: _taskList.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex = newIndex - 1;
                      }
                      final element = _taskList.removeAt(oldIndex);
                      _taskList.insert(newIndex, element);
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      key: ValueKey(_taskList[index]),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          leading: GestureDetector(
                              onTap: () {
                                String completedTask = _taskList[index];
                                Fluttertoast.showToast(
                                  msg: "Task Completed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                                setState(() {
                                  if (!_taskCompleted.contains(index)) {
                                    _taskCompleted.add(completedTask);
                                    _taskList.removeAt(index);
                                  }
                                });
                              },
                              child: _taskCompleted.contains(index)
                                  ? Icon(
                                      Icons.check_circle,
                                      color: widget.backGroundColor,
                                    )
                                  : const Icon(Icons.circle_outlined)),
                          title: Text(
                            _taskList[index],
                            style: TextStyle(
                                decoration: _taskCompleted.contains(index)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: _taskCompleted.contains(index)
                                    ? Colors.grey
                                    : Colors.black),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                final favTask = _taskList[index];
                                if (!_favTaskList.contains(favTask)) {
                                  _favTaskList.add(favTask);
                                } else {
                                  _favTaskList.remove(favTask);
                                }
                              });
                              widget.favToImp(_favTaskList);
                            },
                            icon: _favTaskList.contains(_taskList[index])
                                ? Icon(
                                    Icons.star,
                                    color: widget.backGroundColor,
                                  )
                                : const Icon(Icons.star_border),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            if (_taskCompleted.isNotEmpty)
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpansion = !_isExpansion;
                          });
                        },
                        child: Icon(
                          _isExpansion
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right_sharp,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Completed ${_taskCompleted.length}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    if (_isExpansion == true)
                      Flexible(
                        child: ListView.builder(
                            itemCount: _taskCompleted.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            String inCompletedTask =
                                                _taskCompleted[index];
                                            _taskCompleted.removeAt(index);
                                            _taskList.add(inCompletedTask);
                                          });
                                        },
                                        child: Icon(
                                          Icons.check_circle,
                                          color: widget.backGroundColor,
                                        )),
                                    title: Text(
                                      _taskCompleted[index],
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          final favTask = _taskCompleted[index];
                                          if (!_favTaskList.contains(favTask)) {
                                            _favTaskList.add(favTask);
                                          } else {
                                            _favTaskList.remove(favTask);
                                          }
                                        });
                                      },
                                      icon: _favTaskList
                                              .contains(_taskCompleted[index])
                                          ? Icon(
                                              Icons.star,
                                              color: widget.backGroundColor,
                                            )
                                          : const Icon(Icons.star_border),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                  ],
                ),
              )
          ],
        ),
        floatingActionButton: MyFloatingActionButton(
          passTaskList: (task) {
            _passTaskList(task);
          },
        ));
  }
}
