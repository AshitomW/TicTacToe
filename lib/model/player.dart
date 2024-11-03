// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  final String nickname;
  final String socketID;
  final num points;
  final String playerMark;
  Player({
    required this.nickname,
    required this.socketID,
    required this.points,
    required this.playerMark,
  });

  Player copyWith({
    String? nickname,
    String? socketID,
    double? points,
    String? playerMark,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketID: socketID ?? this.socketID,
      points: points ?? this.points,
      playerMark: playerMark ?? this.playerMark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketID': socketID,
      'points': points,
      'playerMark': playerMark,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] as String,
      socketID: map['socketID'] as String,
      points: map['points'] as num,
      playerMark: map['playerMark'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Player(nickname: $nickname, socketID: $socketID, points: $points, playerMark: $playerMark)';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.nickname == nickname &&
        other.socketID == socketID &&
        other.points == points &&
        other.playerMark == playerMark;
  }

  @override
  int get hashCode {
    return nickname.hashCode ^ socketID.hashCode ^ points.hashCode ^ playerMark.hashCode;
  }
}
