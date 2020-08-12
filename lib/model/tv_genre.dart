class TvGenre{
  final int id;
  final String name;

  TvGenre(this.id, this.name);

  TvGenre.fromJson(Map<String, dynamic> json):
        id = json["id"],
        name = json["name"];
}