import 'package:flutter/material.dart';
import '../api_service.dart';
import '../user_api_model.dart';
import 'user_detail_page.dart';

class ApiUsersPage extends StatefulWidget {
  const ApiUsersPage({Key? key}) : super(key: key);

  @override
  _ApiUsersPageState createState() => _ApiUsersPageState();
}

class _ApiUsersPageState extends State<ApiUsersPage> {
  // Future pour stocker le résultat de l'appel API
  late Future<List<UserApiModel>> _usersFuture;

  // Initialisation de la page
  @override
  void initState() {
    super.initState();
    // Chargement des utilisateurs
    _usersFuture = ApiService.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilisateurs API'),
      ),
      body: FutureBuilder<List<UserApiModel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          // Gestion des différents états du FutureBuilder
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Affichage d'un indicateur de chargement
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Gestion des erreurs
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 60),
                  SizedBox(height: 16),
                  Text(
                    'Erreur: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _usersFuture = ApiService.getAllUsers();
                      });
                    },
                    child: Text('Réessayer'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Gestion du cas où il n'y a pas de données
            return Center(
              child: Text('Aucun utilisateur trouvé'),
            );
          } else {
            // Affichage de la liste des utilisateurs
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(user.id.toString()),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigation vers la page de détails
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailPage(user: user),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Rafraîchir la liste
          setState(() {
            _usersFuture = ApiService.getAllUsers();
          });
        },
        tooltip: 'Rafraîchir',
        child: Icon(Icons.refresh),
      ),
    );
  }
}