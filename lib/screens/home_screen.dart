import 'package:flutter/material.dart';
import 'package:microsoft_to_do/custom_widgets/custom_list_tile.dart';

import 'details_screen.dart';
import 'important_screen.dart';
import 'myday_screen.dart';
import 'new_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> favouriteTask = [];

  void _onCreateList(List<String> newList, Color color) {
    setState(() {
      myList.addAll(newList);
      myColors.add(color);
    });
  }

  _favToImp(List<String> favTask) {
    setState(() {
      favouriteTask = favTask;
    });
  }

  List<String> myList = [];
  List<Color> myColors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "miteshrdabhi@gmail.com",
          style: TextStyle(fontSize: 18),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.indigo,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            CustomTile.listTile(
              "My Day",
              Icons.sunny,
              Colors.blueGrey,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyDayScreen()));
              },
            ),
            CustomTile.listTile(
                "Important", Icons.star_border_outlined, Colors.brown, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImportantScreen(
                            importantTask: favouriteTask,
                          )));
            }),
            CustomTile.listTile(
                "Planned", Icons.calendar_month_outlined, Colors.lightGreen),
            CustomTile.listTile("Assigned to me", Icons.person, Colors.green),
            CustomTile.listTile(
                "Tasks", Icons.home_outlined, Colors.indigoAccent),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            Flexible(
                child: ReorderableListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        key: ValueKey(myList[index]),
                        leading: Icon(
                          Icons.menu,
                          color: myColors[index],
                        ),
                        title: Text(myList[index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        itemTitle: myList[index],
                                        backGroundColor: myColors[index],
                                        favToImp: _favToImp,
                                      )));
                        },
                      );
                    },
                    itemCount: myList.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final element = myList.removeAt(oldIndex);
                        myList.insert(newIndex, element);
                      });
                    })),
            Text("List count : ${favouriteTask.length}"),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewListScreen(
                      onCreateList: _onCreateList,
                    ),
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  "New list",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                leading: Icon(
                  Icons.add,
                  color: Colors.blueAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
