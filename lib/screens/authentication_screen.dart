import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'tab_screen.dart';

enum AuthMode { Signup, Login }

class AuthenticationScreen extends StatelessWidget {
  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: deviceSize.height,
              width: deviceSize.width,
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(top: 80, left: 20),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.none,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              height: deviceSize.height,
              child: Column(
                children: <Widget>[
                  Container(
                    width: deviceSize.width,
                    height: 200,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AuthCard(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An error occurred',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        alignment: Alignment.center,
        title: Text(
          message,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        print(_authData);
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['username']!, _authData['password']!);

        // Sikeres bejelentkezés esetén
        _showSuccessDialog('Successful login');
        _redirectToTabScreen();
      } else {
        print(_authData);

        // Regisztráció esetén ellenőrizze a jelszót
        if (!_isPasswordValid(_authData['password']!)) {
          _showErrorDialog(
              'Password must be at least 8 characters long and include uppercase, lowercase, and a number!');
          setState(() {
            _isLoading = false;
          });
          return;
        }

        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['username']!, _authData['password']!)
            .then((value) {
          _authMode = AuthMode.Login;

          // Sikeres regisztráció esetén
          _showSuccessDialog('Successful registration');
        });
      }
    } catch (error) {
      final errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  bool _isPasswordValid(String password) {
    // Jelszó ellenőrzése reguláris kifejezéssel
    final passwordPattern = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordPattern.hasMatch(password);
  }

  void _redirectToTabScreen() {
    // 2 másodperc várakozás után irányítson át a TabScreen-re
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _authMode == AuthMode.Login ? 450 : 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticInOut,
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey('username'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle_rounded),
                  hintText: 'Username',
                  filled: true,
                  fillColor: Color(0xffdadada),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username cannot be empty!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['username'] = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: const ValueKey('password'),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color(0xffdadada),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (_authMode == AuthMode.Signup &&
                      !_isPasswordValid(value!)) {
                    return 'Password must be at least 8 characters long and include uppercase, lowercase, and a number!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: _submit,
                child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
