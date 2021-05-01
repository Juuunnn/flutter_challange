import 'dart:ffi';
// esta es la clase que corresponde a la creacion de la base de datos y el manejo de 
// de cada uno de los atributos en la tabla 
class Task {
  int? idLocal;
  int? idServer;
  String? name;
  double? calories;

  Task({required this.idLocal, required this.idServer, required this.name, required this.calories});

  Task.fromMapSQL(Map<String, dynamic> mapSQL) {
    idLocal = mapSQL["idLocal"];
    idServer = mapSQL["idServer"];
    name = mapSQL["name"];
    calories = mapSQL["calories"];
  }

  Map<String, dynamic> toMapSQL() {
    return {"idLocal": idLocal, "idServer": idServer, "name": name, "calories": calories};
  }

  Map<String, dynamic> toMapServer() {
    return {"idLocal": idLocal, "idServer": idServer, "name": name, "calories": calories};
  }

  
}
