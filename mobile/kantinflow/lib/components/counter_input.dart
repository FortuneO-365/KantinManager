import 'package:flutter/material.dart';

class CounterInput extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterInput({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text(
                value.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    minimumSize: Size(20.0, 7.0),
                    maximumSize: Size(40.0, 20.0),
                    shape: LinearBorder(),
                  ),
                  icon: const Icon(Icons.arrow_drop_up),
                  onPressed: onIncrement,
                ),
            
            
            
                IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    minimumSize: Size(20.0, 7.0),
                    maximumSize: Size(40.0, 20.0),
                    shape: LinearBorder(),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: onDecrement,
                ),
              ],
            ),
          )
          // Minus Button
        ],
      ),
    );
  }
}
