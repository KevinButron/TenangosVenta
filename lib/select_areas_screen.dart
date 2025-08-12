import 'package:flutter/material.dart';

class SelectAreasScreen extends StatefulWidget {
  final List<int> selectedModels;
  final String selectedType; // Playera o Pantalón

  const SelectAreasScreen({
    Key? key,
    required this.selectedModels,
    required this.selectedType,
  }) : super(key: key);

  @override
  _SelectAreasScreenState createState() => _SelectAreasScreenState();
}

class _SelectAreasScreenState extends State<SelectAreasScreen> {
  final List<int> availableAreas = List.generate(6, (index) => index + 1);

  // Mapa de área -> modelo asignado
  Map<int, int> selectedAreaModels = {};

  void _onAreaToggle(int area, bool? value) {
    setState(() {
      if (value == true) {
        if (selectedAreaModels.length >= 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Solo puedes seleccionar un máximo de 3 áreas'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        if (!selectedAreaModels.containsKey(area)) {
          selectedAreaModels[area] = widget.selectedModels.first;
        }
      } else {
        selectedAreaModels.remove(area);
      }
    });
  }

  void _onModelSelectedForArea(int area, int? model) {
    if (model == null) return;
    setState(() {
      selectedAreaModels[area] = model;
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
                child: Image.asset(
                  'assets/Playerafrente.png',
                  fit: BoxFit.contain,
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
            // Lista de áreas con checkbox y dropdown para asignar modelo
            Expanded(
              flex: 3,
              child: ListView(
                children: availableAreas.map((area) {
                  bool isSelected = selectedAreaModels.containsKey(area);
                  int? modeloAsignado = selectedAreaModels[area];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: Text('Área $area'),
                        value: isSelected,
                        onChanged: (value) => _onAreaToggle(area, value),
                      ),
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 12),
                          child: DropdownButton<int>(
                            value: modeloAsignado,
                            onChanged: (model) =>
                                _onModelSelectedForArea(area, model),
                            items: widget.selectedModels.map((modelNum) {
                              return DropdownMenuItem<int>(
                                value: modelNum,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/m$modelNum.jpeg',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 8),
                                    Text('Modelo $modelNum'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
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
