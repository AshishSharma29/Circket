import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImageUtils.homeBg))),
                ),
                if (_isEditable)
                  Image.asset(
                    ImageUtils.edit,
                    height: 50,
                    width: 50,
                  ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              maxLength: 50,
              enabled: _isEditable,
              decoration: InputDecoration(hintText: Strings.name),
            ),
            TextField(
              enabled: _isEditable,
              maxLength: 50,
              decoration: InputDecoration(hintText: Strings.email),
            ),
            TextField(
              maxLength: 15,
              enabled: _isEditable,
              decoration: InputDecoration(hintText: Strings.mobileNumber),
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: _onTap,
              color: ColorUtils.colorPrimary,
              child: TextWidget(
                color: ColorUtils.white,
                text: _isEditable ? Strings.submit : Strings.edit,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTap() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }
}
