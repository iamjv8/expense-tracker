import 'package:flutter/foundation.dart';

class Expense {
  String id;
  String title;
  double amount;
  DateTime date;

  Expense({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
  });
}