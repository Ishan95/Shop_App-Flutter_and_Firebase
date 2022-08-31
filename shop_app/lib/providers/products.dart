import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'ID01',
      title: 'Slipper',
      description: 'Havaianas Men\'s Black Brasil Logo Plain Slippers',
      price: 2.00,
      imageUrl:
          'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/softlogicbicloud/b/cdn/o/products/400-600/41108501069334--1--1600249199.jpeg',
    ),
    Product(
      id: 'ID02',
      title: 'Wallet',
      description: 'Original Brand Imperial Horse Genuine Leather Wallet',
      price: 59.99,
      imageUrl:
          'https://www.babo.lk/wp-content/uploads/2022/02/100__original_brand_imperial_h_1638715265_1f64c190_progressive.jpg',
    ),
    Product(
      id: 'ID03',
      title: 'Watch',
      description: 'FOSSIL GRANT SPORT MEN\'S WATCH',
      price: 123.99,
      imageUrl: 'https://slwatches.lk/images/products/1618323324-Front.jpg',
    ),
    Product(
      id: 'ID04',
      title: 'Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'ID05',
      title: 'Bag',
      description: 'Shopper bag with deer print',
      price: 240.59,
      imageUrl:
          'https://www.armani.com/variants/images/25185454456169905/F/w480.jpg',
    ),
    Product(
      id: 'ID06',
      title: 'Dress',
      description: 'Floral Print Fit & Flare Dress',
      price: 125.89,
      imageUrl:
          'https://assets.ajio.com/medias/sys_master/root/20211013/DMdl/61667cc8f997ddf8f1ce86dd/-473Wx593H-463086147-blue-MODEL.jpg',
    ),
    Product(
      id: 'ID07',
      title: 'PenDrive',
      description: 'SanDisk Ultra Flair 128GB USB 3.0 Pen Drive',
      price: 45.39,
      imageUrl:
          'https://celltronics.lk/wp-content/uploads/2022/06/SanDisk-Ultra-Flair-128GB-USB-3.0-Pen-Drive-4.jpg',
    ),
    Product(
      id: 'ID08',
      title: 'Earphone',
      description: 'SOUNDPEATS TrueAir2 TWS Bluetooth In-Ear Earphones',
      price: 10.15,
      imageUrl:
          'https://i0.wp.com/www.simplytek.lk/wp-content/uploads/2021/07/SOUNDPEATS-TrueAir2-TWS-Bluetooth-In-Ear-Earphones-Sri-Lanka-SimplyTek-3.jpg?resize=600%2C600&ssl=1',
    ),
    Product(
      id: 'ID09',
      title: 'Mouse',
      description: 'Dell Wireless Mouse-Black',
      price: 55.78,
      imageUrl:
          'https://i.dell.com/is/image/DellContent//content/dam/ss2/product-images/peripherals/input-devices/dell/mouse/wm126/dell-mouse-wm126-504x350.jpg?fmt=jpg',
    ),
    Product(
      id: 'ID10',
      title: 'Cap',
      description: 'DRUNKEN Men Cap Polyester - Black',
      price: 7.33,
      imageUrl:
          'https://assetscdn1.paytm.com/images/catalog/product/A/AC/ACCDRUNKEN-MEN-ILU1071301143478D/1563519403919_0..jpg?imwidth=320&impolicy=hq',
    ),
  ];
  // var _showFavoritesOnly = false;

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

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
