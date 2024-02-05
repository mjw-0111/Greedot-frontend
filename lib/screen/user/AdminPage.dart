import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../service/user_service.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Key _futureBuilderKey = UniqueKey(); // 데이터 수정 시 새로운 페이지 로드 FutureBuilder를 위한 고유 키

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: FutureBuilder<List<dynamic>>(
        key: _futureBuilderKey,
        future: ApiService().getUsers(),
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
                  DataColumn(label: Text('Actions')),
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
                        DataCell(Text(user['role'].toString().split('.').last)),
                        DataCell(Text(user['status'].toString().split('.').last)),
                        DataCell(Text(user['grade'].toString().split('.').last)),
                        DataCell(Text(DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(user['register_at'])))),
                        DataCell(Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                int userId = user['id'];
                                String userEmail = user['email'];
                                String userNickname = user['nickname'];
                                showEditUserDialog(context, userId, userEmail, userNickname);
                                },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteUserAndRefreshList(user['id']),
                            ),
                          ],
                        )),
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

  // 수정 성공 로직
  Future<void> updateUserAndRefreshList(int userId, UserUpdateModel userData) async {
    final response = await ApiService.updateUser(userId, userData);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('업데이트되었습니다.')));
      setState(() {
        _futureBuilderKey = UniqueKey();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('업데이트에 실패하였습니다.')));
    }
  }

  // 수정버튼 누를 때 form 설정
  Future<void> showEditUserDialog(BuildContext context, int userId, String? email, String? nickname) async {
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController nicknameController = TextEditingController(text: nickname);
    TextEditingController passwordController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('사용자 정보 수정'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "이메일"),
                ),
                TextField(
                  controller: nicknameController,
                  decoration: InputDecoration(hintText: "닉네임"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: "비밀번호"),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('수정'),
              onPressed: () async {
                // 사용자 정보 업데이트 모델 생성 및 API 호출
                UserUpdateModel updatedUserData = UserUpdateModel(
                  id: userId,
                  email: emailController.text.isNotEmpty ? emailController.text : null,
                  nickname: nicknameController.text.isNotEmpty ? nicknameController.text : null,
                  password: passwordController.text.isNotEmpty ? passwordController.text : null,
                );
                await updateUserAndRefreshList(userId, updatedUserData);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  // 유저 삭제 로직
  Future<void> deleteUserAndRefreshList(int userId) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('유저 삭제'),
        content: Text('해당 유저를 삭제하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('확인'),
          ),
        ],
      ),
    );

    // 삭제 성공 시 setState로 새로고침
    if (confirmDelete == true) {
      final response = await ApiService.deleteUser(userId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다.')));
        setState(() {
          _futureBuilderKey = UniqueKey();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('실패하였습니다.')));
      }
    }
  }
}


