import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd();

enum ExpenseCategory { Food, Travel, Transportation, Home }

const categoryIcons = {
  ExpenseCategory.Food: Icons.dining,
  ExpenseCategory.Transportation: Icons.car_rental,
  ExpenseCategory.Travel: Icons.airport_shuttle,
  ExpenseCategory.Home: Icons.home
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formatedDate {
    return dateFormat.format(date);
  }
}
