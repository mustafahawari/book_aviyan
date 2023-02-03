import 'package:book_aviyan_final/core/consts/app_collections.dart';
import 'package:book_aviyan_final/core/network/firebase_service.dart';
import 'package:book_aviyan_final/core/utils/com_fun.dart';
import 'package:book_aviyan_final/data/models/category/main_category_model.dart';
import 'package:book_aviyan_final/data/models/category/sub_category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryRemoteDataSource {
  Future<List<MainCategoryModel>> getAllCategory();
  Future<MainCategoryModel> addCategory(MainCategoryModel categoryModel);
  Future<SubCategoryModel> addSubCategory(SubCategoryModel subCategoryModel);

  Future<List<SubCategoryModel>> getAllSubCategoriesById(String catId);
  Future<SubCategoryModel> deleteSubCategory(SubCategoryModel subCategoryModel);
  Future<MainCategoryModel> deleteCategory(MainCategoryModel categoryModel);
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  FirebaseService firebaseService;
  FirebaseFirestore firebaseFirestore;
  CategoryRemoteDataSourceImpl(
    this.firebaseService,
    this.firebaseFirestore,
  );
  @override
  Future<MainCategoryModel> addCategory(MainCategoryModel categoryModel) async {
    try {
      categoryModel.id = generateUniqueId();
      await firebaseService.update(
        AppCollections.CATEGORY,
        data: categoryModel.toMap(),
        docId: categoryModel.id!,
      );
      return categoryModel;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SubCategoryModel> addSubCategory(
      SubCategoryModel subCategoryModel) async {
    try {
      subCategoryModel.id = generateUniqueId();
      await firebaseService.update(
        AppCollections.SUB_CATEGORY,
        data: subCategoryModel.toMap(),
        docId: subCategoryModel.id!,
      );
      return subCategoryModel;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<MainCategoryModel>> getAllCategory() async {
    try {
      final result = await firebaseService.getAll(AppCollections.CATEGORY);
      List<MainCategoryModel> categories =
          result.map((e) => MainCategoryModel.fromMap(e.data())).toList();
      return categories;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<SubCategoryModel>> getAllSubCategoriesById(String catId) async {
    try {
      final snapshot = await firebaseFirestore
          .collection(AppCollections.SUB_CATEGORY)
          .where('catId', isEqualTo: catId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        List<SubCategoryModel> subCategories = snapshot.docs
            .map((e) => SubCategoryModel.fromMap(e.data()))
            .toList();
        return subCategories;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<MainCategoryModel> deleteCategory(
      MainCategoryModel mainCategoryModel) async {
    try {
      await firebaseFirestore
          .collection(AppCollections.CATEGORY)
          .doc(mainCategoryModel.id)
          .delete();
      return mainCategoryModel;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SubCategoryModel> deleteSubCategory(
      SubCategoryModel subCategoryModel) async {
    try {
      await firebaseFirestore
          .collection(AppCollections.SUB_CATEGORY)
          .doc(subCategoryModel.id)
          .delete();
      return subCategoryModel;
    } catch (e) {
      throw e;
    }
  }
}
