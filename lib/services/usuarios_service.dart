import 'package:citas_medicas_app/services/api.dart';

class UsuariosService {
  final Api _api = Api();

  Future<bool> registrarMedico(String email, String password, String nombre,
      String cedula, int idEspecialidad) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "rol": 1,
      "nombre": nombre,
      "cedula": cedula,
      "id_especialidad": idEspecialidad,
    };

    var response = await _api.post("/usuarios", data);

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<bool> registrarPaciente(
      String email, String password, String nombre, String telefono) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "rol": 0,
      "nombre": nombre,
      "telefono": telefono,
    };

    var response = await _api.post("/usuarios", data);

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}
