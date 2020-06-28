import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final String title;
  final double amount;

  ExpenseItem({this.title,this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
     child: ListTile(
       leading: Icon(Icons.money_off),
       title: Text(title),
       trailing: Text(amount.toString()),
     ), 
    );
  }
}