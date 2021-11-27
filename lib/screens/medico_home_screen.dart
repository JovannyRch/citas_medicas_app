import 'package:citas_medicas_app/const/const.dart';
import 'package:citas_medicas_app/helpers/herpers.dart';
import 'package:citas_medicas_app/screens/login_screen.dart';
import 'package:citas_medicas_app/screens/medico/citas_screen.dart';
import 'package:citas_medicas_app/services/auth_service.dart';
import 'package:citas_medicas_app/services/citas_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MedicoHomeScreen extends StatefulWidget {
  DoctorResponse medico;

  MedicoHomeScreen({required this.medico});

  @override
  _MedicoHomeScreenState createState() => _MedicoHomeScreenState();
}

class _MedicoHomeScreenState extends State<MedicoHomeScreen> {
  int _currentIndex = 0;
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.medico.nombre),
            Text(
              widget.medico.especialidad,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return IndexedStack(
      index: _currentIndex,
      children: [CitasMedicoScreen(medico: widget.medico)],
    );
  }
}
