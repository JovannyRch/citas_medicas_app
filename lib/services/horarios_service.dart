import 'package:citas_medicas_app/services/api.dart';
import 'dart:convert';

class HorarioService {
  final Api api = Api();

  Future<List<HorarioResponse>> fetchHorarios() async {
    var response = await api.get("/horarios");

    if (response.statusCode == 200) {
      return list(response.body);
    }

    return [];
  }
}

List<HorarioResponse> list(String str) => List<HorarioResponse>.from(
    json.decode(str).map((x) => HorarioResponse.fromJson(x)));

HorarioResponse horarioResponseFromJson(String str) =>
    HorarioResponse.fromJson(json.decode(str));

String horarioResponseToJson(HorarioResponse data) =>
    json.encode(data.toJson());

class HorarioResponse {
  HorarioResponse({
    this.idHorario = -1,
    this.fecha = "",
    this.horaIngreso = "",
    this.horaSalida = "",
    this.idMedico = -1,
    this.medico = "",
    this.especialidad = "",
  });

  int idHorario;
  String fecha;
  String horaIngreso;
  String horaSalida;
  int idMedico;
  String medico;
  String especialidad;

  factory HorarioResponse.fromJson(Map<String, dynamic> json) =>
      HorarioResponse(
        idHorario: json["id_horario"],
        fecha: json["fecha"],
        horaIngreso: json["hora_ingreso"],
        horaSalida: json["hora_salida"],
        idMedico: json["id_medico"],
        medico: json["medico"],
        especialidad: json["especialidad"],
      );

  Map<String, dynamic> toJson() => {
        "id_horario": idHorario,
        "fecha": fecha,
        "hora_ingreso": horaIngreso,
        "hora_salida": horaSalida,
        "id_medico": idMedico,
        "medico": medico,
        "especialidad": especialidad,
      };
}
