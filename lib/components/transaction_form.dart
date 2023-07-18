import 'package:expenses/components/adaptative_buttom.dart';
import 'package:flutter/material.dart';
import 'adaptative_textfield.dart';
import 'adaptative_datePicker.dart';

class TransactionForm extends StatefulWidget {
  late final void Function(String, double, DateTime)? onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  DateTime? _selectDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    widget.onSubmit!(title, value, _selectDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                label: 'Título',
              ),
              AdaptativeTextField(
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                selectedDate: _selectDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [AdaptativeButtom(() => _submitForm)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
