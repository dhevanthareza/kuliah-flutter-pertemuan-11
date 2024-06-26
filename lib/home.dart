import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController jurusanController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  List<dynamic> mahasiswa = [];
  final dio = Dio();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieve();
  }

  void save() async {
    await supabase.from('mahasiswa').insert(
        {'nama': namaController.text, 'jurusan': jurusanController.text});
    retrieve();
  }

  void retrieve() async {
    final data = await supabase.from('mahasiswa').select('*');
    setState(() {
      this.mahasiswa = data;
    });
  }

  void deleteRow(id) async {
    await supabase.from('mahasiswa').delete().eq('id', id);
    retrieve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Data Mahasiswa")),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: jurusanController,
              decoration: const InputDecoration(
                label: Text("Jurusan"),
              ),
            ),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                label: Text("Nama Mahasiswa"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                save();
              },
              child: Text("Simpan Data Mahasiswa"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Nama'),
                      ),
                      DataColumn(
                        label: Text('Jurusan'),
                      ),
                      DataColumn(
                        label: Text('Action'),
                      ),
                    ],
                    rows: mahasiswa
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  e['nama'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e['jurusan'].toString(),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    deleteRow(e['id']);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
