import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tenorio_app/models/estado.dart';
import 'package:tenorio_app/models/ferrador.dart';
import 'package:tenorio_app/models/user.dart';
import 'package:tenorio_app/models/veterinario.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:tenorio_app/providers/cidade_provider.dart';
import 'package:tenorio_app/providers/estado_provider.dart';
import 'package:tenorio_app/providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _is_loading = false;
  DateTime? _dateTime;

  int? _selectedEstado;
  int? _selectedCidade;
  final TextEditingController _name_controller = TextEditingController();
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _nascimento_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _associacao_controller = TextEditingController();
  final TextEditingController _especializacao_controller =
      TextEditingController();
  final TextEditingController _qualificacao_controller =
      TextEditingController();
  final TextEditingController _tempo_no_mercado_controller =
      TextEditingController();
  final _estadosKey = GlobalKey<FormState>();
  final _cidadesKey = GlobalKey<FormState>();
  int _is_estudante = 1;
  int? _idEstadoSelected;
  String? _profile_type;
  int? _is_membro_AFB;
  @override
  initState() {
    User user = Provider.of<AuthProvider>(context, listen: false).user;
    user.profile ??= Ferrador();
    if (user.profileType == '0') {
      _is_membro_AFB = user.profile.isMembroAfb;
      if (user.profile?.associacao != null) {
        _associacao_controller.text = user.profile?.associacao;
      }
      if (user.profile?.qualificacao != null) {
        _qualificacao_controller.text = user.profile?.qualificacao;
      }
    }

    if (user.profileType == '1') {
      if (user.profile?.especializacao != null) {
        _especializacao_controller.text = user.profile?.especializacao;
      }
      if (user.profile?.especializacao != null) {
        _tempo_no_mercado_controller.text = user.profile?.tempoNoMercado;
      }
      if (user.profile?.isEstudante != null) {
        _is_estudante = user.profile?.isEstudante;
      }
    }

    _profile_type = user.profileType;
    _is_loading = false;
    _idEstadoSelected = user.cidade?.estadoId;
    _selectedEstado = user.cidade?.estadoId;
    _selectedCidade = user.cidade?.id;
    _name_controller.text = user.name;
    _email_controller.text = user.email;
    if (user.dataNascimento != null) {
      _nascimento_controller.text = user.dataNascimento.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).user;
    List<Estado> estados = Provider.of<EstadoProvider>(context).estados;

    void _openFileExplorer() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _is_loading = true;
        });
        var file = result.files.first;

        Map<String, dynamic> json = {"id": user.id, "profile_image_url": file};
        try {
          await Provider.of<UserProvider>(context, listen: false)
              .updateProfileImage(json);
        } catch (_) {}

        setState(() {
          _is_loading = false;
        });
      } else {
        // User canceled the picker
      }
    }

    Widget _buildSelectCidadeByEstadoField() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                enableFeedback: true,
                key: _estadosKey,
                decoration: const InputDecoration(
                    label: Text('Selecione seu Estado'),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (int? newValue) async {
                  setState(() => _idEstadoSelected = null);
                  await Provider.of<CidadeProvider>(context, listen: false)
                      .refreshCidades();
                  setState(() {
                    _selectedEstado = newValue;
                    if (newValue != null) {
                      _idEstadoSelected = newValue;
                    }
                  });
                },
                value: _idEstadoSelected,
                items: estados.map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Text(value.uf.toString()),
                  );
                }).toList()),
          ),
          Consumer<CidadeProvider>(builder: (context, cidadeProvider, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  enableFeedback: true,
                  key: _cidadesKey,
                  decoration: const InputDecoration(
                      label: Text('Selecione sua Cidade'),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedCidade = newValue;
                    });
                    cidadeProvider.cidades
                        .where((cidade) => cidade.id == newValue)
                        .toList();
                  },
                  value: _selectedCidade,
                  items: cidadeProvider.cidades
                      .where((cidade) => cidade.estadoId == _selectedEstado)
                      .map<DropdownMenuItem<int>>((value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Text(value.nome.toString()),
                    );
                  }).toList()),
            );
          })
        ],
      );
    }

    Widget _buildDateField() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: _buildTextField(
                    _nascimento_controller, 'Data de Nascimento', 1,
                    is_disabled: true)),
            const SizedBox(width: 10),
            ElevatedButton(
              child: Row(
                children: const [
                  Text('Selecionar data'),
                  SizedBox(width: 5),
                  Icon(Icons.date_range),
                ],
              ),
              onPressed: () {
                showDatePicker(
                        locale: const Locale("pt", "BR"),
                        context: context,
                        initialDate: user.dataNascimento != null
                            ? DateFormat('dd/MM/yyyy')
                                .parse(user.dataNascimento.toString())
                            : DateTime.now(),
                        firstDate: DateTime.parse('1940-01-01'),
                        lastDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    _dateTime = date;
                    _nascimento_controller.text =
                        "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}";
                  });
                });
              },
            )
          ]);
    }

    Widget _buildSelectIsMembroAFB() {
      return Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == 'null') {
              return 'Campo obrigatório';
            }
            return null;
          },
          enableFeedback: true,
          decoration: const InputDecoration(
              label: Text('É membro da AFB?'),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (newValue) {
            setState(() {
              _is_membro_AFB = int.parse(newValue.toString());
            });
          },
          value: _is_membro_AFB,
          items: const [
            DropdownMenuItem<int>(
              value: 0,
              child: Text('Não'),
            ),
            DropdownMenuItem<int>(
              value: 1,
              child: Text('Sim'),
            ),
          ],
        ),
      );
    }

    Widget _buildSelectIsEstudante() {
      return Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == 'null') {
              return 'Campo obrigatório';
            }
            return null;
          },
          enableFeedback: true,
          decoration: const InputDecoration(
              label: Text('Ocupação'),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (newValue) {
            setState(() {
              _is_estudante = int.parse(newValue.toString());
            });
          },
          value: user.profile.isEstudante ?? 0,
          items: const [
            DropdownMenuItem<int>(
              value: 1,
              child: Text('Estudante'),
            ),
            DropdownMenuItem<int>(
              value: 0,
              child: Text('Profissional'),
            ),
          ],
        ),
      );
    }

    Widget _buildSelectTipoConta() {
      return Padding(
        padding: const EdgeInsets.only(top: 22.0),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == 'null') {
              return 'Campo obrigatório';
            }
            return null;
          },
          enableFeedback: true,
          decoration: const InputDecoration(
              label: Text('Selecione o tipo de conta'),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)))),
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          onChanged: (String? newValue) {
            setState(() {
              _profile_type = newValue.toString();
              if (newValue == '0') {
                user.profile = Ferrador();
              }
              if (newValue == '1') {
                user.profile = Veterinario();
              }
            });
          },
          value: user.profileType,
          items: [
            DropdownMenuItem<String>(
              value: 0.toString(),
              child: const Text('Ferrador'),
            ),
            DropdownMenuItem<String>(
              value: 1.toString(),
              child: const Text('Veterinario'),
            ),
          ],
        ),
      );
    }

    Widget _buildFormByTipoConta() {
      if (_profile_type == '0') {
        return Column(
          children: [
            _buildSelectIsMembroAFB(),
            if (_is_membro_AFB == 0)
              _buildTextField(
                  _associacao_controller, 'Informe sua associação', 1),
            _buildTextField(
                _qualificacao_controller, 'Informe sua qualificação', 1)
          ],
        );
      }
      if (_profile_type == '1') {
        return Column(
          children: [
            _buildSelectIsEstudante(),
            if (_is_estudante == 0)
              Column(children: [
                _buildTextField(
                    _especializacao_controller, "Especialização", 1),
                _buildTextField(
                    _tempo_no_mercado_controller, "Tempo no mercado", 1)
              ])
          ],
        );
      }
      return const SizedBox(height: 5);
    }

    String? _validateForm(profile_type, json) {
      if (json["profile_type"] == null) return 'Selecione o tipo de conta';
      if (json["id"] == null) return 'Ocorreu um erro ao validar o formulário';
      if (json["name"] == null) return 'O campo nome é obrigatório';
      if (json["email"] == null) return 'O email é obrigatório';
      if (json["data_nascimento"] == null || json["data_nascimento"] == '') {
        return 'A data de nascimento é obrigatória';
      }
      if (json["cidade_id"] == null) {
        return 'Selecione sua cidade e estado de atuação';
      }

      if (profile_type == '0') {
        if (json["is_membro_afb"] == null) return 'Informe se é membro da AFB';
        if (json["qualificacao"] == null || json["qualificacao"] == '') {
          return 'Informe sua qualificação';
        }
        if (json["is_membro_afb"] == '0') {
          if (json["associacao"] == null || json["associacao"] == '') {
            return 'Informe sua associação';
          }
        }
      }
      if (profile_type == '1') {
        if (json["is_estudante"] == null) {
          return 'Informe se é um estudante ou profissional da área';
        }
        if (json["is_estudante"] == '0') {
          if (json["especializacao"] == null || json["especializacao"] == '') {
            return 'Informe sua especialização';
          }
          if (json["tempo_no_mercado"] == null ||
              json["tempo_no_mercado"] == '') {
            return 'Informe seu tempo no mercado';
          }
        }
      }
      return null;
    }

    Future<void> _updateUser(id, name, email, password, {profileType}) async {
      try {
        Map<String, dynamic> json = {
          'id': id.toString(),
          'name': name,
          'email': email,
          'profile_type': profileType,
          'data_nascimento': _nascimento_controller.text.toString(),
          'cidade_id': _selectedCidade.toString(),
        };

        if (profileType == '0') {
          json.addAll({
            'is_membro_afb': _is_membro_AFB.toString(),
            'qualificacao': _qualificacao_controller.text,
          });
          if (_is_membro_AFB == 0) {
            json.addAll({
              'associacao': _associacao_controller.text,
            });
          }
        }

        if (profileType == '1') {
          json.addAll({
            'is_estudante': _is_estudante.toString(),
          });
          if (_is_estudante == 0) {
            json.addAll({
              'especializacao': _especializacao_controller.text,
              'tempo_no_mercado': _tempo_no_mercado_controller.text,
            });
          }
        }

        if (password != null && password != "") {
          json['password'] = password;
        }
        String? validarJson = _validateForm(profileType, json);
        if (validarJson != null) {
          _buildAlertMessage(validarJson);
          return;
        }
        await Provider.of<UserProvider>(context, listen: false)
            .updateUser(json);
        User newUser = await Provider.of<AuthProvider>(context, listen: false)
            .getUserAuth();

        if (user.profileType == null && newUser.profileType != null) {
          Get.toNamed('/dashboard');
        }
        _buildAlertMessage('Usuario atualizado!', color: Colors.green);
      } catch (e) {
        var error = e.toString().replaceAll('Exception:', '');
        _buildAlertMessage(error);
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: (user.profileType == null)
              ? null
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () => Get.toNamed('/dashboard'),
                  child:
                      const Icon(Icons.arrow_back_sharp, color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Consumer<AuthProvider>(builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      (user.isPerfilCompleto == false)
                          ? 'Complete seu perfil'
                          : 'Editar Perfil',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (!_is_loading &&
                            !provider.user.profileImageUrl.isEmpty)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.grey,
                                    spreadRadius: 2)
                              ],
                            ),
                            child: CircleAvatar(
                              maxRadius: 70.0,
                              foregroundColor: Colors.blue,
                              backgroundImage:
                                  NetworkImage(provider.user.profileImageUrl),
                            ),
                          ),
                        if (!_is_loading)
                          Positioned(
                              bottom: 0,
                              right: -25,
                              child: RawMaterialButton(
                                onPressed: () {
                                  _openFileExplorer();
                                },
                                elevation: 2.0,
                                fillColor: const Color(0xFFF5F6F9),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.blue,
                                ),
                                padding: const EdgeInsets.all(15.0),
                                shape: const CircleBorder(),
                              )),
                        if (_is_loading)
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey,
                                      spreadRadius: 2)
                                ],
                              ),
                              child: const CircularProgressIndicator()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Informações pessoais',
                      style: TextStyle(fontSize: 16)),
                  _buildTextField(_name_controller, 'Nome', 1),
                  _buildTextField(_email_controller, 'Email', 1),
                  if (user.isPerfilCompleto == true)
                    _buildTextField(_password_controller, 'Nova Senha', 1,
                        is_password: true),
                  _buildDateField(),
                  const SizedBox(height: 20),
                  const Text('Local de Atuação',
                      style: TextStyle(fontSize: 16)),
                  _buildSelectCidadeByEstadoField(),
                  const SizedBox(height: 20),
                  const Text('Perfil profissional',
                      style: TextStyle(fontSize: 16)),
                  _buildSelectTipoConta(),
                  _buildFormByTipoConta(),
                  const SizedBox(height: 20),
                  Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _is_loading = true;
                            });
                            await _updateUser(
                                user.id,
                                _name_controller.text,
                                _email_controller.text,
                                _password_controller.text,
                                profileType: _profile_type);

                            setState(() {
                              _is_loading = false;
                              _name_controller.text = provider.user.name;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: (_is_loading == false)
                                ? const Text('Salvar',
                                    style: TextStyle(fontSize: 20))
                                : const CircularProgressIndicator(),
                          )))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, int lines,
      {is_number = false, is_password = false, is_disabled = false}) {
    TextInputType keyboardType = TextInputType.text;

    if (is_number) keyboardType = TextInputType.number;
    if (is_password) keyboardType = TextInputType.visiblePassword;
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: TextFormField(
        readOnly: is_disabled,
        keyboardType: keyboardType,
        maxLines: lines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }

  void _buildAlertMessage(message,
      {Icon icon = const Icon(Icons.save, color: Colors.white),
      Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Flexible(child: Text(message)),
        ],
      ),
      duration: const Duration(milliseconds: 4000),
      backgroundColor: color,
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 15.0 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }
}
