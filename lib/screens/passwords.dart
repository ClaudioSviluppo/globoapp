import 'package:flutter/material.dart';
import '../data/sembast_db_web.dart';
import '../data/shared_prefs.dart';
import './password-detail.dart';
import '../data/sembast_db.dart';
import '../models/password.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreen();
}

class _PasswordsScreen extends State<PasswordsScreen> {
  late dynamic db;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();

  @override
  void initState() {
    if (kIsWeb) {
      //Running on the web
      db = SembastDBWeb();
    } else {
      //Running on device
      db = SembastDB();
    }

    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
        //é un widget che aggiorna il suo contenuto dopo una Future
        future: getPasswords(),
        builder: (context, snapshot) { //Ridisegno pagina dopo Future
          List<Password> passwords = snapshot.data ?? [];
          return ListView.builder(
              itemCount: passwords == null ? 0 : passwords.length,
              itemBuilder: (_, index) {
                //La funzione prende due parametri, ma uso solo il secondo
                //infatti il primo è il carattere  _
                return Dismissible(
                  //Cancella con Swipe
                  key: Key(passwords[index].id.toString()),
                  onDismissed: (_) {
                    db.deletePassword(passwords[index]);
                  },
                  child: ListTile(
                    title: Text(
                      passwords[index].name,
                      style: TextStyle(fontSize: fontSize),
                    ),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PasswordDetailDialog(
                                passwords[index], false);
                          });
                    },
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(settingColor),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PasswordDetailDialog(Password('', ''), true);
                });
          }),
    );
  }

  Future<List<Password>> getPasswords() async {
    List<Password> passwords = await db.getPasswords();
    return passwords;
  }
}
