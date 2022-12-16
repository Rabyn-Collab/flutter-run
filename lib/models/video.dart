

class Video{

  final String key;
  final String name;

  Video({required this.name, required this.key});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
        name: json['name'],
        key: json['key']
    );
  }

}