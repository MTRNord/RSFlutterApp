import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController filterTextController;
  final onTextChanged;

  SearchBar({
    this.filterTextController,
    this.onTextChanged,
    Key key,
  }) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  String text;

  @override
  build(BuildContext context) {
    return TextField(
      controller: widget.filterTextController,
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0,
      ),
      onChanged: (String newText) {
        setState(() {
          text = newText;
        });
        if (widget.onTextChanged != null) widget.onTextChanged(newText);
      },
      decoration: InputDecoration(
        fillColor: Color(0xffedf0f2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(11),
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xffedf0f2),
        ),
        suffixIcon: text != null && text != ""
            ? IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  // workaround
                  // see https://github.com/flutter/flutter/issues/35848#issuecomment-527854562
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.filterTextController.clear(); // clear text
                    FocusScope.of(context)
                        .requestFocus(FocusNode()); // hide keyboard
                    setState(() {
                      text = "";
                    });
                  });
                },
              )
            : null,
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.blueGrey,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
