import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/screen/edit_role/edit_role.dart';
import 'package:flutter_admin/src/screen/role/widgets/pagination.dart';
import 'package:flutter_admin/src/screen/role/widgets/role_card.dart';
import 'package:flutter_admin/src/screen/role/widgets/search_form.dart';
import 'package:flutter_admin/src/services/role.dart';
import 'package:flutter_admin/utils/general_method.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RoleScreenState createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final RoleFilter initialValue = RoleFilter('', [], 5, 1);
  ScrollController _scrollController = new ScrollController();
  late RoleFilter roleFilter =
      // RoleFilter(limit: 10, page: 1, roleName: '', status: []);
      RoleFilter('', [], 5, 1);
  late List<RoleSM> roles = [];
  late int total = 0;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  getRole() async {
    final res = await RoleService.instance.search(roleFilter);
    setState(() {
      roles = res.list;
      total = res.total;
    });
  }

  handleSearchFilter(RoleFilter formFilter) async {
    final res = await RoleService.instance.search(formFilter);
    setState(() {
      roles = res.list;
      total = res.total;
      roleFilter = formFilter;
    });
  }

  handlePagination(RoleFilter formFilter) async {
    final res = await RoleService.instance.search(formFilter);
    setState(() {
      roles = res.list;
      roleFilter = formFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green[400],
              title: Text('Search Roles'),
            ),
            RoleForm(
              initialRole: roleFilter,
              handleSearchFilter: handleSearchFilter,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      final reLoadPage = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditRoleScreen(roleId: roles[index].roleId)),
                      );
                      if (reLoadPage == null || reLoadPage == true) {
                        handleSearchFilter(initialValue);
                        GeneralMethod.autoScrollOnTop(_scrollController);
                      }
                    },
                    child: RoleCard(
                      role: roles[index],
                    ),
                  );
                },
                childCount: roles.length > 0 ? roles.length : 0,
              ),
            ),
            (total != 0 && total > roleFilter.limit)
                ? PaginationButton(
                    handlePagination: handlePagination,
                    roleFilter: roleFilter,
                    total: total,
                  )
                : SliverToBoxAdapter(
                    child: SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  )
          ],
        ));
  }
}
