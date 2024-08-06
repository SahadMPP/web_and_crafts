import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_craft/home/componets/app_title.dart';
import 'package:web_craft/home/componets/build_dot.dart';
import 'package:web_craft/home/componets/category_list.dart';
import 'package:web_craft/home/componets/error_image_placeholder.dart';
import 'package:web_craft/home/componets/home_appbar.dart';
import 'package:web_craft/home/componets/product_list.dart';
import 'package:web_craft/home/repo/home_repo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:web_craft/home/utils/hive_storage.dart';
import 'package:web_craft/home/view_model/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  HomeRepo homeRepo = HomeRepoImpli();
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Consumer<HomeProvider>(builder: (context, value, _) {
                  return CarouselSlider.builder(
                      itemCount: value.sliderImage.length,
                      itemBuilder: (context, index, realIndex) {
                        // // final urlimge = value.sliderImage[index];
                        // return buildImage(index);
                        return Image.network(
                          value.sliderImage[index],
                          errorBuilder: (context, error, stackTrace) {
                            return const ErrorImagePlaceHolder();
                          },
                          fit: BoxFit.fill,
                        );
                      },
                      options: CarouselOptions(
                        height: 120,
                        onPageChanged: (index, reason) {
                          homeProvider.changingActiveindex(index);
                        },
                      ));
                }),
                Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * .4,
                    child: buldIndicator()),
              ],
            ),
            const AppTitle(title: 'Most Popular'),
            ProductList(
              value: mostProductModelListHive,
              future: homeRepo.getMostPopulorProduct(context),
            ),
            Container(
              height: 120,
              color: Colors.red[100],
              margin: const EdgeInsets.all(8),
              child: const ErrorImagePlaceHolder(),
            ),
            const AppTitle(title: 'Categories'),
            const CategoryList(),
            const AppTitle(title: 'Featured Products'),
            ProductList(
              value: featuredProductModelListHive,
              future: homeRepo.getFeaturedProduct(),
            ),
          ],
        ),
      ),
    );
  }
}
