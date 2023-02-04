import 'package:book_aviyan_final/data/data_sources/books/books_remote_data_sources.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/book_model.dart';

abstract class BooksRepository {
  Future<void> uploadBooks(BookModel bookModel);
  Future<List<BookModel>> getAllBooks();

  Future<List<BookModel>> getSellerBooks(String userId);
}
@LazySingleton(as: BooksRepository)
class BooksRepositoryImpl implements BooksRepository {
  BooksRemoteDataSource booksRemoteDataSource;
  BooksRepositoryImpl(this.booksRemoteDataSource);
  @override
  Future<void> uploadBooks(BookModel bookModel) async {
    try {
      await booksRemoteDataSource.uploadBook(bookModel);
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<List<BookModel>> getAllBooks() async {
    try {
      final data = await booksRemoteDataSource.getAllBooks();
      return data;
    } catch (e) {
      throw e; 
    }
  }
  
  @override
  Future<List<BookModel>> getSellerBooks(String userId) async {
   try {
     final data =await booksRemoteDataSource.getSellerBooks(userId);
     return data;
   } catch (e) {
     throw e;
   }
  }
}
