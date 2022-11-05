import 'dart:async';
import 'package:pokedex/data/model/pokemon_detail_model.dart';
import 'package:pokedex/data/model/pokemon_description_model.dart';
import 'package:pokedex/data/model/pokemon_model.dart';

abstract class Repository {
  FutureOr<PokemonModel?> getPagedPokemon(int offset, int limit);

  FutureOr<PokemonDetailModel> getPokemonDetail(int id);

  FutureOr<PokemonDescriptionModel> getPokemonDescription(int id);
}