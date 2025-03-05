// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoAdapter extends TypeAdapter<Video> {
  @override
  final int typeId = 1;

  @override
  Video read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Video(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      status: fields[3] as String?,
      creationDateTime: fields[4] as String?,
      categoryId: fields[5] as String?,
      urlVideo: fields[6] as String?,
      urlPreview: fields[7] as String?,
      urlImage: fields[8] as String?,
      type: fields[9] as String?,
      source: fields[10] as String?,
      iconSource: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Video obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.creationDateTime)
      ..writeByte(5)
      ..write(obj.categoryId)
      ..writeByte(6)
      ..write(obj.urlVideo)
      ..writeByte(7)
      ..write(obj.urlPreview)
      ..writeByte(8)
      ..write(obj.urlImage)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(11)
      ..write(obj.iconSource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is VideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
