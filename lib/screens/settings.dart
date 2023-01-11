import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import '../models/font_size.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  List<int> colors = [0xFF454A64, 0xFFFFC107, 0xFF673Ab7, 0xFF795548];
  final List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize('medium', 14),
    FontSize('large', 20),
    FontSize('extra-large', 24)
  ];

  SPSettings settings = SPSettings();

  @override
  void initState() {
    // Siccome init ritorna future, noi agganciamo la callback then()
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
        title: const Text('Settings'),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Choose a Font Size for the App',
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          DropdownButton(
            value: fontSize.toString(),
            items: getDropdownMenuItems(),
            onChanged: changeSize,
          ),
          Text(
            'App Main Color',
            style: TextStyle(
              fontSize: fontSize,
              color: Color(settingColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
            ],
          )
        ],
      ),
    );
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (FontSize fontSize in fontSizes) {
      items.add(DropdownMenuItem(
        value: fontSize.size.toString(),
        child: Text(fontSize.name),
      ));
    }
    return items;
  }

  void changeSize(String? newSize) {
    settings.setFontSize(double.parse(newSize ?? '14'));
    setState(() {
      fontSize = double.parse(newSize ?? '14');
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;
  ColorSquare(this.colorCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(colorCode),
      ),
    );
  }
}
