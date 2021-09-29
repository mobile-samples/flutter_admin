import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/role/widgets/role_card.dart';
import 'package:flutter_admin/src/screen/role/widgets/search_form.dart';
import 'package:flutter_admin/src/services/auth.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({
    Key? key,
    required this.authInfo,
  }) : super(key: key);
  final AuthInfo authInfo;

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final RoleFilter filtersInitial = RoleFilter(limit: 10);
  late List<RoleSM> roles = [];
  final int total = 0;

  @override
  void initState() {
    super.initState();
    getRole();
  }

  getRole() async {
    final res = await APIService.instance
        .getRole(token: widget.authInfo.token, filters: filtersInitial);
    setState(() {
      roles.addAll(res.list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green[400],
              title: Text('Search Roles'),
            ),
            RoleForm(
                // handleSearchClick: handleFilters,
                ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return RoleCard(
                    role: roles[index],
                  );
                },
                childCount: roles.length > 0 ? roles.length : 0,
              ),
            ),
          ],
        ));
  }
}
