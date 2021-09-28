import 'package:flutter/material.dart';

class RoleCard extends StatefulWidget {
  const RoleCard({Key? key}) : super(key: key);

  @override
  _RoleCardState createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.teal[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  'Admin',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                )
              ],
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
