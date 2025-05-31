import 'package:flutter/material.dart';

import '../models/cat.dart';
import '../service/api_client.dart';

class AdPage extends StatefulWidget {
  final Cat? cat;

  const AdPage({
    super.key,
    this.cat,
  });

  @override
  State<AdPage> createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  List<dynamic> cats = [];
  bool get isEditing => widget.cat != null;

  @override
  void initState() {
    super.initState();

    if (widget.cat != null) {
      titleController.text = widget.cat!.info.title;
      urlController.text = widget.cat!.url;
      bodyController.text = widget.cat!.info.body;
    }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Notes' : 'Add Notes'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: ' title'),
            controller: titleController,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(hintText: ' imageUrl'),
            minLines: 5,
            maxLines: 8,
            controller: urlController,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'description'),
            minLines: 5,
            maxLines: 8,
            controller: bodyController,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: submitData,
              child: Text(isEditing ? 'Edit Notes' : 'Add Notes')),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async{
    final title = titleController.text;
    final url = urlController.text;
    final body = bodyController.text;
    if (title.isNotEmpty && url.isNotEmpty) {
      isEditing
          ? await ApiClient.editData(id: widget.cat!.id,
        title: title, description: body, ImageUrl: url,)
          : await ApiClient.submitData(title: title, url: url, description: body);
    }
    Navigator.pop(context);

}
}

