import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_notes/ui/Drawer.dart';
import 'package:keep_notes/ui/HomeScreen/add_note.dart';
import 'package:keep_notes/ui/HomeScreen/view_note.dart';
import 'package:keep_notes/Services/google_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  Collection Reference
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  //  Random Colors
  List<Color> randomColors = [
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.deepPurple.shade100,
    Colors.indigo.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          automaticallyImplyLeading: true,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Keep Notes',
            style: GoogleFonts.alegreya(color: Colors.black54, fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GoogleImageServices().getProfileImage(),
            )
          ],
        ),
        drawer: buildDrawer(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddNotePage(),
              ),
            )
                .then((value) {
              print('SetState Called!');
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.orange[700],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: collectionReference.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    //  RandomColors Generator
                    Random random = new Random();
                    Color backgroundColor = randomColors[random.nextInt(5)];

                    //Mapping Data from Firebase
                    Map data = snapshot.data.docs[index].data();

                    //DateTime
                    DateTime dateTime = data['createdAt'].toDate();
                    String formattedTime =
                        DateFormat.yMMMd().add_jm().format(dateTime);

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => ViewNotePage(
                                data,
                                formattedTime,
                                snapshot.data.docs[index].reference),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: backgroundColor,
                        // color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: GoogleFonts.alegreya(
                                    fontSize: 19, color: Colors.black),
                              ),
                              Text(
                                "${data['description']}",
                                style: GoogleFonts.alegreya(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  DateFormat.yMMMd().add_jm().format(dateTime),
                                  style: GoogleFonts.alegreya(
                                      fontSize: 14, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "You haven't added anything yet!",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
