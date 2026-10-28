import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brass = Color(0xFFD4B47A);
    const red = Color(0xFFB63B32);

    return MaterialApp(
      title: 'Data-Pulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF100B0B),
        colorScheme: const ColorScheme.dark(
          primary: brass,
          secondary: red,
          surface: Color(0xFF211211),
          onSurface: Color(0xFFE5D7C5),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF170D0D),
          foregroundColor: Color(0xFFE5D7C5),
          centerTitle: false,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A0B0B),
          selectedItemColor: Color(0xFFE7C7A7),
          unselectedItemColor: Color(0xFF92776B),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedIconTheme: IconThemeData(size: 26),
          unselectedIconTheme: IconThemeData(size: 23),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),
      ),
      home: const NoosphericHomePage(),
    );
  }
}

class NoosphericHomePage extends StatefulWidget {
  const NoosphericHomePage({super.key});

  @override
  State<NoosphericHomePage> createState() => _NoosphericHomePageState();
}

class _NoosphericHomePageState extends State<NoosphericHomePage> {
  static const _brass = Color(0xFFD4B47A);
  static const _muted = Color(0xFFB09A8E);

  int _selectedIndex = 0;
  String _query = '';

  static const _people = <_Person>[
    _Person(
      'Magos Dominus',
      'Belisarius Cawl',
      'Mars · Forja de hierro',
      'ACTIVO',
      Icons.memory,
      Color(0xFF7C3A2D),
    ),
    _Person(
      'Secutor',
      'Delta-9 Voss',
      'Sector Metalica · Legio',
      'EN LÍNEA',
      Icons.shield_outlined,
      Color(0xFF485846),
    ),
    _Person(
      'Tecnosacerdotisa',
      'Lexmechanic Rho',
      'Noctis Labyrinthus',
      'ACTIVO',
      Icons.science_outlined,
      Color(0xFF63543B),
    ),
    _Person(
      'Skitaari',
      'Kastelan-17',
      'Cohorte de exploración',
      'AUSENTE',
      Icons.precision_manufacturing,
      Color(0xFF494D4A),
    ),
    _Person(
      'Enginseer',
      'Mira-Omicron',
      'Forja de Ryza · Taller',
      'EN LÍNEA',
      Icons.settings,
      Color(0xFF75412E),
    ),
  ];

  static const _chats = <_Conversation>[
    _Conversation(
      'Lexmechanic Rho',
      'Los datos del STC han sido purgados.',
      '09:41',
      2,
      Icons.science_outlined,
      Color(0xFF63543B),
    ),
    _Conversation(
      'Delta-9 Voss',
      'Unidad de reconocimiento desplegada.',
      '08:16',
      0,
      Icons.shield_outlined,
      Color(0xFF485846),
    ),
    _Conversation(
      'Mira-Omicron',
      'Ave Omnissiah. Solicito calibración.',
      'Ayer',
      1,
      Icons.settings,
      Color(0xFF75412E),
    ),
    _Conversation(
      'Cohorte Skitaari',
      'El perímetro está asegurado.',
      'Ayer',
      0,
      Icons.groups_outlined,
      Color(0xFF494D4A),
    ),
    _Conversation(
      'Magos Dominus',
      'Que el conocimiento perdure.',
      'Lun',
      0,
      Icons.memory,
      Color(0xFF7C3A2D),
    ),
  ];

  static const _calls = <_CallRecord>[
    _CallRecord(
      'Delta-9 Voss',
      'Entrante · 12 min',
      'Hoy, 08:32',
      Icons.call_received,
      Color(0xFF485846),
    ),
    _CallRecord(
      'Mira-Omicron',
      'Saliente · 4 min',
      'Ayer, 19:06',
      Icons.call_made,
      Color(0xFF75412E),
    ),
    _CallRecord(
      'Lexmechanic Rho',
      'Llamada perdida',
      'Ayer, 14:21',
      Icons.call_missed,
      Color(0xFF63543B),
      missed: true,
    ),
    _CallRecord(
      'Cohorte Skitaari',
      'Entrante · 28 min',
      '28 Oct, 11:04',
      Icons.call_received,
      Color(0xFF494D4A),
    ),
  ];

