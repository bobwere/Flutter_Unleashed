import 'dart:convert';

List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

String pokemonToJson(List<Pokemon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pokemon {
  Pokemon({
    this.name,
    this.type,
    this.species,
    this.height,
    this.weight,
    this.key,
    this.value,
    this.description,
  });

  String name;
  List<PokemonType> type;
  String species;
  dynamic key;
  dynamic value;
  String height;
  String weight;
  String description;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        type: List<PokemonType>.from(
            json["type"].map((x) => PokemonType.fromJson(x))),
        species: json["species"],
        height: json["height"],
        weight: json["weight"],
        key: json["key"],
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": List<dynamic>.from(type.map((x) => x.toJson())),
        "species": species,
        "height": height,
        "weight": weight,
        "key": key,
        "value": value,
        "description": description,
      };
}

class PokemonType {
  PokemonType({
    this.type,
    this.color,
  });

  String type;
  String color;

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        type: json["type"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "color": color,
      };
}
