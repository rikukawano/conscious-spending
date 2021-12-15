import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

import '/models/expense_type.dart';
import '/models/app_color.dart';

class ExpenseTypeCard extends StatelessWidget {
  final ExpenseType expenseType;
  final int income;
  final int expenseAmount;
  final display = createDisplay();

  ExpenseTypeCard({
    required this.expenseType,
    required this.expenseAmount,
    required this.income,
  });

  void selectexpense(BuildContext ctx, String routeName) {
    Navigator.pushNamed(
      ctx,
      routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 10, 16, 10),
      height: 84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                alignment: Alignment.center,
                child: Text(
                  expenseType.icon,
                  style: TextStyle(fontSize: 24),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      expenseType.colors['transparent'] as Color,
                      expenseType.colors['opaque'] as Color
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expenseType.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${(expenseAmount / income * 100).round()}% of income',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '￥',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                '${display(expenseAmount)}',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
