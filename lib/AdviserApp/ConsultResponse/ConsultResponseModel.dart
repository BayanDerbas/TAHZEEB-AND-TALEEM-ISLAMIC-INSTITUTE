
// Model class for the reply
class Reply {
  final int id;
  final String replyText;
  final String adviserName;

  Reply({
    required this.id,
    required this.replyText,
    required this.adviserName,
  });

  // Factory method to create an instance from JSON
  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      replyText: json['reply'],
      adviserName: json['adviser_name'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reply': replyText,
      'adviser_name': adviserName,
    };
  }
}
