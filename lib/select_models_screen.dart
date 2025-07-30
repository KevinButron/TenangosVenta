import 'package:flutter/material.dart';
import 'order_details_screen.dart';  // Nueva pantalla para detalles de pedido

class SelectModelsScreen extends StatefulWidget {
  @override
  _SelectModelsScreenState createState() => _SelectModelsScreenState();
}

class _SelectModelsScreenState extends State<SelectModelsScreen> {
  List<bool> selectedModels = List.generate(10, (_) => false);

  void _onModelToggle(int index, bool? value) {
    int selectedCount = selectedModels.where((e) => e).length;

    if (value == true && selectedCount >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Solo puedes seleccionar hasta 3 modelos."),
        ),
      );
      return;
    }

    setState(() {
      selectedModels[index] = value ?? false;
    });
  }

  void _showModelDetails(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/m${index + 1}.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Modelo ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('\$250', style: TextStyle(fontSize: 16, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = selectedModels.contains(true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elije tu diseño (Máximo 3)'),
        backgroundColor: const Color(0xFF8C4C2F),
      ),
      backgroundColor: const Color(0xFFF3E9DC),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showModelDetails(index),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              'assets/m${index + 1}.jpeg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Modelo ${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Text(
                          '\$250',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        Checkbox(
                          value: selectedModels[index],
                          onChanged: (value) => _onModelToggle(index, value),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      List<int> selectedIndexes = [];
                      for (int i = 0; i < selectedModels.length; i++) {
                        if (selectedModels[i]) selectedIndexes.add(i + 1);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(selectedModels: selectedIndexes),
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
    );
  }
}
