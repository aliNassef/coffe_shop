class CoffeeModel {
  final String coffeeId;
  final String name;
  final double price;
  final String size;
  final int count;
  final String img;
  final double rate;
  final String desc;
  final String type;
  final int numOfReviews;
  CoffeeModel({
    required this.numOfReviews,
    required this.coffeeId,
    required this.name,
    required this.price,
    required this.size,
    required this.count,
    required this.img,
    required this.rate,
    required this.desc,
    required this.type,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      numOfReviews: json['numOfReviews'] ?? 0,
      coffeeId: json['coffeeId'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      size: json['size'] ?? '',
      count: json['count'] ?? 0,
      img: json['img'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
      desc: json['desc'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coffeeId': coffeeId,
      'numOfReviews': numOfReviews,
      'name': name,
      'price': price,
      'size': size,
      'count': count,
      'img': img,
      'rate': rate,
      'desc': desc,
      'type': type,
    };
  }

  CoffeeModel copyWith({required int count}) => CoffeeModel(
    coffeeId: coffeeId,
    numOfReviews: numOfReviews,
    name: name,
    price: price,
    size: size,
    count: count,
    img: img,
    rate: rate,
    desc: desc,
    type: type,
  );
}
