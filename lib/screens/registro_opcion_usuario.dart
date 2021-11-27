import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/registro_medico_scren.dart';
import 'package:citas_medicas_app/screens/registro_paciente_screen.dart';
import 'package:citas_medicas_app/widgets.dart';
import 'package:flutter/material.dart';

class RegistroOpcionScreen extends StatefulWidget {
  RegistroOpcionScreen({Key? key}) : super(key: key);

  @override
  _RegistroOpcionScreenState createState() => _RegistroOpcionScreenState();
}

class _RegistroOpcionScreenState extends State<RegistroOpcionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scaffold(),
    );
  }

  Widget _scaffold() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTitle("Escoje un tipo de usuario"),
          const SizedBox(height: 50),
          AppButton("Usuario paciente", () {
            navigateTo(context, const RegistroPaciente());
          }),
          AppButton("Usuario doctor", () {
            navigateTo(context, const RegistroMedico());
          }),
        ],
      ),
    );
  }
}
