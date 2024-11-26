import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../product_list/product/product.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _price = 0;
  String _imageUrl = '';
  PhoneBrand? _selectedBrand;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 제품 이름 입력
              TextFormField(
                decoration: const InputDecoration(labelText: '제품 이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제품 이름을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 16.0),
              // 제품 가격 입력
              TextFormField(
                decoration: const InputDecoration(labelText: '가격 (만원)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '가격을 입력해주세요.';
                  }
                  if (int.tryParse(value) == null) {
                    return '유효한 숫자를 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = int.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              // 이미지 URL 입력
              TextFormField(
                decoration: const InputDecoration(labelText: '이미지 URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이미지 URL을 입력해주세요.';
                  }
                  //간단한 URL 유효성 검사
                  // if (!Uri.parse(value).isAbsolute) {
                  //   return '유효한 URL을 입력해주세요.';
                  // }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              const SizedBox(height: 16.0),
              // 브랜드 선택 드롭다운
              DropdownButtonFormField<PhoneBrand>(
                decoration: const InputDecoration(labelText: '브랜드'),
                items: PhoneBrand.values.map((brand) {
                  return DropdownMenuItem<PhoneBrand>(
                    value: brand,
                    child: Text(brand.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (PhoneBrand? newBrand) {
                  setState(() {
                    _selectedBrand = newBrand;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return '브랜드를 선택해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              // 등록 버튼
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    productProvider.addProduct(
                      name: _name,
                      price: _price,
                      imageUrl: _imageUrl,
                      brand: _selectedBrand!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('제품이 성공적으로 등록되었습니다.')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('등록'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
