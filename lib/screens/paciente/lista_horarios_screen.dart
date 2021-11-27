import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/paciente/horario_detail_screen.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/services/horarios_service.dart';
import 'package:flutter/material.dart';

class ListaHorariosScreen extends StatefulWidget {
  PacienteResponse paciente;

  ListaHorariosScreen({required this.paciente});

  @override
  _ListaHorariosScreenState createState() => _ListaHorariosScreenState();
}

class _ListaHorariosScreenState extends State<ListaHorariosScreen> {
  bool isLoading = false;
  HorarioService service = HorarioService();

  List<HorarioResponse> horarios = [];
  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  void cargarDatos() async {
    setState(() {
      isLoading = true;
    });

    horarios = await service.fetchHorarios();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccione un horario"),
        backgroundColor: kMainColor,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (horarios.isEmpty) {
      return const Center(
        child: Text("No hay horarios disponibles, intente más tarde"),
      );
    }

    return Container(
      child: ListView(
        children: horarios
            .map(
              (horario) => ListTile(
                onTap: () {
                  navigateTo(
                    context,
                    HorarioDetail(
                      horario: horario,
                      paciente: widget.paciente,
                    ),
                  );
                },
                title: Text(
                  "${horario.medico} - ${horario.especialidad}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                    "${horario.fecha} de ${horario.horaIngreso} - ${horario.horaSalida}"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            )
            .toList(),
      ),
    );
  }
}
