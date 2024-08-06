// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelHiveAdapter extends TypeAdapter<ProductModelHive> {
  @override
  final int typeId = 1;

  @override
  ProductModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModelHive(
      sku: fields[1] as String?,
      productName: fields[2] as String?,
      productImage: fields[3] as String?,
      productRating: fields[4] as int?,
      actualPrice: fields[5] as String?,
      offerPrice: fields[6] as String?,
      discount: fields[7] as String?,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModelHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sku)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.productImage)
      ..writeByte(4)
      ..write(obj.productRating)
      ..writeByte(5)
      ..write(obj.actualPrice)
      ..writeByte(6)
      ..write(obj.offerPrice)
      ..writeByte(7)
      ..write(obj.discount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
