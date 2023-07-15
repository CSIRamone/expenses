import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? value;
  final double? percentage;

  const ChartBar({
    this.label,
    this.value,
    this.percentage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        return Column(
          children: [
            Container(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '${value?.toStringAsFixed(2)}',
                ),
              ),
            ),
            SizedBox(height: Constraints.maxHeight * 0.05),
            Container(
              height: Constraints.maxHeight * 0.6,
              width: 12,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Constraints.maxHeight * 0.05),
            SizedBox(
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label!),
              ),
            ),
          ],
        );
      },
    );
  }
}
