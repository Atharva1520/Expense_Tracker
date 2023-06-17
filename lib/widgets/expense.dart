import 'package:expense_tracker/charts/chart.dart';
import 'package:expense_tracker/widgets/expenseList/expense_list.dart';
import 'package:expense_tracker/widgets/newexpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/model.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Model> _list = [
    Model(
        title: 'Pizza',
        amount: 400,
        date: DateTime.now(),
        category: Category.food),
    Model(
        title: 'Burger',
        amount: 100,
        date: DateTime.now(),
        category: Category.food),
  ];
  void _openmodeloverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((context) => NewExpense(
              addExpense: _addExpense,
            )));
  }

  void _addExpense(Model model) {
    setState(() {
      _list.add(model);
    });
  }

  void _removeExpense(Model model) {
    final Expensesindex = _list.indexOf(model);
    setState(() {
      _list.remove(model);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text("Expense Deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _list.insert(Expensesindex, model);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget main = Center(
      child: Text("No Expense are present...."),
    );
    if (_list.isNotEmpty) {
      main = Column(
        children: [
          Chart(expenses: _list),
          Expanded(
              child: ExpenseList(
            list: _list,
            removeExpense: _removeExpense,
          ))
        ],
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Expense Tracker"),
          actions: [
            IconButton(
                onPressed: _openmodeloverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: main);
  }
}
