import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/data/models/category/main_category_model.dart';
import 'package:book_aviyan_final/presentation/common_widgets/common_textfield.dart';
import 'package:book_aviyan_final/presentation/feature/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/loader_widget.dart';

class WebCategoryPage extends StatefulWidget {
  final CategoryBloc categoryBloc;
  const WebCategoryPage({Key? key, required this.categoryBloc})
      : super(key: key);

  @override
  State<WebCategoryPage> createState() => _WebCategoryPageState();
}

class _WebCategoryPageState extends State<WebCategoryPage> {
  TextEditingController categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state.status == CategoryStatus.initial) {
          DialogUtils.showLoaderDialog(context);
        }
        if (state.status == CategoryStatus.loaded) {
          Navigator.pop(context);
          categoryNameController.clear();
          ToastUtils.showToast("Success", ToastType.SUCCESS);
        }
        if (state.status == CategoryStatus.error) {
          Navigator.pop(context);
          ToastUtils.showToast("Failed", ToastType.ERROR);
        }
      },
      bloc: widget.categoryBloc,
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Category",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category name",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      CommonTextField(
                          controller: categoryNameController,
                          hintText: "Enter Category Name"),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topRight,
                        child: FilledButton(
                          onPressed: () {
                            final alreadyAddedcategories =
                                widget.categoryBloc.categories.value;
                            if (categoryNameController.text.isEmpty) {
                              ToastUtils.showToast("Please enter category name",
                                  ToastType.SUCCESS);
                            } else {
                              final checkIfAlreadyExist =
                                  alreadyAddedcategories.any((element) =>
                                      element.name!.toLowerCase() ==
                                      categoryNameController.text.toLowerCase());
                              if (checkIfAlreadyExist) {
                                ToastUtils.showToast("Category already exists",
                                    ToastType.SUCCESS);
                              } else {
                                MainCategoryModel mainCategoryModel =
                                    MainCategoryModel(
                                  name: categoryNameController.text,
                                );
                                widget.categoryBloc
                                    .add(AddCategory(mainCategoryModel));
                              }
                            }
                          },
                          child: Text("Submit"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category List",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Id",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Name",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Status",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Action",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      StreamBuilder(
                          stream: widget.categoryBloc.categories.stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CenterCircularLoader();
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error"),
                              );
                            } else if (snapshot.hasData) {
                              final data =
                                  snapshot.data as List<MainCategoryModel>;
                              if (data.isEmpty) {
                                return Center(child: Text("No data"));
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              index.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              data[index].name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                              child: Checkbox(
                                                  value: data[index].status,
                                                  onChanged: (val) {})),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    widget.categoryBloc.add(DeleteCategory(data[index]));
                                                  },
                                                  icon: Icon(Icons.delete,color: Colors.red,)
                                                  
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              }
                            } else {
                              return Text("err");
                            }
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
