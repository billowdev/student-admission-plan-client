import 'package:flutter/material.dart';

class BurgerNavBar extends StatefulWidget {
  const BurgerNavBar({Key? key}) : super(key: key);

  @override
  _BurgerNavBarState createState() => _BurgerNavBarState();
}

class _BurgerNavBarState extends State<BurgerNavBar> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: _isExpanded ? Icon(Icons.close) : Icon(Icons.menu),
        color: Colors.black,
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
      ),
      title: _isExpanded
          ? null
          : const Text(
              'เมนู',
              style: TextStyle(color: Colors.black),
            ),
      actions: _isExpanded
          ? [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
            ]
          : null,
    );
  }
}
