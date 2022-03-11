import 'dart:convert';
import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenorio_app/models/cidade.dart';
import 'package:tenorio_app/models/estado.dart';
import 'package:tenorio_app/models/ocorrencia.dart';
import 'package:tenorio_app/models/raca.dart';
import 'package:tenorio_app/pages/auth/login.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:tenorio_app/utilities/constants.dart';

class ApiService {
  late String? token;

  ApiService(this.token);
  String baseUrl = Constants().baseUrl;

  Future<void> verifyErrors(response) async {
    if (response.statusCode == 401) {
      String errorMessage = '';
      Map<String, dynamic> body = jsonDecode(response.body);
      errorMessage = body['message'];
      await AuthProvider().logOut();
      throw Exception(errorMessage);
    }
    if (response.statusCode == 422) {
      Map<dynamic, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = errors.values.first.first;
      throw Exception(errorMessage);
    }
  }

//AUTH
  Future<String> register(String? name, String? email, String? password) async {
    String uri = baseUrl + 'auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      errors.forEach((key, value) {
        value.forEach((element) {
          errorMessage += element + '\n';
        });
      });
      throw Exception(errorMessage);
    }

    // return token
    return response.body;
  }

  Future<String> login(String email, String password) async {
    String uri = baseUrl + 'auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}));
    verifyErrors(response);
    return response.body;
  }

  Future<String> getUserAuth() async {
    http.Response response = await http.post(
      Uri.parse(baseUrl + 'auth/me'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    await verifyErrors(response);
    return response.body;
  }

//USERS
  Future<String> updateUser(json) async {
    http.Response response =
        await http.put(Uri.parse(baseUrl + 'users/${json["id"]}'),
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token'
            },
            body: json);
    print(response.body);
    await verifyErrors(response);
    return response.body;
  }

  Future<void> updateProfileImage(json) async {
    Uri uri = Uri.parse(baseUrl + 'users/${json["id"]}');
    var request = http.MultipartRequest("POST", uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.files.add(await http.MultipartFile.fromPath(
        'profile_image_url', json['profile_image_url'].path));

    request.fields['_method'] = 'PUT';
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode != 200) throw Exception(responseString);
  }

//OCORRENCIAS
  Future<List<Ocorrencia>> fetchOcorrencias() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'ocorrencias'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    verifyErrors(response);
    List ocorrencias = jsonDecode(response.body);
    return ocorrencias
        .map((category) => Ocorrencia.fromJson(category))
        .toList();
  }

  Future<Ocorrencia> addOcorrencia(json) async {
    Uri uri = Uri.parse(baseUrl + 'ocorrencias');
    var request = http.MultipartRequest("POST", uri);

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_esquerda_lateral',
        json['fotos_posterior_esquerda_lateral'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_esquerda_palmar',
        json['fotos_posterior_esquerda_palmar'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_esquerda_frontal',
        json['fotos_posterior_esquerda_frontal'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_direita_lateral',
        json['fotos_posterior_direita_lateral'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_direita_palmar',
        json['fotos_posterior_direita_palmar'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_posterior_direita_frontal',
        json['fotos_posterior_direita_frontal'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_esquerda_lateral',
        json['fotos_anterior_esquerda_lateral'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_esquerda_palmar',
        json['fotos_anterior_esquerda_palmar'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_esquerda_frontal',
        json['fotos_anterior_esquerda_frontal'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_direita_lateral',
        json['fotos_anterior_direita_lateral'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_direita_palmar',
        json['fotos_anterior_direita_palmar'].path));
    request.files.add(await http.MultipartFile.fromPath(
        'fotos_anterior_direita_frontal',
        json['fotos_anterior_direita_frontal'].path));

    request.fields['nome'] = json['nome'];
    request.fields['anotacao'] = json['anotacao'];
    request.fields['estado_id'] = json['estado_id'];
    request.fields['cidade_id'] = json['cidade_id'];
    request.fields['apelido'] = json['apelido'];
    request.fields['sexo'] = json['sexo'];
    request.fields['idade'] = json['idade'];
    request.fields['cavalo_raca_id'] = json['cavalo_raca_id'];

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    if (response.statusCode != 201) {
      if (response.statusCode == 401) {
        var prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Get.to(() => const LoginScreen());
      }
      throw Exception(responseString);
    }

    return Ocorrencia.fromJson(jsonDecode(responseString));
  }

  Future<Ocorrencia> updateOcorrencia(Ocorrencia ocorrencia) async {
    String uri = baseUrl + 'ocorrencias/' + ocorrencia.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': ocorrencia.nome}));

    if (response.statusCode != 200) {
      throw Exception('Error happened on update');
    }

    return Ocorrencia.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteOcorrencia(id) async {
    String uri = baseUrl + 'ocorrencias/' + id.toString();
    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error happened on delete');
    }
  }

  //ESTADOS
  Future<List<Estado>> fetchEstados() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'estados'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    verifyErrors(response);
    List estados = jsonDecode(response.body);
    return estados.map((estado) => Estado.fromJson(estado)).toList();
  }

  //CIDADES
  Future<List<Cidade>> fetchCidades() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'cidades'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    verifyErrors(response);
    List cidades = jsonDecode(response.body);
    return cidades.map((cidade) => Cidade.fromJson(cidade)).toList();
  }

  //CAVALO
  Future<List<Raca>> fetchRacas() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'cavalo_racas'),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    verifyErrors(response);
    List racas = jsonDecode(response.body);
    return racas.map((raca) => Raca.fromJson(raca)).toList();
  }
}
