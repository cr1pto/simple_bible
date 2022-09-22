import 'package:flutter/material.dart';
import 'package:simple_bible/data/sembast_db.dart';
import 'package:simple_bible/models/password.dart';
import 'package:simple_bible/screens/passwords.dart';

class PasswordDetailDialog extends StatefulWidget {
  final Password password;
  final bool isNew;
  final SembastDb sembastDb;

  PasswordDetailDialog(this.password, this.isNew, this.sembastDb);

  @override
  _PasswordDetailDialogState createState() => _PasswordDetailDialogState();
}

class _PasswordDetailDialogState extends State<PasswordDetailDialog> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    String title = (widget.isNew) ? 'Insert new Password' : 'Edit Password';
    txtName.text = widget.password.password;

    return AlertDialog(
      title: Text(title),
      content: Column(children: [
        TextField(
          controller: txtName,
          decoration: const InputDecoration(
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
                        : Icon(Icons.visibility_off))))
      ]),
      actions: [
        TextButton(
            child: Text('Save'),
            onPressed: () async {
              widget.password.name = txtName.text;
              widget.password.password = txtPassword.text;
              bool doesPassExist =
                  await widget.sembastDb.passwordExists(widget.password.name);
              if (doesPassExist) {
                await widget.sembastDb.updatePassword(widget.password);
              } else {
                await widget.sembastDb.addPassword(widget.password);
              }

              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PasswordsScreen()));
            }),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('Cancel'))
      ],
    );
  }
}
