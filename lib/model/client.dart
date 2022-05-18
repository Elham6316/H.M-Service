class Client {
  final String? email,password,fullName,type;

  Client({this.email, this.password, this.fullName,this.type});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'type':type
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      type: map['type'] as String,
    );
  }
}