import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:todo/common/Provider/todo_class.dart';

import '../../../../common/Provider/todo_provider.dart';

class Addproject extends StatefulWidget {
  const Addproject({super.key});

  @override
  State<Addproject> createState() => _AddprojectState();
}

class _AddprojectState extends State<Addproject> {
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  bool _isClicked = false;

  Future getImage(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);

    setState(
      () {
        if (pickedFile != null) {
          image = XFile(pickedFile.path);
          setState(() {
            _isClicked = !_isClicked;
          });
        } else {}
      },
    );
  }

  Widget buildImageButton(String text, ImageSource source, bool isClicked) {
    return InkWell(
      onTap: () {
        getImage(source);
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black),
            // color: _isClicked ? Colors.blue : Colors.green,
          ),
          child: Text(text)),
    );
  }

  TextEditingController projectnamecontroller = TextEditingController();

  Future<void> addproject(BuildContext context) async {
    final String projectname = projectnamecontroller.text;

    if (projectname.isNotEmpty && image != null) {
      final TodoProject todoprojects =
          TodoProject(imagepath: image!.path, projectname: projectname);

      Provider.of<TodoProvider>(context, listen: false)
          .addproject(todoprojects);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('project added successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please fill all fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text(
                    "Add Project",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal.withOpacity(0.18),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.01),
                          const Text(
                            "Select your image",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildImageButton(
                                  "Gallery image", ImageSource.gallery, false),
                              SizedBox(width: width * 0.10),
                              buildImageButton(
                                  "Take picture", ImageSource.camera, false),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10)),
                              child: image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(image!.path),
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Center(child: Text("No image"))),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: TextFormField(
                      controller: projectnamecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a project Name ';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal.withOpacity(0.18),
                        hintText: "Project Name",
                        contentPadding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.red)),
                          child: const Center(
                            child: Text(
                              "Cancle",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            addproject(context);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.lightGreen,
                              )),
                          child: const Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
