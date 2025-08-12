class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final String? department;
  final List<String> parentDeviceIds; // New field

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.department,
    this.parentDeviceIds = const [], // Default empty list
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
      department: map['department'],
      parentDeviceIds: List<String>.from(
        map['parentDeviceIds'] ?? [],
      ), // Safe conversion
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'parentDeviceIds': parentDeviceIds, // Save list to Firestore
    };
  }
}
