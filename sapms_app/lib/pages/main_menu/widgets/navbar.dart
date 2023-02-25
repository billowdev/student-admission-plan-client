import 'package:flutter/material.dart';

class BurgerNavBar extends StatefulWidget {
  const BurgerNavBar({Key? key}) : super(key: key);

  @override
  _BurgerNavBarState  createState() => _BurgerNavBarState();
}

class _BurgerNavBarState extends State<BurgerNavBar> {
  String _selectedItem = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: const Text('Dropdown Button Demo'),
      ),
      body: Center(
        child: DropdownButton<String>(
          value: _selectedItem,
          items: <String>[
            'Item 1',
            'Item 2',
            'Item 3',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
          },
        ),
      ),
    );
  }
}
