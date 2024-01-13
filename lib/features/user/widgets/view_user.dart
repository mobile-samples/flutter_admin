import 'package:flutter/material.dart';

import '../user_model.dart';
import '../user_service.dart';
import 'view_user_form.dart';

class ViewUserScreen extends StatefulWidget {
  const ViewUserScreen({
    super.key,
    required this.user,
  });
  final User user;
  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  late User userDetail;
  bool _loading = true;

  getUserById() async {
    final res = await UserAPIService.instance.load(widget.user.userId);
    setState(() {
      userDetail = res;
      _loading = false;
    });
  }

  handleChangeUser(User user) {
    setState(() {
      userDetail = user;
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.green[400],
            title: const Text('View user'),
          ),
          ViewUserFormScreen(
              userDetail: userDetail, handleChangeUser: handleChangeUser),
        ],
      ),
    );
  }
}
