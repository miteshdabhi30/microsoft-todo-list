import 'package:flutter/material.dart';

class CustomTile {

  static listTile(String title, IconData icon, Color color, [VoidCallback? onTap]){
    return ListTile(
      title: Text(title),
      leading: Icon(icon, color: color,),
      onTap: onTap,
    );
  }
}