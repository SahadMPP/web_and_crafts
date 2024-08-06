import 'package:hive/hive.dart';
 part 'slider_image_hive.g.dart';

@HiveType(typeId: 2)
class SliderimageHive  extends HiveObject {
 
 @HiveField(0)
 int? id;
 
 @HiveField(1)
 String? imageOne;
@HiveField(2)
 String? imageTwo;
@HiveField(3)
 String? imageThree;
@HiveField(4)
 String? imageFour;

SliderimageHive(
  this.id,
  this.imageOne,
  this.imageTwo,
  this.imageThree,
  this.imageFour,
);
  
  
}