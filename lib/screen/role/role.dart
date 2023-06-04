import 'package:flutter/material.dart';
import 'package:flutter_admin/common/appbar.dart';
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/common/state/search_state.dart';
import 'package:flutter_admin/screen/role/role_model.dart';
import 'package:flutter_admin/screen/role/widgets/edit_role.dart';
import 'package:flutter_admin/screen/role/widgets/pagination.dart';
import 'package:flutter_admin/screen/role/widgets/role_card.dart';
import 'package:flutter_admin/screen/role/widgets/search_form.dart';
import 'package:flutter_admin/screen/role/role_service.dart';
import 'package:flutter_admin/utils/general_method.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends SearchState<RoleScreen, Role, RoleFilter> {
  final ScrollController _scrollController = ScrollController();
  late RoleFilter filter;
  late TextEditingController roleNameController = TextEditingController();
  late List<String> status;
  late List<Role> roles;
  late int total;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  RoleFilter getFilter() {
    return filter;
  }

  @override
  Client<Role, String, ResultInfo<Role>, RoleFilter> getService() {
    return RoleService.instance;
  }

  @override
  void setFilter() {
    setState(() {
      filter = RoleFilter(null, null, [], null, null, 5, 1);
      status = filter.status ?? [];
    });
  }

  getRole() async {
    final RoleFilter initialValue =
        RoleFilter(null, null, [], null, null, 5, 1);

    setState(() {
      roleNameController.text = initialValue.roleName ?? '';
      status = initialValue.status ?? [];
    });
    FocusScope.of(context).requestFocus(FocusNode());
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

  handleSearchFilter(RoleFilter formFilter) async {
    filter = formFilter;
    search();
  }

  @override
  PreferredSizeWidget buildAppbar(BuildContext context) {
    return getAppBarWithArrowBack(context, "Role");
  }

  @override
  Widget buildChild(BuildContext context, SearchResult<Role> searchResult) {
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
              roleFilter: filter,
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
            (total != 0 && total > filter.limit!)
                ? PaginationButtonForRole(
                    handlePagination: handleSearchFilter,
                    roleFilter: filter,
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
