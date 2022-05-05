import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget createLabel(text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 3
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      createLabel('Name:'),
                      Text('Name1'),
                      const SizedBox(height: 10),
                      createLabel('Date of birth:'),
                      Text('DateOfBirth1'),
                      const SizedBox(height: 10),
                      createLabel('Location:'),
                      Text('Location1'),
                      const SizedBox(height: 10),
                      createLabel('Phone:'),
                      Text('PhoneNumber1'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
