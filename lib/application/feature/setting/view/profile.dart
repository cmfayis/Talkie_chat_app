import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage('assets/avatar.jpg'), // Replace with user's avatar
            ),
            SizedBox(height: 10),
            Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Software Developer', // Replace with user's occupation or other details
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Container(
              
              width: double.infinity,
              color: Colors.red,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email),
                    title:
                        Text('john.doe@example.com'), // Replace with user's email
                    onTap: () {
                      // Action when email is tapped
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title:
                        Text('+1234567890'), // Replace with user's phone number
                    onTap: () {
                      // Action when phone number is tapped
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('New York, USA'), // Replace with user's location
                    onTap: () {
                      // Action when location is tapped
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
