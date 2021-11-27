import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/medico_home_screen.dart';
import 'package:citas_medicas_app/screens/paciente_home_screen.dart';
import 'package:citas_medicas_app/screens/registro_opcion_usuario.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  late Size _size;
  AuthService authService = AuthService();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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
        _logo(),
        _form(),
      ],
    );
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
          _authTitle(),
          const SizedBox(height: 16.0),
          _input("Correo", Icons.email, controller: email),
          _input("Contraseña", Icons.lock,
              isPassword: true, controller: password),
          _loginButton(),
          _registerLink(),
        ],
      ),
    );
  }

  Widget _authTitle() {
    return AppTitle("Iniciar sesión");
  }

  Widget _registerLink() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("¿Aún no te has registrado? "),
          GestureDetector(
            onTap: () {
              navigateTo(context, RegistroOpcionScreen());
            },
            child: Text(
              "Registrarme",
              style: TextStyle(color: kMainColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: RoundedLoadingButton(
          onPressed: handleLogin,
          controller: _btnController,
          color: kSecondaryColor,
          child: const Text(
            "Iniciar Sesion",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void handleLogin() async {
    String emailInput = email.text.trim();
    String passwordInput = password.text.trim();

    if (emailInput.isEmpty || passwordInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Datos incompletos"),
        ),
      );
      _btnController.stop();
      return;
    }

    var response = await authService.login(emailInput, passwordInput);

    if (response.idUsuario == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario no encontrado"),
        ),
      );
      _btnController.stop();
      return;
    }

    if (response.rol == 1) {
      //Médico
      var medicoResponse = await authService.fetchDoctor(response.idUsuario);

      navigateToReplace(context, MedicoHomeScreen(medico: medicoResponse));
    } else if (response.rol == 0) {
      //Paciente
      var pacienteResponse =
          await authService.fetchPaciente(response.idUsuario);

      navigateToReplace(
          context, PacienteHomeScreen(paciente: pacienteResponse));
    }

    _btnController.stop();
  }

  Widget _input(String text, IconData icon,
      {bool isPassword = false, required TextEditingController controller}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          labelText: text,
          labelStyle: TextStyle(
            color: kMainColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: kMainColor),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    var container = Container(
      width: 150.0,
      height: 150.0,
      margin: const EdgeInsets.only(top: 82.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        child: Image.asset(
          "assets/images/logo.jpg",
          fit: BoxFit.fitWidth,
        ),
      ),
    );

    var name = const Text(
      "Citas Médicas App",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
    );
    return Column(children: [
      container,
      const SizedBox(height: 16.0),
      name,
    ]);
  }
}
