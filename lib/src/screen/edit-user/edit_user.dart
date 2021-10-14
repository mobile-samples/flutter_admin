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
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin: EdgeInsets.fromLTRB(75, 10, 75, 10),
          //     child: ElevatedButton(
          //       onPressed: () {
          //         FocusScope.of(context).requestFocus(FocusNode());
          //       },
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.green,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //       child: Text(
          //         'Save',
          //         style: TextStyle(color: Colors.white, fontSize: 16),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
