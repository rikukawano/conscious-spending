import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:number_display/number_display.dart';
import 'package:provider/provider.dart';

import '/models/thousands_separator_input_formatter.dart';
import '/models/app_color.dart';
import '../models/transactions.dart';
import '/models/expense_type.dart';
import '/models/transaction.dart';
import '/widgets/floating_button.dart';
import '/widgets/select_item.dart';

class AddTransactionScreen extends StatefulWidget {
  final ExpenseType? expenseType;

  AddTransactionScreen(this.expenseType);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late ExpenseType? _selectedExpenseType = ExpenseType.FixedCost;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late TextEditingController _dateController;

  final _formKey = GlobalKey<FormState>();

  late FocusNode _amountFieldFocusNode;

  final display = createDisplay();

  bool _keyboardVisible = false;
  bool _isExpense = true;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
        text: '${DateFormat('d MMMM y').format(_selectedDate)}');
    _amountFieldFocusNode = FocusNode();

    widget.expenseType != null
        ? _selectedExpenseType = widget.expenseType
        : _isExpense = false;
  }

  @override
  void dispose() {
    _amountFieldFocusNode.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      final String enteredTitle = _titleController.text;
      final int enteredAmount = int.parse(_amountController.text);

      if (_isExpense) {
        Provider.of<Transactions>(context, listen: false).addItem(
          txType: TransactionType.Expense,
          expenseType: _selectedExpenseType,
          title: enteredTitle,
          amount: enteredAmount,
          date: _selectedDate,
        );
      } else {
        Provider.of<Transactions>(context, listen: false).addItem(
          txType: TransactionType.Income,
          title: enteredTitle,
          amount: enteredAmount,
          date: _selectedDate,
        );
      }
      Navigator.pop(context);
    }
    return;
  }

  void _selectExpenseType(ExpenseType userSelect) {
    setState(() {
      _selectedExpenseType = userSelect;
    });
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
          _dateController = TextEditingController(
              text: '${DateFormat.yMMMd().format(_selectedDate)}');
        });
      }
    });
  }

  void _toggle(bool val) {
    if (_isExpense == val) return;
    setState(() {
      _isExpense = val;
    });
  }

  Widget _buildToggleSwitch() {
    final BoxDecoration activatedDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 1),
          )
        ]);

    return Container(
      height: 48,
      width: 227,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _toggle(true),
              child: Container(
                alignment: Alignment.center,
                decoration: _isExpense ? activatedDecoration : null,
                child: Text(
                  'Expense',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Expanded(
            child: GestureDetector(
              onTap: () => _toggle(false),
              child: Container(
                alignment: Alignment.center,
                decoration: _isExpense ? null : activatedDecoration,
                child: Text(
                  'Income',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountTextField() {
    return GestureDetector(
      onTap: () => {
        _amountFieldFocusNode.requestFocus(),
      },
      child: Center(
        child: IntrinsicWidth(
          child: TextFormField(
            style: Theme.of(context).textTheme.headline2,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Center(
                widthFactor: 0.1,
                heightFactor: 0.1,
                child: Text('￥', style: Theme.of(context).textTheme.headline6),
              ),
              hintText: '0',
              hintStyle: TextStyle(color: Colors.black26),
              border: InputBorder.none,
              isCollapsed: true,
            ),
            cursorColor: Colors.black12,
            keyboardType: TextInputType.number,
            autofocus: true,
            focusNode: _amountFieldFocusNode,
            controller: _amountController,
            inputFormatters: [ThousandsSeparatorInputFormatter()],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseTypeSelect() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Type',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ExpenseType.values
                .map((type) =>
                    SelectItem(type, _selectExpenseType, _selectedExpenseType!))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleTextField() {
    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(5),
    );

    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 4,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.characters,
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'Enter a title',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Colors.black38),
              contentPadding: EdgeInsets.all(10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _titleController.text.isEmpty
                      ? Colors.black12
                      : Colors.black87,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black87,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
            ),
            cursorColor: Colors.black12,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) return 'Please enter a title';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelectField(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_dateController.text}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black87,
                    size: 16,
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black87,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8 -
          MediaQuery.of(context).viewInsets.bottom,
      padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 12),
              child: GestureDetector(
                onTap: () => {
                  Navigator.pop(context),
                },
                child: Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildToggleSwitch(),
              SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAmountTextField(),
                      SizedBox(height: 32),
                      if (_isExpense) _buildExpenseTypeSelect(),
                      SizedBox(height: 20),
                      _buildTitleTextField(),
                      SizedBox(height: 20),
                      _buildDateSelectField(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColor.primary.withOpacity(0.8),
                      AppColor.primary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.01, 0.3]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add Transaction',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: _buildFormContent(context),
                  )
                ],
              ),
            ),
            if (!_keyboardVisible)
              Align(
                alignment: Alignment.bottomCenter,
                child: FloatingButton(_submitData),
              ),
          ],
        ),
      ),
    );
  }
}
