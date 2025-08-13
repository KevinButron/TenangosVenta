import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Modelo de Pedido
class Pedido {
  final String id;
  final String cliente;
  final String producto;
  final int cantidad;
  final double total;
  final DateTime fecha;
  final String estado;

  Pedido({
    required this.id,
    required this.cliente,
    required this.producto,
    required this.cantidad,
    required this.total,
    required this.fecha,
    required this.estado,
  });

  factory Pedido.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pedido(
      id: doc.id,
      cliente: data['cliente'] ?? '',
      producto: data['producto'] ?? '',
      cantidad: data['cantidad'] ?? 0,
      total: (data['total'] ?? 0).toDouble(),
      fecha: (data['fecha'] as Timestamp).toDate(),
      estado: data['estado'] ?? 'Pendiente',
    );
  }
}

class AdminPedidosPage extends StatelessWidget {
  AdminPedidosPage({super.key});

  final CollectionReference pedidosRef =
      FirebaseFirestore.instance.collection('pedidos');

  void _cambiarEstado(String pedidoId, String nuevoEstado) {
    FirebaseFirestore.instance
        .collection('pedidos')
        .doc(pedidoId)
        .update({'estado': nuevoEstado});
  }

  // Placeholder para cerrar sesión
  void _logout(BuildContext context) {
    // Aquí implementas la lógica de cerrar sesión
    Navigator.pop(context); // ejemplo simple: regresa a la pantalla anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pedidos del Administrador",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF795548),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: pedidosRef.orderBy('fecha', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay pedidos"));
          }

          final pedidos = snapshot.data!.docs
              .map((doc) => Pedido.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: ${pedido.id}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("Cliente: ${pedido.cliente}"),
                      Text("Producto: ${pedido.producto}"),
                      Text("Cantidad: ${pedido.cantidad}"),
                      Text("Total: \$${pedido.total.toStringAsFixed(2)}"),
                      Text(
                          "Fecha: ${pedido.fecha.toLocal().toString().split(' ')[0]}"),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text("Estado: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: pedido.estado == "Pendiente"
                                  ? Colors.orange
                                  : pedido.estado == "Enviado"
                                      ? Colors.green
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              pedido.estado,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (pedido.estado == "Pendiente")
                            ElevatedButton(
                              onPressed: () =>
                                  _cambiarEstado(pedido.id, "Enviado"),
                              child: const Text("Marcar Enviado"),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
