class DesignArticleModel {
  Data? _data;
  late String _message;
  late bool _success;
  late int _statusCode;

  Data? get data => _data;

  String get message => _message;

  bool get success => _success;

  int get statusCode => _statusCode;

  DesignArticleModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = Data.fromJson(json['data']);
    }
    _message = json['message'] ?? 'msg key null on design article!';
    _success = json['success'] ?? false;
    _statusCode = json['status_code'] ?? -1;
  }
}

class Data {
  late int _id;
  late String _name;
  late List<String> _images;
  late List<String> _videos;
  late List<ArticleDetail> _articleDetail;

  int get id => _id;

  String get name => _name;

  List<String> get images => _images;

  List<String> get videos => _videos;

  List<ArticleDetail> get articleDetail => _articleDetail;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'] ?? '';

    _images = <String>[];
    if (json['images'] != null) {
      _images = json['images'].cast<String>();
    }

    _videos = <String>[];
    if (json['videos'] != null) {
      _videos = json['videos'].cast<String>();
    }

    _articleDetail = <ArticleDetail>[];
    if (json['article_detail'] != null) {
      json['article_detail'].forEach((v) {
        _articleDetail.add(ArticleDetail.fromJson(v));
      });
    }
  }
}

class ArticleDetail {
  late int _id;
  late int _productCaretId;
  late String _articalNumber;
  late int _weight;
  late int _totalPrice;

  // int? _isSold;
  // int? _isRejected;
  // int? _isInCart;
  // String? _createdAt;
  // String? _updatedAt;

  int get id => _id;

  int get productCaretId => _productCaretId;

  String get articalNumber => _articalNumber;

  int get weight => _weight;

  int get totalPrice => _totalPrice;

  // int get isSold => _isSold;
  // int get isRejected => _isRejected;
  // int get isInCart => _isInCart;
  // String get createdAt => _createdAt;
  // String get updatedAt => _updatedAt;

  ArticleDetail.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productCaretId = json['product_caret_id'];
    _articalNumber = json['artical_number'] ?? '';
    _weight = json['weight'] ?? 0;
    _totalPrice = json['total_price'] ?? 0;
    // _isSold = json['is_sold'] ?? -1;
    // _isRejected = json['is_rejected'] ?? -1;
    // _isInCart = json['is_in_cart'] ?? -1;
    // _createdAt = json['created_at'] ?? '';
    // _updatedAt = json['updated_at'] ?? '';
  }
}
