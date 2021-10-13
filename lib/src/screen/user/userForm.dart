import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/search.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, required this.handleFilters}) : super(key: key);
  final Function handleFilters;
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  bool checkActive = false;
  bool checkInactive = false;
  List<String> status = [];
  int page = 1;
  int limit = 20;
  filter() {
    final UserFilter filters = UserFilter(
      userNameController.value.text,
      displayNameController.value.text,
      status,
      limit,
      page,
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
                      controller: userNameController,
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
                      controller: displayNameController,
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
                  value: this.checkActive,
                  onChanged: (value) {
                    setState(() {
                      this.checkActive = value!;
                      if (checkActive == true) {
                        status.add('A');
                      } else {
                        status.remove('A');
                      }
                    });
                  },
                ),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 16.0),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.lightGreen,
                  value: this.checkInactive,
                  onChanged: (value) {
                    setState(() {
                      this.checkInactive = value!;
                      if (checkInactive == true) {
                        status.add('I');
                      } else {
                        status.remove('I');
                      }
                    });
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
                  value: limit.toString(),
                  onChanged: (String? newValue) {
                    setState(() {
                      limit = int.parse(newValue!);
                    });
                    filter();
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
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      filter();
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
