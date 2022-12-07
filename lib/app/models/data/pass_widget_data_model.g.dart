// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_widget_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassWidgetDataModelAdapter extends TypeAdapter<PassWidgetDataModel> {
  @override
  final int typeId = 0;

  @override
  PassWidgetDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassWidgetDataModel(
      passName: fields[0] as String,
      ticketsNumber: fields[1] as int,
      passDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PassWidgetDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.passName)
      ..writeByte(1)
      ..write(obj.ticketsNumber)
      ..writeByte(2)
      ..write(obj.passDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassWidgetDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
