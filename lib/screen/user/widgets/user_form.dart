import 'package:flutter/material.dart';
import 'package:flutter_admin/screen/user/user_model.dart';

class UserForm extends StatefulWidget {
  const UserForm({
    Key? key,
    required this.userFilter,
    required this.userName,
    required this.displayName,
    required this.status,
    required this.handleFilters,
    required this.hanleChangeStatus,
  }) : super(key: key);

  final UserFilter userFilter;
  final TextEditingController userName;
  final TextEditingController displayName;
  final List<String> status;
  final void Function(String, bool) hanleChangeStatus;
  final void Function(UserFilter) handleFilters;
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  void filter(int? newValue) {
    final UserFilter filters = UserFilter(
      null,
      widget.userName.text,
      null,
      widget.displayName.text,
      widget.status,
      newValue ?? widget.userFilter.limit,
      1,
    );
    widget.handleFilters(filters);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('User Name'),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      controller: widget.userName,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          //  when the TextFormField in focused
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Display Name'),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      controller: widget.displayName,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          //  when the TextFormField in focused
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Status'),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.lightGreen,
                  value: widget.status.contains('A'),
                  onChanged: (value) {
                    widget.hanleChangeStatus('A', value!);
                  },
                ),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 16.0),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.lightGreen,
                  value: widget.status.contains('I'),
                  onChanged: (value) {
                    widget.hanleChangeStatus('I', value!);
                  },
                ),
                Text(
                  'Inactive',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    child: DropdownButton(
                  value: widget.userFilter.limit.toString(),
                  onChanged: (String? newValue) {
                    filter(int.parse(newValue!));
                  },
                  items: <String>['5', '10', '20', '40']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      filter(null);
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
            ),
          ),
        ],
      ),
    );
  }
}
