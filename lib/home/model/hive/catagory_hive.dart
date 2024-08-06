import 'package:hive/hive.dart';
part 'catagory_hive.g.dart';

@HiveType(typeId: 0)
class CategoryModelHive extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final String? imageUrl;

  CategoryModelHive({
    this.id,
    this.title,
    this.imageUrl,
  });

    factory CategoryModelHive.fromJson(Map<String, dynamic> json) {
    return CategoryModelHive(
      title: json['title'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }
}
