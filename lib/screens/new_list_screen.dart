import 'package:flutter/material.dart';
import 'package:microsoft_to_do/custom_widgets/custom_alert.dart';

class NewListScreen extends StatefulWidget {

  final Function(List<String>, Color) onCreateList;
  const NewListScreen({super.key, required this.onCreateList});

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  Color baseColor = const Color.fromRGBO(93, 112, 189, 1);
   List<String> _listName = [];

  void _newColor2(Color color) {
    setState(() {
      baseColor = color;
    });
  }

  void _updateList(List<String> listName, Color color) {
    setState(() {
      _listName = listName;
      widget.onCreateList(listName, color);
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlert(newColor2: _newColor2, updateList: _updateList, );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
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
        backgroundColor: baseColor,
      ),
    );
  }
}
