import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import '../config.dart';
// import 'result_code.dart';

/*
 * 网络请求管理类
 */
class HTTP {
  //写一个单例
  //在 Dart 里，带下划线开头的变量是私有变量
  static HTTP _instance;

  static HTTP getInstance() {
    if (_instance == null) {
      _instance = HTTP();
    }
    return _instance;
  }

  Dio dio = new Dio();
  HTTP() {
    // Set default configs
    dio.options.headers = {
      "Authorization": '_token',
    };
    dio.options.baseUrl = "http://zhihu.cixi518.com:3000/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    // dio.interceptors.add(
    //   LogInterceptor(responseBody: GlobalConfig.isDebug),
    // ); //是否开启请求日志
    // dio.interceptors.add(CookieManager(CookieJar()));//缓存相关类，具体设置见https://github.com/flutterchina/cookie_jar
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY localhost:8888";
      };
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }

  //get请求
  Future get(String url, Map<String, dynamic> params, Function successCallBack,
      Function errorCallBack) async {
    await _requstHttp(url, successCallBack, 'get', params, errorCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requstHttp(url, successCallBack, "post", params, errorCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method, var params, Function errorCallBack]) async {
    // FormData params
    Response response;
    try {
      if (method == 'get') {
        if (params != null) {
          //  && params.isNotEmpty
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null) {
          //  && params.isNotEmpty
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      // debug模式才打印
      if (GlobalConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + dio.options.headers.toString());
        print('method: ' + dio.options.method);
      }
      _error(errorCallBack, error.message);
      return '';
    }
    // debug模式打印相关数据
    if (GlobalConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['state'] == 0) {
      _error(
          errorCallBack,
          '错误码：' +
              dataMap['errorCode'].toString() +
              '，' +
              response.data.toString());
    } else if (successCallBack != null) {
      successCallBack(dataMap);
    }
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}

/*
 * dio网络请求失败的回调错误码 
 */
class ResultCode {
  //正常返回是1
  static const SUCCESS = 1;

  //异常返回是0
  static const ERROR = 1;

  /// When opening  url timeout, it occurs.
  static const CONNECT_TIMEOUT = -1;

  ///It occurs when receiving timeout.
  static const RECEIVE_TIMEOUT = -2;

  /// When the server response, but with a incorrect status, such as 404, 503...
  static const RESPONSE = -3;

  /// When the request is cancelled, dio will throw a error with this type.
  static const CANCEL = -4;

  /// read the DioError.error if it is not null.
  static const DEFAULT = -5;
}
