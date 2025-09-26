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
    // Puedes personalizar la paleta aquí si tienes una paleta propia
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color cardBg = const Color.fromARGB(255, 231, 231, 231);
    final Color iconEdit = primaryColor;
    final Color iconDelete = Colors.redAccent;
    final Color titleColor = Colors.black87;

    return Card(
      color: cardBg,
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: primaryColor.withOpacity(0.08), width: 2),
      ),
      elevation: 10,
      shadowColor: primaryColor.withOpacity(0.30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          collapsedIconColor: primaryColor,
          iconColor: primaryColor,
          backgroundColor: cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            mainTitle,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: titleColor,
              letterSpacing: 0.2,
            ),
          ),
          leading: Icon(Icons.person, size: 40,color: AppColors.primary,),
          subtitle: subTitle != null
              ? Text(
                  subTitle!,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )
              : null,
          trailing: Container(
            margin: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tooltip(
                  message: "Editar",
                  child: IconButton(
                    icon: Icon(Icons.edit_rounded, color: iconEdit, size: 24),
                    onPressed: onEdit,
                  ),
                ),
                const SizedBox(width: 2),
                Tooltip(
                  message: "Eliminar",
                  child: IconButton(
                    icon: Icon(Icons.delete_outline_rounded, color: iconDelete, size: 24),
                    onPressed: onDelete,
                  ),
                ),
              ],
            ),
          ),
          children: [
            if (extraInfo != null)
              Container(
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.04),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: extraInfo!.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${e.key}: ",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              e.value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}