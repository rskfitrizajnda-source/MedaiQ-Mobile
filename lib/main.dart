import 'package:flutter/material.dart';

const brand = Color(0xFF087F8C);
const ink = Color(0xFF16313B);
const muted = Color(0xFF71838A);
const canvas = Color(0xFFF4F8F9);

void main() => runApp(const MediQApp());

class MediQApp extends StatelessWidget {
  const MediQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas, foregroundColor: ink, elevation: 0,
          centerTitle: false, surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2EAEC))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE2EAEC))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: brand, width: 1.5)),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;
  bool hasQueue = false;
  String clinic = 'Klinik Sehat Sentosa';
  String service = 'Pemeriksaan umum';

  void bookQueue() {
    setState(() { hasQueue = true; index = 1; });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Antrean contoh dibuat. Hubungkan API untuk pendaftaran nyata.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onBook: () => setState(() => index = 1), onChooseClinic: (value) => setState(() => clinic = value)),
      QueuePage(hasQueue: hasQueue, clinic: clinic, service: service, onBook: bookQueue, onCancel: () => setState(() => hasQueue = false)),
      const ProfilePage(),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDF3F2),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), selectedIcon: Icon(Icons.confirmation_number), label: 'Antrean'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onBook;
  final ValueChanged<String> onChooseClinic;
  const HomePage({super.key, required this.onBook, required this.onChooseClinic});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverPadding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 28), sliver: SliverList(delegate: SliverChildListDelegate([
        Row(children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: brand, borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.health_and_safety_rounded, color: Colors.white, size: 28)),
          const SizedBox(width: 11),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MediQ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: ink)),
            Text('Layanan kesehatan lebih mudah', style: TextStyle(fontSize: 12, color: muted)),
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, color: ink)),
        ]),
        const SizedBox(height: 24),
        Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF087F8C), Color(0xFF19A6A0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: .18), borderRadius: BorderRadius.circular(20)),
              child: const Text('SEHAT DIMULAI DI SINI', style: TextStyle(color: Colors.white, fontSize: 10, letterSpacing: 1.1, fontWeight: FontWeight.bold))),
            const SizedBox(height: 15),
            const Text('Tak perlu lama\nmenunggu antrean.', style: TextStyle(color: Colors.white, fontSize: 26, height: 1.15, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            const Text('Pilih layanan klinik dan rencanakan kunjunganmu dengan praktis.', style: TextStyle(color: Colors.white, height: 1.45, fontSize: 13)),
            const SizedBox(height: 20),
            FilledButton.icon(onPressed: onBook, icon: const Icon(Icons.calendar_month_rounded, size: 18),
              label: const Text('Ambil antrean'), style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: brand,
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14))),
          ]),
        ),
        const SizedBox(height: 27),
        const SectionHeading(title: 'Akses cepat', subtitle: 'Semua yang kamu butuhkan'),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: QuickCard(icon: Icons.confirmation_number_outlined, title: 'Antrean saya', subtitle: 'Lihat status', onTap: onBook)),
          const SizedBox(width: 12),
          Expanded(child: QuickCard(icon: Icons.medical_services_outlined, title: 'Layanan', subtitle: 'Pilih pemeriksaan', onTap: onBook)),
        ]),
        const SizedBox(height: 27),
        const SectionHeading(title: 'Klinik pilihan', subtitle: 'Temukan layanan kesehatan'),
        const SizedBox(height: 14),
        ClinicCard(name: 'Klinik Sehat Sentosa', category: 'Umum • Pemeriksaan kesehatan', distance: 'Buka untuk pendaftaran', icon: Icons.local_hospital_rounded,
          onTap: () { onChooseClinic('Klinik Sehat Sentosa'); onBook(); }),
        const SizedBox(height: 12),
        ClinicCard(name: 'Klinik Medika Prima', category: 'Umum • Konsultasi dokter', distance: 'Lihat detail klinik', icon: Icons.health_and_safety_rounded,
          onTap: () { onChooseClinic('Klinik Medika Prima'); onBook(); }),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFE7F4F3), borderRadius: BorderRadius.circular(16)),
          child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.info_outline, color: brand), SizedBox(width: 10),
            Expanded(child: Text('Mode pratinjau: data klinik dan antrean pada layar ini masih contoh, belum terhubung ke server MediQ.', style: TextStyle(color: ink, fontSize: 12, height: 1.45))),
          ])),
      ]))),
    ]);
  }
}

