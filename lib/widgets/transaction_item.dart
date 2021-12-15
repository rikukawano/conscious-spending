import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:provider/provider.dart';

import '/models/transactions.dart';
import '/models/transaction.dart';
import '/models/app_color.dart';
import '/models/expense_type.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tx;
  final int percentageOfTotal;
  final display = createDisplay();

  TransactionItem(this.tx, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(tx.id),
      background: Container(
        padding: const EdgeInsets.only(right: 16),
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Icon(
          Icons.delete_rounded,
          color: Colors.white,
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 10, 16, 10),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 12,
                  width: 12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tx.expenseType?.colors['opaque'] ?? AppColor.primary,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      '$percentageOfTotal% of total',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      '￥',
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      display(tx.amount),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  '${DateFormat.MMMd().format(tx.date)}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Transactions>(context, listen: false).removeItem(tx.id);
      },
    );
  }
}
