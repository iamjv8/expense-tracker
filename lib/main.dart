import 'package:expence_tracker/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/expenses.dart';
import './screens/expense_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Expenses(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(237, 221, 212, 1),
          primaryColor: Color.fromRGBO(25, 114, 120, 1),
          accentColor: Color.fromRGBO(196, 69, 54, 1),
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Expenses',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          leading: Icon(
            Icons.menu,
            color: Theme.of(context).primaryColor,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Today',
              ),
              Tab(
                text: 'Week',
              ),
              Tab(
                text: 'Month',
              ),
            ],
            labelColor: Theme.of(context).primaryColor,
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        body: TabBarView(
          children: [
            ExpenseList('today'),
            ExpenseList('week'),
            ExpenseList('month'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpenseScreen(),
                fullscreenDialog: true,
              ),
            );
          },
          child: Container(
            width: 100,
            height: 100,
            child: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.5
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.5
                  )
                ]),
          ),
          // child: Icon(
          //   Icons.add,
          //   color: Theme.of(context).backgroundColor,
          // ),
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
