import 'dart:io';

import 'package:book_aviyan_final/core/consts/app_collections.dart';
import 'package:book_aviyan_final/core/network/firebase_service.dart';
import 'package:book_aviyan_final/core/utils/com_fun.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/book_model.dart';

abstract class BooksRemoteDataSource {
  Future<void> uploadBook(BookModel bookModel);

  Future<List<BookModel>> getAllBooks();
}

@LazySingleton(as: BooksRemoteDataSource)
class BooksRemoteDataSourceImpl implements BooksRemoteDataSource {
  FirebaseService firebaseService;
  FirebaseStorage firebaseStorage;
  BooksRemoteDataSourceImpl(this.firebaseService, this.firebaseStorage);
  @override
  Future<void> uploadBook(BookModel bookModel) async {
    try {
      bookModel.bookId = generateUniqueId();
      final image =  await uploadImageToCloudStorage(bookModel);
      bookModel.coverImage = image;
      await firebaseService.update(
        AppCollections.BOOKS_COLLECTION,
        data: bookModel.toMap(),
        docId: bookModel.bookId!,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<String> uploadImageToCloudStorage(BookModel bookModel) async {
    try {
      final ref = firebaseStorage
          .ref()
          .child('bookImages')
          .child(bookModel.bookId! + ".jpg");
      await ref.putFile(File(bookModel.coverImage!));
      var url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<List<BookModel>> getAllBooks() async {
   try {
    final response = await firebaseService.getAll(AppCollections.BOOKS_COLLECTION);
    List<BookModel> allBooks = List.from(response.map((e) => BookModel.fromMap(e.data())).toList());
    return allBooks;
   } catch (e) {
     throw e;
   }
  }
}
