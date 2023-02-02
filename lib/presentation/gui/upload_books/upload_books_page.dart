import 'dart:developer';

import 'package:book_aviyan_final/core/injection/di.dart';
import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/core/utils/dialog_utils.dart';
import 'package:book_aviyan_final/data/models/book_model.dart';
import 'package:book_aviyan_final/presentation/common_widgets/error_alert_dialog.dart';
import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/feature/book/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class UploadBooksPage extends StatefulWidget {
  @override
  _UploadBooksPageState createState() => _UploadBooksPageState();
}

class _UploadBooksPageState extends State<UploadBooksPage> {
  final _formKey = GlobalKey<FormState>();
  String? _bookName;
  String? _bookCategory;
  String? _bookDescription;
  String? _location;
  String? _author;
  String? _publisher;
  String? _edition;
  double? _printedPrice;
  double? _sellingPrice;

  bool _isLoading = false;
  var uuid = Uuid();

  String? _categoryValue;
  String? _subCategoryValue;
  File? _pickedImage;

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      _edition = _edition != "" ? _edition : null;
      _publisher = _publisher != "" ? _publisher : null;
      _bookDescription = _bookDescription != "" ? _bookDescription : null;

      if (_pickedImage == null) {
        ErrorDialog.authErrorHandle("Please pick an image", context);
      } else if (_categoryValue == null) {
        ErrorDialog.authErrorHandle("Please select category", context);
      } else if (_subCategoryValue == null) {
        ErrorDialog.authErrorHandle("Please select sub category", context);
      } else {
        final bookToUpload = BookModel(
          userId: getIt<FirebaseAuth>().currentUser!.uid,
          title: _bookName,
          description: _bookDescription,
          author: _author,
          publisher: _publisher,
          category: _categoryValue,
          subCategory: _subCategoryValue,
          location: _location,
          sellingPrice: _sellingPrice,
          printedPrice: _printedPrice,
          edition: _edition,
          coverImage: _pickedImage!.path,
        );
        BlocProvider.of<BookBloc>(context)
            .add(UploadBook(bookModel: bookToUpload));
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Book Details",
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(3),
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        child: Material(
          color: Theme.of(context).colorScheme.primary,
          // color: AppColor.mainColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Upload',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
      body: BlocListener<BookBloc, BookState>(
          listener: (context, state) {
            log(state.status.toString());
            if (state.status == BookStatus.initial) {
              DialogUtils.showLoaderDialog(context);
              print(_edition);
              print(_publisher);
            }
            if (state.status == BookStatus.failure) {
              ToastUtils.showToast(
                state.errorMessage ?? "Upload Failed",
                ToastType.ERROR,
              );
              Navigator.pop(context);
            }
            if (state.status == BookStatus.success) {
              ToastUtils.showToast(
                "Success",
                ToastType.SUCCESS,
              );
              Navigator.pop(context);
              _clear();
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Book Cover*",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.black54),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  //  flex: 2,
                                  child: this._pickedImage == null
                                      ? Container(
                                          margin: EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: AppColor.mainColor,
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(10),
                                          height: 200,
                                          width: 200,
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                            ),
                                            child: Image.file(
                                              this._pickedImage!,
                                              fit: BoxFit.contain,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      child: TextButton.icon(
                                        // textColor: Colors.white,
                                        onPressed: _pickImageCamera,
                                        icon: Icon(Icons.camera,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Camera',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: TextButton.icon(
                                        // textColor: Colors.white,
                                        onPressed: _pickImageGallery,
                                        icon: Icon(Icons.image,
                                            color: Colors.purpleAccent),
                                        label: Text(
                                          'Gallery',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: TextButton.icon(
                                        // textColor: Colors.white,
                                        onPressed: _removeImage,
                                        icon: Icon(
                                          Icons.remove_circle_rounded,
                                          color: Colors.red,
                                        ),
                                        label: Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TextFormField(
                              key: ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a book title';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Book Title*',

                                // label: RichText(
                                //   text: TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: "Book Title",
                                //         style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black54),
                                //       ),
                                //       TextSpan(
                                //         text: "*",
                                //          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.red),
                                //       )
                                //     ]
                                //   ),
                                // ),
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _bookName = value;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('Author'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter author name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Author Name*',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _author = value;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('Edition'),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Edition',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _edition = value;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('Publisher'),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Publisher',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _publisher = value;
                              },
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(right: 9),
                                //     child: Container(
                                //       child: TextFormField(
                                //         controller: _categoryController,
                                //         key: ValueKey('Category'),
                                //         validator: (value) {
                                //           if (value!.isEmpty) {
                                //             return 'Please enter a Category';
                                //           }
                                //           return null;
                                //         },
                                //         decoration: InputDecoration(
                                //           labelText: 'Add a new Category',
                                //           border: OutlineInputBorder(),
                                //         ),
                                //         onSaved: (value) {
                                //           _bookCategory = value!;
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 10),
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: DropdownButton<String>(
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem<String>(
                                          child: Text('Bachelor'),
                                          value: 'Bachelor',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Master'),
                                          value: 'Master',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Primary Level'),
                                          value: 'Primary Level',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Secondary Level'),
                                          value: 'Secondary Level',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Others'),
                                          value: 'Others',
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _categoryValue = value;
                                          //_controller.text= _bookCategory;
                                          print(_bookCategory);
                                        });
                                      },
                                      hint: Text('Select Category*'),
                                      value: _categoryValue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 10),
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(),
                                // isDense: true,
                                isExpanded: true,
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text('1'),
                                    value: '1',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('2'),
                                    value: '2',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('3'),
                                    value: '3',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('4'),
                                    value: '4',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('5'),
                                    value: '5',
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _subCategoryValue = value;
                                    //_controller.text= _bookCategory;
                                    print(_bookCategory);
                                  });
                                },
                                hint: Text('Select Sub Category*'),
                                value: _subCategoryValue,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                                key: ValueKey('Description'),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'product description is required';
                                //   }
                                //   return null;
                                // },
                                maxLines: 6,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  hintText: 'Product description',
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  _bookDescription = value;
                                },
                                onChanged: (text) {}),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('Printed Price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter printed price";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Printed Price*',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _printedPrice = double.parse(value!);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              key: ValueKey('Selling Price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter selling price";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                labelText: 'Selling Price*',
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _sellingPrice = double.parse(value!);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.streetAddress,
                              key: ValueKey('Location'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter your Address';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Location',
                                hintText: "Enter your full address",
                                border: OutlineInputBorder(),
                              ),
                              onSaved: (value) {
                                _location = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )),
    );
  }
  
  void _clear() {}
}
