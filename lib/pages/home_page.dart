import 'package:flutter/material.dart';
import 'package:flutter_rest_api/pages/ad_page.dart';

import '../models/cat.dart';
import '../service/api_client.dart';
import '../widgets/list_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }
  List<Cat> cats = [];
  bool isLoading  = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>AdPage() )), icon: Icon(Icons.add)),
        title: Text('Cats Photos'),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: getData ,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: cats.length,
                    itemBuilder: (context, index) => ListTiles(
                          cat: cats[index],
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiClient.getData();
    setState(() {
      cats = response;
      isLoading = false;
    });
  }

}
