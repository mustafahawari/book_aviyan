import 'package:bloc/bloc.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/domain/repository/books_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/subjects.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final BooksRepository booksRepository;
    BehaviorSubject<List<BookModel>> allBooks = BehaviorSubject<List<BookModel>>();
  DashboardBloc(this.booksRepository) : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      if(event is LoadDashboard) {
        _loadAllBooks();
      }
    });
  }

  _loadAllBooks() {
    booksRepository.getAllBooks().then((value) {
      allBooks.add(value);
    }).onError((error, stackTrace) {
      allBooks.addError(error.toString());
    });
  }


  @override
  Future<void> close() {
    allBooks.close();
    return super.close();
  }
  
  
}
