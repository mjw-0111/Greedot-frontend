import 'package:flutter/material.dart';
import '../../models/user_model.dart'; // 사용자 모델 import
import '../../service/user_service.dart'; // API 서비스 import

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Future<UserModel> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = ApiService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: FutureBuilder<UserModel>(
          future: userProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              UserModel user = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("ID: ${user.id}"),
                  Text("Username: ${user.username}"),
                  Text("Nickname: ${user.nickname}"),
                  Text("Role: ${user.role}"),
                  Text("Grade: ${user.grade}"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showEditProfileDialog(context, user);
                    },
                    child: Text("Edit Profile"),
                  ),
                ],
              );
            } else {
              return Text("No data");
            }
          },
        ),
      ),
    );
  }

  void showEditProfileDialog(BuildContext context, UserModel user) {
    TextEditingController nicknameController = TextEditingController(text: user.nickname);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: TextField(
            controller: nicknameController,
            decoration: InputDecoration(hintText: "Enter new nickname"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                UserProfileUpdateModel updatedData = UserProfileUpdateModel(nickname: nicknameController.text);
                var response = await ApiService.updateUserProfile(updatedData);
                if (response.statusCode == 200) {
                  setState(() {
                    userProfile = ApiService.getUserProfile(); // 프로필 정보 새로고침
                  });
                  Navigator.of(context).pop(); // 성공적으로 업데이트 후 다이얼로그 닫기
                } else {
                  // 실패한 경우 적절한 오류 처리
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}