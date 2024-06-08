import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieve();
  }

  void save() async {
    Response response =
        await dio.post("http://192.168.8.230:8000/api/mahasiswa", data: {
      "nama": namaController.text,
      "jurusan": jurusanController.text,
    });
    retrieve();
  }

  void retrieve() async {
    Response response =
        await dio.get("http://192.168.8.230:8000/api/mahasiswa");
    setState(() {
      this.mahasiswa = response.data;
    });
  }

  void deleteRow(id) async {
    Response response =
        await dio.delete("http://192.168.8.230:8000/api/mahasiswa/${id}");
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
                                  e['jurusan'].toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  e['nama'].toString(),
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
