import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 1',
      // Mengganti warna tema utama menjadi Teal
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      // Menampilkan SnackBar jika tombol - ditekan saat counter 0
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Counter tidak boleh di bawah 0!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Logika penentu genap atau ganjil
    bool isEven = _counter % 2 == 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('PPM Sesi 1 - Daffa Lutvi Mahendra (20240040142)'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1. Kartu Identitas
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      // Menggunakan icon People sesuai permintaan
                      Icon(Icons.people, size: 60, color: Colors.teal),
                      SizedBox(height: 12),
                      Text(
                        'Daffa Lutvi Mahendra', 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text('NIM: 20240040142', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Prodi/Kelas: Teknik Informatika / TI24G', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // 2. Status Angka (Genap / Ganjil)
              Text(
                isEven ? 'Angka Genap' : 'Angka Ganjil',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              
              // 3. Angka Counter dengan Warna Dinamis
              Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: isEven ? Colors.blue : Colors.red, // Biru untuk genap, Merah untuk ganjil
                ),
              ),
              const SizedBox(height: 40),
              
              // 4. Tombol Aksi (+, -, Reset)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}