// widgets/sort_options.dart
import 'package:flutter/material.dart';

class SortOptions extends StatelessWidget {
  final Function(String) onSortChanged;

  SortOptions({required this.onSortChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Sort by'),
      items: [
        DropdownMenuItem(value: 'price', child: Text('Price')),
        DropdownMenuItem(value: 'popularity', child: Text('Popularity')),
        DropdownMenuItem(value: 'rating', child: Text('Rating')),
      ],
      onChanged: (value) {
        onSortChanged(value!);
      },
    );
  }
}
