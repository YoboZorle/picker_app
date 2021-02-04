import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final VoidCallback onPressed;
  final TextInputType inputType;

  InputField({this.inputController, this.hintText, this.onPressed, this.inputType=TextInputType.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 0),
              child: TextFormField(
                keyboardType: inputType,
                cursorColor: AppColor.primaryText,
                controller: inputController,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Ubuntu',
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: inputController.text.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 12.0),
                          child: IconButton(
                            iconSize: 16.0,
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.grey,
                            ),
                            onPressed: onPressed,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
