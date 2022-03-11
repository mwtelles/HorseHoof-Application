
import 'package:flutter/material.dart';
import 'package:tenorio_app/models/ocorrencia.dart'; 
import 'package:tenorio_app/widgets/queue_card.dart'; 

// ignore: must_be_immutable
class OverviewTab extends StatefulWidget {
  List<Ocorrencia> ocorrencias = [];
  OverviewTab(this.ocorrencias, {Key? key}) : super(key: key);


  Widget build(BuildContext context) {

    return Column(
      children: [

        // Learn Card
        QueueCard(
          cardTheme: Colors.grey,
          titleText: 'Ocorrências',
          contentText: 'Total de ocorrências cadastradas',
          inQueue: ocorrencias.length,
          buttonText: 'Ver todas',
          svgPath: '/assets/logo/LOGO-VERSAO-BASICA.svg',
          buttonFunction: () {},
        ),

        // Review Card
        // QueueCard(
        //   cardTheme: Color(0xFF9925EA),
        //   titleText: 'Review',
        //   contentText: 'Review all the vocab you learned so far.',
        //   inQueue: 900,
        //   buttonText: 'Go Review',
        //   svgPath: 'assets/icons/review.svg',
        //   buttonFunction: () {},
        // ),
      ],
    );
  }

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() { 
    throw UnimplementedError();
  }
}