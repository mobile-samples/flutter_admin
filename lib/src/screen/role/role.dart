import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';
import 'package:flutter_admin/src/models/search.dart';
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
  ScrollController _scrollController = ScrollController();
  late RoleFilter roleFilter;
  late TextEditingController roleNameController = TextEditingController();
  late List<String> status;
  late List<Role> roles;
  late int total;
  late bool _loading = true;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  getRole() async {
    final RoleFilter initialValue = RoleFilter(null, [], 5, 1);
    final res = await RoleService.instance.search(initialValue);
    setState(() {
      roles = res.list;
      total = res.total;
      roleFilter = initialValue;
      roleNameController.text = initialValue.roleName ?? '';
      status = initialValue.status ?? [];
      _loading = false;
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

  hanleChangeStatus(String type, bool isChecked) {
    if (type == 'A') {
      setState(() {
        isChecked == true ? status.add('A') : status.remove('A');
      });
    } else {
      setState(() {
        isChecked == true ? status.add('I') : status.remove('I');
      });
    }
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
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.green[400],
              title: Text('Search Roles'),
            ),
            RoleForm(
              roleNameController: roleNameController,
              status: status,
              roleFilter: roleFilter,
              hanleChangeStatus: hanleChangeStatus,
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
                        getRole();
                        FocusScope.of(context).requestFocus(FocusNode());
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
            (total != 0 && total > roleFilter.limit!)
                ? PaginationButton(
                    handlePagination: handleSearchFilter,
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
