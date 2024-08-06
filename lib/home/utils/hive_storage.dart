import 'package:flutter/material.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/model/hive/product_hive.dart';

ValueNotifier<List<CategoryModelHive>> categoryModelListHive =
    ValueNotifier([]);

ValueNotifier<List<ProductModelHive>> mostProductModelListHive = ValueNotifier([]);

ValueNotifier<List<ProductModelHive>> featuredProductModelListHive = ValueNotifier([]);

ValueNotifier<List<ProductModelHive>> sliderImgeModelListHive =
    ValueNotifier([]);
