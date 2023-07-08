import 'dart:math';

import 'package:flutter/material.dart';

import '../models/transaction.dart';

import 'transaction_list.dart';

import 'transaction_form.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transaction = [
    Transaction(
      id: 't1',
      title: 'novo tenis de corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Conta diversas 3',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Conta diversas4',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Conta diversas5',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Conta diversas6',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Conta diversas 7',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Conta diversas 8',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't9',
      title: 'Conta diversas 9',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't10',
      title: 'Conta diversas 10',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't11',
      title: 'Conta diversas 11',
      value: 670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't12',
      title: 'Conta diversas 12',
      value: 670.89,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transaction.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        Transaction_list(_transaction),
      ],
    );
  }
}
