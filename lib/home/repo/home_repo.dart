import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/model/hive/product_hive.dart';
import 'package:web_craft/home/utils/const_values.dart';
import 'package:web_craft/home/utils/hive_storage.dart';

abstract class HomeRepo {
  Future<List<CategoryModelHive>> getCategories();
  Future<List<ProductModelHive>> getMostPopulorProduct(BuildContext context);
  Future<List<ProductModelHive>> getFeaturedProduct();
  Future<List<String>> getSliderImage();
  Future<String> getAdImage();

  Future<void> addCategoryToHive(CategoryModelHive value);
  Future<void> getAllCategoryFormLocalDatabase();

  Future<void> addMostproductToHive(ProductModelHive value);
  Future<void> getAllMostProductFormLocalDatabase();

  Future<void> addFeatureproductToHive(ProductModelHive value);
  Future<void> getAllFeatureProductFormLocalDatabase();
}

class HomeRepoImpli extends HomeRepo {
  DatabaseFunctoins databaseFunction = DatabaseFunctoins();
  final uri = Uri.parse(COMMEN_URL);

  @override
  Future<List<CategoryModelHive>> getCategories() async {
    List<CategoryModelHive> list = [];
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          if (item['type'] == 'catagories') {
            debugPrint('Category Data Found:');
            final List<dynamic> contents = item['contents'] ?? [];
            for (var content in contents) {
              list.add(
                  CategoryModelHive.fromJson(content as Map<String, dynamic>));
            }
          }
        }
        if (list.isEmpty) {
          debugPrint('No category data found.');
        }
        for (var element in list) {
          await addCategoryToHive(CategoryModelHive(
            imageUrl: element.imageUrl,
            title: element.title,
          ));
        }
        return list;
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Bad response format');
    } catch (e) {
      throw Exception('Failed due to an unknown error: $e');
    }
  }

  @override
  Future<List<ProductModelHive>> getMostPopulorProduct(
      BuildContext context) async {
    List<ProductModelHive> list = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          if (item['title'] == "Most Popular") {
            final List<dynamic> condents = item['contents'] ?? [];
            for (var condent in condents) {
              list.add(
                  ProductModelHive.fromJson(condent as Map<String, dynamic>));
            }
            if (list.isEmpty) debugPrint('No most popular product found');
            return list;
          }
        }
      } else {
        throw Exception('Data not found Status code ${response.statusCode}');
      }
    } on SocketException {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No internet connection"),
          margin: EdgeInsets.all(5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent));
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Format Exaption');
    } catch (e) {
      throw Exception('Faild get most popular aknowError$e');
    }
    for (var element in list) {
      await addMostproductToHive(ProductModelHive(
        actualPrice: element.actualPrice,
        discount: element.discount,
        offerPrice: element.offerPrice,
        productImage: element.productImage,
        productName: element.productName,
        productRating: element.productRating,
        sku: element.sku,
      ));
    }

    return list;
  }

  @override
  Future<List<ProductModelHive>> getFeaturedProduct() async {
    List<ProductModelHive> list = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        for (var item in data) {
          if (item['title'] == 'Best Sellers') {
            List<dynamic> condents = item['contents'] ?? [];
            for (var condent in condents) {
              list.add(
                  ProductModelHive.fromJson(condent as Map<String, dynamic>));
            }
          }
          if (list.isEmpty) debugPrint('Field to get best seller products');
        }
      } else {
        throw Exception('Field for aknow Exaption ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('NO internet connection');
    } on FormatException {
      throw Exception('Format Exception fond in product fatching');
    } catch (e) {
      throw Exception('Field to get FeaturedProduct Error$e');
    }
    for (var element in list) {
      await addFeatureproductToHive(ProductModelHive(
        actualPrice: element.actualPrice,
        discount: element.discount,
        offerPrice: element.offerPrice,
        productImage: element.productImage,
        productName: element.productName,
        productRating: element.productRating,
        sku: element.sku,
      ));
    }
    return list;
  }

  @override
  Future<List<String>> getSliderImage() async {
    List<String> list = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          if (item['title'] == 'Top banner') {
            List<dynamic> condents = item['contents'] ?? [];
            for (var condent in condents) {
              list.add(condent['image_url']);
            }
          }
          if (list.isEmpty) debugPrint('Field to get Sliber banners');
        }
      } else {
        throw Exception('Field for aknow Exaption ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Format Exception fond in SliderImage');
    } catch (e) {
      throw Exception('Field to get SliderImage Error$e');
    }
    return list;
  }

  @override
  Future<String> getAdImage() async {
    String result = '';
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          if (item["title"] == "ad banner") {
            debugPrint('Find Ad banner');
            result = item["image_url"] ?? '';
            return result;
          }
          if (result.isEmpty) debugPrint('Field to get Ad banner');
          return result;
        }
      } else {
        throw Exception(
            'Field for Ad banner aknow Exaption ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Format Exception fond in Ad banner');
    } catch (e) {
      throw Exception('Field to get Ad banner Error$e');
    }

    return result;
  }

  @override
  Future<void> addCategoryToHive(CategoryModelHive value) async {
    return databaseFunction.addCategoryToHive(value);
  }

  @override
  Future<void> getAllCategoryFormLocalDatabase() async {
    return databaseFunction.getAllCategoryFormLocalDatabase();
  }

  @override
  Future<void> addMostproductToHive(ProductModelHive value) async {
    return databaseFunction.addMostproductToHive(value);
  }

  @override
  Future<void> getAllMostProductFormLocalDatabase() async {
    return databaseFunction.getAllMostProductFormLocalDatabase();
  }

  @override
  Future<void> addFeatureproductToHive(ProductModelHive value) async {
    return databaseFunction.addFeatureproductToHive(value);
  }

  @override
  Future<void> getAllFeatureProductFormLocalDatabase() async {
    return databaseFunction.getAllFeatureProductFormLocalDatabase();
  }
}

