import 'package:flutter/material.dart';
import 'package:flutter_rest_api/service/api_client.dart';

import '../models/cat.dart';
import '../pages/ad_page.dart';

class ListTiles extends StatelessWidget {
  final Cat cat;

  const ListTiles({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(cat.url),
      ),
      title: Text(cat.info.title),
      subtitle: Text(cat.info.body),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdPage(cat: cat)));

            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              ApiClient.deleteData(cat.id.toString());
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Deleted')));
            },
          ),
        ],
      ),
    );
  }
}
