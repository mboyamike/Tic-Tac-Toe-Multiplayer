import 'package:flutter/material.dart';
import 'package:tttm/select_mode.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/photos/portrait-of-a-handsome-black-man-picture-id1289461328?b=1&k=20&m=1289461328&s=170667a&w=0&h=SpRhSvRMO7UkXWo52mV9bf0bo6au6kC-2wsOGsQ0D2Y='),
                    radius: 70,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'useremail@gmail.com',
                    style: TextStyle(
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
