import 'package:bloc/bloc.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/domain/repository/books_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BooksRepository booksRepository;
  BookBloc(this.booksRepository) : super(BookState()) {
    on<BookEvent>((event, emit) async {
      if (event is UploadBook) {
        try {
          emit(state.copyWith(status: BookStatus.initial));
          await booksRepository.uploadBooks(event.bookModel);
          emit(state.copyWith(status: BookStatus.success));
        } catch (e) {
          emit(state.copyWith(
              errorMessage: e.toString(), status: BookStatus.failure));
        }
      } else if (event is GetAllBooks) {
        try {
          emit(state.copyWith(status: BookStatus.initial));
          final books = await booksRepository.getAllBooks();
          emit(state.copyWith(allBooks: books, status: BookStatus.success));
        } catch (e) {
          emit(state.copyWith(
              errorMessage: e.toString(), status: BookStatus.failure));
        }
      }
    });
  }
}
