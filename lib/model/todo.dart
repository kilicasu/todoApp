class Todo {
  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  int? id;
  String? todo;
  bool? completed;
  int? userId;

  //? ile her zaman dolu gelip gelmediğini kontrol etmek için koyduk nuleble yaptık.

//veritabanında görünüm için kendim FROM JSON VE TO JSON METOTLARINI ekledim.

//FROM JSON  //API DAN GELEN İSTEKLERİ ALDIK
  ///jsondan nesneye dönüştürdü
  Todo.fromJson(Map<String, dynamic> json) {
    //dynamic dğişken value değerinin tipi belli değil demek
    id = json["id"];
    todo = json["todo"];
    completed = json["completed"] ?? false;
    userId = json["userId"];
  }

//TO JSON
//nesneden jsona dönüştürdü
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["todo"] = todo;
    data["completed"] = completed;
    data["userId"] = userId;

    return data;
  }
}
