import 'package:flutter/material.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF795548),
        title: const Text('Nuestra misión'),
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
                  color: Color(0xFF8C4C2F),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '"Tradición y comercio justo"\n',
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
                    TextSpan(text: 'Nuestra misión en '),
                    TextSpan(
                      text: 'Tenangos App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' es conectar la tradición artesanal de Tenango de Doria con el mundo moderno, '
                          'ofreciendo prendas únicas y de alta calidad, mientras impulsamos el trabajo justo y sostenible '
                          'de las y los artesanos.\n\n',
                    ),
                    TextSpan(
                      text:
                          'Buscamos que cada cliente no solo adquiera una prenda, sino que lleve consigo una pieza de historia, '
                          'cultura y amor por México.',
                    ),
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
