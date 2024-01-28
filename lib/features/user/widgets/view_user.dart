import 'package:flutter/material.dart';
import 'package:flutter_admin/common/widget/size.dart';
import 'package:flutter_admin/features/user/widgets/user_form.dart';

import '../user_model.dart';
import '../user_service.dart';

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
  User? userDetail;
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

  buildTextRow(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          value ?? '',
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: const Text('View user'),
          actions: [
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserFormScreen(
                              user: userDetail!,
                              handleChangeUser: handleChangeUser)),
                    )),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextRow('User Id', userDetail?.userId),
                spaceHeightWithChild(20, const Divider()),
                buildTextRow('Name', userDetail?.displayName),
                spaceHeightWithChild(20, const Divider()),
                buildTextRow(
                  'Position',
                  ['Employee', 'Manager', 'Director', 'Other'].firstWhere(
                      (e) => e.startsWith(userDetail?.position ?? 'O')),
                ),
                spaceHeightWithChild(20, const Divider()),
                buildTextRow('Telephone', userDetail?.phone),
                spaceHeightWithChild(20, const Divider()),
                buildTextRow('Email', userDetail?.email),
                spaceHeightWithChild(20, const Divider()),
                buildTextRow('Status',
                    userDetail?.status == 'A' ? 'Actived' : 'Inactive'),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
