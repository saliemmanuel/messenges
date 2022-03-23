import 'dart:convert';

class ChatModel {
  final String? title;
  final String? adress;
  final String? lastMessage;
  final String? date;
  final bool? kind;

  ChatModel({
    this.title,
    this.adress,
    this.lastMessage,
    this.date,
    this.kind,
  });

  ChatModel copyWith({
    String? title,
    String? adress,
    String? lastMessage,
    String? date,
    String? kind,
  }) {
    return ChatModel(
      title: title ?? this.title,
      adress: adress ?? this.adress,
      lastMessage: lastMessage ?? this.lastMessage,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (adress != null) {
      result.addAll({'adress': adress});
    }
    if (lastMessage != null) {
      result.addAll({'lastMessage': lastMessage});
    }
    if (date != null) {
      result.addAll({'date': date});
    }
    if (kind != null) {
      result.addAll({'kind': kind});
    }

    return result;
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      title: map['title'],
      adress: map['adress'],
      lastMessage: map['lastMessage'],
      date: map['date'], 
      kind: map['kind'], 
      
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(title: $title, adress: $adress, lastMessage: $lastMessage, date: $date,  date: $kind)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.title == title &&
        other.adress == adress &&
        other.lastMessage == lastMessage &&
        other.date == date && 
        other.kind == kind;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        adress.hashCode ^
        lastMessage.hashCode ^
        date.hashCode^
        kind.hashCode;
  }
}
