import 'package:flutter/material.dart';
import '../data/sembast_db.dart';
import '../data/sembast_db_web.dart';
import './passwords.dart';
import '../models/password.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PasswordDetailDialog extends StatefulWidget {
  final Password password;
  final bool isNew;

  PasswordDetailDialog(this.password, this.isNew);

  @override
  _PasswordDetailDialogState createState() => _PasswordDetailDialogState();
}

class _PasswordDetailDialogState extends State<PasswordDetailDialog> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool hidePassword = true;
  dynamic db;

  @override
  Widget build(BuildContext context) {
    String title = (widget.isNew) ? 'Insert new Password' : 'Edit Password';
    txtName.text = widget.password.name;
    txtPassword.text = widget.password.password;
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          TextField(
            controller: txtName,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
          TextField(
            controller: txtPassword,
            obscureText: hidePassword,
            decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: hidePassword
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off))),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Save'),
          onPressed: () {
            widget.password.name = txtName.text;
            widget.password.password = txtPassword.text;
            if (kIsWeb) {
              //Running on the web
              SembastDBWeb db = SembastDBWeb();
            } else {
              //Running on device
              SembastDB  db= SembastDB();
            }
            (widget.isNew)
                ? db.addPassword(widget.password)
                : db.updatePassword(widget.password);

            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PasswordsScreen()));
          },
        ),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel')),
      ],
    );
  }
}
