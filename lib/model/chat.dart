class Chat {
  final String? clientId,techId;
  Chat({this.clientId,this.techId});

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'techId': techId,
    };
  }

  String get roomId => '${clientId}_$techId';
}