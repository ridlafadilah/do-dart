import 'package:do_dart/app_theme.dart';
import 'package:do_dart/main/main_app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isButtonDisabled = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> doLogin() async {
    Navigator.of(context).pushNamed(MainAppHomeScreen.tag);
  }

  @override
  Widget build(BuildContext context) {
    final title = Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Login',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontSize: 35,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final subtitle = Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Hello! Login with your username or email.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    final email = TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'Username or email :',
          hintText: 'Username / Email',
          contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (txt) {
          if (txt.length == 0) {
            setState(() {
              isButtonDisabled = true;
            });
          } else {
            setState(() {
              if (passwordController.text.length == 0)
                isButtonDisabled = true;
              else
                isButtonDisabled = false;
            });
          }
        });

    final password = TextFormField(
        controller: passwordController,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password :',
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        onChanged: (txt) {
          if (txt.length == 0) {
            setState(() {
              isButtonDisabled = true;
            });
          } else {
            setState(() {
              print(emailController.text);
              if (emailController.text.length == 0)
                isButtonDisabled = true;
              else
                isButtonDisabled = false;
            });
          }
        });

    final forgotLabel = Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            'Forgot password?',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: () {},
        ));

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Container(
          decoration: isButtonDisabled
              ? null
              : BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 2.0),
                  ],
                ),
          child: MaterialButton(
            color: AppTheme.button,
            disabledColor: AppTheme.buttonDisable,
            minWidth: 200.0,
            height: 48.0,
            onPressed: isButtonDisabled ? null : () => doLogin(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isButtonDisabled
                        ? AppTheme.buttonTextDisable
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final additionalTitle = Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'or enter with:',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

    final google = IconButton(
      icon: SvgPicture.asset(
        'assets/eva_icons/fill/svg/google.svg',
        color: AppTheme.colorTheme,
      ),
      onPressed: () {},
    );

    final register = Container(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  'Don' 't have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            InkWell(
              onTap: () {},
              child: new Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colorTheme,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]),
    );

    final termsCondition = Container(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () {},
        child: new Text(
          'Terms & Conditions',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppTheme.colorTheme,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            title,
            SizedBox(height: 8.0),
            subtitle,
            SizedBox(height: 35.0),
            email,
            SizedBox(height: 8.0),
            forgotLabel,
            password,
            SizedBox(height: 24.0),
            loginButton,
            additionalTitle,
            SizedBox(height: 20.0),
            google,
            SizedBox(height: 20.0),
            register,
            SizedBox(height: 35.0),
            termsCondition,
          ],
        ),
      ),
    );
  }
}
