class Cast {
  List<Actor> actors = List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = Actor.fromJsomMap(element);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsomMap(Map<String, dynamic> json) {
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    order = json["order"];
    profilePath = json["profile_path"];
  }

  getPhoto() {
    if (profilePath == null) {
      return "https://i.dlpng.com/static/png/6728146_preview.png";
    }
    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}
