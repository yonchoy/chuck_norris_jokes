class Joke {
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Joke({this.iconUrl, this.id, this.url, this.value});
//icon_url, id, url, value
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      iconUrl: json['icon_url'],
      id: json['id'],
      url: json['url'],
      value: json['value'],
    );
  }
}