import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tenorio_app/models/cidade.dart';
import 'package:tenorio_app/models/ferrador.dart';
import 'package:tenorio_app/models/veterinario.dart';
import 'package:tenorio_app/utilities/constants.dart';

class User extends ChangeNotifier {
  int id = 0;
  late String name;
  late String email;
  String profileImageUrl =
      '${Constants().baseStorage}users/icon-user-default.png';
  late String password;
  String? profileType;
  bool isPerfilCompleto = false;
  String? dataNascimento;
  Cidade? cidade;
  dynamic profile;

  constructorUser(String name, String email,
      {profileImageUrl,
      password,
      id,
      profileType,
      dataNascimento,
      cidade,
      isPerfilCompleto}) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.profileImageUrl = profileImageUrl;
    this.password = password;
    this.profileType = profileType;
    this.dataNascimento = dataNascimento;
    this.isPerfilCompleto = isPerfilCompleto;
    this.cidade = cidade;
  }

// create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['profile_image_url'] != null) {
      profileImageUrl = (Constants().baseStorage + json['profile_image_url'])
          .replaceFirst('//storage', '/');
    }
    if (json['password'] != null) {
      password = json['password'];
    }
    name = json['name'];
    email = json['email'];

    if (json['profile_type'] == 'App\\Models\\Ferrador') {
      profileType = '0';
      profile = Ferrador.fromJson(json['profile']);
    }

    if (json['profile_type'] == 'App\\Models\\Veterinario') {
      profileType = '1';
      profile = Veterinario.fromJson(json['profile']);
    }
    isPerfilCompleto = json['is_perfil_completo'];
    if (json['data_nascimento'] != null) {
      var inputFormat = DateFormat('yyyy-MM-dd');
      var inputDate =
          inputFormat.parse(json['data_nascimento']); // <-- dd/MM 24H format

      var outputFormat = DateFormat('dd/MM/yyyy');
      var outputDate = outputFormat.format(inputDate);
      dataNascimento = outputDate;
    }
    if (json['cidade'] != null) {
      cidade = Cidade.fromJson(json['cidade']);
    }
  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['profile_image_url'] = profileImageUrl;
    data['password'] = password;
    data['name'] = name;
    data['email'] = email;
    data['profile_type'] = profileType;
    data['is_perfil_completo'] = isPerfilCompleto;
    data['cidade'] = cidade;
    data['data_nascimento'] = dataNascimento;
    return data;
  }
}
