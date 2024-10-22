import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/data_model.dart'; // Import your model

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  DataModel? _dataModel;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the screen is initialized
  }

  Future<void> _fetchData() async {
    const String url = 'https://dummyjson.com/products'; // API URL
    try {
      final response = await http.get(Uri.parse(url)); // Make the API call
      if (response.statusCode == 200) {
        setState(() {
          _dataModel = DataModel.fromJson(json.decode(response.body)); // Parse JSON to model
          _isLoading = false; // Update loading state
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REST API Example')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : ListView.builder(
        itemCount: _dataModel?.products?.length ?? 0, // Get number of products
        itemBuilder: (context, index) {
          final product = _dataModel!.products![index]; // Get product
          return ListTile(
            leading: Image.network(product.thumbnail ?? ''),
            title: Text(product.title ?? ''),
            subtitle: Text('\$${product.price?.toStringAsFixed(2) ?? ''}'),
          );
        },
      ),
    );
  }
}
