// ignore: constant_identifier_names
enum PhoneBrand { Samsung, iPhone }

class Product {
  final int id;
  final String name;
  final int price;
  final PhoneBrand brand;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.imageUrl,
  });

//두 상품이 같은 상품인지 판별
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

//두 상품이 같은 id를 가질 경우 같은 해시코드를 갖도록 해준다. 상품 효율적으로 찾기위해서..
  @override
  int get hashCode => id.hashCode;
}
