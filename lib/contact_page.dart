import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF795548),
        title: const Text('Contáctanos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 350,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Tenangos App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF795548),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '"Conecta con nosotros"\n',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 72, 72),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '📍 Dirección: Calle de los Colores 123, Tenango de Doria, Hidalgo, México.\n\n'
                '📞 Teléfono: +52 771 123 4567\n\n'
                '📧 Correo: contacto@tenangosapp.mx\n\n'
                '🌐 Sitio web: www.tenangosapp.mx\n\n'
                'Síguenos en redes sociales:\n'
                '• Facebook: fb.com/TenangosApp\n'
                '• Instagram: @TenangosApp\n'
                '• TikTok: @TenangosApp',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
