import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  // backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/ic_pokeball.svg",
                        height: kToolbarHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Pokedex"),
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    // height: 30,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: "Cari Pokemon",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                          )),
                    ),
                  ),
                ),
                PagedSliverGrid<int, pokemon.Results?>(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // crossAxisSpacing: 3,
                      mainAxisExtent: 198),
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
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: grass)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                        "#${controller.formatter.format(
                                            int.parse(item?.url
                                                ?.split("pokemon")
                                                .last
                                                .replaceAll("/", "") ??
                                                "0"))}"),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${item
                                        ?.url
                                        ?.split("pokemon")
                                        .last
                                        .replaceAll("/", "")}.png",
                                    placeholder: (context, url) =>
                                        Lottie.asset(
                                            "assets/pokeball_lottie.json"),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: grass,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    height: 40,
                                    child: Center(
                                      child:
                                      Text(item?.name?.capitalizeFirst ?? "-"),
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
