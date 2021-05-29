import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
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
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: addNotes,
                        color: Colors.green[300],
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 17.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                // Title Container
                Form(
                  child: Column(
                    children: [
                      // Title Field
                      TextFormField(
                        autofocus: true,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.black)),
                        style: GoogleFonts.alegreya(
                            fontSize: 25, color: Colors.black),
                        onChanged: (_val) {
                          title = _val;
                        },
                      ),

                      //Description Field
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'Description',
                              hintStyle:
                                  GoogleFonts.alegreya(color: Colors.black)),
                          style: GoogleFonts.alegreya(
                              fontSize: 18, color: Colors.black),
                          onChanged: (_val) {
                            description = _val;
                          },
                          maxLines: 30,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addNotes() {
    // Saving data to firebase
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    var notesData = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now()
    };

    collectionReference.add(notesData);

    Navigator.pop(context);
  }
}
