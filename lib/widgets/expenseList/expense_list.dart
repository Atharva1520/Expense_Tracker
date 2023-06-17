import 'package:expense_tracker/models/model.dart';
import 'package:expense_tracker/widgets/expenseList/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.removeExpense, required this.list});

  final List<Model> list;
  final Function(Model model) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: ((context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            onDismissed: ((direction) {
              removeExpense(list[index]);
            }),
            key: ValueKey(list[index]),
            child: ExpenseItem(list[index]))));
  }
}
