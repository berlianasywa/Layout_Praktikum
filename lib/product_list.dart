import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> dummyProducts = List.generate(
    10,
    (index) => Product(
      name: 'Barang ${index + 1}',
      price: (index + 1) * 10000,
    ),
  );

  void _addProduct() {
    int newIndex = dummyProducts.length + 1;
    Product newProduct = Product(
      name: 'Barang $newIndex',
      price: newIndex * 10000,
    );
    setState(() {
      dummyProducts.add(newProduct);
    });
  }

  void _removeProduct(int index) {
    setState(() {
      dummyProducts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Produk"),
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];

          // Konversi harga ke dalam format mata uang Rupiah
          final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
          final formattedPrice = currencyFormatter.format(product.price);

          return ListTile(
            title: Text(product.name),
            subtitle: Text('Harga: $formattedPrice'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeProduct(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addProduct();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListPage(),
      ),
    );
