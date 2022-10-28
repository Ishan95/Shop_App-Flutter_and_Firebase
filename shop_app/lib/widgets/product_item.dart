import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black26,
          // leading: Consumer<Product>(
          //   builder: (ctx, value, _) => IconButton(
          //     icon: Icon(
          //         product.isFavorite ? Icons.favorite : Icons.favorite_border),
          //     onPressed: () {
          //       product.toggleFavoriteStatus();
          //     },
          //     color: Theme.of(context).accentColor,
          //   ),
          // ),
          // title: Text(
          //   product.title,
          //   textAlign: TextAlign.center,
          // ),
          title: Text(
            product.title,
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Row(
            children: [
              Consumer<Product>(
                builder: (ctx, value, _) => Container(
                  margin: EdgeInsets.only(left: 2),
                  width: 20,
                  child: IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavoriteStatus(
                        authData.token,
                        authData.userId,
                      );
                    },
                    iconSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                width: 20,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    cart.addItem(product.id, product.price, product.title);
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Added Item to cart',
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ));
                  },
                  iconSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
