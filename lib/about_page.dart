import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C4C2F),
        title: const Text('Sobre nosotros'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Espacio para logo o imagen
              Container(
                height: 180, 
                width: 350,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'), // Aquí tu logo
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
                '"Llevando la tradición a tus manos" \n',
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
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'En '),
                    TextSpan(
                      text: 'Tenangos App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ', llevamos el arte textil de la comunidad otomí-tepehua hasta la palma de tu mano. '
                          'Somos una empresa orgullosamente mexicana dedicada a crear prendas únicas —',
                    ),
                    TextSpan(
                      text: 'playeras y pantalones',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '— decoradas con auténticos bordados de Tenango de Doria, Hidalgo.\n\n',
                    ),
                    TextSpan(
                      text:
                          'Cada diseño cuenta una historia: aves, flores, figuras y colores que representan siglos de tradición. '
                          'Trabajamos de la mano con artesanas y artesanos locales para preservar sus técnicas ancestrales '
                          'y brindarles una plataforma moderna para llegar a nuevos clientes.\n\n',
                    ),
                    TextSpan(
                      text:
                          'Nuestra aplicación facilita el pedido de prendas personalizadas, fomentando el ',
                    ),
                    TextSpan(
                      text: 'comercio justo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' y promoviendo la riqueza cultural de nuestra región.',
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
