import 'dart:async';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenorio_app/models/estado.dart';
import 'package:tenorio_app/models/ocorrencia.dart';
import 'package:tenorio_app/pages/ocorrencias/show.dart';
import 'package:tenorio_app/providers/cidade_provider.dart';
import 'package:tenorio_app/providers/estado_provider.dart';
import 'package:provider/provider.dart';
import 'package:tenorio_app/providers/ocorrencia_provider.dart';
import 'package:tenorio_app/providers/raca_provider.dart';
import 'package:tenorio_app/widgets/app_bar.dart';
import 'package:tenorio_app/widgets/background_mascara.dart';
import 'package:tenorio_app/widgets/frontal.dart';
import 'package:tenorio_app/widgets/lateral_direito.dart';
import 'package:tenorio_app/widgets/lateral_esquerdo.dart';
import 'package:tenorio_app/widgets/palmar.dart';

class CreateOcorrencia extends StatefulWidget {
  const CreateOcorrencia({Key? key}) : super(key: key);

  @override
  _CreateOcorrenciaState createState() => _CreateOcorrenciaState();
}

class _CreateOcorrenciaState extends State<CreateOcorrencia> {
  final _estadosKey = GlobalKey<FormState>();
  final _sexoKey = GlobalKey<FormState>();
  final _racaKey = GlobalKey<FormState>();
  final _cidadesKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome_ocorrencia_controller =
      TextEditingController();
  final TextEditingController _anotacao_controller = TextEditingController();
  final TextEditingController _apelido_controller = TextEditingController();
  final TextEditingController _idade_controller = TextEditingController();
  Map<String, dynamic> fotos_posterior_esquerda = {
    'VISTA LATERAL': null,
    'VISTA PALMAR': null,
    'VISTA FRONTAL': null,
  };
  Map<String, dynamic> fotos_posterior_direita = {
    'VISTA LATERAL': null,
    'VISTA PALMAR': null,
    'VISTA FRONTAL': null,
  };
  Map<String, dynamic> fotos_anterior_esquerda = {
    'VISTA LATERAL': null,
    'VISTA PALMAR': null,
    'VISTA FRONTAL': null,
  };
  Map<String, dynamic> fotos_anterior_direita = {
    'VISTA LATERAL': null,
    'VISTA PALMAR': null,
    'VISTA FRONTAL': null,
  };
  int? _idEstadoSelected;
  String? _selectedSexo;
  String? _selectedRaca;
  String? _selectedEstado;
  String? _selectedCidade;

