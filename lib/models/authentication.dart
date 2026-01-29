class Authentication {
  final String token;
  final String type;
  final int expireIn;

  Authentication({
    required this.token,
    required this.type,
    required this.expireIn,
  });

  factory Authentication.fromJson(Map<String, dynamic> json){
    return Authentication(
      token: json['token'],
      type: json['type'],
      expireIn: json['expireIn']
    );
  }

  factory Authentication.init(){
    return Authentication(
      token: "",
      type: "",
      expireIn: 0,
    );
  }
}