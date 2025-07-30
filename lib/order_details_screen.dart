import 'package:flutter/material.dart';
import 'select_areas_screen.dart';  // Importa la nueva pantalla

class OrderDetailsScreen extends StatefulWidget {
  final List<int> selectedModels;

  OrderDetailsScreen({required this.selectedModels});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? selectedType; // Playera o Pantalón
  String? selectedSize;

  final List<String> types = ['Playera', 'Pantalón'];
  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
        backgroundColor: const Color(0xFF8C4C2F),
      ),
      backgroundColor: const Color(0xFFF3E9DC),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modelos seleccionados:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: widget.selectedModels.map((model) {
                return Chip(label: Text('Modelo $model'));
              }).toList(),
            ),
            SizedBox(height: 24),
            Text(
              'Tipo:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            ...types.map((type) {
              return RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: selectedType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 16),
            Text(
              'Talla:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: selectedSize,
              hint: const Text('Selecciona una talla'),
              isExpanded: true,
              items: sizes
                  .map((size) => DropdownMenuItem(
                        child: Text(size),
                        value: size,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedSize = value;
                });
              },
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: (selectedType != null && selectedSize != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectAreasScreen(
                              selectedModels: widget.selectedModels,
                              selectedType: selectedType!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD1495B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
