import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/role.dart';

class PaginationButton extends StatefulWidget {
  const PaginationButton({
    Key? key,
    required this.handlePagination,
    required this.roleFilter,
    required this.total,
  }) : super(key: key);
  final Function handlePagination;
  final RoleFilter roleFilter;
  final int total;
  @override
  _PaginationButtonState createState() => _PaginationButtonState();
}

class _PaginationButtonState extends State<PaginationButton> {
  handleOnClick(int newPage) {
    final RoleFilter formFilter = RoleFilter(
      roleName: widget.roleFilter.roleName,
      status: widget.roleFilter.status,
      limit: widget.roleFilter.limit,
      page: newPage,
    );
    widget.handlePagination(formFilter);
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
            (widget.total / widget.roleFilter.limit).ceil(),
            (index) => GestureDetector(
              onTap: () {
                handleOnClick(index + 1);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: index + 1 == widget.roleFilter.page
                      ? Colors.blue
                      : Colors.white,
                ),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: index + 1 == widget.roleFilter.page
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
