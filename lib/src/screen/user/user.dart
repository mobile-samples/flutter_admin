import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/search.dart';
import 'package:flutter_admin/src/models/user.dart';
import 'package:flutter_admin/src/screen/edit_user/edit_user.dart';
import 'package:flutter_admin/src/screen/user/userCard.dart';
import 'package:flutter_admin/src/screen/user/userForm.dart';
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
  // late List<UserSQL> users = [];
  bool _loading = true;

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    final UserFilter initialValue = UserFilter(null, '', null, '', [], 20, 1);
    final SearchResult<User> res =
        await UserAPIService.instance.search(initialValue);
    setState(() {
      users = res.list;
      total = res.total;
      filters = initialValue;
      _loading = false;
    });
  }

  handleFilters(UserFilter filter) async {
    final SearchResult<User> res = await UserAPIService.instance.search(filter);
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
                  handleFilters: handleFilters,
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
                (total != 0 && total >= users.length)
                    ? SliverToBoxAdapter(
                        child: Center(
                          heightFactor: 2.0,
                          child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List<Widget>.generate(
                                  (total / filters.limit!).ceil(),
                                  (index) => GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   filters.page = index + 1;
                                          // });
                                          final UserFilter newFilter =
                                              UserFilter(
                                            filters.userId,
                                            filters.username,
                                            filters.email,
                                            filters.displayName,
                                            filters.status,
                                            filters.limit,
                                            index + 1,
                                          );
                                          handleFilters(newFilter);
                                          GeneralMethod.autoScrollOnTop(
                                              _scrollController);
                                        },
                                        child: Container(
                                          child: Center(
                                            child: Padding(
                                                padding: EdgeInsets.all(5.0),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                          ),
                                          decoration: BoxDecoration(
                                              color:
                                                  ((index + 1) == filters.page)
                                                      ? Colors.teal
                                                      : Colors.white,
                                              border: Border.all(
                                                  color: Colors.teal,
                                                  width: 2)),
                                        ),
                                      )),
                            ),
                          ),
                        ),
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
