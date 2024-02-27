class CoffeeModel {
  String? sId;
  int? id;
  String? name;
  String? description;
  double? price;
  String? region;
  int? weight;
  List<String>? flavorProfile;
  List<String>? grindOption;
  int? roastLevel;
  String? imageUrl;
  bool isLoved; // Property for toggling love status
  bool isInCart; // Property for tracking whether item is in cart
  int qty; // Property for quantity

  CoffeeModel({
    this.sId,
    this.id,
    this.name,
    this.description,
    this.price,
    this.region,
    this.weight,
    this.flavorProfile,
    this.grindOption,
    this.roastLevel,
    this.imageUrl,
    this.isLoved = false, // Initialize with false by default
    this.isInCart = false, // Initialize with false by default
    this.qty = 1, // Initialize with 1 by default
  });

  CoffeeModel.fromJson(Map<String, dynamic> json)
      : sId = json['_id'],
        id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        region = json['region'],
        weight = json['weight'],
        flavorProfile = json['flavor_profile']?.cast<String>(),
        grindOption = json['grind_option']?.cast<String>(),
        roastLevel = json['roast_level'],
        imageUrl = json['image_url'],
        isLoved = false, // Initialize with false by default
        isInCart = false, // Initialize with false by default
        qty = 1; // Initialize with 1 by default

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'region': region,
      'weight': weight,
      'flavor_profile': flavorProfile,
      'grind_option': grindOption,
      'roast_level': roastLevel,
      'image_url': imageUrl,
      'isInCart': isInCart,
      'qty': qty,
    };
  }
}
