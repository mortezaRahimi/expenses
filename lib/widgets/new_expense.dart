import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.newExpenseToAdd});

  final void Function(Expense expense) newExpenseToAdd;

  @override
  State<StatefulWidget> createState() {
    return _NewStateClass();
  }
}

class _NewStateClass extends State<NewExpense> {
  var _titleControler = TextEditingController();
  String? _titleError;
  var _amountControler = TextEditingController();
  String? _selectedDate;
  var _dateTime = DateTime.now();
  ExpenseCategory selectedCat = ExpenseCategory.Food;

  void _selectedDateFun(DateTime? date) {
    if (date != null) {
      _dateTime = date;
      setState(() {
        _selectedDate = dateFormat.format(date);
      });
    }
  }

  void _showDatePicker() {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
            context: context,
            initialDate: now,
            firstDate: firstDate,
            lastDate: now)
        .then((value) {
      _selectedDateFun(value);
    });
  }

  void validateNewExpense() {
    double? enteredAmount = double.tryParse(_amountControler.text);
    final amountIsInValid = enteredAmount == null || enteredAmount <= 0;
    if (_titleControler.value.toString().trim().isEmpty ||
        amountIsInValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('Make sure all the input are entered right!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Ok'))
                ],
              ));
      return;
    }

    final Expense _expense = Expense(
        title: _titleControler.value.text,
        amount: enteredAmount,
        date: _dateTime,
        category: selectedCat);

    widget.newExpenseToAdd(_expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleControler,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: const Text('Title')),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(children: [
            Expanded(
              child: TextField(
                controller: _amountControler,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Amount'), prefix: Text('\$')),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(_selectedDate ?? 'Select Date'),
                IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(Icons.calendar_month))
              ]),
            )
          ]),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCat,
                  items: ExpenseCategory.values
                      .map((item) => DropdownMenuItem(
                          value: item, child: Text(item.name.toString())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCat = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: validateNewExpense,
                  child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
