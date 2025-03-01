class Contact {
  String? name;
  String? number;
  String? img;
  String? email;
  String? address;

  Contact({this.name, this.number, this.img, this.email, this.address});
}
class Voicemail {
  final String senderName;
  final String number;
  final DateTime timeReceived;
  final String message; // For simplicity, treating the voicemail as text here

  Voicemail({
    required this.senderName,
    required this.number,
    required this.timeReceived,
    required this.message,
  });
}
