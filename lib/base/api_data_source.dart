import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<List<dynamic>> loadMatches() {
    return BaseNetwork.getList("matches");
    // "https://copa22.medeiro.tech/matches"
  }

  Future<Map<String, dynamic>> loadDetailMatches(String id) {
    return BaseNetwork.get("matches/$id");
    // "https://copa22.medeiro.tech/matches/clakj8jii002mra2tv46v7vcd"
  }
}