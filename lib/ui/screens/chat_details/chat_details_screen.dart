import '../../../shared/constants/default_values.dart';
import 'package:flutter/material.dart';

import '../../widgets/chat_details_body.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const ChatDetailsBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user_2.png'),
          ),
          const SizedBox(width: myDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Kristin Watson',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                'Active 3m ago',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.videocam),
        ),
        const SizedBox(width: myDefaultPadding / 2),
      ],
    );
  }
}
