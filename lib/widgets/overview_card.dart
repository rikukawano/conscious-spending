import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '/models/transactions.dart';
import '/models/transaction.dart';
import '/models/app_color.dart';
import '/models/expense_type.dart';

class OverviewCard extends StatelessWidget {
  final int totalAmount;
  final bool isIncome;
  final List<Transaction> transactions;

  // pie chart variables
  final Map<String, double> dataMap = {};
  final List<Color> colors = [];

  final display = createDisplay();

  OverviewCard({
    required this.totalAmount,
    required this.isIncome,
    required this.transactions,
  });

  void initializeData(BuildContext context) {
    // when OverviewScreen
    if (isIncome) {
      ExpenseType.values.forEach((val) {
        final String expenseTitle = val.toString().split('.').elementAt(1);
        dataMap[expenseTitle] = Provider.of<Transactions>(context)
            .totalAmount(txType: TransactionType.Expense, expType: val)
            .toDouble();

        colors.add(val.colors['opaque']!);
      });
    } else {
      // when ExpenseTypeScreen
      transactions.sort((b, a) => a.amount.compareTo(b.amount));
      if (transactions[0].expenseType != null) {
        for (var i = 0; i < transactions.length; i++) {
          // add pie chart data
          dataMap[i.toString()] = transactions[i].amount.toDouble();
          // add colors
          colors.add(transactions[i].expenseType!.colors['opaque']?.withOpacity(
              1 / transactions.length * (transactions.length - i)) as Color);
        }
      } else {
        for (var i = 0; i < transactions.length; i++) {
          // add pie chart data
          dataMap[i.toString()] = transactions[i].amount.toDouble();
          // add colors
          colors.add(AppColor.primary.withOpacity(
              1 / transactions.length * (transactions.length - i)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeData(context);

    return Container(
      height: 192,
      width: 320,
      padding: EdgeInsets.symmetric(vertical: 24.0),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PieChart(
            dataMap: dataMap,
            chartRadius: 90,
            legendOptions: LegendOptions(
              showLegends: false,
            ),
            colorList: colors,
            chartType: ChartType.ring,
            ringStrokeWidth: 30,
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
          SizedBox(
            width: 24,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMM().format(DateTime.now()),
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(
                height: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isIncome ? 'Total Income' : 'Total Expense',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Row(
                    children: [
                      Text(
                        '￥',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${display(totalAmount)}',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
