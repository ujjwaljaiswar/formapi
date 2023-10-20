class User{

  final int success;
  final String message;

  User({

    required this.success,
    required this.message,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(

      success: json['success'],
      message: json['message'],
    );
  }

}