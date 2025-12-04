class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImageUrl;
  final bool? emailVerified;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImageUrl,
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'], 
    firstName: json['firstName'], 
    lastName: json['lastName'], 
    email: json['email'],
    profileImageUrl: json['profileImageUrl'],
    emailVerified: json["emailVerified"]
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "ProfileImageUrl": profileImageUrl,
    "EmailVerified": emailVerified
  };
}