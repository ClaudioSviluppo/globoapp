# globeapp

A new Flutter project.

## Persisting Data Locally with Flutter

### Questo progetto è tratto dal Corso Pluralsight:
Persisting Data Locally With Flutter

## Using Shared Prefernces Summary
1. Reading and Writing Values
2. Factory Constructor

## Using Sembast  Summary
### Sembast acronimo di Simple Embedded Application Store
#### Single Fle loaded in memory and document Saved in JSON Format
#### Written in Dart Works on Android, IOS, Web
1. Adding Sembast to the Project
2. Using DatabaseFactory and StoreRef
3. Read and Write Data With Sembast
4. Encrypting Data
Per l'utilizzo, servono due dependencies
sembast e path_provider

#### Step Required for Sembast:
1. DatabaseFactory dbFactory = databaseFactoryIo; -> Usa FactoryIO per aprire un database Sembast
2. final db = await dbFactory.openDatabase(dbPath); -> prende il path del db (se non c'è lo crea)
3. final store = intMapStoreFactory.store('mystore'); -> Dove salvo i dati nel database
4. await store.add(db, myObject.toMap()); -> add new document in store
5. final finder = Finder (sortOrders: [SortOrder('name'),]) -> Order documents with a Finder instance
6. final snapshot = await store.find(_db, finder: finder); -> retrieve existing data
7. return snapshot.map((item){
    return Password.fromMap(item.value);
}).toList();  -> returning a list of Objects
8. final finder = Finder(filter: Filter.byKey(myObjectId)); -> filtra singolo con una istanza Finder
9. await store.update(db,myObject.toMap(),finder: finder); -> aggiorna quanto filtrato
10. await store.delete (db, finder:finder); -> cancella quanto filtrato


