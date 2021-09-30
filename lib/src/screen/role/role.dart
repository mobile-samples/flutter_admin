import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/role/widgets/paginationButton.dart';
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
  late RoleFilter roleFilter = RoleFilter(limit: 10);
  late List<RoleSM> roles = [];
  late int total = 0;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  getRole() async {
    final res = await APIService.instance
        .getRole(token: widget.authInfo.token, filters: roleFilter);
    setState(() {
      roles = res.list;
      total = res.total;
    });
  }

  handleSearchFilter(RoleFilter formFilter) async {
    print(formFilter.limit);
    final res = await APIService.instance
        .getRole(token: widget.authInfo.token, filters: formFilter);
    print(res.list.length);
    setState(() {
      roles = res.list;
      total = res.total;
    });
  }

  handlePagination(RoleFilter formFilter) {}

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
              initialRolel: roleFilter,
              handleSearchFilter: handleSearchFilter,
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
            PaginationButton(
              handlePagination: handlePagination,
            )
          ],
        ));
  }
}
