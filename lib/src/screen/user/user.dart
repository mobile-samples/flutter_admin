import 'package:flutter/material.dart';
import 'package:flutter_admin/src/common/client/client.dart';
import 'package:flutter_admin/src/common/client/model.dart';
import 'package:flutter_admin/src/common/state/generic_state.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/src/screen/edit_user/edit_user.dart';
import 'package:flutter_admin/src/screen/user/pagination.dart';
import 'package:flutter_admin/src/screen/user/userCard.dart';
import 'package:flutter_admin/src/screen/user/userForm.dart';
import 'package:flutter_admin/src/services/user.dart';
import 'package:flutter_admin/utils/general_method.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends GenericState<UserScreen, User, UserFilter> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController displayNameController = TextEditingController();
  late UserFilter filter;
  late List<String> status;

  @override
  UserFilter getFilter() {
    return filter;
  }

  @override
  Client<User, String, ResultInfo<User>, UserFilter> getService() {
    return UserAPIService.instance;
  }

  @override
  void setFilter() {
    setState(() {
      filter = UserFilter(null, '', null, '', [], 20, 1);
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

  handleFilters(UserFilter filter) async {
    this.filter = filter;
    search();
  }

  @override
  Widget buildChild(BuildContext context, SearchResult<User> searchResult) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.green[400],
                title: const Text('User'),
              ),
              UserForm(
                userFilter: filter,
                userName: userNameController,
                displayName: displayNameController,
                status: status,
                handleFilters: handleFilters,
                hanleChangeStatus: hanleChangeStatus,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (searchResult.list.isNotEmpty) {
                      return GestureDetector(
                          onTap: () async {
                            final reLoadPage = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUserScreen(
                                      user: searchResult.list[index])),
                            );
                            if (reLoadPage == null || reLoadPage == true) {
                              search();
                              GeneralMethod.autoScrollOnTop(_scrollController);
                            }
                          },
                          child: UserCard(
                            user: searchResult.list[index],
                          ));
                    } else {
                      return Container();
                    }
                  },
                  childCount: searchResult.list.length,
                ),
              ),
              (searchResult.total != 0 && searchResult.total > filter.limit!)
                  ? PaginationButtonForUser(
                      handlePagination: handleFilters,
                      total: searchResult.total,
                      userFilter: filter,
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox(
                        width: 0,
                        height: 0,
                      ),
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
