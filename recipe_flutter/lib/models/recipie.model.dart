class Recipe {
  String? docId;
  int? calories;
  String? category;
  String? image;
  int? preparation_time;
  int? rate;
  int? serving;
  String? title;
  bool? is_today;

  List<String>? favouriteUserIds;

  Recipe();
  Recipe.fromJson(Map<String, dynamic> data, String id) {
    docId = id;
    calories = data['calories'];
    category = data['category'];
    image = data['image'];
    preparation_time = data['preparation_time'];
    rate = data['rate'];
    serving = data['serving'];
    title = data['title'];
    is_today = data['is_today'];

    favouriteUserIds = data['favourite_user_ids'] != null
        ? List<String>.from(data['favourite_user_ids']
            .map((e) => e.toString())) //to make sure the return value is string
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "calories": calories,
      "category": category,
      "image": image,
      "preparation_time": preparation_time,
      "rate": rate,
      "serving": serving,
      "title": title,
      "is_today": is_today,
      "favouriteUserIds": favouriteUserIds
    };
  }
}
