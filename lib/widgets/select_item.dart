import 'package:flutter/material.dart';

import '/models/expense_type.dart';

class SelectItem extends StatelessWidget {
  SelectItem(
    this.expenseType,
    this.selectExpenseType,
    this.userSelect,
  );

  final ExpenseType expenseType;
  final Function selectExpenseType;
  final ExpenseType userSelect;

  @override
  Widget build(BuildContext context) {
    Widget _buildUnselectedItem() {
      return GestureDetector(
        onTap: () => selectExpenseType(expenseType),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).disabledColor, width: 1),
                  shape: BoxShape.circle),
              child: Text(
                expenseType.icon,
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).disabledColor),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              expenseType.title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: Theme.of(context).disabledColor),
            ),
          ],
        ),
      );
    }

    Widget _buildSelectedItem() {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 64,
            width: 64,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                ),
                shape: BoxShape.circle),
            child: Text(
              expenseType.icon,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            expenseType.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      );
    }

    return expenseType == userSelect
        ? _buildSelectedItem()
        : _buildUnselectedItem();
  }
}
