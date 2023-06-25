import 'package:flutter/material.dart';
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/common/state/search_state.dart';
import 'package:flutter_admin/utils/general_method.dart';

import 'user_model.dart';
import 'user_service.dart';
import 'widgets/user_card.dart';
import 'widgets/user_form.dart';
import 'widgets/view_user.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends SearchState<UserScreen, User, UserFilter> {
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

  handleChangeStatus(String type, bool isChecked) {
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

  void handleFilters(UserFilter filter) async {
    this.filter = filter;
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
                  UserForm(
                    userFilter: filter,
                    userName: userNameController,
                    displayName: displayNameController,
                    status: status,
                    handleFilters: handleFilters,
                    handleChangeStatus: handleChangeStatus,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  PreferredSizeWidget buildAppbar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('User'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearchModal(context);
              }),
        ]);
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (searchResult.list.isNotEmpty) {
                      return GestureDetector(
                          onTap: () {
                            final reLoadPage = Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewUserScreen(
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
            ],
          ),
        ),
      ]),
    );
  }
}
