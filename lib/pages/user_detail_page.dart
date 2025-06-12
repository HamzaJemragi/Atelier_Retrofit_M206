import 'package:flutter/material.dart';
import '../user_api_model.dart';

class UserDetailPage extends StatelessWidget {
  final UserApiModel user;
  const UserDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue.shade200,
                child: Text(
                  user.name.substring(0, 1),
                  style: TextStyle(fontSize: 40, color: Colors.blue.shade800),
                ),
              ),
            ),
            SizedBox(height: 24),
            InfoCard(
              title: 'Informations personnelles',
              content: [
                InfoRow(label: 'Nom', value: user.name),
                InfoRow(label: 'Nom d\'utilisateur', value: user.username),
                InfoRow(label: 'Email', value: user.email),
                InfoRow(label: 'Téléphone', value: user.phone),
                InfoRow(label: 'Site web', value: user.website),
              ],
            ),
            SizedBox(height: 16),
            InfoCard(
              title: 'Adresse',
              content: [
                InfoRow(label: 'Rue', value: user.address.street),
                InfoRow(label: 'Suite', value: user.address.suite),
                InfoRow(label: 'Ville', value: user.address.city),
                InfoRow(label: 'Code postal', value: user.address.zipcode),
                InfoRow(
                  label: 'Géolocalisation',
                  value: 'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}',
                ),
              ],
            ),
            SizedBox(height: 16),
            InfoCard(
              title: 'Entreprise',
              content: [
                InfoRow(label: 'Nom', value: user.company.name),
                InfoRow(label: 'Slogan', value: user.company.catchPhrase),
                InfoRow(label: 'Stratégie', value: user.company.bs),
              ],
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('Voir sur la carte'),
                onPressed: () {
                  // Ouverture d'une carte (fonctionnalité à implémenter)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fonctionnalité à venir')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widgets d'aide pour l'affichage
class InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> content;
  const InfoCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            ...content,
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}