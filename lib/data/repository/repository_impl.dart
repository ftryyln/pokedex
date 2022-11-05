import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pokedex/data/model/pokemon_description_model.dart';
import 'package:pokedex/data/model/pokemon_detail_model.dart';
import 'package:pokedex/data/model/pokemon_model.dart';
import 'package:pokedex/data/network_core.dart';
import 'package:pokedex/data/repository/repository.dart';

class RepositoryImpl implements Repository {
  final network = Get.find<NetworkCore>();

  @override
  FutureOr<PokemonModel?> getPagedPokemon(int offset, int limit) async {
    try {
      // List<PokemonModel> listPokemon = [];
      var response = await network.dio.get("/pokemon",
          queryParameters: {"offset": offset, "limit": limit});

      return PokemonModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      return null;
    }
  }

  @override
  FutureOr<PokemonDescriptionModel> getPokemonDescription(int id) async {
    try {
      var response = await network.dio.get("/pokemon-species/$id");
      return PokemonDescriptionModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      return e.error;
    }
  }

  @override
  FutureOr<PokemonDetailModel> getPokemonDetail(int id) async {
    try {
      var response = await network.dio.get("/pokemon/$id");
      return PokemonDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.error);
      return e.error;
    }
  }
}