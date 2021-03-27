import 'dart:convert';
import 'package:login_bloc/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductoProvider {
  final _url = 'https://flutter-crud-cddfa-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductModel producto) async {
    try {
      final url = '$_url/productos.json';
      final response =
          await http.post(Uri.parse(url), body: productModelToJson(producto));

      final decodedData = json.decode(response.body);
      print(decodedData);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ProductModel>> obtenerProductos() async {
    try {
      final url = '$_url/productos.json';
      final response = await http.get(Uri.parse(url));

      final Map<String, dynamic> decodedData = json.decode(response.body);

      final List<ProductModel> productos = [];

      if (decodedData == null) return [];

      decodedData.forEach((id, prod) {
        final prodTemp = new ProductModel.fromJson(prod);
        prodTemp.id = id;
        productos.add(prodTemp);
      });
      return productos;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> borrarProducto(String id) async {
    try {
      final url = '$_url/productos/$id.json';
      final response = await http.delete(Uri.parse(url));
      print(json.decode(response.body));
      return true;
    } catch (e) {
      return false;
    }
  }
}
