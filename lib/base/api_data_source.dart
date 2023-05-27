import 'dart:convert';
import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<List<dynamic>> loadMatches() {
    return BaseNetwork.getList("matches");
    // "https://copa22.medeiro.tech/matches"
  }

  Future<Map<String, dynamic>> loadDetailChara(String name) {
    return BaseNetwork.get("characters/$name");
    // "https://api.genshin.dev/characters/albedo"
  }

  Future<List<dynamic>> loadWeapon() {
    return BaseNetwork.getList("weapons");
    // "https://api.genshin.dev/weapons"
  }

  Future<Map<String, dynamic>> loadDetailWeapon(String name) {
    return BaseNetwork.get("weapons/$name"); // get api pizza
    // "https://api.genshin.dev/weapons/alley-hunter"
  }
}