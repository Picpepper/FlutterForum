class Message {
  final int id;
  final String titre;
  final DateTime datePoste;
  final String contenu;
  final String author; // Ici, nous stockons l'URL de l'utilisateur

  Message({
    required this.id,
    required this.titre,
    required this.datePoste,
    required this.contenu,
    required this.author,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? 0,
      titre: json['titre'] ?? "Sans titre",
      datePoste: json['datePoste'] != null 
          ? DateTime.parse(json['datePoste']) 
          : DateTime.now(),
      contenu: json['contenu'] ?? "Aucun contenu",
      author: json['user'] ?? "Utilisateur inconnu", // Stocke l'URL de l'utilisateur
    );
  }
}