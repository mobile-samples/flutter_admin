import 'package:flutter/material.dart';
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/common/client/search_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../role_model.dart';
import 'edit_role.dart';
import 'role_card.dart';
import 'search_form.dart';
import '../role_service.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({
    super.key,
  });

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends SearchState<RoleScreen, Role, RoleFilter> {
  final ScrollController _scrollController = ScrollController();
  late RoleFilter filter;
  late TextEditingController roleNameController = TextEditingController();
  late List<String> status;

  @override
  RoleFilter getFilter() {
    return filter;
  }

  @override
  Client<Role, String, RoleFilter> getService() {
    return RoleService.instance;
  }

  @override
  void setFilter() {
    setState(() {
      filter = RoleFilter(null, null, [], null, null, 5, 1);
      status = filter.status ?? [];
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

  handleSearchFilter(RoleFilter formFilter) async {
    filter = formFilter;
    search();
  }

  void showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 250),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoleForm(
                  roleNameController: roleNameController,
                  status: status,
                  roleFilter: filter,
                  hanleChangeStatus: hanleChangeStatus,
                  handleSearchFilter: handleSearchFilter,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget buildAppbar(BuildContext context) {
    return AppBar(
        title: Text(AppLocalizations.of(context)!.roleManagementTitle),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearchModal(context)),
        ]);
  }

  @override
  Widget buildChild(BuildContext context, SearchResult<Role> searchResult) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (searchResult.list.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditRoleScreen(
                              roleId: searchResult.list[index].roleId)),
                    );
                  },
                  child: RoleCard(
                    role: searchResult.list[index],
                  ),
                );
              } else {
                return Container();
              }
            },
            childCount: searchResult.list.length,
          ),
        ),
      ],
    );
  }
}
