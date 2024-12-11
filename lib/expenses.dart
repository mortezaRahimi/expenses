import 'package:expenses/widgets/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void newExpenseToAdd(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _addNewExpenses() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(newExpenseToAdd: newExpenseToAdd));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          }),
      content: const Text('Expense Removed!'),
    ));
  }

  final List<Expense> _expensesList = List.empty();

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses found,try adding new expense!!'),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _expensesList,
        onDismissedExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(onPressed: _addNewExpenses, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('chart'),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
