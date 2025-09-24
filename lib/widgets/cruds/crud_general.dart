import 'package:flutter/material.dart';

class DataTableCrud extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final List<String> columns;
  final void Function(Map<String, dynamic>) onEdit;
  final void Function(int) onDelete;

  const DataTableCrud({
    super.key,
    required this.data,
    required this.columns,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // permite scroll si hay muchas columnas
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
        border: TableBorder.all(color: Colors.grey.shade300),
        columns: [
          ...columns.map((col) => DataColumn(label: Text(col))),
          const DataColumn(label: Text("Opciones")),
        ],
        rows: data.map((item) {
          return DataRow(
            cells: [
              ...columns.map((col) => DataCell(Text(item[col].toString()))),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => onEdit(item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDelete(item["id"]),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
