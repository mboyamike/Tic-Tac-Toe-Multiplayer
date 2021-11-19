import 'package:flutter/material.dart';
import 'package:tttm/Drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      drawer: UserDrawer(),
    );
  }
}