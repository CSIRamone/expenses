import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  Transaction_list(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/imagens/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent.shade700,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y H mm ss').format(tr.date),
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red.shade200,
                        onPressed: () => onRemove(tr.id),
                      ),
                    ),
                  );
                },
              ));
  }
}
