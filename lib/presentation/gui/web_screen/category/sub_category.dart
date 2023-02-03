import 'dart:math';

import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/data/models/category/main_category_model.dart';
import 'package:book_aviyan_final/data/models/category/sub_category_model.dart';
import 'package:book_aviyan_final/presentation/feature/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/utils/loader_widget.dart';
import '../../../common_widgets/common_textfield.dart';

class WebSubCategoryPage extends StatefulWidget {
  final CategoryBloc categoryBloc;
  const WebSubCategoryPage({Key? key, required this.categoryBloc})
      : super(key: key);

  @override
  State<WebSubCategoryPage> createState() => _WebSubCategoryPageState();
}

class _WebSubCategoryPageState extends State<WebSubCategoryPage> {
  final subCategoryController = TextEditingController();
  List<MainCategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    categories = widget.categoryBloc.categories.value;
  }

  MainCategoryModel? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CategoryBloc, CategoryState>(
        bloc: widget.categoryBloc,
        listener: (context, state) {
          if (state.status == CategoryStatus.initial) {
            DialogUtils.showLoaderDialog(context);
          }
          if (state.status == CategoryStatus.loaded) {
            Navigator.pop(context);
            subCategoryController.clear();
            ToastUtils.showToast("Success", ToastType.SUCCESS);
          }
          if (state.status == CategoryStatus.error) {
            Navigator.pop(context);
            ToastUtils.showToast(
                state.errorMessage ?? "Failed", ToastType.ERROR);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Add Sub Category",
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
                      "Sub Category",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButton<MainCategoryModel>(
                              underline: SizedBox(),
                              isExpanded: true,
                              items: [
                                ...categories.map(
                                  (e) => DropdownMenuItem<MainCategoryModel>(
                                    child: Text(e.name!),
                                    value: e,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;

                                  //_controller.text= _bookCategory;
                                  // print(_bookCategory);
                                });
                                widget.categoryBloc.add(
                                    GetAllSubCategoryByCategoryId(value!.id!));
                              },
                              hint: Text('Select Category*'),
                              value: _selectedCategory,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CommonTextField(
                              controller: subCategoryController,
                              hintText: "Enter sub category name"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topRight,
                      child: FilledButton(
                        onPressed: () {
                          final alreadyAddedcategories =
                              widget.categoryBloc.subcategories.value;
                          if (subCategoryController.text.isEmpty ||
                              _selectedCategory == null) {
                            ToastUtils.showToast(
                                "Please select category and name of sub category.",
                                ToastType.ERROR);
                          } else {
                            final checkIfAlreadyExist =
                                alreadyAddedcategories.any((element) =>
                                    element.name!.toLowerCase() ==
                                    subCategoryController.text.toLowerCase());
                            if (checkIfAlreadyExist) {
                              ToastUtils.showToast(
                                  "Sub category already exists",
                                  ToastType.SUCCESS);
                            } else {
                              SubCategoryModel subCategoryModel =
                                  SubCategoryModel(
                                name: subCategoryController.text,
                                catId: _selectedCategory!.id,
                              );
                              widget.categoryBloc
                                  .add(AddSubCategory(subCategoryModel));
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
            SizedBox(height: 40),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sub Category List",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 20),
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
                    _selectedCategory == null
                        ? Center(
                            child: Text("No Data"),
                          )
                        : StreamBuilder(
                            stream: widget.categoryBloc.subcategories.stream,
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
                                    snapshot.data as List<SubCategoryModel>;
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
                                                        widget.categoryBloc.add(
                                                            DeleteSubCategory(
                                                                data[index]));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )),
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
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
