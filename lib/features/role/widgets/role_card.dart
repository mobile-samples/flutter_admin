import 'package:flutter/material.dart';
import 'package:flutter_admin/features/role/role_model.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({super.key, required this.role});

  final Role role;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.roleName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: role.status == 'A'
                              ? Colors.teal[700]
                              : Colors.grey,
                        ),
                  ),
                  Text(
                    role.remark,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
              const Icon(Icons.chevron_right),
            ],
          )),
    );
  }
}
