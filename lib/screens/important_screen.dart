import 'package:flutter/material.dart';

class ImportantScreen extends StatefulWidget {
  final List<String> importantTask;
  const ImportantScreen({super.key, required this.importantTask});

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  final Color _baseColor = const Color.fromRGBO(242, 231, 248, 1);
  final Color _baseColor2 = const Color.fromRGBO(141, 52, 90, 1.0);

  final List<String> _importantList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _baseColor,
      appBar: AppBar(
        backgroundColor: _baseColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: _baseColor2,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Important",
              style: TextStyle(
                  color: _baseColor2,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
          ),

          Flexible(
            child: ReorderableListView.builder(
                itemCount: widget.importantTask.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex = newIndex - 1;
                    }
                    final element = widget.importantTask.removeAt(oldIndex);
                    widget.importantTask.insert(newIndex, element);
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    key: ValueKey(widget.importantTask[index]),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      child: ListTile(
                        leading: GestureDetector(
                            onTap: () {
                              String completedTask = widget.importantTask[index];
                              setState(() {
                                widget.importantTask.removeAt(index);
                              });
                            },
                            child: widget.importantTask.contains(index)
                                ? Icon(
                              Icons.check_circle,
                            )
                                : const Icon(Icons.circle_outlined)),
                        title: Text(
                          widget.importantTask[index],
                          style: TextStyle(
                              decoration: widget.importantTask.contains(index)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: widget.importantTask.contains(index)
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: widget.importantTask.contains(widget.importantTask[index])
                              ? Icon(
                            Icons.star,
                          )
                              : const Icon(Icons.star_border),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
