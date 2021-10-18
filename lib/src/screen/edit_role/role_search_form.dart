import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoleSearchForm extends StatefulWidget {
  const RoleSearchForm({
    Key? key,
    required this.privilegesByRole,
    required this.allPrivilege,
    required this.handleCheckAll,
    required this.searchController,
    required this.handleSearch,
  }) : super(key: key);

  final List<String> privilegesByRole;
  final List<String> allPrivilege;
  final Function handleCheckAll;
  final TextEditingController searchController;
  final Function handleSearch;

  @override
  _RoleSearchFormState createState() => _RoleSearchFormState();
}

class _RoleSearchFormState extends State<RoleSearchForm> {
  @override
  void initState() {
    super.initState();
  }

  privilegesNotExistByRole(
    List<String> allPrivilege,
    List<String> privilegesByRole,
  ) {
    List<String> newList = [...allPrivilege];
    privilegesByRole.forEach((e) {
      allPrivilege.forEach((e1) {
        if (e == e1) {
          newList.remove(e);
        }
      });
    });
    return newList;
  }

  handleCheckedClick(bool value) {
    if (value == false) {
      final List<String> list = [];
      widget.handleCheckAll(value, list);
    } else if (value == true) {
      final List<String> list = privilegesNotExistByRole(
          widget.allPrivilege, widget.privilegesByRole);
      widget.handleCheckAll(value, list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
        decoration: BoxDecoration(color: Colors.black12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.lightGreen,
                    value: widget.allPrivilege.length ==
                            widget.privilegesByRole.length
                        ? true
                        : false,
                    onChanged: (value) {
                      handleCheckedClick(value!);
                    },
                  ),
                  Text('All Privileges'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: widget.searchController,
                  enableSuggestions: false,
                  autocorrect: false,
                  onSubmitted: (value) {
                    widget.handleSearch(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Filter modules",

                    // Set height for InputDecoration.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,

                    prefixIcon:
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
