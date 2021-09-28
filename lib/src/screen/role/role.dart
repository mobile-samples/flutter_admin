import 'package:flutter/material.dart';
import 'package:flutter_admin/src/screen/role/widgets/role_card.dart';
import 'package:flutter_admin/src/screen/role/widgets/search_form.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({Key? key}) : super(key: key);

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  bool checkActive = false;
  bool checkInactive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green[400],
              title: Text('User'),
            ),
            RoleForm(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RoleCard();
                },
                childCount: 10,
              ),
            ),
          ],
        ));
  }
}
