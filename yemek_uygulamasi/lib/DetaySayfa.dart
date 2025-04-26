import 'package:flutter/material.dart';
import 'package:yemek_uygulamasi/Yemekler.dart';

class DetaySayfa extends StatefulWidget {
  final Yemekler yemek;

  const DetaySayfa({super.key, required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 1;

  @override
  Widget build(BuildContext context) {
    double toplamFiyat = widget.yemek.yemek_fiyat * adet;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.yemek.yemek_adi),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "resimler/${widget.yemek.yemek_resim_adi}",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "${widget.yemek.yemek_fiyat.toStringAsFixed(2)} ₺",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (adet > 1) adet--;
                    });
                  },
                  icon: const Icon(Icons.remove_circle, size: 30),
                ),
                Text(
                  adet.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      adet++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, size: 30),
                ),
              ],
            ),
            Text(
              "Toplam: ${toplamFiyat.toStringAsFixed(2)} ₺",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "${adet} adet ${widget.yemek.yemek_adi} sipariş verildi. Toplam: ${toplamFiyat.toStringAsFixed(2)} ₺"),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: const Text("SİPARİŞ VER"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
