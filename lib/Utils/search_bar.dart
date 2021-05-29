import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_notes/Helper/strings.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _simpleText =
        GoogleFonts.alegreya(color: Colors.black54, fontSize: 18);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            prefixIcon:
                Icon(Icons.search_sharp, color: Colors.black87, size: 24),
            suffixIcon: Icon(Icons.arrow_circle_down_sharp,
                color: Colors.black87, size: 22),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            filled: true,
            hintText: Strings.searchText,
            hintStyle: _simpleText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.blue.shade200),
            ),
          ),
        ),
      ),
    );
  }
}
