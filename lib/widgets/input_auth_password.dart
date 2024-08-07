// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter_coworkers_app/widgets/input_title.dart';

class InputAuthPassword extends StatefulWidget {
  const InputAuthPassword({
    Key? key,
    required this.hint,
    required this.editingController,
    required this.title,
  }) : super(key: key);

  final String hint;
  final TextEditingController editingController;
  final String title;

  @override
  State<InputAuthPassword> createState() => _InputAuthPasswordState();
}

class _InputAuthPasswordState extends State<InputAuthPassword> {
  bool hide = true;
  setHide() {
    hide = !hide;
    setState(() {}); // utuk update atau refresh page
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(
          x: widget.title,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 8),
          alignment: Alignment.centerLeft,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0XFFE5E7EC).withOpacity(0.5),
                blurRadius: 30,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.editingController,
                  obscureText: hide,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Color(0XFFA7A883),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                  ),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                onPressed: setHide, // gausah pake () karna tidak ada parameter
                icon: ImageIcon(
                  AssetImage(
                    hide
                        ? 'assets/ic_eye_closed.png'
                        : 'assets/icon_eye_open.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
