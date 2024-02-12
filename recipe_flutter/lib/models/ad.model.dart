class Ad {
  String? title;
  String? image;
  bool? is_active;

  Ad();
  Ad.fromJson(Map<String, dynamic> data, String id) {
    title = data['title'];
    image = data['image'];
    is_active = data['is_active'];
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "image": image, "is_active": is_active};
  }
}
