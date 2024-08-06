
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_craft/home/componets/product_cart.dart';
import 'package:web_craft/home/model/hive/product_hive.dart';

class ProductList extends StatelessWidget {
  final Future<List<ProductModelHive>> future;
final  ValueListenable<List<ProductModelHive>> value;
  const ProductList({super.key, required this.future,required this.value});

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
              return ValueListenableBuilder(
                valueListenable: value,
                builder: (context,data,_) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        ProductModelHive product = data[index];
                        return ProductCard(product: product);
                      },
                      itemCount: data.length,
                    );
                }
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'No data available',
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              List<ProductModelHive> mostPopularProduct = snapshot.data!;
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
                    ProductModelHive product = mostPopularProduct[index];
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
