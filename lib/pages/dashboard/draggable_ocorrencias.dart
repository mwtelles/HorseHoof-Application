import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenorio_app/models/ocorrencia.dart';
import 'package:tenorio_app/pages/ocorrencias/show.dart';
import 'package:tenorio_app/providers/ocorrencia_provider.dart';
import 'package:provider/provider.dart';

class DraggableOcorrencias extends StatefulWidget {
  const DraggableOcorrencias({Key? key}) : super(key: key);

  @override
  _DraggableOcorrenciasState createState() => _DraggableOcorrenciasState();
}

class _DraggableOcorrenciasState extends State<DraggableOcorrencias> {
  bool _loading_draggable = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<OcorrenciaProvider>(builder: (context, provider, child) {
      return DraggableScrollableSheet(
          initialChildSize: .27,
          minChildSize: .27,
          maxChildSize: .98,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset.zero,
                        blurRadius: 10.0,
                        spreadRadius: 2)
                  ],
                  color: ThemeData().primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              height: 800.0,
              width: double.infinity,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ThemeData().secondaryHeaderColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      width: 80,
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(29.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ocorrências',
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          TextField(
                            onChanged: (value) {
                              List<Ocorrencia> result =
                                  provider.ocorrencias.where((i) {
                                return i.nome
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    i.id.toString() == value;
                              }).toList();

                              if (result.isNotEmpty && value != '') {
                                Provider.of<OcorrenciaProvider>(context,
                                        listen: false)
                                    .searchOcorrencias(result);
                              }
                              if (result.isEmpty || value == '') {
                                Provider.of<OcorrenciaProvider>(context,
                                        listen: false)
                                    .refreshOcorrencias();
                              }
                            },
                            obscureText: false,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(35, 80, 137, 0.5),
                                prefixIcon: Icon(Icons.search_outlined),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(35, 80, 137, 0.5),
                                        width: 0.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(73.0))),
                                labelText: 'Pesquisar',
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          if (!_loading_draggable)
                            Consumer<OcorrenciaProvider>(builder:
                                (BuildContext context, provider, index) {
                              return RefreshIndicator(
                                  onRefresh: () =>
                                      Provider.of<OcorrenciaProvider>(context,
                                              listen: false)
                                          .refreshOcorrencias(),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    itemCount: provider.ocorrencias.length,
                                    itemBuilder: (context, index) {
                                      final ocorrencia =
                                          provider.ocorrencias[index];
                                      return buildOcorrenciaTile(ocorrencia);
                                    },
                                  ));
                            }),
                          if (_loading_draggable)
                            const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  Widget buildOcorrenciaTile(Ocorrencia ocorrencia) {
    var style = const TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20.0);
    return TextButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: ThemeData().primaryColor,
      ),
      onPressed: () async {
        setState(() {
          _loading_draggable = true;
        });
        await Provider.of<OcorrenciaProvider>(context, listen: false)
            .refreshOcorrencias();
        ocorrencia = Provider.of<OcorrenciaProvider>(context, listen: false)
            .ocorrencias
            .firstWhere((oc) => oc.id == ocorrencia.id);
        Get.to(() => const ShowOcorrencia(), arguments: ocorrencia);
        setState(() {
          _loading_draggable = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 29.0, right: 13.0, bottom: 35.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '#${ocorrencia.id}',
              style: style,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(text: ocorrencia.nome, style: style)),
            ),
            if (ocorrencia.status == 0)
              const Icon(
                Icons.pending,
                color: Colors.white,
              )
            else if (ocorrencia.status == 1)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            else if (ocorrencia.status == 2)
              const Icon(
                Icons.close_rounded,
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }
}
