import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  // final UserSQL user;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundImage: user.imageURL!.isEmpty
                  ? null
                  : NetworkImage(user.imageURL.toString()),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.displayName,
                      style: TextStyle(
                          color: user.status == 'A'
                              ? Colors.teal[700]
                              : Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
