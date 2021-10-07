import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/auth.dart';

class RoleSearchForm extends StatefulWidget {
  const RoleSearchForm({
    Key? key,
    required this.privilegesByRole,
    required this.allPrivilege,
    required this.handleCheckAll,
  }) : super(key: key);
  final List<String> privilegesByRole;
  final List<String> allPrivilege;
  final Function handleCheckAll;

  @override
  _RoleSearchFormState createState() => _RoleSearchFormState();
}

class _RoleSearchFormState extends State<RoleSearchForm> {
  TextEditingController _searchController = TextEditingController();

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
                      if (value == false) {
                        final List<String> list = [];
                        widget.handleCheckAll(value, list);
                      } else if (value == true) {
                        final List<String> list = privilegesNotExistByRole(
                            widget.allPrivilege, widget.privilegesByRole);
                        widget.handleCheckAll(value, list);
                      }
                    },
                  ),
                  Text('All Privileges'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TextField(
                  controller: _searchController,
                  enableSuggestions: false,
                  autocorrect: false,
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