class DatabaseFunctoins extends ChangeNotifier {
  addCategoryToHive(CategoryModelHive value) async {
    final catogoryDb = await Hive.openBox<CategoryModelHive>('category_db');
    final id = await catogoryDb.add(value);
    value.id = id;
    final category = catogoryDb.get(id);
    await catogoryDb.put(
        id,
        CategoryModelHive(
            imageUrl: category!.imageUrl, title: category.title, id: id));
    categoryModelListHive.value.add(category);
    categoryModelListHive.notifyListeners();
  }

  getAllCategoryFormLocalDatabase() async {
    final categotydb = await Hive.openBox<CategoryModelHive>('category_db');
    categoryModelListHive.value.clear();
    categoryModelListHive.value.addAll(categotydb.values);
    categoryModelListHive.notifyListeners();
  }

  addMostproductToHive(ProductModelHive value) async {
    final productDb = await Hive.openBox<ProductModelHive>('most_product_db');
    final id = await productDb.add(value);
    value.id = id;
    final product = productDb.get(id);
    await productDb.put(
        id,
        ProductModelHive(
            actualPrice: product!.actualPrice,
            discount: product.discount,
            offerPrice: product.offerPrice,
            productImage: product.productImage,
            productName: product.productName,
            productRating: product.productRating,
            sku: product.sku,
            id: id));
    mostProductModelListHive.value.add(product);
    mostProductModelListHive.notifyListeners();
  }

  getAllMostProductFormLocalDatabase() async {
    final categotydb = await Hive.openBox<ProductModelHive>('most_product_db');
    mostProductModelListHive.value.clear();
    mostProductModelListHive.value.addAll(categotydb.values);
    mostProductModelListHive.notifyListeners();
  }

  addFeatureproductToHive(ProductModelHive value) async {
    final productDb =
        await Hive.openBox<ProductModelHive>('feature_product_db');
    final id = await productDb.add(value);
    value.id = id;
    final product = productDb.get(id);
    await productDb.put(
        id,
        ProductModelHive(
            actualPrice: product!.actualPrice,
            discount: product.discount,
            offerPrice: product.offerPrice,
            productImage: product.productImage,
            productName: product.productName,
            productRating: product.productRating,
            sku: product.sku,
            id: id));
    featuredProductModelListHive.value.add(product);
    featuredProductModelListHive.notifyListeners();
  }

  getAllFeatureProductFormLocalDatabase() async {
    final categotydb =
        await Hive.openBox<ProductModelHive>('feature_product_db');
    featuredProductModelListHive.value.clear();
    featuredProductModelListHive.value.addAll(categotydb.values);
    featuredProductModelListHive.notifyListeners();
  }
}
