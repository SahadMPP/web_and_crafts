import 'package:flutter/material.dart';
import 'package:web_craft/home/componets/catogory_cart.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';
import 'package:web_craft/home/repo/home_repo.dart';
import 'package:web_craft/home/utils/hive_storage.dart';

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

