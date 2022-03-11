import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tenorio_app/pages/ocorrencias/relatorio/show.dart';
import 'package:tenorio_app/pages/ocorrencias/show.dart';
import 'package:tenorio_app/pages/profile/index.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:tenorio_app/providers/cidade_provider.dart';
import 'package:tenorio_app/providers/estado_provider.dart';
import 'package:tenorio_app/providers/ocorrencia_provider.dart';
import 'package:tenorio_app/providers/raca_provider.dart';
import 'package:tenorio_app/providers/user_provider.dart';
import 'pages/dashboard/index.dart';
import 'pages/auth/login.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<OcorrenciaProvider>(
                    create: (context) => OcorrenciaProvider(authProvider)),
                ChangeNotifierProvider<UserProvider>(
                    create: (context) => UserProvider(authProvider)),
                ChangeNotifierProvider<EstadoProvider>(
                    create: (context) => EstadoProvider(authProvider)),
                ChangeNotifierProvider<CidadeProvider>(
                    create: (context) => CidadeProvider(authProvider)),
                ChangeNotifierProvider<RacaProvider>(
                    create: (context) => RacaProvider(authProvider)),
              ],
              child: GetMaterialApp(
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('pt', ''),
                    Locale('en', ''),
                  ],
                  title: 'OSCASCOS',
                  theme: ThemeData(
                      scaffoldBackgroundColor: Colors
                          .white /**Color.fromRGBO(123, 133, 143, 1).withOpacity(1.0)**/,
                      primaryColor: const Color.fromRGBO(40, 94, 163, 1),
                      secondaryHeaderColor:
                          const Color.fromRGBO(123, 133, 143, 1)
                              .withOpacity(1.0),
                      bottomAppBarColor: const Color.fromRGBO(40, 94, 163, 1),
                      textTheme: const TextTheme(
                        bodyText1: TextStyle(color: Colors.grey),
                        bodyText2: TextStyle(color: Colors.grey),
                      )),
                  routes: {
                    '/': (context) {
                      // return TestSvgPaint();
                      final authProvider = Provider.of<AuthProvider>(context);
                      if (authProvider.isAuthenticated) {
                        if (authProvider.user.profileType == null) {
                          return const ProfilePage();
                        }
                        return const DashboardScreen();
                      } else {
                        return const LoginScreen();
                      }
                    },
                    '/login': (context) => const LoginScreen(),
                    '/dashboard': (context) {
                      if (authProvider.user.profileType == null) {
                        return const ProfilePage();
                      }
                      return const DashboardScreen();
                    },
                    '/ocorrencia': (context) => const ShowOcorrencia(),
                    '/profile': (context) => const ProfilePage(),
                    '/relatorio': (context) => const ShowRelatorio(),
                  }));
        }));
  }
}
