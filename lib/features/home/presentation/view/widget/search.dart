import 'package:flutter/material.dart';

class Product {
  final String label;

  Product(this.label);
}

class CustomSearch extends StatelessWidget {
  final List<Product> products;
  final SearchController searchController;

  const CustomSearch({
    Key? key,
    required this.products,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: "Search recipes",
      searchController: searchController,
      suggestionsBuilder: (context, controller) {
        final input = controller.value.text;
        final filtered = products
            .where((p) => p.label.toLowerCase().contains(input.toLowerCase()))
            .toList();

        return List<Widget>.generate(filtered.length, (index) {
          final product = filtered[index];
          return ListTile(
            title: Text(product.label),
            onTap: () {
              controller.closeView(product.label);
              // you can add callback or navigation here
            },
          );
        });
      },
    );
  }
}
