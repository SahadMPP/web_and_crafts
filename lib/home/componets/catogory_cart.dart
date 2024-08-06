import 'package:flutter/material.dart';
import 'package:web_craft/home/componets/error_image_placeholder.dart';
import 'package:web_craft/home/model/hive/catagory_hive.dart';

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
