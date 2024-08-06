// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_image_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SliderimageHiveAdapter extends TypeAdapter<SliderimageHive> {
  @override
  final int typeId = 2;

  @override
  SliderimageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SliderimageHive(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SliderimageHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageOne)
      ..writeByte(2)
      ..write(obj.imageTwo)
      ..writeByte(3)
      ..write(obj.imageThree)
      ..writeByte(4)
      ..write(obj.imageFour);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderimageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
