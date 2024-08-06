import 'package:flutter/material.dart';
import 'package:web_craft/home/componets/error_image_placeholder.dart';
import 'package:web_craft/home/model/hive/product_hive.dart';

class ProductCard extends StatelessWidget {
  final ProductModelHive product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final RegExp digitRegExp = RegExp(r'\d');
    final Iterable<Match> matches = digitRegExp.allMatches(product.discount!);
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
                product.productImage!,
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
                    product.productName!,
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
                        color: product.productRating! >= index + 1
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        product.offerPrice!.replaceAll(RegExp(r'â¹'), ''),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 8),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.actualPrice!.replaceAll(RegExp(r'â¹'), ''),
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

