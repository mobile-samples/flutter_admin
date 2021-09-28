import 'package:flutter/material.dart';

class RoleForm extends StatefulWidget {
  const RoleForm({Key? key}) : super(key: key);

  @override
  _RoleFormState createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  bool checkActive = false;
  bool checkInactive = false;
  int dropdownValue = 20;
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
                  child: TextField(),
                ),
              ],
            ),
            Row(
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
                        value: checkActive,
                        onChanged: (value) {
                          setState(() {
                            checkActive = value!;
                          });
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
                        value: checkInactive,
                        onChanged: (value) {
                          setState(() {
                            checkInactive = value!;
                          });
                        },
                      ),
                      Text('Inactive')
                    ],
                  ),
                ),
              ],
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
                        value: dropdownValue.toString(),
                        iconSize: 0.0,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = int.parse(newValue!);
                          });
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
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
