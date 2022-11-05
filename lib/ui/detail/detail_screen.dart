import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/ui/detail/detail_controller.dart';
import 'package:pokedex/helper/extension_method.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        init: DetailController(),
        builder: (controller) {
          int? pokeid = controller.pokemonDetail?.id;
          Color? pokecolor = controller.types.isNotEmpty
              ? controller.types[0].type?.name?.toPokemonTypeColor()
              : Colors.white;

          return Scaffold(
            backgroundColor: pokecolor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: pokecolor,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                  controller.pokemonDetail?.name?.capitalizeFirst ?? '-',
                  style: TextStyle(color: Colors.white)),
              actions: [
                Container(
                    padding: const EdgeInsets.only(right: 13),
                    alignment: Alignment.center,
                    child: Text('#${controller.formatter.format(pokeid ?? 0)}',
                        style: TextStyle(color: Colors.white)))
              ],
            ),
            body: controller.pokemonDescription.isNotEmpty &&
                    controller.pokemonDetail!.stats!.isNotEmpty &&
                    controller.pokemonDetail!.types!.isNotEmpty
                ? Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: SvgPicture.asset(
                          "assets/ic_pokeball.svg",
                          height: 250,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      Positioned(
                          bottom: 25,
                          right: 0,
                          left: 0,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(15),
                            width: Get.width,
                            // height: 380,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: controller.types
                                          .map((e) => Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: controller
                                                          .types.isNotEmpty
                                                      ? e.type?.name
                                                          ?.toPokemonTypeColor()
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(e.type?.name
                                                      ?.capitalizeFirst ??
                                                  '')))
                                          .toList(),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.all(15),
                                        child: Text(
                                          "About",
                                          style: TextStyle(
                                              color: pokecolor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black87),
                                                children: [
                                                  WidgetSpan(
                                                      child: SvgPicture.asset(
                                                    "assets/ic_weight.svg",
                                                    color: Colors.black87,
                                                  )),
                                                  TextSpan(
                                                      text:
                                                          '  ${(controller.pokemonDetail?.weight)! / 10} Kg'),
                                                  TextSpan(text: '\n\nWeight')
                                                ])),
                                        VerticalDivider(
                                          width: 20,
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 0,
                                          color: Colors.black87,
                                        ),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black87),
                                                children: [
                                                  WidgetSpan(
                                                      child: SvgPicture.asset(
                                                    "assets/ic_height.svg",
                                                    color: Colors.black87,
                                                  )),
                                                  TextSpan(
                                                      text:
                                                          '  ${(controller.pokemonDetail?.height)! / 10} m'),
                                                  TextSpan(text: '\n\nHeight')
                                                ])),
                                      ],
                                    ),
                                    RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 12),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "\n${controller.pokemonDescription[0].flavorText?.getPokemonDescription()}"),
                                              TextSpan(
                                                  text:
                                                      " ${controller.pokemonDescription[1].flavorText?.getPokemonDescription()}"),
                                              TextSpan(
                                                  text:
                                                      " ${controller.pokemonDescription[2].flavorText?.getPokemonDescription()}")
                                            ])),
                                    Container(
                                        margin: const EdgeInsets.all(15),
                                        child: Text(
                                          "Base Stats",
                                          style: TextStyle(
                                              color: pokecolor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Column(
                                      children: controller.pokemonDetail!.stats!
                                          .map((e) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              e.stat?.name
                                                                      ?.getPokemonStat() ??
                                                                  '',
                                                              style: TextStyle(
                                                                  color:
                                                                      pokecolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      )),
                                                  Flexible(
                                                      flex: 1,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(e.baseStat
                                                              .toString())
                                                        ],
                                                      )),
                                                  Flexible(
                                                      flex: 5,
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                LinearProgressIndicator(
                                                              minHeight: 7,
                                                              backgroundColor:
                                                                  Colors.grey,
                                                              color: pokecolor,
                                                              value:
                                                                  (e.baseStat)! /
                                                                      255,
                                                            ),
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ))
                                          .toList(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                        top: -10,
                        right: 0,
                        left: 0,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokeid}.png",
                          placeholder: (context, url) =>
                              Lottie.asset("assets/pokeball_lottie.json"),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 170,
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
