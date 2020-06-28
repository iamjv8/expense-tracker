import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './expense.dart';

class Expenses with ChangeNotifier {
  List<Expense> _expenses = [
    Expense(
        id: DateTime.now().toIso8601String(),
        title: 'Grocery',
        amount: 190.0,
        date: DateTime.now()),
    Expense(
        id: DateTime.now().toIso8601String(),
        title: 'Medicine',
        amount: 694.0,
        date: DateTime.now()),
    Expense(
        id: DateTime.now().toIso8601String(),
        title: 'Food',
        amount: 490.0,
        date: DateTime.now()),
    Expense(
        id: DateTime.now().toIso8601String(),
        title: 'Books',
        amount: 245.0,
        date: DateTime.now()),
  ];

  List<Expense> get expenses {
    return [..._expenses];
  }

  void addExpense(Expense item) {
    _expenses.insert(0, item);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) {
      return expense.id == id;
    });
    notifyListeners();
  }

  List<Expense> getExpensesForToday() {
    final currentDate = DateTime.now();
    return _expenses.where((expense) {
      return DateFormat.yMMMMd().format(expense.date) == DateFormat.yMMMMd().format(currentDate);
    }).toList();

  }

  List<Expense> getExpensesForWeek() {
    final currentDate = DateTime.now();
    return _expenses.where((expense) {
      return weekNumber(expense.date) == weekNumber(currentDate) &&
          expense.date.year == currentDate.year;
    }).toList();

  }

  List<Expense> getExpensesForMonth() {
    final currentDate = DateTime.now();
    return _expenses.where((expense) {
      return expense.date.month == currentDate.month &&
          expense.date.year == currentDate.year;
    }).toList();
  }

  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}
