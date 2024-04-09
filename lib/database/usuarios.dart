class Usuario{
  int id;
  String nombre;
  String matricula;
  String password;
  String email;

  Usuario(
      {
        required this.id,
        required this.nombre,
        required this.matricula,
        required this.password,
        required this.email
      });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nombre': nombre, 'matricula': matricula, 'password': password, 'email': email};
  }
}