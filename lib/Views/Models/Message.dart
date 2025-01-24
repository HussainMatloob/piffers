class Message {
  final String name;
  final String message;
  final String timestamp;
  final bool unread;

  Message(
      {required this.name,
      required this.message,
      required this.timestamp,

      this.unread = false});
}
