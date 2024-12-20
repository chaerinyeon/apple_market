// lib/providers/product_provider.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/pages/product_list/product/product.dart';

class ProductProvider with ChangeNotifier {
  int _currentID = 1;
  List<Product> _products = [
    Product(
        id: 10000000,
        name: '아이폰12 mini',
        price: 1200000,
        brand: PhoneBrand.iPhone,
        imageUrl: 'assets/images/i_phone1.jpg',
        grade: PhoneGrade.UNOPENED,
        likeCount: 2),
    Product(
        id: 200000000,
        name: '갤럭시 s23',
        price: 550000,
        brand: PhoneBrand.Samsung,
        imageUrl: 'assets/images/sam_phone1.jpg',
        grade: PhoneGrade.B_GRADE,
        likeCount: 6),
    Product(
        id: 300000000,
        name: '아이폰 13프로',
        price: 750000,
        brand: PhoneBrand.iPhone,
        imageUrl: 'assets/images/i_phone2.jpeg',
        grade: PhoneGrade.S_GRADE,
        likeCount: 10),
    Product(
        id: 40000000,
        name: '플립4 박스 올갈이',
        price: 380000,
        brand: PhoneBrand.Samsung,
        imageUrl: 'assets/images/sam_phone2.jpg',
        grade: PhoneGrade.A_GRADE,
        likeCount: 7),
    Product(
        id: 50000000,
        name: '플립5 512g 팝니다',
        price: 450000,
        brand: PhoneBrand.Samsung,
        imageUrl: 'assets/images/sam_phone3.jpg',
        grade: PhoneGrade.A_GRADE,
        likeCount: 11),
    Product(
        id: 60000000,
        name: '갤럭시 울트라',
        price: 670000,
        brand: PhoneBrand.Samsung,
        imageUrl: 'assets/images/sam_phone4.jpg',
        grade: PhoneGrade.B_GRADE,
        likeCount: 11),
  ];

// _로 시작하는건 외부에서 접근 불가. 클래스 내부에서만 사용
  final List<Product> _favoriteProducts = [];

  final List<Product> _cartProducts = [];
  //_products 라는 이름의 getter 정의. 이 메서드 호출하면 _products 리스트 반환. 즉 상품 목록을 외부에서 쉽게 접근 가능
  List<Product> get products => _products;
  //favoriteProducts 라는 이름의 getter 정의. 이 메서드 호출하면 _favoriteProducts 반환. 즉 즐겨찾기 한 상품 목록을 외부에서 쉽게 접근 가능
  List<Product> get favoriteProducts => _favoriteProducts;
  List<Product> get cartProducts => _cartProducts;

  void setProducts(List<Product> products) {
    _products = products;
    // _products가 비어있으면 _currentID 값을 _products 리스트에 있는 상품 id 중 가장 큰 값에 1을 더한 값으로 설정
    if (_products.isEmpty) {
      _currentID =
          _products.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    }
    // _products가 비어있지 않으면 _currentID 값을 1로 설정
    else {
      _currentID = 1;
    }

    // 데이터 변경 알림. 이렇게 하면 상품 목록이 변경될 때 화면도 자동으로 변경됨
    notifyListeners();
  }

  void addProduct({
    required String name,
    required int price,
    required String imageUrl,
    required PhoneBrand brand,
    required PhoneGrade grade,
    required int likeCount,
  }) {
    final newProduct = Product(
      id: _currentID,
      name: name,
      price: price,
      imageUrl: imageUrl,
      brand: brand,
      grade: grade,
      likeCount: likeCount,
    );
    _products.add(newProduct);
    _currentID++;
    notifyListeners();
  }

  void addFavorite(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
      notifyListeners();
    }
  }

  void addCart(Product product) {
    if (!_cartProducts.contains(product)) {
      _cartProducts.add(product);
      notifyListeners();
    }
  }

  void removeCart(Product product) {
    if (_cartProducts.contains(product)) {
      _cartProducts.remove(product);
      notifyListeners();
    }
  }
}
