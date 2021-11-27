import 'dart:convert';

Medico apreciacionModelFromJson(String str) =>
    Medico.fromJson(json.decode(str));

/* String apreciacionModelToJson(Medico data) => json.encode(data.toJson()); */

class Medico {
  Medico({
    this.idMedico = -1,
    this.nombre = "",
    this.cedulaProfesional = "",
    this.especialidad = "",
  });

  int idMedico;
  String nombre;
  String cedulaProfesional;
  String especialidad;

  factory Medico.fromJson(Map<String, dynamic> json) => Medico(
        idMedico: json["id_medico"],
        nombre: json["nombre_completo"],
        cedulaProfesional: json["cedula_profesional"],
        especialidad: json["especialidad"],
      );

  /*  Map<String, dynamic> toJson() => {
        "id": id,
        "instrucciones": instrucciones,
        "ciclo": ciclo,
      }; */
}
