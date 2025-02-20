// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catagory_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelHiveAdapter extends TypeAdapter<CategoryModelHive> {
  @override
  final int typeId = 0;

  @override
  CategoryModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModelHive(
      id: fields[0] as int?,
      title: fields[1] as String?,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModelHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
