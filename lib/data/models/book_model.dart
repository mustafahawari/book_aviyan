class BookModel {
  String? bookId;
  String? userId;
  String? title;
  String? author;
  String? edition;
  String? publisher;
  double? printedPrice;
  double? sellingPrice;
  String? description;
  String? coverImage;
  String? category;
  String? subCategory;
  String? location;
  String? status;

  BookModel({
    this.userId,
    this.title,
    this.description,
    this.coverImage,
    this.category,
    this.location,
    this.author,
    this.bookId,
    this.edition,
    this.printedPrice,
    this.publisher,
    this.sellingPrice,
    this.subCategory,
    this.status = "AVAILABLE"
  });

  BookModel.fromMap(Map<String, dynamic> data) {
    userId = data['userId'];
    bookId = data['bookId'];
    title = data['title'];
    description = data['description'];
    coverImage = data['coverImage'];
    category = data['category'];
    subCategory = data['subCategory'];
    location = data['location'];
    author = data['author'];
    edition = data['edition'];
    printedPrice = data['printedPrice'];
    publisher = data['publisher'];
    sellingPrice = data['sellingPrice'];
    status = data['status'];
  }

  Map<String,dynamic> toMap() {
    return {
      'userId': userId,
      'bookId': bookId,
      'title': title,
      'description': description,
      'author': author,
      'edition': edition,
      'publisher': publisher,
      'printedPrice': printedPrice,
      'sellingPrice': sellingPrice,
      'coverImage': coverImage,
      'category': category,
      'subCategory': subCategory,
      'location': location,
      'status': status
    };
  }
}
