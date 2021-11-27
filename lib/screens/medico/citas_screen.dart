import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/widgets/cita_medico_card.dart';
import 'package:citas_medicas_app/widgets/title_widget.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/services/citas_service.dart';
import 'package:flutter/material.dart';
import 'package:citas_medicas_app/const/const.dart';

class CitasMedicoScreen extends StatefulWidget {
  DoctorResponse medico;

  CitasMedicoScreen({required this.medico});
  @override
  _CitasMedicoScreenState createState() => _CitasMedicoScreenState();
}

class _CitasMedicoScreenState extends State<CitasMedicoScreen> {
  List<CitaMedicoResponse> citas = [];
  bool isLoading = false;
  CitasService citasService = CitasService();
  late Size _size;

  late CitaMedicoResponse citaActual = CitaMedicoResponse();

  @override
  void initState() {
    cargarDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            TitleWidget(title: "Lista de citas", color: kMainColor),
            const SizedBox(height: 16.0),
            citasContainer(),
          ],
        ),
      ),
    );
  }

  Widget citasContainer() {
    return SizedBox(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: _renderMateriasOrLoading(),
      ),
    );
  }

  Widget _renderMateriasOrLoading() {
    if (isLoading) {
      return Container(
        height: 300,
        width: _size.width * 0.9,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
          ),
        ),
      );
    }

    if (citas.isEmpty) {
      return Container(
        width: _size.width * 0.9,
        height: 300,
        child: Center(
          child: Column(
            children: const [
              Text("Aún no tienes citas"),
              Text("Espera a que los pacientes agenden citas"),
            ],
          ),
        ),
      );
    }

    return Column(
      children: citas
          .map((c) => CitaMedicoCard(
                cita: c,
                callbackCancelar: cancelarCita,
                callbackEliminar: eliminarCita,
                disable: c.idCita == citaActual.idCita,
              ))
          .toList(),
    );
  }

  void eliminarCita(int citaId) async {
    setState(() {
      citaActual.idCita = citaId;
    });
    var resp = await citasService.eliminarCita(citaId);
    if (resp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cita eliminada con éxito"),
        ),
      );
      setState(() {
        citas = eliminarCitaLocalmente(citaId, citas);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ocurrió un error al eliminar la cita"),
        ),
      );
    }

    setState(() {
      citaActual.idCita = -1;
    });
  }

  List<CitaMedicoResponse> eliminarCitaLocalmente(
      int idCita, List<CitaMedicoResponse> lista) {
    List<CitaMedicoResponse> res = [];

    for (int i = 0; i < lista.length; i++) {
      var item = lista[i];

      if (item.idCita == idCita) {
        continue;
      }
      res.add(item);
    }

    return res;
  }

  void cancelarCita(int citaId) async {
    setState(() {
      citaActual.idCita = citaId;
    });
    var resp = await citasService.cancelarCita(citaId);
    if (resp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cita cancelada con éxito"),
        ),
      );
      setState(() {
        citas = [
          ...citas
              .map((e) => e.idCita == citaId ? cancelarCitaLocalmente(e) : e)
              .toList()
        ];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ocurrió un error al cancelar la cita"),
        ),
      );
    }
    setState(() {
      citaActual.idCita = -1;
    });
  }

  CitaMedicoResponse cancelarCitaLocalmente(CitaMedicoResponse cita) {
    cita.status = "Cancelado";
    return cita;
  }

  void cargarDatos() async {
    setState(() {
      isLoading = true;
    });

    citas = await citasService.fetchByMedico(widget.medico.idMedico);

    setState(() {
      isLoading = false;
    });
  }
}
