part of 'book_bloc.dart';

@immutable
abstract class BookEvent {}

class UploadBook extends BookEvent {
  final BookModel bookModel;
  UploadBook({required this.bookModel});
}

class GetAllBooks extends BookEvent {}

class GetSellerBooks extends BookEvent {
  final String userId;

  GetSellerBooks(this.userId);
}
