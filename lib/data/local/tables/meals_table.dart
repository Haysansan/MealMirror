import 'package:drift/drift.dart';

class Meals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()(); // yyyy-MM-dd
  TextColumn get category => text()();
  IntColumn get energy => integer()();
  IntColumn get sugar => integer()();
  IntColumn get fat => integer()();
  IntColumn get protein => integer()();
  IntColumn get fiber => integer()();
}
