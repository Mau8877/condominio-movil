import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_condominium/Data/api.dart';
import 'package:smart_condominium/paletaColores.dart';

class Bitacora extends StatefulWidget {
  const Bitacora({super.key});

  @override
  State<Bitacora> createState() => _BitacoraState();
}


class _BitacoraState extends State<Bitacora> {
  late Future<void> _futureInit;
  List<Map<String, dynamic>> _bitacoras = [];
  String? _nextPageUrl;
  String? _prevPageUrl;
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _futureInit = fetchBitacora("${Api.url}/bitacora/");
  }

  Future<void> fetchBitacora(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);

      final List<dynamic> results = decoded["results"];
      setState(() {
        _bitacoras = results.map((e) => e as Map<String, dynamic>).toList();
        // Paginación
        if (decoded.containsKey("pagination")) {
          final pagination = decoded["pagination"];
          _currentPage = pagination["current_page"] ?? 1;
          _totalPages = pagination["total_pages"] ?? 1;
          _nextPageUrl = pagination["next_page"];
          _prevPageUrl = pagination["previous_page"];
        } else {
          _nextPageUrl = null;
          _prevPageUrl = null;
          _currentPage = 1;
          _totalPages = 1;
        }
      });
    } else {
      throw Exception("Error al cargar la bitacora");
    }
  }

  void _loadNextPage() {
    if (_nextPageUrl != null) {
      setState(() {
        _futureInit = fetchBitacora(_nextPageUrl!);
      });
    }
  }

  void _loadPrevPage() {
    if (_prevPageUrl != null) {
      setState(() {
        _futureInit = fetchBitacora(_prevPageUrl!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(15),
      child: FutureBuilder<void>(
        future: _futureInit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (_bitacoras.isEmpty) {
            return const Text(
              "No hay registros en la bitácora",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lista de bitácora
              Expanded(
                child: ListView.builder(
                  itemCount: _bitacoras.length,
                  itemBuilder: (context, index) {
                    final item = _bitacoras[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 14,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.primary.withOpacity(
                                0.9,
                              ),
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["nombre"] ?? "Sin nombre",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item["accion"] ?? "",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item["fecha_hora_legible"] ?? "",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Paginación
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 18,
                ),
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón Anterior
                    GestureDetector(
                      onTap: _prevPageUrl != null ? _loadPrevPage : null,
                      child: Opacity(
                        opacity: _prevPageUrl != null ? 1.0 : 0.4,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.navigate_before_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Anterior",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Página actual
                    Text(
                      "Página $_currentPage de $_totalPages",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Botón Siguiente
                    GestureDetector(
                      onTap: _nextPageUrl != null ? _loadNextPage : null,
                      child: Opacity(
                        opacity: _nextPageUrl != null ? 1.0 : 0.4,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Siguiente",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}