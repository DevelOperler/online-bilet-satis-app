// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_ticket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusTicketAdapter extends TypeAdapter<BusTicket> {
  @override
  final int typeId = 2;

  @override
  BusTicket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusTicket(
      userId: fields[0] as String,
      tripName: fields[1] as String,
      date: fields[2] as String,
      time: fields[3] as String,
      seatNumbers: fields[4] as String,
      price: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BusTicket obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.tripName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.seatNumbers)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusTicketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
