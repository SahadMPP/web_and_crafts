import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:web_craft/home/model/catagory_model.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/model/product_model.dart';
import 'package:web_craft/home/utils/const_values.dart';

abstract class HomeRepo {
  Future<List<CategoryModelHive>> getCategories();
  Future<List<ProductModel>> getMostPopulorProduct(BuildContext context);
  Future<List<ProductModel>> getFeaturedProduct();
  Future<List<String>> getSliderImage();
  Future<String> getAdImage();

  Future<void> addCategoryToHive(CategoryModelHive value);
  Future<void> getAllCategoryFormLocalDatabase();
}

ValueNotifier<List<CategoryModelHive>> categoryModelListHive =
    ValueNotifier([]);

class HomeRepoImpli extends HomeRepo {
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
              list.add(CategoryModelHive.fromJson(content as Map<String, dynamic>));
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
  Future<List<ProductModel>> getMostPopulorProduct(BuildContext context) async {
    List<ProductModel> list = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          if (item['title'] == "Most Popular") {
            final List<dynamic> condents = item['contents'] ?? [];
            for (var condent in condents) {
              list.add(ProductModel.fromJson(condent as Map<String, dynamic>));
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

    return list;
  }

  @override
  Future<List<ProductModel>> getFeaturedProduct() async {
    List<ProductModel> list = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        for (var item in data) {
          if (item['title'] == 'Best Sellers') {
            List<dynamic> condents = item['contents'] ?? [];
            for (var condent in condents) {
              list.add(ProductModel.fromJson(condent as Map<String, dynamic>));
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

  @override
  Future<void> getAllCategoryFormLocalDatabase() async {
    final categotydb = await Hive.openBox<CategoryModelHive>('category_db');
    categoryModelListHive.value.clear();
    categoryModelListHive.value.addAll(categotydb.values);
    categoryModelListHive.notifyListeners();
  }
}
