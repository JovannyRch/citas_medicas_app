import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/paciente_home_screen.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/services/citas_service.dart';
import 'package:citas_medicas_app/services/horarios_service.dart';
import 'package:citas_medicas_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HorarioDetail extends StatefulWidget {
  HorarioResponse horario;
  PacienteResponse paciente;

  HorarioDetail({required this.horario, required this.paciente});

  @override
  _HorarioDetailState createState() => _HorarioDetailState();
}

class _HorarioDetailState extends State<HorarioDetail> {
  TextEditingController hora = TextEditingController();
  CitasService service = CitasService();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: const Text("Selecciona un horario"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTitle("Crear cita"),
            const SizedBox(height: 10.0),
            AppCaptionValue(widget.horario.medico.trim()),
            const SizedBox(height: 5.0),
            AppCaption(widget.horario.especialidad),
            const SizedBox(height: 15.0),
            AppCaption("Horario disponible"),
            AppCaptionValue(
                "${widget.horario.horaIngreso} - ${widget.horario.horaSalida}"),
            const SizedBox(height: 25.0),
            InputApp("Hora", Icons.timer, controller: hora, isNumber: true),
            const SizedBox(height: 10.0),
            _submit(),
          ],
        ),
      ),
    );
  }

  void handleSubmit() async {
    String horaInput = hora.text.trim();

    if (horaInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Datos incompletos"),
        ),
      );
      _btnController.stop();
      return;
    }

    int horaVal = int.parse(horaInput);

    if (horaVal >= 0 && horaVal <= 24) {
      bool resp = await service.createCita(
          widget.horario.idMedico,
          widget.horario.idHorario,
          widget.paciente.idPaciente,
          "$horaVal:00:00");

      if (resp) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cita creada exitosamente"),
          ),
        );

        navigateToReplace(
            context, PacienteHomeScreen(paciente: widget.paciente));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error al crear la cita"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("La hora debe de estár entre el disponible del médico"),
        ),
      );
    }

    _btnController.stop();
  }

  Widget _submit() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: RoundedLoadingButton(
          onPressed: handleSubmit,
          controller: _btnController,
          color: kSecondaryColor,
          child: const Text(
            "Agendar cita",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
