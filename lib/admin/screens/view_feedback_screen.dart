import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sef_ass/common/purple_list_tile.dart';
import 'package:sef_ass/common/read%20data/get_feedback_details.dart';

import '../../common/pop_up_window.dart';
import '../../constants/global_variables.dart';

class ViewFeedbackScreen extends StatefulWidget {
  const ViewFeedbackScreen({super.key});
  static const String routeName = '/view-feedback';

  @override
  State<ViewFeedbackScreen> createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  //documnet IDs
  Stream<List<String>>? feedbackIDsStream;

  @override
  void initState() {
    // TODO: fetch the feedbackIDStream
    super.initState();
    feedbackIDsStream =
        FirebaseFirestore.instance.collection('Feedback').snapshots().map(
              (snapshot) =>
                  snapshot.docs.map((document) => document.id).toList(),
            );
  }

  void showDescriptionPopUp(String unitNo, String description) {
    Popup(
      title: 'Unit No: $unitNo',
      content: Text(
        description,
        style: TextStyle(color: GlobalVariables.primaryColor),
      ),
      buttons: [
        ButtonConfig(
          text: 'Exit',
          onPressed: () {
            // Your logic when Confirm button is pressed
          },
        ),
      ],
    ).show(context);
  }

  String unitNo = '';
  String des = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: GlobalVariables.primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'View feedback',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: GlobalVariables.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back button is pressed
          },
        ),
      ),
      body: StreamBuilder<List<String>>(
        stream: feedbackIDsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return GestureDetector(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PurpleListTile(
                      type: 'Feedback',
                      title: [
                        //get Feedback details
                        GetFeedbackDetails(
                          documentId: snapshot.data![index],
                          onPressed: (unitNo, des) {
                            setState(() {
                              unitNo = unitNo;
                              des = des;
                            });
                            showDescriptionPopUp(unitNo, des);
                          },
                        )
                      ],
                      icon: null,
                      hasSlidable: false,
                    );
                  },
                  itemCount: snapshot.data!.length,
                ),
              );
            } else {
              return Text('Error loading data');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
