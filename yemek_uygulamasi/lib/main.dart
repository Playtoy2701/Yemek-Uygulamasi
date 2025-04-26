import 'package:flutter/material.dart';
import 'package:yemek_uygulamasi/DetaySayfa.dart';
import 'package:yemek_uygulamasi/Yemekler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Yemek Listesi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Yemekler>> yemekleriGetir() async {
    return [
      Yemekler(1, "Köfte", "kofte.png", 15.99),
      Yemekler(2, "Ayran", "ayran.png", 3.5),
      Yemekler(3, "Fanta", "fanta.png", 5.0),
      Yemekler(4, "Makarna", "makarna.png", 12.0),
      Yemekler(5, "Kadayıf", "kadayif.png", 10.0),
      Yemekler(6, "Baklava", "baklava.png", 18.5),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Yemekler>>(
        future: yemekleriGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata oluştu: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Yemek bulunamadı"));
          } else {
            var yemekListesi = snapshot.data!;
            return ListView.builder(
              itemCount: yemekListesi.length,
              itemBuilder: (context, indeks) {
                var yemek = yemekListesi[indeks];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetaySayfa(yemek: yemek),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "resimler/${yemek.yemek_resim_adi}",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  yemek.yemek_adi,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${yemek.yemek_fiyat.toStringAsFixed(2)} ₺",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
