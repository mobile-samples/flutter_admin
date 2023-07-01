import 'package:flutter/material.dart';
import 'package:flutter_admin/screen/role/role_model.dart';

class RoleForm extends StatefulWidget {
  const RoleForm({
    Key? key,
    required this.roleFilter,
    required this.roleNameController,
    required this.status,
    required this.handleSearchFilter,
    required this.hanleChangeStatus,
  }) : super(key: key);

  final RoleFilter roleFilter;
  final TextEditingController roleNameController;
  final Function handleSearchFilter;
  final List<String> status;
  final void Function(String, bool) hanleChangeStatus;

  @override
  State<RoleForm> createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  handleSearchClick(int? newLimit) {
    final RoleFilter formFilter = RoleFilter(
      null,
      widget.roleNameController.value.text,
      widget.status,
      null,
      null,
      newLimit ?? widget.roleFilter.limit,
      1,
    );
    widget.handleSearchFilter(formFilter);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Role name:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    controller: widget.roleNameController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Status:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: widget.status.contains('A'),
                          onChanged: (value) {
                            widget.hanleChangeStatus('A', value!);
                          },
                        ),
                        Text('Active')
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: widget.status.contains('I'),
                          onChanged: (value) {
                            widget.hanleChangeStatus('I', value!);
                          },
                        ),
                        Text('Inactive')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Row(
                    children: [
                      Text('Page Size: ', style: TextStyle(fontSize: 16.0)),
                      DropdownButton<String>(
                        value: widget.roleFilter.limit.toString(),
                        iconSize: 0.0,
                        onChanged: (String? newValue) {
                          handleSearchClick(int.parse(newValue!));
                        },
                        items: <String>['5', '10', '20', '40']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      handleSearchClick(null);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
