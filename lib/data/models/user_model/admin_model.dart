class AdminUser {
  final String name;
  final String username;
  final String email;
  final String? imageUrl;

  AdminUser(this.name, this.username, this.email, this.imageUrl);
  factory AdminUser.fromMap(Map<String, dynamic> data) {
    return AdminUser(
      data['name'],
      data['username'],
      data['email'],
      data['imageUrl'],
    );
  }
}
