import 'package:flutter/material.dart';
import 'package:flutter_admin/features/user/user_model.dart';

class PaginationButtonForUser extends StatefulWidget {
  const PaginationButtonForUser({
    Key? key,
    required this.handlePagination,
    required this.userFilter,
    required this.total,
  }) : super(key: key);

  final int total;
  final UserFilter userFilter;
  final Function(UserFilter) handlePagination;

  @override
  State<PaginationButtonForUser> createState() =>
      _PaginationButtonForUserState();
}

class _PaginationButtonForUserState extends State<PaginationButtonForUser> {
  handleOnClick(int newPage) {
    final UserFilter filters = UserFilter(
      null,
      widget.userFilter.username,
      null,
      widget.userFilter.displayName,
      widget.userFilter.status,
      widget.userFilter.limit,
      newPage,
    );
    widget.handlePagination(filters);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List<Widget>.generate(
            (widget.total / widget.userFilter.limit!).ceil(),
            (index) => GestureDetector(
              onTap: () {
                handleOnClick(index + 1);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: index + 1 == widget.userFilter.page
                      ? Colors.blue
                      : Colors.white,
                ),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: index + 1 == widget.userFilter.page
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
