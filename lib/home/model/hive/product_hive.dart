import 'package:hive/hive.dart';
part 'product_hive.g.dart';

@HiveType(typeId: 1)
class ProductModelHive extends HiveObject {

   @HiveField(0)
  int? id;

  @HiveField(1)
  final String? sku;

  @HiveField(2)
  final String? productName;

  @HiveField(3)
  final String? productImage;

  @HiveField(4)
  final int? productRating;

  @HiveField(5)
  final String? actualPrice;

  @HiveField(6)
  final String? offerPrice;

  @HiveField(7)
  final String? discount;

 

  ProductModelHive({
     this.sku,
     this.productName,
     this.productImage,
     this.productRating,
     this.actualPrice,
     this.offerPrice,
     this.discount,
    this.id,
  });

    factory ProductModelHive.fromJson(Map<String, dynamic> json) {
    return ProductModelHive(
      sku: json['sku'],
      productName: json['product_name'],
      productImage: json['product_image'],
      productRating: json['product_rating'],
      actualPrice: json['actual_price'],
      offerPrice: json['offer_price'],
      discount: json['discount'],
    );
  }

  
}
