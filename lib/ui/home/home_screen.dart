import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/const/color.dart';
import 'package:pokedex/data/model/pokemon_model.dart' as pokemon;
import 'package:pokedex/ui/home/home_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: background,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Color(0xfff00000),
                  title: Row(
                    children: [
                      Image.asset(
                        "assets/ic_pokeball.png",
                        height: 50,
                        width: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text("Pokédex",
                            style: TextStyle( color: Colors.white,
                              fontWeight: FontWeight.w900,
                            )),
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 35, bottom: 25),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Cari Pokemon",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          )),
                    ),
                  ),
                ),
                PagedSliverGrid<int, pokemon.Results?>(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 160),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<pokemon.Results?>(
                      itemBuilder: (context, item, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed("/detail", arguments: {
                          "id": item?.url
                              ?.split("pokemon")
                              .last
                              .replaceAll("/", "")
                        });
                      },
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), side: BorderSide(
                          width: 2, color: electric
                        )
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(color: electric, width: 2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 5),
                                child: Text(
                                    "#${controller.formatter.format(int.parse(item?.url?.split("pokemon").last.replaceAll("/", "") ?? "0"))}"),
                              ),
                              Expanded(
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${item?.url?.split("pokemon").last.replaceAll("/", "")}.png",
                                    placeholder: (context, url) =>
                                        Lottie.asset("assets/pokeball_lottie.json"),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: electric,
                                    border: Border.all(color: electric, width: 5),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13))),
                                height: 40,
                                child: Center(
                                  child: Text(
                                      item?.name?.capitalizeFirst ?? "-",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          );
        });
  }
}
