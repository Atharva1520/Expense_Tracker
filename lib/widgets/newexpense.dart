import 'package:expense_tracker/models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/model.dart' as eos;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(Model model) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

var kcolour1 =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(31, 110, 140, 100));

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  DateTime? _seldate;
  eos.Category _selcategory = eos.Category.personal;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showdate() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _seldate = date!;
    });
  }

  void _savedata() {
    final enteramt = double.tryParse(_amtController.text);
    final amtisvalid = enteramt == null || enteramt <= 0;
    if (_titleController.text.trim() == null ||
        amtisvalid ||
        _seldate == null) {
      showDialog(
          context: context,
          builder: ((ctx) => AlertDialog(
                title: const Text("Invalid Text"),
                content: Text(
                    "Please make sure that title,amount is not empty and select a date"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("Okay"))
                ],
              )));
      return;
    }
    widget.addExpense(Model(
        title: _titleController.text,
        amount: enteramt,
        date: _seldate!,
        category: _selcategory));
    Navigator.pop(context);
  }

  static const String ruppeicon = '₹';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcolour1.primaryContainer,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text("Label"), hintText: 'Ex:Food'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amtController,
                    decoration: const InputDecoration(
                        label: Text("Amount"),
                        hintText: "Rs.300",
                        prefixText: ruppeicon),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_seldate == null
                        ? 'No Date Selected'
                        : formatter.format(_seldate!)),
                    IconButton(
                        onPressed: _showdate,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ))
              ],
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selcategory,
                    items: eos.Category.values
                        .map((category) => DropdownMenuItem(
                            value: category, child: Text(category.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selcategory = value as eos.Category;
                      });
                    }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: _savedata, child: Text("Save Expense"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
