import 'package:flutter/material.dart';
import 'package:login_bloc/src/bloc/login_bloc.dart';
import 'package:login_bloc/src/bloc/provider.dart';
import 'package:login_bloc/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ]),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation;
    final size = isPortrait == Orientation.portrait ? 400.0 : 300.0;

    final fondoMorado = Container(
      height: size,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    final bienvenida = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person,
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(width: double.infinity),
          Text(
            'Carlos Morales',
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          )
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        bienvenida,
        Positioned(
          child: circulo,
          top: 90.0,
          left: 30.0,
        ),
        Positioned(
          child: circulo,
          top: 50.0,
          left: -0.0,
        ),
        Positioned(
          child: circulo,
          bottom: 20.0,
          right: 20.0,
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final providerBloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 200.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                _crearEmail(providerBloc),
                SizedBox(height: 20.0),
                _crearContrasena(providerBloc),
                SizedBox(height: 50.0),
                _crearBoton(providerBloc)
              ],
            ),
          ),
          Text('Ovidaste tu contraseña?'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc providerBloc) {
    return StreamBuilder(
      stream: providerBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: (value) => providerBloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearContrasena(LoginBloc providerBloc) {
    return StreamBuilder(
      stream: providerBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Colors.deepPurple,
              ),
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: providerBloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc providerBloc) {
    return StreamBuilder(
      stream: providerBloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            onPressed:
                snapshot.hasData ? () => _login(providerBloc, context) : null,
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.disabled)
                          ? Colors.grey.shade300
                          : Theme.of(context).colorScheme.primary),
            ),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                child: Text('Ingresar')));
      },
    );
  }

  void _login(LoginBloc bloc, BuildContext context) {
    print(bloc.emailValue);
    Navigator.pushReplacementNamed(context, 'home');
  }
}
