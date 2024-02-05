import 'package:flutter/material.dart';
import '../../service/user_service.dart';

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
            // 오류 발생시 오류 메시지를 표시합니다.
            return Center(child: Text("An error occurred: ${snapshot.error.toString()}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // 데이터가 있는 경우에만 ListView를 빌드합니다.
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // 여기서 'id'는 서버에서 받은 데이터의 키와 일치해야 합니다.
                // 'id'가 int 타입이라면, 문자열로 변환합니다.
                return ListTile(
                  title: Text(snapshot.data![index]['id'].toString()),
                  // onTap 등의 인터랙션을 구현합니다.
                );
              },
            );
          } else {
            // 데이터가 없는 경우 메시지를 표시합니다.
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}
