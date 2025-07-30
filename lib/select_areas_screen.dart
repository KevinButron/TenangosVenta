import 'package:flutter/material.dart';

class SelectAreasScreen extends StatefulWidget {
  final List<int> selectedModels;
  final String selectedType; // Playera o Pantalón

  SelectAreasScreen({required this.selectedModels, required this.selectedType});

  @override
  _SelectAreasScreenState createState() => _SelectAreasScreenState();
}

class _SelectAreasScreenState extends State<SelectAreasScreen> {
  final List<int> availableAreas = List.generate(6, (index) => index + 1);
  List<int> selectedAreas = [];

  void _onAreaToggle(int area, bool? value) {
    setState(() {
      if (value == true) {
        if (selectedAreas.length >= 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Solo puedes seleccionar un máximo de 3 áreas'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        if (!selectedAreas.contains(area)) selectedAreas.add(area);
      } else {
        selectedAreas.remove(area);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona las áreas a tu gusto'),
        backgroundColor: const Color(0xFF8C4C2F),
      ),
      backgroundColor: const Color(0xFFF3E9DC),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (widget.selectedType.toLowerCase() == 'playera') ...[
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Image.asset('assets/Playerafrente.png', fit: BoxFit.contain),
                    )
                  ],
                ),
              ),
            ] else
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    'Opciones para "${widget.selectedType}" no implementadas',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Miniaturas modelos seleccionados
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.selectedModels.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  int modelNum = widget.selectedModels[index];
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/m$modelNum.jpeg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Modelo $modelNum'),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Lista de áreas con Checkbox
            Expanded(
              flex: 2,
              child: ListView(
                children: availableAreas.map((area) {
                  return CheckboxListTile(
                    title: Text('Área $area'),
                    value: selectedAreas.contains(area),
                    onChanged: (value) => _onAreaToggle(area, value),
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
