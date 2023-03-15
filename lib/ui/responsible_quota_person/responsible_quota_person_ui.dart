import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/common/constants/constants.dart';
import 'package:project/common/widgets/appbar.widget.dart';
import 'package:project/common/widgets/drawer.widget.dart';
import 'package:project/ui/responsible_quota_person/add_rqp_ui.dart';
import 'package:project/ui/responsible_quota_person/detail_rqp_ui.dart';
import '../../common/utils/local_storage_util.dart';
import '../../common/widgets/search_bar.widget.dart';
import 'package:http/http.dart' as http;
import 'models/responsible_quota_person_model.dart';

class AllResponseibleQuotaPersonScreen extends StatefulWidget {
  const AllResponseibleQuotaPersonScreen({super.key});

  @override
  State<AllResponseibleQuotaPersonScreen> createState() =>
      _AllResponseibleQuotaPersonScreenState();
}

class _AllResponseibleQuotaPersonScreenState
    extends State<AllResponseibleQuotaPersonScreen> {
  late String token = "";
  List<RQPArrayPayload> rqp = [];
  @override
  void initState() {
    super.initState();

    _getResponseibleQuotaPerson();
    LocalStorageUtil.getItem('token').then((value) => setState(() {
          token = value ?? "";
        }));
  }

  _getResponseibleQuotaPerson() async {
    final url = Uri.http(BASEURL, '$ENDPOINT/rqp/get-all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      RQPArrayModel rqpData = RQPArrayModel.fromJson(jsonDecode(response.body));
      setState(() {
        rqp = rqpData.payload!;
      });
    }
  }

  _getResponseibleQuotaPersonKeyword(String? keyword) async {
    final queryParam = {"keyword": keyword};
    Uri url = Uri.http(BASEURL, '$ENDPOINT/rqp/get-all', queryParam);
    final token = await LocalStorageUtil.getItem('token');
    final header = {
      'Authorization': 'Bearer ${token.toString()}',
      'Content-Type': 'application/json',
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      RQPArrayModel rqpData = RQPArrayModel.fromJson(jsonDecode(response.body));

      setState(() {
        rqp = rqpData.payload!;
      });
    }
  }

  @override
  void dispose() {
    rqp.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(txtTitle: 'หน้าข้อมูลผู้รับผิดชอบโควตา'),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SearchBar(
                onTextChanged: (String value) {
                  if (value != "") {
                    _getResponseibleQuotaPersonKeyword(value);
                  } else {
                    _getResponseibleQuotaPerson();
                  }
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showCheckboxColumn: false,
                  sortAscending: true,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: IgnorePointer(
                        ignoring: true,
                        child: Text(
                          'ปีการศึกษา',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                      'ชื่อ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'นามสกุล',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'ประเภทโควตา',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    )),
                  ],
                  rows: rqp.map((data) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text("${data.year}")),
                        DataCell(Text("${data.name}")),
                        DataCell(Text("${data.surname}")),
                        DataCell(Text("${data.quota}")),
                      ],
                      selected: false, // Add this line to remove the borders
                      onSelectChanged: (isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailRQPScreen(
                                    id: data.id!,
                                    agency: data.agency!,
                                    name: data.name!,
                                    surname: data.surname!,
                                    phone: data.phone!,
                                    quota: data.quota!,
                                    year: data.year!,
                                  )),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: token.isNotEmpty,
                    child: SizedBox(
                      width: 80, // adjust the width to your desired size
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddRQPScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            SizedBox(
                                width:
                                    2), // Add some space between icon and text
                            Text('เพิ่ม'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.brown,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios_new),
                        SizedBox(
                            width: 5), // Add some space between icon and text
                        Text('กลับ'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: const DrawerMenuWidget(),
      ),
    );
  }
}
