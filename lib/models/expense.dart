import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
final numberFormatter = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 2,
);
const uuid = Uuid();

enum Category { food, travel, leisure, work, shopping, investment }

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.flight_takeoff_outlined,
  Category.leisure: Icons.movie_creation_outlined,
  Category.work: Icons.work_outline,
  Category.shopping: Icons.shopping_cart_outlined,
  Category.investment: Icons.attach_money_outlined,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  String get formattedCurrency {
    return numberFormatter.format(amount);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses =
            allExpenses.where((item) => item.category == category).toList();

  double get totalExpenses {
    double sum = 0;
    for (final item in expenses) {
      sum += item.amount;
    }
    return sum;
  }
}
