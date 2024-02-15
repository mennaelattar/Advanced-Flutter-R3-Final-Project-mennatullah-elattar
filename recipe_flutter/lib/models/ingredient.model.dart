class Ingredient {
  String? docId;
  String? name;
  String? image;
  List<String>? user_ids;

  Ingredient();
  Ingredient.fromJson(Map<String, dynamic> data, String id) {
    docId = id;
    name = data['name'];
    image = data['image'];
    user_ids = data['user_ids'] != null
        ? List<String>.from(data['user_ids']
            .map((e) => e.toString())) //to make sure the return value is string
        : null;
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "image": image, "user_ids": user_ids};
  }
}
