part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<MainCategoryModel>? categories;
  final List<SubCategoryModel>? subCategories;
  final String? errorMessage;
  CategoryState(
      {this.categories,
      this.subCategories,
      this.errorMessage,
      this.status = CategoryStatus.initial});

  CategoryState copyWith({
    CategoryStatus? status,
    List<MainCategoryModel>? categories,
    List<SubCategoryModel>? subCategories,
    String? errorMessage
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status,categories,errorMessage,subCategories,];
}

enum CategoryStatus {
  initial,
  loaded,
  error,
}
