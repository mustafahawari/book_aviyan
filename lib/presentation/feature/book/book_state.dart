part of 'book_bloc.dart';

enum BookStatus {
  initial,
  success,
  failure,
}

class BookState extends Equatable {
  final BookStatus status;
  final String? errorMessage;
  final List<BookModel>? allBooks;
  final List<BookModel>? sellerBooks;
  BookState({
    this.status = BookStatus.initial,
    this.errorMessage,
    this.allBooks,
    this.sellerBooks
  });

  BookState copyWith({
    BookStatus? status,
    String? errorMessage,
    List<BookModel>? allBooks,
    List<BookModel>? sellerBooks,
  }) {
    return BookState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      allBooks: allBooks ?? this.allBooks,
      sellerBooks: sellerBooks ?? this.sellerBooks
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [status, errorMessage, allBooks, sellerBooks];
}
