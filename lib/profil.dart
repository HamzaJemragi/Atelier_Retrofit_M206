import 'package:flutter/material.dart';
import 'class/class.dart'; // Assurez-vous que ce fichier existe et contient les classes nécessaires

// Assurez-vous que la classe UserProfile est définie dans class/class.dart
// Exemple (à adapter selon votre structure réelle) :
/*
class UserProfile {
  final String nom;
  final int age;
  final String genre;
  final DateTime dateDeNaissance;
  final String formation;
  final double niveauCompetence; // ou int selon votre cas
  final List<String> interets;
  final bool notifications;

  UserProfile({
    required this.nom,
    required this.age,
    required this.genre,
    required this.dateDeNaissance,
    required this.formation,
    required this.niveauCompetence,
    required this.interets,
    required this.notifications,
  });
}

// Assurez-vous que ProfileInfoCard et ProfileInfoRow sont définis
class ProfileInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileInfoCard({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...children, // Utilisation de l'opérateur spread pour ajouter les widgets enfants
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded( // Permet au texte de la valeur de prendre l'espace restant et de passer à la ligne
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
*/


class ProfilePage extends StatelessWidget {
  final UserProfile? userProfile;

  const ProfilePage({super.key, this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'), // Titre de l'AppBar ajouté/décommenté
      ),
      body: userProfile == null
          ? _buildEmptyProfile()
          : _buildUserProfile(),
    );
  }

  Widget _buildEmptyProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Aucun profil disponible',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'Remplissez le formulaire sur la page d\'accueil',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    // Utilisation de '!' est sûre ici car cette méthode est appelée uniquement si userProfile n'est pas null
    final profile = userProfile!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.person, size: 60, color: Colors.blue),
            ),
          ),
          SizedBox(height: 24),
          ProfileInfoCard(
            title: 'Informations personnelles',
            children: [
              ProfileInfoRow(label: 'Nom', value: profile.nom),
              ProfileInfoRow(label: 'Age', value: '${profile.age} ans'),
              ProfileInfoRow(label: 'Genre', value: profile.genre),
              ProfileInfoRow(
                label: 'Date de naissance',
                value:
                    '${profile.dateDeNaissance.day}/${profile.dateDeNaissance.month}/${profile.dateDeNaissance.year}',
              ),
            ],
          ),
          SizedBox(height: 16),
          ProfileInfoCard(
            title: 'Formation et compétences',
            children: [
              ProfileInfoRow(label: 'Formation', value: profile.formation),
              ProfileInfoRow(
                label: 'Niveau en programmation',
                value: '${profile.niveauCompetence.round()}/5',
              ),
            ],
          ),
          SizedBox(height: 16),
          ProfileInfoCard(
            title: 'Centres d\'intérêt',
            children: [
              ProfileInfoRow(
                label: 'Intérêts',
                value: profile.interets.join(', '),
              ),
            ],
          ),
          SizedBox(height: 16),
          ProfileInfoCard(
            title: 'Préférences',
            children: [
              ProfileInfoRow(
                label: 'Notifications',
                value: profile.notifications ? 'Activées' : 'Désactivées',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  ProfileInfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...children,
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Text(value),
      ],
    );
  }
}