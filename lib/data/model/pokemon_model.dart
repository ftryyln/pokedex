import 'dart:convert';

PokemonModel pokemonModelFromJson(String str) =>
    PokemonModel.fromJson(json.decode(str));

String pokemonModelToJson(PokemonModel data) => json.encode(data.toJson());

class PokemonModel {
  PokemonModel({
    int? count,
    String? next,
    dynamic previous,
    List<Results>? results,
  }) {
    _count = count;
    _next = next;
    _previous = previous;
    _results = results;
  }

  PokemonModel.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }

  int? _count;
  String? _next;
  dynamic _previous;
  List<Results>? _results;

  PokemonModel copyWith({
    int? count,
    String? next,
    dynamic previous,
    List<Results>? results,
  }) =>
      PokemonModel(
        count: count ?? _count,
        next: next ?? _next,
        previous: previous ?? _previous,
        results: results ?? _results,
      );

  int? get count => _count;

  String? get next => _next;

  dynamic get previous => _previous;

  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "bulbasaur"
/// url : "https://pokeapi.co/api/v2/pokemon/1/"
Results resultsFromJson(String str) => Results.fromJson(json.decode(str));

String resultsToJson(Results data) => json.encode(data.toJson());

class Results {
  Results({
    String? name,
    String? url,
  }) {
    _name = name;
    _url = url;
  }

  Results.fromJson(dynamic json) {
    _name = json['name'];
    _url = json['url'];
  }

  String? _name;
  String? _url;

  Results copyWith({
    String? name,
    String? url,
  }) =>
      Results(
        name: name ?? _name,
        url: url ?? _url,
      );

  String? get name => _name;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }
}
