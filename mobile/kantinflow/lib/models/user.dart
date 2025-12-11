class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? profileImageUrl;
  final String? address;
  final String? gender;
  final bool? emailVerified;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImageUrl,
    this.address,
    this.gender,
    this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'], 
    firstName: json['firstName'], 
    lastName: json['lastName'], 
    email: json['email'],
    profileImageUrl: json['profileImageUrl'],
    gender: json['gender'],
    address: json['address'],
    emailVerified: json["emailVerified"]
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "ProfileImageUrl": profileImageUrl,
    "Gender": gender,
    "Address": address,
    "EmailVerified": emailVerified
  };
}