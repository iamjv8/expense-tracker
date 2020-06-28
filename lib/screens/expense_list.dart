import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/expense_item.dart';
import '../providers/expense.dart';
import '../providers/expenses.dart';

class ExpenseList extends StatefulWidget {
  final String _filter;

  ExpenseList(this._filter);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<Expense> getExpenses(String filter, BuildContext context) {
    if (filter == 'today') {
      return Provider.of<Expenses>(context).getExpensesForToday();
    } else if (filter == 'week') {
      return Provider.of<Expenses>(context).getExpensesForWeek();
    } else if (filter == 'month') {
      return Provider.of<Expenses>(context).getExpensesForMonth();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenses = getExpenses(widget._filter, context);
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Dismissible(
            key: Key(expenses[index].id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to delete this item?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<Expenses>(context, listen: false)
                                  .removeExpense(expenses[index].id);
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("${expenses[index].title} deleted")));
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("DELETE")),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("CANCEL"),
                      ),
                    ],
                  );
                },
              );
            },
            // onDismissed: (direction) {
            //   setState(() {
            //     Provider.of<Expenses>(context, listen: false)
            //         .removeExpense(expenses[index].id);
            //   });
            //   Scaffold.of(context).showSnackBar(
            //       SnackBar(content: Text("${expenses[index].title} deleted")));
            // },
            child: ExpenseItem(
              title: expenses[index].title,
              amount: expenses[index].amount,
            ),
          ),
        );
      },
    );
  }
}
