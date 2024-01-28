import 'package:flutter/material.dart';
import 'package:flutter_admin/common/client/client.dart';
import 'package:flutter_admin/common/client/model.dart';
import 'package:flutter_admin/common/client/search_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../user_model.dart';
import '../user_service.dart';
import 'user_card.dart';
import 'user_search_form.dart';
import 'view_user.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
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
  Client<User, String, UserFilter> getService() {
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
                  UserSearchForm(
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
        title: Text(AppLocalizations.of(context)!.userManagementTitle),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearchModal(context)),
        ]);
  }

  @override
  Widget buildChild(BuildContext context, SearchResult<User> searchResult) {
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
                            builder: (context) =>
                                ViewUserScreen(user: searchResult.list[index])),
                      );
                    },
                    child: UserCard(user: searchResult.list[index]));
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
