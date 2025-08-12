import 'package:flutter/material.dart';
import 'select_areas_screen.dart';

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
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    // Decide qué imagen mostrar según selectedType
    Widget? typeImage;
    if (selectedType == 'Playera') {
      typeImage = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Image.asset(
          'assets/tallasplayeras.png',
          height: 150,
          fit: BoxFit.contain,
        ),
      );
    } else if (selectedType == 'Pantalón') {
      typeImage = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Image.asset(
          'assets/tallaspantalones.png',
          height: 150,
          fit: BoxFit.contain,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
        backgroundColor: const Color(0xFF8C4C2F),
        elevation: 5,
      ),
      backgroundColor: const Color(0xFFF3E9DC),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modelos seleccionados:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B2F2F),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: widget.selectedModels
                  .map(
                    (model) => Chip(
                      label: Text(
                        'Modelo $model',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: const Color(0xFFD1495B).withOpacity(0.2),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 28),
            Text(
              'Tipo:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5B8E7D),
              ),
            ),
            ...types.map((type) {
              return RadioListTile<String>(
                title: Text(
                  type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: type,
                groupValue: selectedType,
                activeColor: const Color(0xFFD1495B),
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                    // Al cambiar tipo, reseteamos talla para que se seleccione de nuevo si se quiere
                    selectedSize = null;
                  });
                },
              );
            }).toList(),
            if (typeImage != null) typeImage,
            const SizedBox(height: 12),
            Text(
              'Talla:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5B8E7D),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD1495B), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedSize,
                hint: const Text('Selecciona una talla'),
                isExpanded: true,
                underline: const SizedBox(),
                items: sizes
                    .map(
                      (size) => DropdownMenuItem(
                        child: Text(
                          size,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        value: size,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSize = value;
                  });
                },
              ),
            ),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 6,
                  ),
                  child: const Text(
                    'Siguiente',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
