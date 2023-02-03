import 'package:book_aviyan_final/data/data_sources/category/category_remote_data_source.dart';
import 'package:book_aviyan_final/data/models/category/main_category_model.dart';
import 'package:book_aviyan_final/data/models/category/sub_category_model.dart';
import 'package:injectable/injectable.dart';

abstract class CategoryRepository {
  Future<List<MainCategoryModel>> getAllCategory();
  Future<MainCategoryModel> addCategory(MainCategoryModel categoryModel);
  Future<SubCategoryModel> addSubCategory(SubCategoryModel subCategoryModel);

  Future<List<SubCategoryModel>> getAllSubCategoriesById(String catId);
  Future<SubCategoryModel> deleteSubCategory(SubCategoryModel subCategoryModel);
  Future<MainCategoryModel> deleteCategory(MainCategoryModel categoryModel);
  
}
@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(this.categoryRemoteDataSource);
  @override
  Future<MainCategoryModel> addCategory(MainCategoryModel categoryModel) async {
    try {
      final data = await categoryRemoteDataSource.addCategory(categoryModel);
      return data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SubCategoryModel> addSubCategory(SubCategoryModel subCategoryModel) async {
    try {
      final data = await categoryRemoteDataSource.addSubCategory(subCategoryModel);
      return data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<MainCategoryModel>> getAllCategory() async {
    try {
      final data = await categoryRemoteDataSource.getAllCategory();
      return data;
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<List<SubCategoryModel>> getAllSubCategoriesById(String catId) async {
    try {
      final data = await categoryRemoteDataSource.getAllSubCategoriesById(catId);
      return data;
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<MainCategoryModel> deleteCategory(MainCategoryModel categoryModel) async {
    try {
      final data = await categoryRemoteDataSource.deleteCategory(categoryModel);
      return data;
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<SubCategoryModel> deleteSubCategory(SubCategoryModel subCategoryModel) async {
    try {
      final data = await categoryRemoteDataSource.deleteSubCategory(subCategoryModel);
      return data;
    } catch (e) {
      throw e;
    }
  }

}