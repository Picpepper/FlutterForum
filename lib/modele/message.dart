class Message {
  final int id;
  final String titre;
  final DateTime datePoste;
  final String contenu;
  final String author;

  Message({
    required this.id,
    required this.titre,
    required this.datePoste,
    required this.contenu,
    required this.author,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] is int ? json['id'] : 0,
      titre: json['titre'] is String ? json['titre'] : "Sans titre",
      datePoste: json['datePoste'] is String
          ? DateTime.parse(json['datePoste'])
          : DateTime.now(),
      contenu: json['contenu'] is String ? json['contenu'] : "Aucun contenu",
      author: json['user'] != null && json['user'] is Map<String, dynamic>
          ? "${json['user']['prenom']} ${json['user']['nom']}"
          : "Utilisateur inconnu",
    );
  }
}
