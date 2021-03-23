import 'package:cricquiz11/common_widget/text_widget.dart';
import 'package:cricquiz11/util/colors.dart';
import 'package:cricquiz11/util/image_strings.dart';
import 'package:cricquiz11/util/strings.dart';
import 'package:flutter/material.dart';

class AccountVerification extends StatefulWidget {
  @override
  _AccountVerificationState createState() => _AccountVerificationState();
}

class _AccountVerificationState extends State<AccountVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Account details',
          color: ColorUtils.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(ImageUtils.APP_LOGO_BANNER),
            TextField(
              maxLength: 50,
              decoration: InputDecoration(
                counterText: '',
                labelText: Strings.accountHolderName,
                hintText: Strings.accountHolderName,
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              maxLength: 50,
              decoration: InputDecoration(
                counterText: '',
                labelText: Strings.accountNumber,
                hintText: Strings.accountNumber,
              ),
              onChanged: (value) {},
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: () {},
              color: ColorUtils.colorPrimary,
              child: TextWidget(
                color: ColorUtils.white,
                textSize: 14,
                text: Strings.submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
