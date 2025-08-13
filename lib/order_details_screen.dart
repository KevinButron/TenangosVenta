import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'select_areas_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final List<int> selectedModels;

  const OrderDetailsScreen({Key? key, required this.selectedModels}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? selectedType; // Playera o Pantalón
  String? selectedSize;

  final List<String> types = ['Playera', 'Pantalón'];
  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  /// Inicializa Firebase si aún no se ha hecho
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  /// Guarda el pedido en Firebase Firestore
  Future<void> saveOrder() async {
    if (selectedType != null && selectedSize != null) {
      await FirebaseFirestore.instance.collection('orders').add({
        'models': widget.selectedModels,
        'type': selectedType,
        'size': selectedSize,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

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
            const Text(
              'Modelos seleccionados:',
              style: TextStyle(
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
            const Text(
              'Tipo:',
              style: TextStyle(
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
                    selectedSize = null; // Reset talla al cambiar tipo
                  });
                },
              );
            }).toList(),
            if (typeImage != null) typeImage,
            const SizedBox(height: 12),
            const Text(
              'Talla:',
              style: TextStyle(
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
                boxShadow: const [
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
                        value: size,
                        child: Text(
                          size,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
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
                      ? () async {
                          await saveOrder(); // Guardar en Firebase
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SelectAreasScreen(
                                selectedType: selectedType ?? '',
                                selectedSize: selectedSize ?? '',         // <-- obligatorio
                                selectedModels: widget.selectedModels,  // <-- tu lista de modelos// seguro
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
