import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SelectAreasScreen extends StatefulWidget {
  final String selectedType;
  final String selectedSize;
  final List<int> selectedModels;

  const SelectAreasScreen({
    Key? key,
    required this.selectedType,
    required this.selectedSize,
    required this.selectedModels,
  }) : super(key: key);

  @override
  State<SelectAreasScreen> createState() => _SelectAreasScreenState();
}

class _SelectAreasScreenState extends State<SelectAreasScreen> {
  final List<Map<String, dynamic>> prendasPedido = [];
  final Map<int, int> selectedAreas = {};
  final Map<int, String> selectedColors = {};
  int cantidad = 1;

  final int precioModelo = 250;
  final int precioUnitario = 750;

  final List<int> areasDisponibles = [1, 2, 3, 4, 5, 6];
  final List<String> coloresDisponibles = ['Rojo', 'Verde', 'Azul', 'Amarillo', 'Negro'];

  Color _colorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'rojo':
        return Colors.red;
      case 'verde':
        return Colors.green;
      case 'azul':
        return Colors.blue;
      case 'amarillo':
        return Colors.yellow;
      case 'negro':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  // Comprueba si el área ya está asignada a otro modelo (distinto a modelKey)
  bool _isAreaAlreadyUsedByOtherModel(int modelKey, int area) {
    for (var entry in selectedAreas.entries) {
      if (entry.key != modelKey && entry.value == area) return true;
    }
    return false;
  }

  // Valida que todos los modelos tengan área y color y que no haya áreas repetidas
  bool _validarSeleccion() {
    // 1) comprobar que todos los modelos tengan área y color
    for (var model in widget.selectedModels) {
      if (selectedAreas[model] == null || selectedColors[model] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selecciona área y color para el modelo $model')),
        );
        return false;
      }
    }

    // 2) comprobar duplicados de área
    final areasSeleccionadas = selectedAreas.values.toList();
    final areasUnicas = areasSeleccionadas.toSet();
    if (areasSeleccionadas.length != areasUnicas.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se puede elegir la misma área en más de un modelo')),
      );
      return false;
    }

    return true;
  }

  void _agregarPrenda() {
    if (!_validarSeleccion()) return;

    final modelosMap = <String, dynamic>{};
    for (var i = 0; i < widget.selectedModels.length; i++) {
      final m = widget.selectedModels[i];
      modelosMap['modelo_${i + 1}'] = {
        'color': selectedColors[m]!,
        'precio_modelo': precioModelo,
        'ubicacion': selectedAreas[m]!,
      };
    }

    prendasPedido.add({
      'tipo': widget.selectedType,
      'talla': widget.selectedSize,
      'cantidad': cantidad,
      'precio_unitario': precioUnitario,
      'modelos': modelosMap,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prenda agregada al pedido')),
    );

    setState(() {
      // limpiamos las selecciones (si quieres mantener previas, quita el clear)
      selectedAreas.clear();
      selectedColors.clear();
      cantidad = 1;
    });
  }

  Future<void> _guardarPedidoFirestore() async {
    if (prendasPedido.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos una prenda antes de confirmar')),
      );
      return;
    }

    try {
      User? usuario = FirebaseAuth.instance.currentUser;
      if (usuario == null) throw Exception('No hay usuario autenticado.');

      final pedidoDoc = FirebaseFirestore.instance.collection('pedidos').doc();

      await pedidoDoc.set({
        'estatus': 'Pendiente',
        'fecha': FieldValue.serverTimestamp(),
        'total': prendasPedido.fold<num>(0, (sum, p) {
          return sum + ((p['precio_unitario'] as num) * (p['cantidad'] as num));
        }),
        'usuario_email': usuario.email,
        'usuario_id': usuario.uid,
    });

    for (var prenda in prendasPedido) {
      await pedidoDoc.collection('productos').add(prenda);
    }

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pedido guardado en Firestore')),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar el pedido: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9DC),
      appBar: AppBar(
        title: const Text('Seleccionar áreas y colores'),
        backgroundColor: const Color(0xFF8C4C2F),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
               // Imagen de la prenda según el tipo
            Expanded(
              flex: 3,
              child: widget.selectedType.toLowerCase() == 'playera'
                  ? Image.asset('assets/Playerafrente.png', fit: BoxFit.contain)
                  : Center(
                      child: Text(
                        'Opciones para "${widget.selectedType}" no implementadas',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
            ),
            
              const SizedBox(height: 12),

              // Miniaturas de modelos seleccionados (más espaciosas y centradas)
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.selectedModels.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    int modelNum = widget.selectedModels[index];
                    return Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/m$modelNum.jpeg',
                                  width: 100,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('Modelo $modelNum', textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Sección de selección de áreas y colores (scrollable)
              Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    // Para cada modelo, mostramos una tarjeta con dropdowns
                    ...widget.selectedModels.map((model) {
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Modelo $model',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),

                              // Dropdown de ubicación (área)
                              DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'Ubicación',
                                  border: OutlineInputBorder(),
                                ),
                                hint: const Text('Selecciona un área'),
                                value: selectedAreas[model],
                                items: areasDisponibles
                                    .map<DropdownMenuItem<int>>((a) {
                                  final disabled = _isAreaAlreadyUsedByOtherModel(model, a);
                                  return DropdownMenuItem<int>(
                                    value: a,
                                    enabled: !disabled,
                                    child: Text(disabled ? 'Área $a (ocupada)' : 'Área $a'),
                                  );
                                }).toList(),
                                onChanged: (int? v) {
                                  if (v == null) return;
                                  // Previene asignar misma área a otro modelo
                                  if (_isAreaAlreadyUsedByOtherModel(model, v)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Esa área ya está asignada a otro modelo'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  setState(() => selectedAreas[model] = v);
                                },
                              ),

                              const SizedBox(height: 8),

                              // Dropdown de color con cuadrado de color al lado
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Color',
                                  border: OutlineInputBorder(),
                                ),
                                hint: const Text('Selecciona un color'),
                                value: selectedColors[model],
                                items: coloresDisponibles.map<DropdownMenuItem<String>>((c) {
                                  return DropdownMenuItem<String>(
                                    value: c,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: _colorFromName(c),
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.black12),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(c),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? v) {
                                  if (v == null) return;
                                  setState(() => selectedColors[model] = v);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 12),

                    // Cantidad
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      initialValue: cantidad.toString(),
                      onChanged: (v) {
                        int value = int.tryParse(v) ?? 1;
                        if (value < 1) value = 1;
                        if (value > 100) value = 100;
                        setState(() => cantidad = value);
                      },
                    ),

                    const SizedBox(height: 16),

                    // Botones
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _agregarPrenda,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C4C2F),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Agregar otra prenda'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _guardarPedidoFirestore,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Confirmar pedido'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    if (prendasPedido.isNotEmpty) ...[
                      const Text('Resumen de pedido:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 10),
                      ...prendasPedido.map((p) => Text('${p['tipo']} - ${p['talla']} x${p['cantidad']}')),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
