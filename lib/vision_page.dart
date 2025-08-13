import 'package:flutter/material.dart';

class VisionPage extends StatelessWidget {
  const VisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF795548),
        title: const Text('Nuestra visión'),
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
                '"Arte tradicional con mirada al futuro"\n',
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
                    TextSpan(text: 'Nuestra visión es convertirnos en la principal plataforma digital para la venta de prendas con bordados '
                        'tradicionales en México, reconocida por su compromiso con la calidad, la autenticidad y el impacto social.\n\n'),
                    TextSpan(text: 'Queremos que el arte textil de Tenango sea apreciado en cada rincón del mundo, y que nuestras prendas '
                        'representen un puente entre el pasado y el futuro.'),
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
