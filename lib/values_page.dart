import 'package:flutter/material.dart';

class ValuesPage extends StatelessWidget {
  const ValuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF795548),
        title: const Text('Nuestros valores'),
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
                '"Lo que nos guía cada día"\n',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 72, 72),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
                  children: [
                    TextSpan(text: '• Respeto por la cultura y las tradiciones.\n'),
                    TextSpan(text: '• Comercio justo y apoyo a comunidades locales.\n'),
                    TextSpan(text: '• Calidad y autenticidad en cada prenda.\n'),
                    TextSpan(text: '• Innovación para conectar lo tradicional con lo moderno.\n'),
                    TextSpan(text: '• Sostenibilidad y producción responsable.\n'),
                    TextSpan(text: '• Pasión por el arte textil y su preservación.\n'),
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
