import 'package:flutter/material.dart';

class ColorListView extends StatefulWidget {
  final Function(Color) newColor;

  const ColorListView({super.key, required this.newColor});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  Color baseColor = Colors.indigo;
  int _isSelected = 0;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: colorList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.newColor(colorList[index]);
              setState(() {
                _isSelected = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: colorList[index],
                  border: Border.all(
                      color: index > 6 ? Colors.black54 : Colors.transparent,
                      width: 2),
                  borderRadius: BorderRadius.circular(50)),
            ),
          );
        },
      ),
    );
  }
}