class QueuePage extends StatefulWidget {
  final bool hasQueue;
  final String clinic;
  final String service;
  final VoidCallback onBook;
  final VoidCallback onCancel;
  const QueuePage({super.key, required this.hasQueue, required this.clinic, required this.service, required this.onBook, required this.onCancel});
  @override
  State<QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  String selectedService = 'Pemeriksaan umum';
  final services = const ['Pemeriksaan umum', 'Konsultasi dokter', 'Pemeriksaan kesehatan'];
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 28), children: [
      const Text('Antrean', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 6),
      const Text('Daftar kunjungan dan pantau antreanmu.', style: TextStyle(color: muted)),
      const SizedBox(height: 24),
      if (widget.hasQueue) ...[
        Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFE2EAEC))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Icon(Icons.check_circle, color: brand), const SizedBox(width: 8), const Text('Antrean terdaftar (contoh)', style: TextStyle(color: brand, fontWeight: FontWeight.w700))]),
            const SizedBox(height: 20),
            const Text('A-012', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: ink)),
            const Text('Nomor antrean contoh', style: TextStyle(color: muted)),
            const Divider(height: 30),
            InfoRow(label: 'Klinik', value: widget.clinic),
            InfoRow(label: 'Layanan', value: selectedService),
            const InfoRow(label: 'Status', value: 'Menunggu konfirmasi server'),
            const SizedBox(height: 18),
            OutlinedButton.icon(onPressed: widget.onCancel, icon: const Icon(Icons.close), label: const Text('Hapus antrean contoh'),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.redAccent, minimumSize: const Size(double.infinity, 48))),
          ])),
      ] else ...[
        Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFFE2EAEC))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 62, height: 62, decoration: BoxDecoration(color: const Color(0xFFE7F4F3), borderRadius: BorderRadius.circular(18)), child: const Icon(Icons.event_available_rounded, color: brand, size: 30)),
            const SizedBox(height: 18),
            const Text('Mulai kunjunganmu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink)),
            const SizedBox(height: 8),
            const Text('Pilih layanan yang kamu butuhkan untuk membuat simulasi pendaftaran antrean.', style: TextStyle(color: muted, height: 1.5)),
            const SizedBox(height: 22),
            const Text('Klinik', style: TextStyle(fontWeight: FontWeight.w700, color: ink)),
            const SizedBox(height: 8),
            Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: canvas, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [const Icon(Icons.local_hospital_outlined, color: brand), const SizedBox(width: 10), Expanded(child: Text(widget.clinic, style: const TextStyle(fontWeight: FontWeight.w600, color: ink)))])),
            const SizedBox(height: 18),
            const Text('Jenis layanan', style: TextStyle(fontWeight: FontWeight.w700, color: ink)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(value: selectedService, decoration: const InputDecoration(),
              items: services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (value) { if (value != null) setState(() => selectedService = value); }),
            const SizedBox(height: 22),
            FilledButton.icon(onPressed: widget.onBook, icon: const Icon(Icons.add_circle_outline), label: const Text('Buat antrean contoh'),
              style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
          ])),
      ],
      const SizedBox(height: 16),
      const Text('Penting: antrean di layar ini hanya simulasi. Jangan gunakan sebagai nomor antrean medis sungguhan.', style: TextStyle(color: muted, fontSize: 12, height: 1.5)),
    ]);
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 28), children: [
    const Text('Profil', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 6), const Text('Informasi akun dan preferensi.', style: TextStyle(color: muted)),
    const SizedBox(height: 24),
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2EAEC))),
      child: const Column(children: [
        CircleAvatar(radius: 36, backgroundColor: Color(0xFFDDF3F2), child: Icon(Icons.person_rounded, size: 38, color: brand)),
        SizedBox(height: 12), Text('Pengguna MediQ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
        SizedBox(height: 4), Text('Mode pratinjau • Belum masuk', style: TextStyle(color: muted, fontSize: 12)),
      ])),
    const SizedBox(height: 18),
    const ProfileOption(icon: Icons.person_outline, title: 'Data pribadi', subtitle: 'Kelola informasi akun'),
    const ProfileOption(icon: Icons.history_rounded, title: 'Riwayat kunjungan', subtitle: 'Kunjungan dan antrean sebelumnya'),
    const ProfileOption(icon: Icons.notifications_none_rounded, title: 'Notifikasi', subtitle: 'Pengingat kunjungan'),
    const ProfileOption(icon: Icons.help_outline_rounded, title: 'Bantuan', subtitle: 'Informasi penggunaan MediQ'),
    const SizedBox(height: 18),
    const Text('Akun dan fitur profil akan diaktifkan setelah autentikasi backend terintegrasi.', style: TextStyle(color: muted, fontSize: 12, height: 1.5)),
  ]);
}

class SectionHeading extends StatelessWidget {
  final String title, subtitle;
  const SectionHeading({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: ink)),
    const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
  ]);
}

class QuickCard extends StatelessWidget {
  final IconData icon; final String title, subtitle; final VoidCallback onTap;
  const QuickCard({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(color: Colors.white, borderRadius: BorderRadius.circular(18), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
    child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2EAEC))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: brand, size: 26), const SizedBox(height: 16),
        Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
      ]))));
}

class ClinicCard extends StatelessWidget {
  final String name, category, distance; final IconData icon; final VoidCallback onTap;
  const ClinicCard({super.key, required this.name, required this.category, required this.distance, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(color: Colors.white, borderRadius: BorderRadius.circular(18), child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18),
    child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE2EAEC))),
      child: Row(children: [
        Container(width: 54, height: 54, decoration: BoxDecoration(color: const Color(0xFFE7F4F3), borderRadius: BorderRadius.circular(15)), child: Icon(icon, color: brand, size: 27)),
        const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(color: ink, fontWeight: FontWeight.w700)),
          const SizedBox(height: 5), Text(category, style: const TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 6), Text(distance, style: const TextStyle(color: brand, fontSize: 11, fontWeight: FontWeight.w600)),
        ])), const Icon(Icons.chevron_right, color: muted),
      ]))));
}

class InfoRow extends StatelessWidget {
  final String label, value;
  const InfoRow({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 7), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 88, child: Text(label, style: const TextStyle(color: muted, fontSize: 13))),
    Expanded(child: Text(value, style: const TextStyle(color: ink, fontSize: 13, fontWeight: FontWeight.w600))),
  ]));
}

class ProfileOption extends StatelessWidget {
  final IconData icon; final String title, subtitle;
  const ProfileOption({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2EAEC))),
    child: Row(children: [Icon(icon, color: brand, size: 23), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w700)),
      const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
    ])), const Icon(Icons.chevron_right, color: muted)]));
}
