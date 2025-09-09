import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tab = 0;

  // Datos simples
  final List<String> titles = [
    'Latest',
    'Selección expertos',
    'Halloween Sonidos & Tonos',
    'Navidad',
    'Hip Hop',
    'Tonos japoneses',
    'Alarmas',
  ];
  final List<int> counts = [15, 57, 55, 40, 30, 30, 25];

  @override
  Widget build(BuildContext context) {
    // 3 pantallas muy básicas
    final pages = [
      _buildHomeList(),
      _simplePage('Buscar'),
      _simplePage('Favoritos'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _simpleDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Tonos de llamada',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: pages[_tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  // LISTA PRINCIPAL (scroll vertical)
  Widget _buildHomeList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: titles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final title = titles[index];
        final count = counts[index];

        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Cuadrado con color sólido (simple)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors
                        .primaries[index % Colors.primaries.length]
                        .shade400,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 14),
                // Título y subtítulo
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$count tonos',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Flecha dentro de círculo (fácil)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26, width: 1.2),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Páginas de relleno
  Widget _simplePage(String text) {
    return Center(child: Text(text, style: const TextStyle(fontSize: 18)));
  }

  // Drawer básico
  Drawer _simpleDrawer() {
    return const Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Acerca de'),
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text('Ajustes'),
            ),
          ],
        ),
      ),
    );
  }
}
