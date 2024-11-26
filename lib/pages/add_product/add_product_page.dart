import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';
import 'package:flutter_application_1/providers/product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  PhoneGrade? _selectedGrade;
  //int _likeCount = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('상품 등록'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이미지 선택 섹션
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 300,
                          child: _imageUrl.isEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/default_image.jpg',
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_imageUrl),
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _imageUrl = image.path;
                              });
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, color: Colors.black),
                                  SizedBox(width: 8),
                                  Text('사진 추가하기',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20),

                // 상품명 입력
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '상품명',
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '상품명을 입력해주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                SizedBox(height: 20),
                // 가격 입력
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '가격',
                    prefixIcon: Text('₩ ', style: TextStyle(fontSize: 16)),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    suffixText: '원',
                    border: UnderlineInputBorder(),
                  ),
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
                SizedBox(height: 20),
                // 브랜드와 폰 상태 드롭다운을 포함하는 Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField2<PhoneBrand>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: Text('브랜드', style: TextStyle(fontSize: 15)),
                        items: PhoneBrand.values.map((brand) {
                          return DropdownMenuItem<PhoneBrand>(
                            value: brand,
                            child: Text(brand.name),
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
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField2<PhoneGrade>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: Text('핸드폰 상태', style: TextStyle(fontSize: 15)),
                        items: PhoneGrade.values.map((grade) {
                          return DropdownMenuItem<PhoneGrade>(
                            value: grade,
                            child: Text(grade.name),
                          );
                        }).toList(),
                        onChanged: (PhoneGrade? newGrade) {
                          setState(() {
                            _selectedGrade = newGrade;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return '폰 상태를 선택해주세요.';
                          }
                          return null;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                // 설명 입력
                TextField(
                  maxLength: 2000,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText:
                        '브랜드, 모델명, 구매 시기, 하자 유무 등 \n상품 설명을 최대한 자세히 적어주세요.',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_imageUrl.isEmpty) {
                _imageUrl = 'assets/images/default_image.jpg';
              }
              productProvider.addProduct(
                name: _name,
                price: _price,
                imageUrl: _imageUrl,
                brand: _selectedBrand!,
                grade: _selectedGrade!,
                likeCount: 0,
              );

              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('제품이 성공적으로 등록되었습니다.')),
              // );
              Navigator.pop(context);
            }
          },
          child: Text('등록 완료'),
        ),
      ),
    );
  }
}
