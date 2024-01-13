import 'package:flutter/material.dart';
import 'package:flutter_admin/features/user/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });
  // final UserSQL user;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundImage: (user.imageURL == null || user.imageURL!.isEmpty)
                  ? null
                  : NetworkImage(user.imageURL.toString()),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Icon(Icons.chevron_right),
          )
        ],
      ),
    );
  }
}
