import 'package:flutter/material.dart';
import 'package:smart_condominium/paletaColores.dart';

class CrudItem extends StatelessWidget {
  final String mainTitle; // info principal
  final String? subTitle; // subtítulo opcional
  final Map<String, String>? extraInfo; // datos detallados
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CrudItem({
    super.key,
    required this.mainTitle,
    this.subTitle,
    this.extraInfo,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(207, 245, 245, 245),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ExpansionTile(
        backgroundColor: const Color.fromARGB(0, 245, 245, 245),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          mainTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: subTitle != null ? Text(subTitle!) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blueGrey),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        children: [
          if (extraInfo != null)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // 👈 Alineación izquierda
                children: extraInfo!.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      "${e.key}: ${e.value}",
                      textAlign: TextAlign
                          .left, style: TextStyle(color: Colors.black45),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
