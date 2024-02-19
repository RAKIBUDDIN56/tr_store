import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store/config/routes/routes_location.dart';
import 'package:tr_store/provider/cart_provider.dart';
import 'package:tr_store/widgets/text_widget.dart';
import 'package:tr_store/widgets/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: const Text('Product List'),
        actions: [
          badge(context),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: body(),
    );
  }

  Consumer<CartProvider> body() {
    return Consumer<CartProvider>(
      builder: (context, provider, child) => provider.products.isEmpty &&
              provider.error != null
          ? Text(provider.error!)
          : provider.isLoading
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  itemCount: 5,
                  itemBuilder: (context, index) => const ShimmerEffect(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  shrinkWrap: true,
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () =>
                          context.push("${RouteLocation.detail}/$index"),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 120,
                        child: Card(
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  width: 100,
                                  height: 200,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      TextWidget(
                                        text: provider.products[index].title,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            maxLines: 1,
                                            text: TextSpan(
                                                text: 'Price: ' r"$",
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 16.0),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          '${provider.products[index].userId.toString()}\n',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                          ),
                                          const Spacer(),
                                          OutlinedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              onPressed: () async {
                                                bool res = await provider
                                                    .saveData(index);
                                                if (res) {
                                                  showToast(
                                                      "Product added to Cart");
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
                          ),
                        ),
                      ),
                    );
                  }),
    );
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

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 120,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(8)),
        child: const Card(color: Colors.white),
      ),
    );
  }
}
