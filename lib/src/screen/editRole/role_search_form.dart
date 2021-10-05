import 'package:flutter/material.dart';

class RoleSearchForm extends StatefulWidget {
  const RoleSearchForm({Key? key}) : super(key: key);
  @override
  _RoleSearchFormState createState() => _RoleSearchFormState();
}

class _RoleSearchFormState extends State<RoleSearchForm> {
  bool checkAll = true;
  TextEditingController _searchController = TextEditingController();

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
                    value: checkAll,
                    onChanged: (value) {
                      setState(() {
                        checkAll = value!;
                      });
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
