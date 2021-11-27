import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/login_screen.dart';
import 'package:citas_medicas_app/screens/medico/citas_screen.dart';
import 'package:citas_medicas_app/screens/paciente/citas_paciente_screen.dart';
import 'package:citas_medicas_app/screens/paciente/lista_horarios_screen.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/services/citas_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PacienteHomeScreen extends StatefulWidget {
  PacienteResponse paciente;

  PacienteHomeScreen({required this.paciente});

  @override
  _PacienteHomeScreenState createState() => _PacienteHomeScreenState();
}

class _PacienteHomeScreenState extends State<PacienteHomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<CitaMedicoResponse> citas = [];
  bool isLoading = false;
  CitasService citasService = CitasService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: kMainColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              navigateToReplace(context, const LoginScreen());
            },
          )
        ],
        title: Text(widget.paciente.nombre),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateTo(
              context,
              ListaHorariosScreen(
                paciente: widget.paciente,
              ));
        },
        backgroundColor: kSecondaryColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _body() {
    return CitasPacienteScreen(paciente: widget.paciente);
  }
}