  void _openCamera(listaDeFotos, {dynamic mascara}) {
    if (listaDeFotos['VISTA LATERAL'] == null) {
      mascara = mascara;
    } else if (listaDeFotos['VISTA PALMAR'] == null) {
      mascara = Palmar();
    } else if (listaDeFotos['VISTA FRONTAL'] == null) {
      mascara = Frontal();
    }

    try {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                    CameraCamera(
                      enableZoom: false,
                      onFile: (file) async {
                        setState(() {
                          if (listaDeFotos['VISTA LATERAL'] == null) {
                            listaDeFotos['VISTA LATERAL'] = file;
                          } else if (listaDeFotos['VISTA PALMAR'] == null) {
                            listaDeFotos['VISTA PALMAR'] = file;
                          } else if (listaDeFotos['VISTA FRONTAL'] == null) {
                            listaDeFotos['VISTA FRONTAL'] = file;
                          }
                        });
                        //When take foto you should close camera
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: CustomPaint(
                        size: Size(
                            MediaQuery.of(context).size.width,
                            (MediaQuery.of(context).size.height)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        foregroundPainter: BackgroundMascara(),
                        isComplex: true,
                        willChange: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: CustomPaint(
                        size: Size(
                            MediaQuery.of(context).size.width,
                            (MediaQuery.of(context).size.height)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        foregroundPainter: mascara,
                        isComplex: true,
                        willChange: true,
                      ),
                    ),
                  ])));
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    List<Estado> estados = Provider.of<EstadoProvider>(context).estados;

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
                    label: Text('Selecione o Estado'),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) async {
                  setState(() => _idEstadoSelected = null);
                  await Provider.of<CidadeProvider>(context, listen: false)
                      .refreshCidades();
                  setState(() {
                    _selectedEstado = newValue;
                    if (newValue != null) {
                      _idEstadoSelected = int.parse(newValue);
                    }
                  });
                },
                items: estados.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.id.toString(),
                    child: Text(value.uf.toString()),
                  );
                }).toList()),
          ),
          Consumer<CidadeProvider>(builder: (context, cidadeProvider, child) {
            if (_idEstadoSelected != null) {
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
                        label: Text('Selecione a Cidade'),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCidade = newValue;
                      });
                      cidadeProvider.cidades
                          .where((cidade) => cidade.id.toString() == newValue)
                          .toList();
                    },
                    items: cidadeProvider.cidades
                        .where((cidade) => cidade.estadoId == _idEstadoSelected)
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(value.nome.toString()),
                      );
                    }).toList()),
              );
            } else {
              return const SizedBox(height: 50.0);
            }
          })
        ],
      );
    }

    return Scaffold(
      appBar: BuildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 5.0,
                    spreadRadius: 2)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0))),
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0, left: 21, right: 21),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cadastrar Ocorrência',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    _buildTextField(
                        _nome_ocorrencia_controller, 'Nome da Ocorrência', 1),
                    _buildTextField(_anotacao_controller, 'Anotação', 2),
                    _buildSelectCidadeByEstadoField(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Dados do Animal',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    _buildTextField(_apelido_controller, 'Apelido', 1),
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          key: _sexoKey,
                          decoration: const InputDecoration(
                              label: Text('Selecione o Sexo'),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSexo = newValue;
                            });
                          },
                          items:
                              ['M', 'F'].map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList()),
                    ),
                    _buildTextField(_idade_controller, 'Idade', 1,
                        is_number: false),
                    Consumer<RacaProvider>(builder: (context, provider, child) {
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
                            key: _racaKey,
                            decoration: const InputDecoration(
                                label: Text('Selecione a Raça'),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRaca = newValue;
                              });
                            },
                            items: provider.racas
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.id.toString(),
                                child: Text(value.nome.toString()),
                              );
                            }).toList()),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Fotos do Animal',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pata posterior esquerda (3 fotos)',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (fotos_posterior_esquerda['VISTA LATERAL'] !=
                                      null &&
                                  fotos_posterior_esquerda['VISTA PALMAR'] !=
                                      null &&
                                  fotos_posterior_esquerda['VISTA FRONTAL'] !=
                                      null) {
                                _showSnackbarLimiteFotos(context);
                              } else {
                                _openCamera(fotos_posterior_esquerda,
                                    mascara: LateralEsquerdo());
                              }
                            },
                            child: const Icon(Icons.add_a_photo)),
                      ],
                    ),
                    _buildListaDeFotos(fotos_posterior_esquerda),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pata posterior direita (3 fotos)',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (fotos_posterior_direita['VISTA LATERAL'] !=
                                      null &&
                                  fotos_posterior_direita['VISTA PALMAR'] !=
                                      null &&
                                  fotos_posterior_direita['VISTA FRONTAL'] !=
                                      null) {
                                _showSnackbarLimiteFotos(context);
                              } else {
                                _openCamera(fotos_posterior_direita,
                                    mascara: LateralDireito());
                              }
                            },
                            child: const Icon(Icons.add_a_photo)),
                      ],
                    ),
                    _buildListaDeFotos(fotos_posterior_direita),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pata anterior esquerda (3 fotos)',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (fotos_anterior_esquerda['VISTA LATERAL'] !=
                                      null &&
                                  fotos_anterior_esquerda['VISTA PALMAR'] !=
                                      null &&
                                  fotos_anterior_esquerda['VISTA FRONTAL'] !=
                                      null) {
                                _showSnackbarLimiteFotos(context);
                              } else {
                                _openCamera(fotos_anterior_esquerda,
                                    mascara: LateralEsquerdo());
                              }
                            },
                            child: const Icon(Icons.add_a_photo)),
                      ],
                    ),
                    _buildListaDeFotos(fotos_anterior_esquerda),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pata anterior direita (3 fotos)',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (fotos_anterior_direita['VISTA LATERAL'] !=
                                      null &&
                                  fotos_anterior_direita['VISTA PALMAR'] !=
                                      null &&
                                  fotos_anterior_direita['VISTA FRONTAL'] !=
                                      null) {
                                _showSnackbarLimiteFotos(context);
                              } else {
                                _openCamera(fotos_anterior_direita,
                                    mascara: LateralDireito());
                              }
                            },
                            child: const Icon(Icons.add_a_photo)),
                      ],
                    ),
                    _buildListaDeFotos(fotos_anterior_direita),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 45.0, horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            bool valid = true;
                            if (fotos_anterior_direita['VISTA LATERAL'] ==
                                    null ||
                                fotos_anterior_direita['VISTA PALMAR'] ==
                                    null ||
                                fotos_anterior_direita['VISTA FRONTAL'] ==
                                    null) {
                              valid = false;
                            }
                            if (fotos_anterior_esquerda['VISTA LATERAL'] ==
                                    null ||
                                fotos_anterior_esquerda['VISTA PALMAR'] ==
                                    null ||
                                fotos_anterior_esquerda['VISTA FRONTAL'] ==
                                    null) valid = false;
                            if (fotos_posterior_esquerda['VISTA LATERAL'] ==
                                    null ||
                                fotos_posterior_esquerda['VISTA PALMAR'] ==
                                    null ||
                                fotos_posterior_esquerda['VISTA FRONTAL'] ==
                                    null) valid = false;
                            if (fotos_posterior_direita['VISTA LATERAL'] ==
                                    null ||
                                fotos_posterior_direita['VISTA PALMAR'] ==
                                    null ||
                                fotos_posterior_direita['VISTA FRONTAL'] ==
                                    null) valid = false;

                            if (!_formKey.currentState!.validate() ||
                                valid == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Row(
                                      children: const [
                                        Icon(Icons.error, color: Colors.white),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            'Preencha todos os dados corretamente')
                                      ],
                                    ),
                                    backgroundColor: Colors.red),
                              );
                            }
                            if (_formKey.currentState!.validate() && valid) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: Row(
                                        children: const [
                                          CircularProgressIndicator(
                                              strokeWidth: 2.0),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('Cadastrando')
                                        ],
                                      ),
                                      backgroundColor: Colors.indigo));

                              _storeOcorrencia();
                            }
                          },
                          child: const Text("Cadastrar"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _storeOcorrencia() async {
    try {
      Map<String, dynamic> json = {
        "nome": _nome_ocorrencia_controller.text,
        "anotacao": _anotacao_controller.text,
        "estado_id": _selectedEstado,
        "cidade_id": _selectedCidade,
        "apelido": _apelido_controller.text,
        "sexo": _selectedSexo,
        "idade": _idade_controller.text,
        "cavalo_raca_id": _selectedRaca,
        "fotos_posterior_esquerda_lateral":
            fotos_posterior_esquerda['VISTA LATERAL'],
        "fotos_posterior_esquerda_palmar":
            fotos_posterior_esquerda['VISTA PALMAR'],
        "fotos_posterior_esquerda_frontal":
            fotos_posterior_esquerda['VISTA FRONTAL'],
        "fotos_posterior_direita_lateral":
            fotos_posterior_direita['VISTA LATERAL'],
        "fotos_posterior_direita_palmar":
            fotos_posterior_direita['VISTA PALMAR'],
        "fotos_posterior_direita_frontal":
            fotos_posterior_direita['VISTA FRONTAL'],
        "fotos_anterior_esquerda_lateral":
            fotos_anterior_esquerda['VISTA LATERAL'],
        "fotos_anterior_esquerda_palmar":
            fotos_anterior_esquerda['VISTA PALMAR'],
        "fotos_anterior_esquerda_frontal":
            fotos_anterior_esquerda['VISTA FRONTAL'],
        "fotos_anterior_direita_lateral":
            fotos_anterior_direita['VISTA LATERAL'],
        "fotos_anterior_direita_palmar": fotos_anterior_direita['VISTA PALMAR'],
        "fotos_anterior_direita_frontal":
            fotos_anterior_direita['VISTA FRONTAL'],
      };

      Ocorrencia ocorrencia =
          await Provider.of<OcorrenciaProvider>(context, listen: false)
              .addOcorrencia(json);
      SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_outline_rounded, color: Colors.white),
              SizedBox(
                width: 20,
              ),
              Text('Cadastrando com sucesso!')
            ],
          ),
          backgroundColor: Colors.green);
      Get.to(() => const ShowOcorrencia(), arguments: ocorrencia);
    } catch (Exception) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(
                width: 20,
              ),
              Text('Erro ao cadastrar ocorrência')
            ],
          ),
          backgroundColor: Colors.red));
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      _showSnackbarLimiteFotos(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Limite de fotos atingido!'),
      duration: const Duration(milliseconds: 2000),
      backgroundColor: Colors.redAccent,
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

  Widget _buildTextField(
      TextEditingController controller, String label, int lines,
      {is_number = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: TextFormField(
        keyboardType: is_number ? TextInputType.number : TextInputType.text,
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

  Widget _buildListaDeFotos(listaDeFotos) {
    List<dynamic> list = [];
    if (listaDeFotos['VISTA LATERAL'] != null) {
      list.add(listaDeFotos['VISTA LATERAL']);
    }
    if (listaDeFotos['VISTA PALMAR'] != null) {
      list.add(listaDeFotos['VISTA PALMAR']);
    }
    if (listaDeFotos['VISTA FRONTAL'] != null) {
      list.add(listaDeFotos['VISTA FRONTAL']);
    }
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:
                    Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  if (list[index] != null)
                    Image.file(
                      list[index],
                      gaplessPlayback: true,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  if (list[index] != null)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          setState(() {
                            if (listaDeFotos['VISTA LATERAL'] == list[index]) {
                              listaDeFotos['VISTA LATERAL'] = null;
                            }
                            if (listaDeFotos['VISTA PALMAR'] == list[index]) {
                              listaDeFotos['VISTA PALMAR'] = null;
                            }
                            if (listaDeFotos['VISTA FRONTAL'] == list[index]) {
                              listaDeFotos['VISTA FRONTAL'] = null;
                            }
                          });
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        )),
                ]),
              );
            }));
  }
}
