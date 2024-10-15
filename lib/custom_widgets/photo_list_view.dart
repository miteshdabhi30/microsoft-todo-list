import 'package:flutter/material.dart';

class PhotoListView extends StatefulWidget {


  const PhotoListView({super.key});

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {

  List<String> photoList = [
    "assets/one.jpg",
    "assets/two.jpg",
    "assets/three.jpg",
    "assets/four.jpg",
    "assets/five.jpg",
    "assets/six.jpg",
    "assets/seven.jpg",
    "assets/eight.jpg",
    "assets/nine.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: photoList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(photoList[index], fit: BoxFit.cover,)),
            ),
          );
        },
      ),
    );
  }
}



