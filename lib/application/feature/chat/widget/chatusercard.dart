import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      leading: CircleAvatar(
        radius: 40,
        child: Image.asset('asset/images/person.png'),
      ),
      title: Text('Fayis'),
      subtitle: Text('Last seen 8 hour ago'),
      trailing: Text('12:00 pm'),
    );
  }
}