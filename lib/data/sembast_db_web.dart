import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import '../models/password.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDBWeb {
  DatabaseFactory dbFactory = databaseFactoryWeb;
  late Database _db;
  final store = intMapStoreFactory.store('passwords');

  //Uso il factory constr0uctor Pattern, pèerchè voglio avere una sola istanza
  static SembastDBWeb _singleton = SembastDBWeb.internal();

  SembastDBWeb.internal() {}

  factory SembastDBWeb() {
    return _singleton;
  }

  Future<Database> init() async {
    if (_db == null) {
      _db = await _openDb();
    }

    return _db;
  }

  Future _openDb() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'pass.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addPassword(Password password) async {
    //Ritorna l'id dell'documento creato
    int id = await store.add(_db, password.toMap());
    return id;
  }

  Future getPasswords() async {
    await init();
    final finder = Finder(sortOrders: [
      SortOrder('name'),
    ]);
    final snapshot = await store.find(_db, finder: finder);
    return snapshot.map((item) {
      final pwd = Password.fromMap(item.value);
      pwd.id = item.key;
      return pwd;
    }).toList(); // returning a list of Objects Il chiamante riceverà una lista di oggetti
  }

  Future updatePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await store.update(_db, pwd.toMap(), finder: finder);
  }

  Future deletePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}
