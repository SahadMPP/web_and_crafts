  import 'package:flutter/material.dart';

AppBar homeAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 80, 175, 83),
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child:
            Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 20),
      ),
      title:  ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            constraints: const BoxConstraints(
              maxHeight: 30
            ),
            suffixIcon: Icon(Icons.search,color: Colors.grey[300],size: 22),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.notifications_none_outlined,
              color: Colors.white, size: 20),
        )
      ],
    );
  }
