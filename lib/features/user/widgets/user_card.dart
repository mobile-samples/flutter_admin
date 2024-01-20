import 'package:flutter/material.dart';
import 'package:flutter_admin/common/widget/size.dart';
import 'package:flutter_admin/features/user/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  final User user;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (user.imageURL == null || user.imageURL!.isEmpty)
                        ? null
                        : NetworkImage(user.imageURL.toString()),
                  ),
                  AppSizedWidget.spaceWidth(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: user.status == 'A'
                                    ? Colors.teal[700]
                                    : Colors.grey,
                          ),
                        ),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                        )
                      ],
                    ),
                  ],
            ),
            const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
