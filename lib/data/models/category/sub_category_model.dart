class SubCategoryModel {
  String? name;
  String? id;
  String? catId;
  bool? status;
  SubCategoryModel({
    this.name,
    this.catId,
    this.id,
    this.status = true,
  });

  SubCategoryModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    status = data['status'];
    catId = data['catId'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "status": status,
      'catId': catId,
    };
  }
}
