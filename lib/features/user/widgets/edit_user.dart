import 'package:flutter/material.dart';

import '../user_model.dart';
import '../user_service.dart';
import 'edit_user_form.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({
    Key? key,
    required this.user,
    required this.handleChangeUser,
  }) : super(key: key);
  final User user;
  final Function handleChangeUser;
  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late User userDetail;
  bool _loading = true;

  handleClickSave(User user) async {
    await UserAPIService.instance.update(user);
    setState(() {
      userDetail = user;
    });
    widget.handleChangeUser(user);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userDetail = widget.user;
      _loading = false;
    });
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
            title: const Text('Edit user'),
          ),
          EditUserFormScreen(
              userDetail: userDetail, handleClickSave: handleClickSave),
        ],
      ),
    );
  }
}
