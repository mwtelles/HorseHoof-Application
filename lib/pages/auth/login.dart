import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/route_manager.dart';
import 'package:tenorio_app/providers/auth_provider.dart';
import 'package:tenorio_app/utilities/constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreen();

  static const routeName = '/auth/login';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      additionalSignupFields: const [
        UserFormField(keyName: 'nome_completo', displayName: 'Nome Completo'),
      ],
      logo: 'assets/logo/LOGO-VERSAO-BASICA.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      title: 'O portal referência em cascos no Brasil',
      navigateBackAfterRecovery: true,
      hideProvidersTitle: false,
      loginAfterSignUp: false,
      hideForgotPasswordButton: true,
      // hideSignUpButton: true,
      userType: LoginUserType.email,
      disableCustomPageTransformer: false,
      messages: LoginMessages(
          additionalSignUpFormDescription:
              'Por favor, preencha os dados a seguir para finalizar o cadastro',
          additionalSignUpSubmitButton: 'Cadastrar',
          userHint: 'Email',
          passwordHint: 'Senha',
          confirmPasswordHint: 'Confirmar senha',
          loginButton: 'Entrar',
          signupButton: 'Cadastrar',
          forgotPasswordButton: 'Esqueceu a senha?',
          //   recoverPasswordButton: 'HELP ME',
          goBackButton: 'VOLTAR',
          confirmPasswordError: 'As senhas não são iguais!',
          //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
          //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          //   recoverPasswordSuccess: 'Password rescued successfully',
          flushbarTitleError: 'Ops!',
          flushbarTitleSuccess: 'Sucesso!',
          signUpSuccess: 'Cadastro realizado com sucesso'
          //   providersTitle: 'login with'
          ),
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        errorColor: Colors.deepOrange,
        logoWidth: 0.80,
        titleStyle: TextStyle(
            color: ThemeData().primaryColor,
            fontFamily: 'ITC Avant Garde Gothic',
            fontSize: 10.0),
        beforeHeroFontSize: 18,
        afterHeroFontSize: 0,
        bodyStyle: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
        textFieldStyle: const TextStyle(color: Colors.grey, height: 1.6),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        cardTheme: CardTheme(
          color: ThemeData().primaryColor,
          elevation: 6,
          margin: const EdgeInsets.only(top: 50),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50.0)),
        ),
        inputTheme: InputDecorationTheme(
          alignLabelWithHint: false,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            color: Colors.red.shade700,
          ),
          labelStyle: const TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade800, width: 3),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 2),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: ThemeData().primaryColor,
          backgroundColor: Colors.white,
          highlightColor: ThemeData().primaryColor,
          elevation: 2.0,
          highlightElevation: 9.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email deve conter '@' e terminar com '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Senha vazia';
        }
        return null;
      },
      onLogin: (loginData) => _loginUser(loginData),
      onSignup: (registerData) => _registerUser(registerData),
      onSubmitAnimationCompleted: () {
        Get.toNamed('/dashboard');
      },
      onRecoverPassword: (name) {
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }

  Future<String?> _loginUser(LoginData data) async {
    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      await provider.login(
        data.name,
        data.password,
      );
    } catch (Exception) {
      return Exception.toString().replaceAll('Exception: ', '');
    }
    return null;
  }

  Future<String?> _registerUser(SignupData data) async {
    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      await provider.register(
        data.additionalSignupData!['nome_completo'],
        data.name,
        data.password,
      );
    } catch (Exception) {
      return Exception.toString().replaceAll('Exception: ', '');
    }
    return null;
  }
}
