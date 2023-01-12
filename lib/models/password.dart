class Password {
  int? id;
  late String name;
  late String password;

  Password(this.name, this.password);

  //Metodo per trasformare un ogget Password in Map
  //In quanto Sembast usa oggetti Map per inserire e aggiornare dati

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'password': password};
  }
  //Ora serve un costruttore che faccia l'opposto, quando leggiamo dal db
  //otterremo un object Mape lo trasformeremo in un istanza di password

  Password.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    password = map['password'];
  }
}
