import 'package:flutter/material.dart';

class InputChoiceSingle extends StatefulWidget {
  final List<String> opciones; // Lista de opciones
  final String? valorSeleccionado; // Valor inicial seleccionado (opcional)
  final Function(String)? onChanged; // Callback cuando cambia la selección

  const InputChoiceSingle({
    super.key,
    required this.opciones,
    this.valorSeleccionado,
    this.onChanged,
  });

  @override
  State<InputChoiceSingle> createState() => _InputChoiceSingleState();
}

class _InputChoiceSingleState extends State<InputChoiceSingle> {
  String? _seleccionActual;

  @override
  void initState() {
    super.initState();
    _seleccionActual = widget.valorSeleccionado;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.opciones.map((opcion) {
        return RadioListTile<String>(
          title: Text(opcion),
          value: opcion,
          groupValue: _seleccionActual,
          onChanged: (String? value) {
            setState(() {
              _seleccionActual = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
        );
      }).toList(),
    );
  }
}
