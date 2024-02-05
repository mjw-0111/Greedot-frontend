import 'package:flutter/material.dart';
import '../../service/user_service.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatelessWidget {
  final ApiService _userService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _userService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Nickname')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Grade')),
                  DataColumn(label: Text('Registered At')),
                ],
                rows: List<DataRow>.generate(
                  snapshot.data!.length,
                      (index) {
                    var user = snapshot.data![index];
                    return DataRow(
                      cells: [
                        DataCell(Text(user['id'].toString())),
                        DataCell(Text(user['email'])),
                        DataCell(Text(user['nickname'])),
                        DataCell(Text(user['role'].toString().split('.').last)), // Enum 처리
                        DataCell(Text(user['status'].toString().split('.').last)), // Enum 처리
                        DataCell(Text(user['grade'].toString().split('.').last)), // Enum 처리
                        DataCell(Text(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(user['register_at'])))),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
