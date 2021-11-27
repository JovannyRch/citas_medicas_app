import 'dart:convert';
import 'package:citas_medicas_app/services/api.dart';

class CitasService {
  final Api _api = Api();

  Future<bool> createCita(
      int idMedico, int idHorario, int idPaciente, String hora) async {
    final data = {
      'id_medico': idMedico,
      'id_horario': idHorario,
      'id_paciente': idPaciente,
      'hora': hora,
    };

    var response = await _api.post("/citas", data);

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  Future<List<CitaMedicoResponse>> fetchByMedico(int idMedico) async {
    var apiResponse = await _api.get('/citas/medico/$idMedico');

    if (apiResponse.statusCode == 200) {
      List<CitaMedicoResponse> data = list(apiResponse.body);

      return data;
    }

    return [];
  }

  Future<List<CitaPacienteResponse>> fetchByPaciente(int idPaciente) async {
    var apiResponse = await _api.get('/citas/paciente/$idPaciente');

    if (apiResponse.statusCode == 200) {
      List<CitaPacienteResponse> data = list2(apiResponse.body);

      return data;
    }

    return [];
  }

  Future<bool> cancelarCita(int idCita) async {
    var apiResponse = await _api.delete('/citas/cancelar/$idCita');
    return apiResponse.statusCode == 204;
  }

  Future<bool> eliminarCita(int idCita) async {
    var apiResponse = await _api.delete('/citas/eliminar/$idCita');
    return apiResponse.statusCode == 204;
  }
}

List<CitaMedicoResponse> list(String str) => List<CitaMedicoResponse>.from(
    json.decode(str).map((x) => CitaMedicoResponse.fromJson(x)));

CitaMedicoResponse citaMedicoResponseFromJson(String str) =>
    CitaMedicoResponse.fromJson(json.decode(str));

class CitaMedicoResponse {
  CitaMedicoResponse({
    this.idCita = -1,
    this.status = "",
    this.hora = "",
    this.fecha = "",
    this.paciente = "",
  });

  int idCita;
  String status;
  String hora;
  String fecha;
  String paciente;

  factory CitaMedicoResponse.fromJson(Map<String, dynamic> json) =>
      CitaMedicoResponse(
        idCita: json["id_cita"],
        status: json["status"],
        hora: json["hora"],
        fecha: json["fecha"],
        paciente: json["paciente"],
      );

  Map<String, dynamic> toJson() => {
        "id_cita": idCita,
        "status": status,
        "hora": hora,
        "fecha": fecha,
        "paciente": paciente,
      };
}

CitaPacienteResponse citaPacienteResponseFromJson(String str) =>
    CitaPacienteResponse.fromJson(json.decode(str));

String citaPacienteResponseToJson(CitaPacienteResponse data) =>
    json.encode(data.toJson());

List<CitaPacienteResponse> list2(String str) => List<CitaPacienteResponse>.from(
    json.decode(str).map((x) => CitaPacienteResponse.fromJson(x)));

class CitaPacienteResponse {
  CitaPacienteResponse({
    this.idCita = -1,
    this.status = "",
    this.hora = "",
    this.fecha = "",
    this.medico = "",
    this.especialidad = "",
  });

  int idCita;
  String status;
  String hora;
  String fecha;
  String medico;
  String especialidad;

  factory CitaPacienteResponse.fromJson(Map<String, dynamic> json) =>
      CitaPacienteResponse(
        idCita: json["id_cita"],
        status: json["status"],
        hora: json["hora"],
        fecha: json["fecha"],
        medico: json["medico"],
        especialidad: json["especialidad"],
      );

  Map<String, dynamic> toJson() => {
        "id_cita": idCita,
        "status": status,
        "hora": hora,
        "fecha": fecha,
        "medico": medico,
        "especialidad": especialidad,
      };
}
