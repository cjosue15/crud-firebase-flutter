import 'package:flutter/material.dart';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:login_bloc/src/providers/producto_provider.dart';
import 'package:login_bloc/src/utils/utils.validators.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  ProductModel producto = new ProductModel();
  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.photo_size_select_actual),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(children: <Widget>[
                _crearNombreProducto(),
                SizedBox(height: 15.0),
                _crearPrecio(),
                SizedBox(height: 15.0),
                _crearBoton()
              ])),
        ),
      ),
    );
  }

  Widget _crearNombreProducto() {
    return TextFormField(
      initialValue: producto.titulo,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        return value.isEmpty || value.length < 3 ? 'Ingrese un producto' : null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      onSaved: (value) => producto.valor = double.parse(value),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        return !utils.isNumeric(value) ? 'Ingrese un número valido' : null;
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
        onPressed: _submit, icon: Icon(Icons.save), label: Text('Guardar'));
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print(producto.titulo);
    print(producto.valor);
    productoProvider.crearProducto(producto);
  }
}
