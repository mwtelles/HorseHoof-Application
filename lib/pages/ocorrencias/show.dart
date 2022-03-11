import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tenorio_app/models/ocorrencia.dart';
import 'package:tenorio_app/pages/dashboard/index.dart';
import 'package:tenorio_app/pages/ocorrencias/relatorio/show.dart';
import 'package:tenorio_app/utilities/constants.dart';

class ShowOcorrencia extends StatefulWidget {
  const ShowOcorrencia({Key? key}) : super(key: key);

  @override
  _ShowOcorrenciaState createState() => _ShowOcorrenciaState();
}

class _ShowOcorrenciaState extends State<ShowOcorrencia> {
  int indexCarousel = 0;
  final CarouselController _controller = CarouselController();
  Ocorrencia ocorrencia = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CarouselSlider(
              items: ocorrencia.fotos.map<Widget>((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      child: Image.network(
                          "${Constants().baseStorage}${i.path}",
                          height: 400.0,
                          fit: BoxFit.cover),
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  height: 500.0,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      indexCarousel = index;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 440.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 25.0, right: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ocorrencia.nome,
                          style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ocorrencia.createdAt,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(136, 135, 135, 1.0)),
                            ),
                            Text(
                              '${ocorrencia.cidade} - ${ocorrencia.estado}',
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromRGBO(136, 135, 135, 1.0)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 11.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: ocorrencia.statusColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(40.0))),
                          child: Center(
                            child: Text(
                              ocorrencia.statusLabel,
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        if (ocorrencia.relatorioPath != null)
                          ElevatedButton(
                              onPressed: () => Get.to(
                                  () => const ShowRelatorio(),
                                  arguments: Constants().baseStorage +
                                      ocorrencia.relatorioPath.toString()),
                              child: const Text('Ver Relatório')),
                        const SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          '${ocorrencia.anotacao}',
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(136, 135, 135, 1.0)),
                        ),
                        const Divider(
                          height: 50.0,
                        ),
                        _infoCavalo('Apelido:', ocorrencia.cavalo.apelido),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _infoCavalo('Sexo:', ocorrencia.cavalo.sexo),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _infoCavalo('Idade:', ocorrencia.cavalo.idade),
                        const SizedBox(
                          height: 20.0,
                        ),
                        _infoCavalo('Raça:', ocorrencia.cavalo.raca),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 440.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ocorrencia.fotos.asMap().entries.map<Widget>((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Colors.white).withOpacity(
                              indexCarousel == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {
                    Get.to(() => const DashboardScreen());
                  },
                  child: const Icon(Icons.arrow_back_sharp)),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoCavalo(titulo, descricao) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo,
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Text(
          descricao,
          style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(136, 135, 135, 1.0)),
        ),
      ],
    );
  }
}
