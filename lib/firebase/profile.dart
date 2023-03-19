import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserinfoProvider.dart';
import 'func.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Method to handle sign-out action.
  void onSignout() {
    signout();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: CircleAvatar(
              radius: 110,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Display user name from UserInfoProvider.
          Consumer<UserInfoProvider>(
            builder: (context, userInfoProvider, _) => Center(
              child: Text(
                "Hi, ${userInfoProvider.userName}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(color: Colors.grey),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Change Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: 20,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Divider(color: Colors.grey),
          SizedBox(
            height: 30,
          ),
          // Sign-out button.
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: onSignout, // Call sign-out method when pressed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign out",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
