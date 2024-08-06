import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web_craft/home/componets/app_title.dart';
import 'package:web_craft/home/componets/error_image_placeholder.dart';
import 'package:web_craft/home/componets/home_appbar.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/model/product_model.dart';
import 'package:web_craft/home/repo/home_repo.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  late List<String> urlimages;
  // late String bannerSingle;
  HomeRepo homeRepo = HomeRepoImpli();

  ini() async {
    urlimages = await homeRepo.getSliderImage();
    // bannerSingle = await homeRepo.getAdImage();
  }
  

  @override
  void initState() {
    super.initState();
    ini();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                    itemCount: urlimages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlimge = urlimages[index];
                      return buildImage(urlimge, index);
                    },
                    options: CarouselOptions(
                      height: 120,
                      onPageChanged: (index, reason) => setState(() {
                        activeIndex = index;
                      }),
                    )),
                Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width * .4,
                    child: buldIndicator()),
              ],
            ),
            const AppTitle(title: 'Most Popular'),
            ProductList(
              future: homeRepo.getMostPopulorProduct(context),
            ),
            Container(
              height: 120,
              color: Colors.red[100],
              margin: const EdgeInsets.all(8),
              child: const ErrorImagePlaceHolder(),
              // child: Image.network(bannerSingle,errorBuilder: (context, error, stackTrace) {
              //   return const Placeholder();
              // },),
            ),
            const AppTitle(title: 'Categories'),
            const CategoryList(),
            const AppTitle(title: 'Featured Products'),
            ProductList(
              future: homeRepo.getFeaturedProduct(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buldIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlimages.length,
        effect: const ExpandingDotsEffect(
            dotWidth: 5,
            dotHeight: 5,
            activeDotColor: Colors.white,
            expansionFactor: 1.5),
      );

  Widget buildImage(String urlimge, int index) => Image.network(
        urlimages[index],
        errorBuilder: (context, error, stackTrace) {
          return const ErrorImagePlaceHolder();
        },
        fit: BoxFit.fill,
      );
}



class ProductList extends StatelessWidget {
  final Future<List<ProductModel>> future;
  const ProductList({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to get data: ${snapshot.error}',
                  style: const TextStyle(color: Colors.black),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              List<ProductModel> mostPopularProduct = snapshot.data!;
              if (mostPopularProduct.isEmpty) {
                return const Center(
                  child: Text(
                    'list is empty',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ProductModel product = mostPopularProduct[index];
                    return ProductCard(product: product);
                  },
                  itemCount: mostPopularProduct.length,
                );
              }
            }
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final RegExp digitRegExp = RegExp(r'\d');
    final Iterable<Match> matches = digitRegExp.allMatches(product.discount);
    final String result = matches.map((m) => m.group(0)!).join();

    int discound = int.parse(result);
    return Container(
      width: 120,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.productImage,
                errorBuilder: (context, error, stackTrace) {
                  return const ErrorImagePlaceHolder();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 25,
                    child: Visibility(
                      visible: discound >= 0,
                      child: Card(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Colors.red[200],
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            child: Text(
                              'sale ${product.discount}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.productName,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        size: 14,
                        color: product.productRating >= index + 1
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        product.offerPrice.replaceAll(RegExp(r'â¹'), ''),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 8),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.actualPrice.replaceAll(RegExp(r'â¹'), ''),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 8,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeRepo homeRepo = HomeRepoImpli();

    return SizedBox(
      height: 110,
      child: FutureBuilder(
        future: homeRepo.getCategories(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return ValueListenableBuilder(
              valueListenable: categoryModelListHive,
              builder: (BuildContext condext, dynamic dataM, Widget? child) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataM.length,
                    itemBuilder: (context, index) {
                      final data = dataM[index];
                      return CategoryCard(data: data, index: index);
                    },
                  );
              }
            );
            // return Center(
            //   child: Text(
            //     'Failed to get data: ${snapshot.error}',
            //     style: const TextStyle(color: Colors.black),
            //   ),
            // );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            List<CategoryModelHive> categoriesModel = snapshot.data!;
            if (categoriesModel.isEmpty) {
              return const Center(
                child: Text(
                  'List is empty',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesModel.length,
                itemBuilder: (context, index) {
                  final data = categoriesModel[index];
                  return CategoryCard(data: data, index: index);
                },
              );
            }
          }
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModelHive data;
  final int index;
  const CategoryCard({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              color: Colors.grey,
              child: Image.network(
                data.imageUrl!,
                errorBuilder: (context, error, stackTrace) {
                  return const ErrorImagePlaceHolder();
                },
              ),
            )),
            const SizedBox(height: 8),
            Text(
              data.title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
