// lib/product_widgets/brand_dropdown.dart

import 'package:flutter/material.dart';
import '../product/product.dart';

class FilterDropdown extends StatelessWidget {
  final PhoneBrand? selectedBrand;
  final PhoneGrade? selectedGrade;
  final ValueChanged<PhoneBrand?> onBrandChanged;
  final ValueChanged<PhoneGrade?> onGradeChanged;

  const FilterDropdown({
    super.key,
    required this.selectedBrand,
    required this.selectedGrade,
    required this.onBrandChanged,
    required this.onGradeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<PhoneBrand>(
            decoration: const InputDecoration(
              labelText: 'Filter by Brand',
              border: OutlineInputBorder(),
            ),
            value: selectedBrand,
            isExpanded: true,
            items: [
              const DropdownMenuItem<PhoneBrand>(
                value: null,
                child: Text('전체 핸드폰'),
              ),
              const DropdownMenuItem<PhoneBrand>(
                value: PhoneBrand.Samsung,
                child: Text('삼성폰'),
              ),
              const DropdownMenuItem<PhoneBrand>(
                value: PhoneBrand.iPhone,
                child: Text('아이폰'),
              ),
            ],
            onChanged: onBrandChanged,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: DropdownButtonFormField<PhoneGrade>(
            decoration: const InputDecoration(
              labelText: 'Filter by Grade',
              border: OutlineInputBorder(),
            ),
            value: selectedGrade,
            isExpanded: true,
            items: [
              const DropdownMenuItem<PhoneGrade>(
                value: null,
                child: Text('핸드폰 상태'),
              ),
              const DropdownMenuItem<PhoneGrade>(
                value: PhoneGrade.UNOPENED,
                child: Text('미개봉'),
              ),
              const DropdownMenuItem<PhoneGrade>(
                value: PhoneGrade.S_GRADE,
                child: Text('S급'),
              ),
              const DropdownMenuItem<PhoneGrade>(
                value: PhoneGrade.A_GRADE,
                child: Text('A급'),
              ),
              const DropdownMenuItem<PhoneGrade>(
                value: PhoneGrade.B_GRADE,
                child: Text('B급'),
              ),
            ],
            onChanged: onGradeChanged,
          ),
        ),
      ],
    );
  }
}
