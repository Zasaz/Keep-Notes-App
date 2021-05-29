import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewNotePage extends StatefulWidget {
  //Constructors
  final Map data;
  final String time;
  final DocumentReference documentReference;

  ViewNotePage(this.data, this.time, this.documentReference);

  @override
  _ViewNotePageState createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  String title, description;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Button Container
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      InkWell(
                        child: Icon(
                          Icons.delete_forever,
                          size: 25,
                          color: Colors.red,
                        ),
                        onTap: delete,
                      ),
                    ],
                  ),
                ),
                // Title Container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    Text(
                      "${widget.data['title']}",
                      style: GoogleFonts.alegreya(
                          color: Colors.black, fontSize: 25),
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.time,
                        style: GoogleFonts.alegreya(
                            color: Colors.black, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 10),
                    //Description Field
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey[50])),
                      // padding: EdgeInsets.all(12.0),
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "${widget.data['description']}",
                        style: GoogleFonts.alegreya(
                            color: Colors.black, fontSize: 20),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() {
    // Deleting data to firebase

    widget.documentReference.delete();
    Navigator.pop(context);
  }
}
