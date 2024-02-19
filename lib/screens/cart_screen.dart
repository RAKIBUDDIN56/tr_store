import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tr_store/data/db_helper.dart';
import 'package:tr_store/data/models/cart_model.dart';
import 'package:tr_store/provider/cart_provider.dart';
import 'package:tr_store/widgets/text_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static CartScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CartScreen();

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final getIt = GetIt.instance;

  List<bool> tapped = [];

  @override
  void initState() {
    super.initState();

    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Shopping Cart'),
        actions: [
          Badge(
            label: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            // position: const BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                      child: Text(
                    'Your Cart is Empty',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ));
                } else {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          elevation: 5.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.network(
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                                provider.cart[index].image!,
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    TextWidget(
                                      text: provider.cart[index].productName!,
                                      size: 18,
                                    ),
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
                                                    '${provider.cart[index].productPrice!}\n',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              ValueListenableBuilder<int>(
                                  valueListenable:
                                      provider.cart[index].quantity!,
                                  builder: (context, val, child) {
                                    return PlusMinusButtons(
                                      addQuantity: () {
                                        cart.addQuantity(
                                            provider.cart[index].id!);
                                        provider
                                            .getIt<DBHelper>()
                                            .updateQuantity(Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: provider
                                                    .cart[index].productName,
                                                productPrice: provider
                                                    .cart[index].productPrice,
                                                quantity: ValueNotifier(provider
                                                    .cart[index]
                                                    .quantity!
                                                    .value),
                                                image:
                                                    provider.cart[index].image))
                                            .then((value) {
                                          setState(() {
                                            cart.addTotalPrice(double.parse(
                                                provider
                                                    .cart[index].productPrice
                                                    .toString()));
                                          });
                                        });
                                      },
                                      deleteQuantity: () {
                                        cart.deleteQuantity(
                                            provider.cart[index].id!);
                                        cart.removeTotalPrice(double.parse(
                                            provider.cart[index].productPrice
                                                .toString()));
                                      },
                                      text: val.toString(),
                                    );
                                  }),
                              IconButton(
                                  onPressed: () {
                                    provider.getIt<DBHelper>().deleteCartItem(
                                        provider.cart[index].id!);
                                    provider
                                        .removeItem(provider.cart[index].id!);
                                    provider.removeCounter();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 35,
                                  )),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                totalPrice.value =
                    (element.productPrice! * element.quantity!.value) +
                        (totalPrice.value ?? 0);
              }
              return Column(
                children: [
                  ValueListenableBuilder<int?>(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return ReusableWidget(
                            title: 'Sub-Total',
                            value: r'$' + (val?.toStringAsFixed(2) ?? '0'));
                      }),
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        TextWidget(text: text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
