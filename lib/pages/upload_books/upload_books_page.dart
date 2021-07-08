import 'package:book_aviyan_final/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class UploadBooksPage extends StatefulWidget {
  @override
  _UploadBooksPageState createState() => _UploadBooksPageState();
}

class _UploadBooksPageState extends State<UploadBooksPage> {
  final _formKey = GlobalKey<FormState>();
  var _bookName = '';
  var _bookCategory = '';
  var _bookDescription = '';
  var _phoneNumber = '';
  var _location = '';
  bool _isLoading = false;
  var uuid = Uuid();
  final TextEditingController _categoryController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _categoryValue;

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
      print(_bookName);
      print(_bookCategory);
      print(_bookDescription);
      print(_phoneNumber);
      // Use those values to send our auth request ..
      // try {
      //   if (_pickedImage == null) {
      //     ErrorDialog.authErrorHandle("Please pick an image", context);
      //   } else {
      //     setState(() {
      //       _isLoading = true;
      //     });
      //   }
      //   final ref = FirebaseStorage.instance
      //       .ref()
      //       .child('bookImages')
      //       .child(_bookName + ".jpg");
      //   await ref.putFile(_pickedImage!);
      //   var url = await ref.getDownloadURL();

      //   final User _user = _auth.currentUser!;
      //   final _uid = _user.uid;

      //   final bookId = uuid.v4();

      //   FirebaseFirestore.instance.collection("books").doc(bookId).set({
      //     "bookName": _bookName,
      //     "bookImage": url,
      //     "category": _bookCategory,
      //     "description": _bookDescription,
      //     "phoneNumber": _phoneNumber,
      //     "location": _location,
      //     "userId": _uid,
      //     "bookId": bookId,
      //     "joinedAt": Timestamp.now(),
      //   });
      //   Navigator.canPop(context) ? Navigator.pop(context) : null;
      // } on FirebaseAuthException catch (error) {
      //   ErrorDialog.authErrorHandle(error.message!, context);
      // } finally {
      //   setState(() {
      //     _isLoading = false;
      //     _formKey.currentState!.reset();
      //   });
      // }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Donate your Books",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.all(3),
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Material(
          color: AppColor.mainColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Upload',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
                            key: ValueKey('Title'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a book name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: 'Book Name',
                            ),
                            onSaved: (value) {
                              _bookName = value!;
                            },
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
                                        borderRadius: BorderRadius.circular(4),
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
                                          color:
                                              Theme.of(context).backgroundColor,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _categoryController,
                                    key: ValueKey('Category'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Category';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Add a new Category',
                                    ),
                                    onSaved: (value) {
                                      _bookCategory = value!;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
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
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value!;
                                  //_controller.text= _bookCategory;
                                  print(_bookCategory);
                                });
                              },
                              hint: Text('Select a Category'),
                              value: _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            key: ValueKey('Description'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'product description is required';
                              }
                              return null;
                            },
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'Product description',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _bookDescription = value!;
                            },
                            onChanged: (text) {}),
                        Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            key: ValueKey('Contact'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Contact number is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                            ),
                            onSaved: (value) {
                              _phoneNumber = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: TextFormField(
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
                            ),
                            onSaved: (value) {
                              _location = value!;
                            },
                          ),
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
      ),
    );
  }
}
