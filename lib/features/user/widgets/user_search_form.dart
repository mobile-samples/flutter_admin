import 'package:flutter/material.dart';

import '../user_model.dart';

class UserSearchForm extends StatefulWidget {
  const UserSearchForm({
    super.key,
    required this.userFilter,
    required this.userName,
    required this.displayName,
    required this.status,
    required this.handleFilters,
    required this.handleChangeStatus,
  });

  final UserFilter userFilter;
  final TextEditingController userName;
  final TextEditingController displayName;
  final List<String> status;
  final void Function(String, bool) handleChangeStatus;
  final void Function(UserFilter) handleFilters;

  @override
  State<UserSearchForm> createState() => _UserSearchFormState();
}

class _UserSearchFormState extends State<UserSearchForm> {
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
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 100,
              child: Text('User Name'),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  controller: widget.userName,
                  decoration: const InputDecoration(
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
        Row(
          children: [
            const SizedBox(
              width: 100,
              child: Text('Display Name'),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  controller: widget.displayName,
                  decoration: const InputDecoration(
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
        Row(
          children: [
            const SizedBox(
              width: 100,
              child: Text('Status'),
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.lightGreen,
              value: widget.status.contains('A'),
              onChanged: (value) {
                setState(() {
                  widget.handleChangeStatus('A', value!);
                });
              },
            ),
            const Text(
              'Active',
              style: TextStyle(fontSize: 16.0),
            ),
            Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.lightGreen,
              value: widget.status.contains('I'),
              onChanged: (value) {
                setState(() {
                  widget.handleChangeStatus('I', value!);
                });
              },
            ),
            const Text(
              'Inactive',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                child: DropdownButton(
              value: widget.userFilter.limit.toString(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.userFilter.limit = int.parse(newValue!);
                });
              },
              items: <String>['5', '10', '20', '40']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(width: 60),
            SizedBox(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                minimumSize: const Size(88, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )),
            SizedBox(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                minimumSize: const Size(88, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              onPressed: () {
                filter(null);
                Navigator.pop(context);
              },
              child: const Text('Search'),
            )),
          ],
        ),
      ],
    );
  }
}
