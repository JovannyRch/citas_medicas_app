import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/login_screen.dart';
import 'package:citas_medicas_app/services/usuarios_service.dart';
import 'package:citas_medicas_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegistroPaciente extends StatefulWidget {
  const RegistroPaciente({Key? key}) : super(key: key);

  @override
  _RegistroPacienteState createState() => _RegistroPacienteState();
}

class _RegistroPacienteState extends State<RegistroPaciente> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController telefono = TextEditingController();

  UsuariosService usuariosService = UsuariosService();

  late Size _size;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool isOk = false;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: _scaffold(),
    );
  }

  Widget _scaffold() {
    return SizedBox(
      height: _size.height,
      child: SingleChildScrollView(
        child: _mainContent(),
      ),
    );
  }

  Widget _mainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _form(),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: RoundedLoadingButton(
          onPressed: isOk ? null : handleSubmit,
          controller: _btnController,
          color: kSecondaryColor,
          child: const Text(
            "Registrarse",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void handleSubmit() async {
    String emailInput = email.text.trim();
    String passwordInput = password.text.trim();
    String nombreInput = nombre.text.trim();
    String telefonoInput = telefono.text.trim();

    if (emailInput.isEmpty ||
        passwordInput.isEmpty ||
        nombreInput.isEmpty ||
        telefonoInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Datos incompletos"),
        ),
      );
      _btnController.stop();
      return;
    }

    bool resp = await usuariosService.registrarPaciente(
        emailInput, passwordInput, nombreInput, telefonoInput);

    _btnController.stop();

    if (resp) {
      setState(() {
        isOk = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario creado exitosamente, inicie sesión por favor"),
        ),
      );
      navigateToReplace(context, const LoginScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear el usuario, intente de nuevo"),
        ),
      );
    }
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(top: _size.height * 0.22),
      padding: const EdgeInsets.symmetric(
        horizontal: 35.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitle("Registro usuario paciente"),
          const SizedBox(height: 16.0),
          InputApp("Nombre completo", Icons.person, controller: nombre),
          InputApp("Teléfono", Icons.phone,
              controller: telefono, isNumber: true),
          InputApp("Correo", Icons.email, controller: email),
          InputApp(
            "Contraseña",
            Icons.lock,
            isPassword: true,
            controller: password,
          ),
          _submitButton(),
        ],
      ),
    );
  }
}
