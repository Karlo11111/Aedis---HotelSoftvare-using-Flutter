class NFCData {
  final String userId;
  final String authToken;
  final String roomId;

  NFCData(
      {required this.userId, required this.authToken, required this.roomId});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'authToken': authToken,
        'roomId': roomId,
      };
}
