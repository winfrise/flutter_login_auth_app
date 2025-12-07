/// 用户信息模型
class UserInfo {
  final String avatar;
  final String nickname;
  final String phone;

  UserInfo({
    this.avatar = 'https://picsum.photos/100/100?random=1',
    this.nickname = 'Flutter用户',
    required this.phone,
  });
}
