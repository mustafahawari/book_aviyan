import 'package:bloc/bloc.dart';
import 'package:book_aviyan_final/data/models/category/main_category_model.dart';
import 'package:book_aviyan_final/data/models/category/sub_category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  BehaviorSubject<List<MainCategoryModel>> categories =
      BehaviorSubject<List<MainCategoryModel>>();
  BehaviorSubject<List<SubCategoryModel>> subcategories =
      BehaviorSubject<List<SubCategoryModel>>();
  CategoryBloc(this.categoryRepository) : super(CategoryState()) {
    on<CategoryEvent>((event, emit) async {
      if (event is AddCategory) {
        emit(state.copyWith(status: CategoryStatus.initial));
        try {
          final addedCat =
              await categoryRepository.addCategory(event.mainCategoryModel);
          List<MainCategoryModel> cat = categories.value;
          cat.add(addedCat);
          categories.add(cat);
          emit(state.copyWith(status: CategoryStatus.loaded));
        } catch (e) {
          emit(state.copyWith(
            status: CategoryStatus.error,
            errorMessage: e.toString(),
          ));
        }
      } else if (event is AddSubCategory) {
        try {
          emit(state.copyWith(status: CategoryStatus.initial));
          await categoryRepository.addSubCategory(event.subCategoryModel);
          emit(state.copyWith(status: CategoryStatus.loaded));
        } catch (e) {
          emit(state.copyWith(
            status: CategoryStatus.error,
            errorMessage: e.toString(),
          ));
        }
      } else if (event is GetAllCategory) {
        getAllCategories();
      } else if (event is GetAllSubCategoryByCategoryId) {
        getAllSubCategories(event);
      } else if (event is DeleteCategory) {
        deleteCategory(event);
      } else if (event is DeleteSubCategory) {
        deleteSubCategory(event);
      }
    });
  }

  // Future<void> addCategory(AddCategory event) async {
  //   await categoryRepository.addCategory(event.mainCategoryModel).then((value) {
  //     List<MainCategoryModel> ca = categories.value;
  //     ca.add(value);
  //     categories.add(ca);
  //   }).onError((error, stackTrace) {
  //     categories.addError(error.toString());
  //   });
  // }

  void getAllCategories() {
    categoryRepository.getAllCategory().then((value) {
      categories.add(value);
    }).onError((error, stackTrace) {
      categories.addError(error.toString());
    });
  }

  void getAllSubCategories(GetAllSubCategoryByCategoryId event) {
    categoryRepository.getAllSubCategoriesById(event.categoryId).then((value) {
      subcategories.add(value);
    }).onError((error, stackTrace) {
      subcategories.addError(error.toString());
    });
  }

  void deleteCategory(DeleteCategory event) {
    categoryRepository.deleteCategory(event.mainCategoryModel).then((value) {
      List<MainCategoryModel> cat = categories.value;
      cat.remove(value);
      categories.add(cat);
    }).onError((error, stackTrace) {
      categories.addError(error.toString());
    });
  }

  void deleteSubCategory(DeleteSubCategory event) {
    categoryRepository.deleteSubCategory(event.subCategoryModel).then((value) {
      List<SubCategoryModel> cat = subcategories.value;
      cat.remove(value);
      subcategories.add(cat);
    }).onError((error, stackTrace) {
      categories.addError(error.toString());
    });
  }

  @override
  Future<void> close() async {
    await categories.close();
    await subcategories.close();
    return super.close();
  }
}
