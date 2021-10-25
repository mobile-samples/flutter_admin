import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/src/screen/edit_user/edit_user.dart';
import 'package:flutter_admin/src/screen/user/pagination.dart';
import 'package:flutter_admin/src/screen/user/userCard.dart';
import 'package:flutter_admin/src/screen/user/userForm.dart';
import 'package:flutter_admin/src/services/sqlite.dart';
import 'package:flutter_admin/src/services/user.dart';
import 'package:flutter_admin/utils/general_method.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  ScrollController _scrollController = new ScrollController();
  late UserFilter filters;
  late List<User> users;
  late int total;
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController displayNameController = TextEditingController();
  late List<String> status;
  // late List<UserSQL> users = [];
  bool _loading = true;

  @override
  void initState() {
    getUsers();
    super.initState();
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

  getUsers() async {
    final UserFilter initialValue = UserFilter(null, '', null, '', [], 20, 1);
    final SearchResult<User> res = await SqliteService.searchUser(initialValue);
    final res1 = await SqliteService.loadUser('00012');
    // final SearchResult<User> res =
    //     await UserAPIService.instance.search(initialValue);
    setState(() {
      users = res.list;
      total = res.total;
      filters = initialValue;
      userNameController.text = initialValue.username ?? '';
      displayNameController.text = initialValue.displayName ?? '';
      status = initialValue.status ?? [];
      _loading = false;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  handleFilters(UserFilter filter) async {
    final SearchResult<User> res = await SqliteService.searchUser(filter);
    // final SearchResult<User> res = await UserAPIService.instance.search(filter);
    setState(() {
      users = res.list;
      total = res.total;
      filters = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return Center(
        child: Text('Loading....'),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.green[400],
                  title: Text('User'),
                ),
                UserForm(
                  userFilter: filters,
                  userName: userNameController,
                  displayName: displayNameController,
                  status: status,
                  handleFilters: handleFilters,
                  hanleChangeStatus: hanleChangeStatus,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (users.length > 0) {
                        return GestureDetector(
                            onTap: () async {
                              final reLoadPage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditUserScreen(user: users[index])),
                              );
                              if (reLoadPage == null || reLoadPage == true) {
                                getUsers();
                                GeneralMethod.autoScrollOnTop(
                                    _scrollController);
                              }
                            },
                            child: UserCard(
                              user: users[index],
                            ));
                      }
                    },
                    childCount: users.length,
                  ),
                ),
                (total != 0 && total > filters.limit!)
                    ? PaginationButtonForUser(
                        handlePagination: handleFilters,
                        total: total,
                        userFilter: filters,
                      )
                    : SliverToBoxAdapter(
                        child: SizedBox(
                          width: 0,
                          height: 0,
                        ),
                      )
              ],
            ),
          ),
        ]),
      );
    }
  }
}
