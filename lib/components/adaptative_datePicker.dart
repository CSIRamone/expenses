import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  //const AdaptativeDatePicker({super.key});

  final DateTime? selectedDate;
  final Function(DateTime)? onDateChanged;

  const AdaptativeDatePicker({
    this.onDateChanged,
    this.selectedDate,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged!(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              onDateTimeChanged: onDateChanged!,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data Selecionada!'
                        : DateFormat('d MMM y').format(selectedDate!),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen),
                  ),
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
