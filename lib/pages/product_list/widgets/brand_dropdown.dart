// lib/product_widgets/brand_dropdown.dart

import 'package:flutter/material.dart';

import '../product/product.dart';

class BrandDropdown extends StatelessWidget {
  final PhoneBrand? selectedBrand;
  final ValueChanged<PhoneBrand?> onChanged;

  const BrandDropdown({
    super.key,
    required this.selectedBrand,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PhoneBrand>(
      decoration: const InputDecoration(
        labelText: 'Filter by Brand',
        border: OutlineInputBorder(),
      ),
      value: selectedBrand,
      isExpanded: true,
      items: const [
        DropdownMenuItem<PhoneBrand>(
          value: null,
          child: Text('전체 핸드폰'),
        ),
        DropdownMenuItem<PhoneBrand>(
          value: PhoneBrand.Samsung,
          child: Text('삼성폰'),
        ),
        DropdownMenuItem<PhoneBrand>(
          value: PhoneBrand.iPhone,
          child: Text('아이폰'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
