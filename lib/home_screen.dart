import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import 'catalog_screen.dart';
import 'models_screen.dart';
import 'select_models_screen.dart';


import 'about_page.dart';
import 'mission_page.dart';
import 'vision_page.dart';
import 'values_page.dart';
import 'contact_page.dart';


class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({Key? key, required this.name}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cerrar sesión: ${e.toString()}'),
          backgroundColor: const Color(0xFFD32F2F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Color textColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: color.withOpacity(0.3), width: 2),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        splashColor: color.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 30, color: color),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Paleta de colores inspirada en Tenangos mexicanos
    const Color rojoTenango = Color(0xFFE53935);
    const Color azulTenango = Color(0xFF1E88E5);
    const Color amarilloTenango = Color(0xFFFFD600);
    const Color moradoTenango = Color(0xFF8E24AA);
    const Color fondoClaro = Color(0xFFF5F5F5);
    const Color textoOscuro = Color(0xFF212121);

    return Scaffold(
      backgroundColor: fondoClaro,

      // 📌 Aquí añadimos el menú lateral
      drawer: Drawer(
        backgroundColor: const Color(0xFFF3E9DC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF795548),
              ),
              child: const Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF795548)),
              title: const Text('Sobre nosotros'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag, color: Color(0xFF795548)),
              title: const Text('Nuestra misión'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MissionPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility, color: Color(0xFF795548)),
              title: const Text('Nuestra visión'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VisionPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Color(0xFF795548)),
              title: const Text('Nuestros valores'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ValuesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Color(0xFF795548)),
              title: const Text('Contáctanos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactPage()),
                );
              },
            ),
          ],
        ),
      ),
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF795548), // Café
            elevation: 8,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Tenangos App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Container(color: const Color(0xFF795548)),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                tooltip: 'Cerrar sesión',
                onPressed: () => _logout(context),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              40,
            ), // Ajusté el padding superior
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  '¡Bienvenid@, $name!',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // ← Negro
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explora nuestra artesanía tradicional',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(
                      0.7,
                    ), // ← Negro con opacidad
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ), // Reduje el espacio antes de los botones
                // Botones principales
                _buildButton(
                  text: 'Nuestro Catálogo Completo',
                  icon: Icons.art_track,
                  color: rojoTenango,
                  textColor: textoOscuro,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CatalogScreen()),
                    );
                  },
                ),
                _buildButton(
                  text: 'Modelos Tradicionales',
                  icon: Icons.style,
                  color: azulTenango,
                  textColor: textoOscuro,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ModelsScreen()),
                    );
                  },
                ),
                _buildButton(
                  text: 'Personaliza tu Tenango',
                  icon: Icons.brush,
                  color: amarilloTenango,
                  textColor: textoOscuro,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SelectModelsScreen()),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
          border: Border(top: BorderSide(color: rojoTenango.withOpacity(0.2))),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Artesanía Mexicana de Corazón',
                style: TextStyle(
                  color: moradoTenango,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '© 2025 Tenangos Auténticos',
                style: TextStyle(
                  color: textoOscuro.withOpacity(0.6),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
