// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuck_norris_fact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChuckNorrisFactAdapter extends TypeAdapter<ChuckNorrisFact> {
  @override
  final int typeId = 0;

  @override
  ChuckNorrisFact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChuckNorrisFact(
      image: fields[0] as String,
      id: fields[1] as String,
      url: fields[2] as String,
      value: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChuckNorrisFact obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChuckNorrisFactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
