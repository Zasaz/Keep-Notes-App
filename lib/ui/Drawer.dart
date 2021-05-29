import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_notes/Services/google_auth.dart';

Drawer buildDrawer(BuildContext context) {
  return new Drawer(
    elevation: 10,
    child: Container(
      color: Theme.of(context).primaryColor,
      child: new ListView(
        children: <Widget>[
          new Container(
            child: new DrawerHeader(
              child: Text(
                'KeepNotes',
                style: GoogleFonts.alegreya(color: Colors.black, fontSize: 23),
                textAlign: TextAlign.center,
              ),
              margin: EdgeInsets.only(top: 30),
            ),
            // color: Colors.black26,
          ),
          new Container(
            child: Column(
              children: <Widget>[
                InkWell(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.black54,
                        size: 23,
                      ),
                      title: Text(
                        'Profile',
                        style: GoogleFonts.alegreya(
                            color: Colors.black, fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SalesModule()),
                      // );
                    }),
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.power_settings_new_sharp,
                      color: Colors.black54,
                      size: 23,
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.alegreya(
                          color: Colors.black, fontSize: 20),
                    ),
                  ),
                  // onTap: GoogleImageServices().signOut(),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
