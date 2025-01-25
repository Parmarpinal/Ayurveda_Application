import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  GlobalKey<FormState> key1 = GlobalKey();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var feedbackController = TextEditingController();

  Future<dynamic> sendFeedback(data) async {
    final String URI =
        'http://api.aswdc.in/Api/MST_AppVersions/PostAppFeedback/AppPostFeedback';
    try {
      var res = await http.post(Uri.parse(URI),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'API_KEY': '1234'
          });
      return res.statusCode;
    } catch (Error) {
      throw Error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: key1,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2)),
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid mobile number";
                        }
                        final mobileRegex = RegExp(r'^[6-9]\d{9}$');
                        if (!mobileRegex.hasMatch(value)) {
                          return "Enter a valid 10-digit mobile number";
                        }
                        return null;
                      },
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2)),
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email address";
                        }
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,8})+$');
                        if (!emailRegex.hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2)),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please give your feedback";
                        }
                        return null;
                      },
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.red, width: 2)),
                        labelText: "Feedback",
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(),
                            iconColor: Colors.white,
                          ),
                          onPressed: () async {
                            if (key1.currentState!.validate()) {
                              // Form is valid
                              print("Name: ${nameController.text}");
                              print("Mobile: ${mobileController.text}");
                              print("Email: ${emailController.text}");
                              print("Feedback: ${feedbackController.text}");

                              Map<String, dynamic> feedbackData = Map();
                              feedbackData['AppName'] = 'Ayurveda';
                              feedbackData['VersionNo'] = '1.2';
                              feedbackData['Platform'] = Platform.isAndroid ? "Android" : "IOS";
                              feedbackData['PersonName'] = nameController.text;
                              feedbackData['Mobile'] =
                                  mobileController.text;
                              feedbackData['Email'] = emailController.text;
                              feedbackData['Message'] = feedbackController.text;
                              feedbackData['Remarks'] = 'Not more';
                              var res = await sendFeedback(feedbackData);
                              print("Res is res $res");
                              if (res == 200) {
                                setState(() {
                                  nameController.clear();
                                  mobileController.clear();
                                  emailController.clear();
                                  feedbackController.clear();
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'Feedback sent successfully. Thank you!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              } else {
                                setState(() {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'Something Went Wrong.'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              }
                            }
                          },
                          label: Text("Submit",style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w600,color: Colors.white),),
                          icon: Icon(Icons.send,size: 18,),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(),
                            iconColor: Colors.white,
                          ),
                          onPressed: () {
                            nameController.clear();
                            mobileController.clear();
                            emailController.clear();
                            feedbackController.clear();
                          },
                          label: Text("Clear",style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.w600,color: Colors.white),),
                          icon: Icon(Icons.clear,size: 20,),
                        ),
                      ],
                    )
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