  static const _titles = ['Peoples', 'Chats', 'Calls'];
  static const _subtitles = [
    'DIRECTORIO DEL ADEPTUS MECHANICUS',
    'TRANSMISIONES NOOSFÉRICAS',
    'REGISTRO DE COMUNICACIONES',
  ];

  void _showNotice(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF30352F),
        ),
      );
  }

  List<T> _filter<T>(List<T> items, String Function(T) label) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items
        .where((item) => label(item).toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF130B0A),
              border: Border.all(color: const Color(0xFF6D3427), width: 2),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x663B100D),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Color(0xFF080606),
                  blurRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildConsoleHeader(),
                const _RedDivider(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 740) {
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 6,
                                child: _buildContentPanel(compact: false),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(flex: 4, child: _TerminalPanel()),
                            ],
                          ),
                        );
                      }
                      return _buildContentPanel(compact: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A0B0B),
          border: Border(top: BorderSide(color: Color(0xFF7E372C), width: 2)),
          boxShadow: [
            BoxShadow(
              color: Color(0xAA080606),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _query = '';
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Peoples',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              activeIcon: Icon(Icons.call),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsoleHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 9),
      child: Row(
        children: [
          const _MechanicusMark(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'DATA-PULSE: NOOSPHERIC LINK',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE3CFB4),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'MARS · CANAL SEGURO · ${_titles[_selectedIndex].toUpperCase()} [CLASSIFIED]',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    letterSpacing: .3,
                    color: _muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Estado de conexión',
            visualDensity: VisualDensity.compact,
            onPressed: () =>
                _showNotice('Enlace noosférico seguro · Señal 98%'),
            icon: const Icon(
              Icons.wifi_tethering,
              color: Color(0xFF83B66D),
              size: 20,
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF6CC65D),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0xFF3B8E3B), blurRadius: 6)],
            ),
          ),
          const SizedBox(width: 9),
        ],
      ),
    );
  }

  Widget _buildContentPanel({required bool compact}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A0E0D),
        border: Border.all(color: const Color(0xFF71372D), width: 1.5),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xAA080606),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          const _RedDivider(inset: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
            child: _buildSearchField(),
          ),
          if (compact) const _TerminalPanel(compact: true),
          Expanded(child: _buildSelectedList()),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      height: 42,
      child: TextField(
        key: const Key('directory-search'),
        onChanged: (value) => setState(() => _query = value),
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFE6D8C8),
        ),
        decoration: InputDecoration(
          hintText: 'SEARCH ARCHIVE...',
          hintStyle: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF9A7467),
            fontSize: 11,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFFD7765A),
            size: 19,
          ),
          suffixIcon: _query.isEmpty
              ? const Icon(Icons.tune, color: Color(0xFF9A7467), size: 17)
              : IconButton(
                  tooltip: 'Limpiar búsqueda',
                  onPressed: () {
                    setState(() => _query = '');
                  },
                  icon: const Icon(Icons.close, size: 17),
                ),
          filled: true,
          fillColor: const Color(0xFF120A09),
          contentPadding: const EdgeInsets.symmetric(vertical: 9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Color(0xFF603128)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Color(0xFF603128)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(color: Color(0xFFC34D3C), width: 1.2),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    final count = switch (_selectedIndex) {
      0 => _filter(
        _people,
        (person) => '${person.name} ${person.role} ${person.location}',
      ).length,
      1 => _filter(_chats, (chat) => '${chat.name} ${chat.message}').length,
      _ => _filter(_calls, (call) => '${call.name} ${call.detail}').length,
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _subtitles[_selectedIndex],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 8,
                    letterSpacing: .5,
                    color: Color(0xFFD67859),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _titles[_selectedIndex],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .3,
                    color: Color(0xFFE1D1BE),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF381713),
              border: Border.all(color: const Color(0xFF804034)),
            ),
            child: Text(
              '$count FILES',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 8,
                letterSpacing: .5,
                color: Color(0xFFE7B69A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedList() {
    switch (_selectedIndex) {
      case 0:
        final people = _filter(
          _people,
          (person) => '${person.name} ${person.role} ${person.location}',
        );
        if (people.isEmpty) return _emptyState();
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: people.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _personTile(people[index]),
        );
      case 1:
        final chats = _filter(_chats, (chat) => '${chat.name} ${chat.message}');
        if (chats.isEmpty) return _emptyState();
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: chats.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _chatTile(chats[index]),
        );
      default:
        final calls = _filter(_calls, (call) => '${call.name} ${call.detail}');
        if (calls.isEmpty) return _emptyState();
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: calls.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _callTile(calls[index]),
        );
    }
  }

  Widget _personTile(_Person person) {
    return _DataCard(
      child: Row(
        children: [
          _UnitAvatar(
            initials: person.initials,
            color: person.color,
            icon: person.icon,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  person.role,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
                const SizedBox(height: 6),
                Text(
                  person.location,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF777B72),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _StatusLabel(person.status),
              const SizedBox(height: 10),
              _RoundAction(
                icon: Icons.call_outlined,
                label: 'Llamar a ${person.name}',
                onPressed: () => _showNotice(
                  'Iniciando llamada simulada con ${person.name}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chatTile(_Conversation chat) {
    return _DataCard(
      onTap: () => _showNotice('Abriendo transmisión con ${chat.name}'),
      child: Row(
        children: [
          _UnitAvatar(
            initials: chat.initials,
            color: chat.color,
            icon: chat.icon,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  chat.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat.time,
                style: const TextStyle(fontSize: 10, color: _muted),
              ),
              const SizedBox(height: 9),
              if (chat.unread > 0)
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 19,
                    minHeight: 19,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF9E3029),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${chat.unread}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                const Icon(Icons.done_all, size: 15, color: _brass),
            ],
          ),
        ],
      ),
    );
  }

  Widget _callTile(_CallRecord call) {
    final callColor = call.missed ? const Color(0xFFD05A4E) : _muted;
    return _DataCard(
      child: Row(
        children: [
          _UnitAvatar(
            initials: call.initials,
            color: call.color,
            icon: Icons.person_outline,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(call.directionIcon, size: 14, color: callColor),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        call.detail,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: callColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                call.time,
                style: const TextStyle(fontSize: 10, color: _muted),
              ),
              const SizedBox(height: 8),
              _RoundAction(
                icon: Icons.call_outlined,
                label: 'Devolver llamada a ${call.name}',
                onPressed: () =>
                    _showNotice('Devolviendo llamada a ${call.name}'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 42, color: Color(0xFF696D64)),
            const SizedBox(height: 12),
            const Text(
              'NINGÚN REGISTRO ENCONTRADO',
              style: TextStyle(fontSize: 11, letterSpacing: 1.3, color: _muted),
            ),
            const SizedBox(height: 5),
            Text(
              'Prueba otra búsqueda, acólito.',
              style: TextStyle(
                fontSize: 12,
                color: _muted.withValues(alpha: .75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MechanicusMark extends StatelessWidget {
  const _MechanicusMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF391714),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFB36B3F), width: 1.5),
        boxShadow: const [BoxShadow(color: Color(0x55390E0B), blurRadius: 8)],
      ),
      child: const Icon(Icons.memory, size: 22, color: Color(0xFFE1C38B)),
    );
  }
}

class _RedDivider extends StatelessWidget {
  const _RedDivider({this.inset = 0});

  final double inset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: inset),
      child: Container(
        height: 1,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x004A1714),
              Color(0xFF9A4435),
              Color(0xFFD57958),
              Color(0xFF9A4435),
              Color(0x004A1714),
            ],
          ),
          boxShadow: [BoxShadow(color: Color(0x883F100D), blurRadius: 5)],
        ),
      ),
    );
  }
}

