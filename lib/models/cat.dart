import 'info.dart';

class Cat {
  final String id;
  final String url;
  final Info info;


  Cat({
    required this.id,
    required this.url,
    required this.info,
    });

  factory Cat.fromJson(Map<String, dynamic> e){
    return Cat(
        info: Info.fromJson(e["info"]),
        url: e['url'],
      id: e['id']
      );
  }
}

