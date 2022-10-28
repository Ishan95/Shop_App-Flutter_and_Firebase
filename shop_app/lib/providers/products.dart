import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'ID01',
    //   title: 'Slipper',
    //   description: 'Havaianas Men\'s Black Brasil Logo Plain Slippers',
    //   price: 2.00,
    //   imageUrl:
    //       'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/softlogicbicloud/b/cdn/o/products/400-600/41108501069334--1--1600249199.jpeg',
    // ),
    // Product(
    //   id: 'ID02',
    //   title: 'Wallet',
    //   description: 'Original Brand Imperial Horse Genuine Leather Wallet',
    //   price: 59.99,
    //   imageUrl:
    //       'https://www.babo.lk/wp-content/uploads/2022/02/100__original_brand_imperial_h_1638715265_1f64c190_progressive.jpg',
    // ),
    // Product(
    //   id: 'ID03',
    //   title: 'Watch',
    //   description: 'FOSSIL GRANT SPORT MEN\'S WATCH',
    //   price: 123.99,
    //   imageUrl: 'https://slwatches.lk/images/products/1618323324-Front.jpg',
    // ),
    // Product(
    //   id: 'ID04',
    //   title: 'Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
    // Product(
    //   id: 'ID05',
    //   title: 'Bag',
    //   description: 'Shopper bag with deer print',
    //   price: 240.59,
    //   imageUrl:
    //       'https://www.armani.com/variants/images/25185454456169905/F/w480.jpg',
    // ),
    // Product(
    //   id: 'ID06',
    //   title: 'Dress',
    //   description: 'Floral Print Fit & Flare Dress',
    //   price: 125.89,
    //   imageUrl:
    //       'https://assets.ajio.com/medias/sys_master/root/20211013/DMdl/61667cc8f997ddf8f1ce86dd/-473Wx593H-463086147-blue-MODEL.jpg',
    // ),
    // Product(
    //   id: 'ID07',
    //   title: 'PenDrive',
    //   description: 'SanDisk Ultra Flair 128GB USB 3.0 Pen Drive',
    //   price: 45.39,
    //   imageUrl:
    //       'https://celltronics.lk/wp-content/uploads/2022/06/SanDisk-Ultra-Flair-128GB-USB-3.0-Pen-Drive-4.jpg',
    // ),
    // Product(
    //   id: 'ID08',
    //   title: 'Earphone',
    //   description: 'SOUNDPEATS TrueAir2 TWS Bluetooth In-Ear Earphones',
    //   price: 10.15,
    //   imageUrl:
    //       'https://i0.wp.com/www.simplytek.lk/wp-content/uploads/2021/07/SOUNDPEATS-TrueAir2-TWS-Bluetooth-In-Ear-Earphones-Sri-Lanka-SimplyTek-3.jpg?resize=600%2C600&ssl=1',
    // ),
    // Product(
    //   id: 'ID09',
    //   title: 'Mouse',
    //   description: 'Dell Wireless Mouse-Black',
    //   price: 55.78,
    //   imageUrl:
    //       'https://i.dell.com/is/image/DellContent//content/dam/ss2/product-images/peripherals/input-devices/dell/mouse/wm126/dell-mouse-wm126-504x350.jpg?fmt=jpg',
    // ),
    // Product(
    //   id: 'ID10',
    //   title: 'Cap',
    //   description: 'DRUNKEN Men Cap Polyester - Black',
    //   price: 7.33,
    //   imageUrl:
    //       'https://assetscdn1.paytm.com/images/catalog/product/A/AC/ACCDRUNKEN-MEN-ILU1071301143478D/1563519403919_0..jpg?imwidth=320&impolicy=hq',
    // ),
  ];
  // var _showFavoritesOnly = false;

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://update-data1-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == '') {
        return;
      }
      url =
          'https://update-data1-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(Uri.parse(url));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://update-data1-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
          // 'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://update-data1-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://update-data1-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null as Product;
    // existingProduct = '' as Product;
  }
}