class _TerminalPanel extends StatelessWidget {
  const _TerminalPanel({this.compact = false});

  final bool compact;

  static const _green = Color(0xFF8DA76D);
  static const _red = Color(0xFFD26C55);
  static const _terminalTextStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 10,
    height: 1.65,
  );

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        height: 64,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF100A09),
          border: Border.all(color: const Color(0xFF552922)),
        ),
        child: const Row(
          children: [
            Icon(Icons.terminal, size: 18, color: Color(0xFFD57958)),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FLUTTER 5.0K / DART LANG / NOOSPHERE v0.9',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: Color(0xFFD57958),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'STATUS: ENCRYPTED  ·  SIGNAL: 98%  ·  ONLINE',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: _green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF100A09),
        border: Border.all(color: const Color(0xFF71372D), width: 1.5),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xAA080606),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF27110F),
              border: Border(bottom: BorderSide(color: Color(0xFF643027))),
            ),
            child: const Row(
              children: [
                Icon(Icons.terminal, size: 16, color: _red),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'FLUTTER 5.0K / DART LANG',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: Color(0xFFE0C7AD),
                    ),
                  ),
                ),
                Text(
                  'v0.9',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: _green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '> noosphere.connect()',
                  style: _terminalTextStyle.copyWith(color: _red),
                ),
                Text(
                  '> auth: omnissiah_eye',
                  style: _terminalTextStyle.copyWith(color: Color(0xFFD9A16C)),
                ),
                SizedBox(height: 8),
                Text(
                  'STATUS: key accepted',
                  style: _terminalTextStyle.copyWith(color: _green),
                ),
                Text(
                  'STATUS: data stream secured',
                  style: _terminalTextStyle.copyWith(color: _green),
                ),
                Text(
                  'STATUS: relay online',
                  style: _terminalTextStyle.copyWith(color: _green),
                ),
                SizedBox(height: 8),
                Text(
                  '// the machine spirit endures',
                  style: _terminalTextStyle.copyWith(color: Color(0xFF9D7463)),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Container(
              height: 112,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B0E0C),
                border: Border.all(color: const Color(0xFF50271F)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+++ INQUISITORIAL UPLINK +++',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: _red,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'NOOSPHERIC SIGNAL: 98%',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: Color(0xFFD6C7AE),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'MARS FORGE // SECURE',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: _green,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PRAISE THE OMNISSIAH',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9,
                      color: Color(0xFFB59B66),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF260F0E),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFF5C2A24)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x44080000),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF9F4435),
                  boxShadow: [
                    BoxShadow(color: Color(0x553E100D), blurRadius: 4),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnitAvatar extends StatelessWidget {
  const _UnitAvatar({
    required this.initials,
    required this.color,
    required this.icon,
  });

  final String initials;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF120B0A),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: const Color(0xFF805247)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              initials,
              style: const TextStyle(
                color: Color(0xFFD5C4AE),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 2),
            Icon(icon, size: 10, color: color),
          ],
        ),
      ),
    );
  }
}

