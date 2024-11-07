class ItemModel {
  String? id, name, price, image, rating;
  bool? bookmarke;
  ItemModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.rating,
      this.bookmarke});

  Map<String, dynamic> tomap() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "image": image,
      "rating": rating,
      "bookmarke": bookmarke
    };
  }

  ItemModel copyWith(
{    String? id,
    String? name,
    String? price,
    String? image,
    String? rating,
    bool? bookmarke,}
  ) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      bookmarke: bookmarke ?? this.bookmarke,
    );
  }

  ItemModel.fromejson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        name = json["name"] ?? "",
        image = json["image"] ?? "",
        rating = json["rating"] ?? "",
        price = json["price"] ?? "",
        bookmarke = json["bookmarke"] ?? false;
}
