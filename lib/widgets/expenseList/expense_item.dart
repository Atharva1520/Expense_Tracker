import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.model, {super.key});

  final Model model;
  static const String ruppeicon = '₹';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '$ruppeicon' + '${model.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[model.category]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      model.formattedDate,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