class _StatusLabel extends StatelessWidget {
  const _StatusLabel(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    final isAway = status == 'AUSENTE';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isAway ? const Color(0xFF8D796E) : const Color(0xFF83B66D),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          status,
          style: const TextStyle(
            fontSize: 8,
            letterSpacing: .7,
            color: _NoosphericHomePageState._muted,
          ),
        ),
      ],
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        tooltip: label,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          foregroundColor: const Color(0xFFE3B483),
          backgroundColor: const Color(0xFF351713),
          side: const BorderSide(color: Color(0xFF784033)),
        ),
        icon: Icon(icon, size: 16),
      ),
    );
  }
}

class _Person {
  const _Person(
    this.role,
    this.name,
    this.location,
    this.status,
    this.icon,
    this.color,
  );

  final String role;
  final String name;
  final String location;
  final String status;
  final IconData icon;
  final Color color;

  String get initials =>
      name.split(' ').map((part) => part[0]).take(2).join().toUpperCase();
}

class _Conversation {
  const _Conversation(
    this.name,
    this.message,
    this.time,
    this.unread,
    this.icon,
    this.color,
  );

  final String name;
  final String message;
  final String time;
  final int unread;
  final IconData icon;
  final Color color;

  String get initials =>
      name.split(' ').map((part) => part[0]).take(2).join().toUpperCase();
}

class _CallRecord {
  const _CallRecord(
    this.name,
    this.detail,
    this.time,
    this.directionIcon,
    this.color, {
    this.missed = false,
  });

  final String name;
  final String detail;
  final String time;
  final IconData directionIcon;
  final Color color;
  final bool missed;

  String get initials =>
      name.split(' ').map((part) => part[0]).take(2).join().toUpperCase();
}
