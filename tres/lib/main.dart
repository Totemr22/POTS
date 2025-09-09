import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify UI Mock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SpotifyHomePage(),
    );
  }
}

/// Altura del mini-player (para dejar espacio al hacer scroll)
const double kMiniPlayerHeight = 70;

class SpotifyHomePage extends StatelessWidget {
  const SpotifyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App “a pantalla completa” con SliverAppBar colapsable
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 140,
                backgroundColor: const Color(0xFF121212),
                elevation: 0,
                titleSpacing: 0,
                leadingWidth: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: _HeaderGradient(
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.settings_outlined),
                                  tooltip: 'Ajustes',
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '¡Buenas noches!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // GRID de 2 columnas (tarjetas tipo “rápido acceso”)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.9, // rectangular como en Spotify
                  ),
                  delegate: SliverChildListDelegate.fixed([
                    for (final title in [
                      'classic soul',
                      'Radar de\nNovedades',
                      'Descubrimiento\nsemanal',
                      'Country Rock',
                      'James Morrison',
                      'Clarence "Frogman"\n…',
                    ])
                      _QuickCard(title: title),
                  ]),
                ),
              ),

              // Sección “Vuelve a...”
              const _SectionHeader(title: 'Vuelve a...'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 190,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _AlbumCard(
                        title: 'Álbum ${index + 1}',
                        subtitle: 'Artista ${index + 1}',
                      );
                    },
                  ),
                ),
              ),

              // Otra sección horizontal (opcional, para que tengas más scroll)
              const _SectionHeader(title: 'Recomendados para ti'),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 190,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _AlbumCard(
                        title: 'Playlist ${index + 1}',
                        subtitle: 'Mezcla diaria',
                      );
                    },
                  ),
                ),
              ),

              // “Colchón” para que el contenido no quede oculto tras el mini-player + nav
              SliverToBoxAdapter(
                child: SizedBox(height: kMiniPlayerHeight + 72),
              ),
            ],
          ),

          // Mini-player fijo (como la banda inferior de Spotify)
          Align(alignment: Alignment.bottomCenter, child: _MiniPlayer()),
        ],
      ),

      // Barra de navegación inferior
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: const Color(0xFF181818),
        indicatorColor: Colors.white10,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            label: 'Tu biblioteca',
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (_) {},
      ),
    );
  }
}

class _HeaderGradient extends StatelessWidget {
  final Widget child;
  const _HeaderGradient({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A1B33), // violeta oscuro arriba
            Color(0x00121212), // se funde con el fondo
          ],
        ),
      ),
      child: child,
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String title;
  const _QuickCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // “Cover” cuadrado a la izquierda
            Container(
              width: 56,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
              ),
              child: const Icon(Icons.album, size: 26, color: Colors.black87),
            ),
            const SizedBox(width: 10),
            // Título (puede tener dos líneas como en tu screenshot)
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _AlbumCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // “Portada”
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade800,
                child: const Icon(
                  Icons.library_music,
                  size: 38,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F1F1F),
      elevation: 8,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: kMiniPlayerHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              // cover mini
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.grey.shade700,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.album,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // título + dispositivos disponibles
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drinkin’ Problem - Midland',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Dispositivos disponibles',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                tooltip: 'Me gusta',
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                tooltip: 'Reproducir',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
