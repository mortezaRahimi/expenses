import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expensesList,
      required this.onDismissedExpense});

  final List<Expense> expensesList;
  final Function(Expense expense) onDismissedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal)),
            onDismissed: (direction) {
              onDismissedExpense(expensesList[index]);
            },
            key: ValueKey(expensesList[index]),
            child: ExpenseItem(expensesList[index])));
  }
}
