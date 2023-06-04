import 'package:flutter/material.dart';
import 'package:flutter_admin/screen/role/role_model.dart';

class PaginationButtonForRole extends StatefulWidget {
  const PaginationButtonForRole({
    Key? key,
    required this.handlePagination,
    required this.roleFilter,
    required this.total,
  }) : super(key: key);
  final Function(RoleFilter) handlePagination;
  final RoleFilter roleFilter;
  final int total;
  @override
  State<PaginationButtonForRole> createState() =>
      _PaginationButtonForRoleState();
}

class _PaginationButtonForRoleState extends State<PaginationButtonForRole> {
  handleOnClick(int newPage) {
    final RoleFilter formFilter = RoleFilter(
      null,
      widget.roleFilter.roleName,
      widget.roleFilter.status,
      null,
      null,
      widget.roleFilter.limit!,
      newPage,
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
            (widget.total / widget.roleFilter.limit!).ceil(),
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
