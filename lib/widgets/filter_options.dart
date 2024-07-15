// widgets/filter_options.dart
import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final Function(String) onCategoryChanged;
  final Function(double) onPriceChanged;
  final Function(double) onRatingChanged;

  FilterOptions(
      {required this.onCategoryChanged,
      required this.onPriceChanged,
      required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Filter
        DropdownButton<String>(
          hint: Text('Filter by Category'),
          items: [
            DropdownMenuItem(value: 'electronics', child: Text('Electronics')),
            DropdownMenuItem(value: 'jewelery', child: Text('Jewelery')),
            DropdownMenuItem(
                value: 'men\'s clothing', child: Text('Men\'s Clothing')),
            DropdownMenuItem(
                value: 'women\'s clothing', child: Text('Women\'s Clothing')),
          ],
          onChanged: (value) {
            onCategoryChanged(value!);
          },
        ),
        // Price Filter
        Slider(
          value: 0,
          min: 0,
          max: 1000,
          divisions: 100,
          label: 'Price Range',
          onChanged: (value) {
            onPriceChanged(value);
          },
        ),
        // Rating Filter
        Slider(
          value: 0,
          min: 0,
          max: 5,
          divisions: 5,
          label: 'Minimum Rating',
          onChanged: (value) {
            onRatingChanged(value);
          },
        ),
      ],
    );
  }
}
