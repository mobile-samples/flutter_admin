import 'package:flutter/material.dart';

class PaginationButton extends StatefulWidget {
  const PaginationButton({Key? key, required this.handlePagination})
      : super(key: key);
  final Function handlePagination;
  @override
  _PaginationButtonState createState() => _PaginationButtonState();
}

class _PaginationButtonState extends State<PaginationButton> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List<Widget>.generate(
            5,
            (index) => GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: index + 1 == 1 ? Colors.blue : Colors.white),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                      color: index + 1 == 1 ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
