import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/src/screen/edit-user/edit_role_form.dart';
import 'package:flutter_admin/src/services/user.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late User userDetail;
  bool _loading = true;

  getUserById() async {
    final res = await UserAPIService.instance.load(widget.user.userId);
    print(res.position);
    print(res.title);
    setState(() {
      userDetail = res;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserById();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return Center(
        child: Text('Loading....'),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green[400],
            title: Text('Edit user'),
          ),
          EditRoleFormScreen(userDetail: userDetail),
        ],
      ),
    );
  }
}
