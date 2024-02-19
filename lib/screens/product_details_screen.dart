import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/config/routes/routes_location.dart';
import 'package:tr_store/provider/cart_provider.dart';
import 'package:tr_store/widgets/text_widget.dart';
import 'package:tr_store/widgets/toast.dart';

class ProductDetailsScrren extends StatefulWidget {
  final int index;
  const ProductDetailsScrren({super.key, required this.index});

  @override
  State<ProductDetailsScrren> createState() => _ProductDetailsScrrenState();
}

class _ProductDetailsScrrenState extends State<ProductDetailsScrren> {
  @override
  void initState() {
    context.read<CartProvider>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Product Details'),
        actions: [
          
          badge(context),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: body(widget.index),
    );
  }

  Consumer<CartProvider> body(int index) {
    return Consumer<CartProvider>(
        builder: (context, provider, child) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          width: 120,
                          height: 120,
                          provider.products[index].image,
                          fit: BoxFit.fill,
                          // loadingBuilder: (context, child, loadingProgress) =>
                          //     const CupertinoActivityIndicator(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextWidget(
                                text: provider.products[index].title,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                        text: 'Price: ' r"$",
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade800,
                                            fontSize: 16.0),
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${provider.products[index].userId.toString()}\n',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  const Spacer(),
                                  OutlinedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () async {
                                        bool res =
                                            await provider.saveData(index);
                                        if (res) {
                                          showToast("Product added to Cart");
                                        } else {
                                          showToast(
                                              "Product already added to Cart");
                                        }
                                      },
                                      child: const TextWidget(
                                        text: 'Add to Cart',
                                        size: 14,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(provider.products[index].content)
                  ],
                ),
              ),
            ));
  }

  Badge badge(BuildContext context) {
    return Badge(
      label: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Text(
            value.getCounter().toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          );
        },
      ),
      child: IconButton(
        onPressed: () {
          context.push(
            RouteLocation.cart,
          );
        },
        icon: const Icon(
          Icons.shopping_cart,
          size: 30,
        ),
      ),
    );
  }
}
