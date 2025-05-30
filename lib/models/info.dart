class Info {
  final String body;
  final String title;

  Info({required this.body, required this.title});

  factory Info.fromJson(Map<String, dynamic> e) {
    return Info(body: e["description"], title: e["title"]);
  }
}
