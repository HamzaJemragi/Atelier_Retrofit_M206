class UserProfile {
  final String nom;
  final String age;
  final String genre;
  final List<String> interets;
  final DateTime dateDeNaissance;
  final double niveauCompetence;
  final String formation;
  final bool notifications;
  UserProfile({
    required this.nom,
    required this.age,
    required this.genre,
    required this.interets,
    required this.dateDeNaissance,
    required this.niveauCompetence,
    required this.formation,
    required this.notifications,
  });
}
