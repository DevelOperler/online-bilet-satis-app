// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusTripAdapter extends TypeAdapter<BusTrip> {
  @override
  final int typeId = 1;

  @override
  BusTrip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusTrip(
      id: fields[0] as String,
      name: fields[4] as String,
      startLocation: fields[5] as String,
      endLocation: fields[6] as String,
      startTime: fields[2] as String,
      arrivalTime: fields[1] as String,
      date: fields[7] as String,
      price: fields[3] as String,
      availableSeats: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BusTrip obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.arrivalTime)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.startLocation)
      ..writeByte(6)
      ..write(obj.endLocation)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.availableSeats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusTripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
