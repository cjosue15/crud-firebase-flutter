import 'package:flutter/material.dart';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:login_bloc/src/providers/producto_provider.dart';

class HomePage extends StatelessWidget {
  final productoProvider = new ProductoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: _crearProductos(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'producto');
      },
      child: Text('Holi'),
    );
  }

  Widget _crearProductos() {
    return FutureBuilder(
      future: productoProvider.obtenerProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        return snapshot.hasData
            ? _listViewProductos(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _listViewProductos(List<ProductModel> productos) {
    return ListView.builder(
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index) =>
            _crearItem(context, productos[index]));
  }

  Widget _crearItem(BuildContext context, ProductModel producto) {
    return Container(
      child: Column(
        children: [
          Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
            ),
            onDismissed: (direccion) {
              productoProvider.borrarProducto(producto.id);
            },
            child: ListTile(
              title: Text(producto.titulo),
              // subtitle: Text(producto.id),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'producto');
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
