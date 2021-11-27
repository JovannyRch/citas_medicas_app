import 'dart:convert';
import 'package:citas_medicas_app/services/api.dart';

class AuthService {
  final Api _api = Api();

  Future<AuthResponse> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    var apiResponse = await _api.post('/usuarios/login', data);

    if (apiResponse.statusCode == 200) {
      var body = json.decode(apiResponse.body);

      return AuthResponse(
        email: body["email"],
        idUsuario: body["id_usuario"],
        rol: body["rol"],
      );
    }

    return AuthResponse();
  }

  Future<DoctorResponse> fetchDoctor(int idUsuario) async {
    var apiResponse = await _api.get('/usuarios/doctor/$idUsuario');

    if (apiResponse.statusCode == 200) {
      var body = json.decode(apiResponse.body);

      return DoctorResponse(
        idMedico: body["id_medico"],
        idUsuario: body["id_usuario"],
        cedula: body["cedula_profesional"],
        nombre: body["nombre_completo"],
        especialidad: body["especialidad"],
      );
    }

    return DoctorResponse();
  }

  Future<PacienteResponse> fetchPaciente(int idUsuario) async {
    var apiResponse = await _api.get('/usuarios/paciente/$idUsuario');

    if (apiResponse.statusCode == 200) {
      var body = json.decode(apiResponse.body);

      return PacienteResponse(
        idPaciente: body["id_paciente"],
        nombre: body["nombre_completo"],
        idUsuario: body["id_usuario"],
        telefono: body["telefono"].toString(),
      );
    }

    return PacienteResponse();
  }
}

class AuthResponse {
  AuthResponse({this.idUsuario = -1, this.email = "", this.rol = -1});

  int idUsuario;
  String email;
  int rol;
}

class DoctorResponse {
  DoctorResponse(
      {this.idMedico = -1,
      this.idUsuario = -1,
      this.nombre = "",
      this.cedula = "",
      this.especialidad = ""});

  int idMedico;
  int idUsuario;
  String nombre;
  String cedula;
  String especialidad;
}

class PacienteResponse {
  PacienteResponse(
      {this.idPaciente = -1,
      this.nombre = "",
      this.telefono = "",
      this.idUsuario = -1});

  int idPaciente;
  String nombre;
  String telefono;
  int idUsuario;
}
