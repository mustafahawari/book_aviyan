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
      categories: categories ?? categories,
      subCategories: subCategories ?? subCategories,
      errorMessage: errorMessage ?? errorMessage,
    );
  }

  @override
  List<Object?> get props => [status];
}

enum CategoryStatus {
  initial,
  loaded,
  error,
}
