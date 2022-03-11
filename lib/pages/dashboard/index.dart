import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenorio_app/pages/auth/login.dart';
import 'package:tenorio_app/pages/dashboard/card_counter.dart';
import 'package:tenorio_app/pages/dashboard/draggable_ocorrencias.dart';
import 'package:tenorio_app/pages/ocorrencias/create.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:tenorio_app/providers/ocorrencia_provider.dart';
import 'package:tenorio_app/utilities/transition_route_observer.dart';
import 'package:provider/provider.dart';
import 'package:tenorio_app/widgets/app_bar.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, TransitionRouteAware {
  Future<bool> _goToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushReplacementNamed(LoginScreen.routeName)
        // we dont want to pop the screen, just replace it completely
        .then((_) => false);
  }

  final routeObserver = TransitionRouteObserver<PageRoute?>();
  AnimationController? _loadingController;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute<dynamic>?);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _loadingController!.dispose();
    super.dispose();
  }

  @override
  void didPushAfterTransition() => _loadingController!.forward();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () => _goToLogin(context),
      child: SafeArea(
        child: Scaffold(
          appBar: BuildAppBar(context),
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(29.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          'Olá, ${provider.user.name}!',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        );
                      },
                    ),
                    const Divider(
                      height: 12.0,
                      color: Colors.white,
                    ),
                    const Text(
                      'Bem vindo ao portal referência em cascos no Brasil',
                      style: TextStyle(
                        color: Color.fromRGBO(114, 136, 147, 1.0),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Divider(
                      height: 38.0,
                      color: Colors.white,
                    ),
                    Consumer<OcorrenciaProvider>(
                        builder: (context, provider, child) {
                      return Column(
                        children: [
                          CardCounter('Total de Ocorrencias',
                              provider.ocorrencias.length),
                          const Divider(
                            height: 38.0,
                            color: Colors.white,
                          ),
                          const CardCounter('Cavalos Cadastrados', 0)
                        ],
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Container(
                        height: 168,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                height: 168,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                ),
                                child: const Center(
                                    child: Text('Espaço reservado para anuncio',
                                        style: TextStyle(color: Colors.white))),
                              ),
                              Container(
                                height: 168,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: const Center(
                                    child: Text('Espaço reservado para anuncio',
                                        style: TextStyle(color: Colors.white))),
                              ),
                              Container(
                                height: 168,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: const Center(
                                    child: Text('Espaço reservado para anuncio',
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              const DraggableOcorrencias(),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.green,
                      primary: Colors.white,
                      minimumSize: const Size(88, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0)),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const CreateOcorrencia());
                    },
                    child: const Text('Nova Ocorrência'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
