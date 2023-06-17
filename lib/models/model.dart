import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, college, personal }

final CategoryIcons = {
  Category.food: Icons.dinner_dining,
  Category.travel: Icons.train,
  Category.college: Icons.school,
  Category.personal: Icons.person,
};

class Model {
  Model(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.list});

  ExpenseBucket.forCatergory(List<Model> allExpenses, this.category)
      : list =
            allExpenses.where((Model) => Model.category == category).toList();

  final Category category;
  final List<Model> list;

  double get totalExpenses {
    double sum = 0;

    for (final model in list) {
      sum += model.amount;
    }
    return sum;
  }
}
