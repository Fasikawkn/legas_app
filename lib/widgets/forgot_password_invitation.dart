import 'package:crowd_funding_app/Models/status.dart';
import 'package:crowd_funding_app/services/provider/user.dart';
import 'package:crowd_funding_app/translations/locale_keys.g.dart';
import 'package:crowd_funding_app/widgets/authdialog.dart';
import 'package:crowd_funding_app/widgets/loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordInvitaion extends StatefulWidget {
  const ForgotPasswordInvitaion({Key? key, required this.email})
      : super(key: key);
  final String email;

  @override
  _ForgotPasswordInvitaionState createState() =>
      _ForgotPasswordInvitaionState();
}

class _ForgotPasswordInvitaionState extends State<ForgotPasswordInvitaion> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';

  @override
  void initState() {
    setState(() {
      _userEmail = widget.email;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.enter_your_email_address_text.tr()),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: _userEmail,
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              setState(() {
                _userEmail = value!;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.field_required_text.tr();
              } 
            },
            decoration: InputDecoration(
              labelText: LocaleKeys.enter_user_email_text.tr(),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor),
          onPressed: () async {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              loadingProgress(context);

              await context.read<UserModel>().forgotPassword(_userEmail);
              Response _response = context.read<UserModel>().response;
              if (_response.status == ResponseStatus.SUCCESS) {
                Navigator.of(context).pop();

                Fluttertoast.showToast(
                    msg: "Email sent to your email with reset link",
                    toastLength: Toast.LENGTH_LONG);
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                authShowDialog(context, Text(_response.message),
                    close: true, error: true);
              }
            }
          },
          child: Text(
            LocaleKeys.send_button_text.tr(),
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
        ),
      ],
    );
  }
}
