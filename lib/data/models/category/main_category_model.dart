class MainCategoryModel {
  String? name;
  String? id;
  bool? status;
  MainCategoryModel({
    this.name,
    this.id,
    this.status = true,
  });
  MainCategoryModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    status = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "status": status,
    };
  }
}
