import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import '../screens/passwords.dart';
import '../screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();

  @override
  void initState() {
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Con Future Builder ogni cambiamento ai serttings sarà immediatamente
    //visibile nella schermata
    return FutureBuilder(
        future: getSettings(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(settingColor),
              title: Text('GlobApp'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('GlobApp Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                    decoration: BoxDecoration(
                      color: Color(settingColor),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Passwords',
                      style: TextStyle(
                        fontSize: fontSize,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PasswordsScreen()));
                    },
                  ),
                ],
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/travel.jpg'),
                      fit: BoxFit.cover)),
            ),
          );
        });
  }

  Future getSettings() async {
    settings = SPSettings();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
  }
}
