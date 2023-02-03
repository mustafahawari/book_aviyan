part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class AddCategory extends CategoryEvent {
  final MainCategoryModel mainCategoryModel;

  AddCategory(this.mainCategoryModel);
}

class AddSubCategory extends CategoryEvent {
  final SubCategoryModel subCategoryModel;

  AddSubCategory(this.subCategoryModel);
}

class GetAllCategory extends CategoryEvent {}

class DeleteCategory extends CategoryEvent {
  final MainCategoryModel mainCategoryModel;

  DeleteCategory(this.mainCategoryModel);
}

class DeleteSubCategory extends CategoryEvent {
  final SubCategoryModel subCategoryModel;

  DeleteSubCategory(this.subCategoryModel);
}

class GetAllSubCategoryByCategoryId extends CategoryEvent {
  final String categoryId;

  GetAllSubCategoryByCategoryId(this.categoryId);
}
