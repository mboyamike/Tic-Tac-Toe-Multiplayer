import 'package:flutter/material.dart';
import 'package:tttm/multiplayer/multiplayer.dart';
import 'package:tttm/singleplayer.dart';

class SelectMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(80.0, 50.0, 10.0, 0.0),
            child: Text(
              'Select Mode to Play',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Single_Player()));
              },
              child: Text(
                'Single Mode',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60.0, 10.0, 10.0, 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MenuScreen.route());
              },
              child: Text(
                'Multiplayer Mode',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
