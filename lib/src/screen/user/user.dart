import 'package:flutter/material.dart';
import 'package:flutter_admin/src/common/client/client.dart';
import 'package:flutter_admin/src/common/client/model.dart';
import 'package:flutter_admin/src/common/search_state.dart';
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
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends SearchState<UserScreen, User, UserFilter> {
  ScrollController _scrollController = new ScrollController();
  late UserFilter filter;
  // late List<User> users;
  late int total;
  late TextEditingController userNameController = TextEditingController();
  late TextEditingController displayNameController = TextEditingController();
  late List<String> status;

  @override
  void initState() {
    this.search();
    super.initState();
  }

  @override
  UserFilter getFilter() {
    return this.filter;
  }

  @override
  Client<User, String, ResultInfo<User>, UserFilter> getService() {
    return UserAPIService.instance;
  }

  @override
  void setFilter() {
    this.filter = UserFilter(null, '', null, '', [], 20, 1);
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

  // getUsers() async {
  //   final UserFilter initialValue = UserFilter(null, '', null, '', [], 20, 1);
  //   // final SearchResult<User> res =
  //   //     await SqliteService.instance.searchUser(initialValue);
  //   // final SearchResult<User> res =
  //   //     await UserAPIService.instance.search(initialValue);
  //   setState(() {
  //     // users = res.list;
  //     // total = res.total;
  //     filter = initialValue;
  //     userNameController.text = initialValue.username ?? '';
  //     displayNameController.text = initialValue.displayName ?? '';
  //     status = initialValue.status ?? [];
  //   });
  //   FocusScope.of(context).requestFocus(FocusNode());
  // }

  handleFilters(UserFilter filter) async {
    this.filter = filter;
    this.search();
  }

  @override
  Widget buildChild(BuildContext context) {
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
                    if (this.dataList.list.length > 0) {
                      return GestureDetector(
                          onTap: () async {
                            final reLoadPage = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditUserScreen(
                                      user: this.dataList.list[index])),
                            );
                            if (reLoadPage == null || reLoadPage == true) {
                              this.search();
                              GeneralMethod.autoScrollOnTop(_scrollController);
                            }
                          },
                          child: UserCard(
                            user: this.dataList.list[index],
                          ));
                    } else {
                      return Container();
                    }
                  },
                  childCount: this.dataList.list.length,
                ),
              ),
              (total != 0 && total > filter.limit!)
                  ? PaginationButtonForUser(
                      handlePagination: handleFilters,
                      total: total,
                      userFilter: filter,
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
