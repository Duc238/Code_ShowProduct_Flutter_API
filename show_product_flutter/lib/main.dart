import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'api_service.dart';
import 'Products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isLoading = true;
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    LoadData();
    futureProducts = ApiService().fetchProducts();
  }

  Future<void> LoadData() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Danh sách sản phẩm',
            style: TextStyle(color: Colors.amberAccent),
          ),
        ),
        body: SafeArea(
            child: Skeletonizer(
                ignoreContainers: true,
                enabled: isLoading,
                child: FutureBuilder<List<Product>>(
                    future: futureProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products found'));
                      } else {
                        final products = snapshot.data!;
                        return LayoutBuilder(builder: (context, constraints) {
                          int crossAxisCount = 2;
                          if (constraints.maxWidth > 1200) {
                            crossAxisCount = 4;
                          } else if (constraints.maxWidth > 800) {
                            crossAxisCount = 3;
                          }
                          return GridView.builder(
                            padding: EdgeInsets.all(10.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Container(
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.amberAccent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        product.Name,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '\$${product.Price}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        });
                      }
                    }))));
  }
}
