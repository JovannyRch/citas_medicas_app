import 'package:citas_medicas_app/services/citas_service.dart';
import 'package:citas_medicas_app/typedefs/typedefs.dart';
import 'package:citas_medicas_app/widgets.dart';
import 'package:flutter/material.dart';

class CitaPacienteCard extends StatelessWidget {
  CitaPacienteResponse cita;
  CitaClickAction callbackEliminar;
  CitaClickAction callbackCancelar;
  bool disable;

  CitaPacienteCard({
    required this.cita,
    required this.callbackEliminar,
    required this.callbackCancelar,
    required this.disable,
  });

  Size _size = Size(0, 0);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    if (cita.status == "Eliminado") {
      return Container();
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 13.0),
        padding: const EdgeInsets.all(15.0),
        width: _size.width * 0.85,
        height: 187.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
                offset: Offset(4, 4), blurRadius: 2.0, color: Colors.black12),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSubtitle(cita.medico),
            const SizedBox(height: 5.0),
            AppCaptionValue(cita.especialidad),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    AppCaption("Fecha"),
                    AppCaptionValue(cita.fecha),
                  ],
                ),
                Column(
                  children: [
                    AppCaption("Hora"),
                    AppCaptionValue(cita.hora),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dotIndicator(),
                actionButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget actionButton() {
    if (cita.status == "Activo") {
      return AppButton("Cancelar cita", () {
        callbackCancelar(cita.idCita);
      }, disable: disable);
    }

    return AppButton("Eliminar cita", () {
      callbackEliminar(cita.idCita);
    }, disable: disable);
  }

  Widget dotIndicator() {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: getStatusColor(),
        shape: BoxShape.circle,
      ),
    );
  }

  Color getStatusColor() {
    if (cita.status == "Activo") {
      return Colors.green;
    }

    return Colors.red;
  }
}
