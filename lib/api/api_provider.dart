
import 'package:openapi/api.dart';

const accessTokenHeaderName = "x-api-key";

class ApiProvider {
  ApiKeyAuth? _apiKey;
  AccountApi _account;
  ProfileApi _profile;
  MediaApi _media;

  String _serverAddress;

  AccountApi get account => _account;
  ProfileApi get profile => _profile;
  MediaApi get media => _media;
  String get serverAddress => _serverAddress;

  ApiProvider(String address) :
    this.withClient(ApiClient(basePath: address), address);

  ApiProvider.withClient(ApiClient client, String serverAddress) :
    _serverAddress = serverAddress,
    _account = AccountApi(client),
    _profile = ProfileApi(client),
    _media = MediaApi(client);

  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", accessTokenHeaderName);
    auth.apiKey = apiKey.apiKey;
    _apiKey = auth;
    var client = ApiClient(basePath: serverAddress, authentication: auth);
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }

  void updateServerAddress(String serverAddress) {
    _serverAddress = serverAddress;
    var client = ApiClient(basePath: serverAddress, authentication: _apiKey);
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }
}
