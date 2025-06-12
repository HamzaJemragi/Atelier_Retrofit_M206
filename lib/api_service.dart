import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_api_model.dart';

class ApiService {
  // URL de base de l'API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Méthode pour récupérer un utilisateur par ID
  static Future<UserApiModel> getUserById(int id) async {
    // Construction de l'URL
    final url = Uri.parse('$baseUrl/users/$id');
    try {
      // Envoi de la requête GET
      final response = await http.get(url);

      // Vérification du statut de la réponse
      if (response.statusCode == 200) {
        // Conversion du JSON en Map
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Conversion de la Map en objet UserApiModel
        return UserApiModel.fromJson(data);
      } else {
        // Gestion des erreurs HTTP
        throw Exception('Échec du chargement de l\'utilisateur: ${response.statusCode}');
      }
    } catch (e) {
      // Gestion des exceptions
      throw Exception('Erreur réseau: $e');
    }
  }

  // Méthode pour récupérer tous les utilisateurs
  static Future<List<UserApiModel>> getAllUsers() async {
    final url = Uri.parse('$baseUrl/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Conversion du JSON en List<dynamic>
        final List<dynamic> usersJson = jsonDecode(response.body);
        // Conversion de chaque élément en UserApiModel
        return usersJson.map((json) => UserApiModel.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des utilisateurs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  // Méthode pour créer un utilisateur (POST)
  static Future<UserApiModel> createUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users');
    try {
      // Conversion de Map en JSON
      final String jsonBody = jsonEncode(userData);
      // Configuration des headers
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // Envoi de la requête POST
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );
      if (response.statusCode == 201) {
        return UserApiModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Échec de la création de l\'utilisateur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  // Méthode pour mettre à jour un utilisateur (PUT)
  static Future<UserApiModel> updateUser(int id, Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users/$id');
    try {
      final String jsonBody = jsonEncode(userData);
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final response = await http.put(
        url,
        headers: headers,
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        return UserApiModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Échec de la mise à jour de l\'utilisateur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  // Méthode pour supprimer un utilisateur (DELETE)
  static Future<bool> deleteUser(int id) async {
    final url = Uri.parse('$baseUrl/users/$id');
    try {
      final response = await http.delete(url);
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}