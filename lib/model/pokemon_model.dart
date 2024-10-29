import 'package:pokemon/helper/model_variable_helper.dart';

class PokemonModel {
  List<PokemonItemModel>? data;
  bool? hasError;

  PokemonModel({this.data, this.hasError});

  factory PokemonModel.fromJson(Map<String, dynamic> json, bool error) =>
      PokemonModel(
        hasError: error,
        data: json.containsKey('data') && json['data'] != null
            ? List<PokemonItemModel>.from(
                json["data"].map((x) => PokemonItemModel.fromJson(x)))
            : [],
      );
}

class PokemonImage {
  String? small;
  String? large;

  PokemonImage({this.large, this.small});

  factory PokemonImage.fromJson(Map<String, dynamic> json) => PokemonImage(
        large: ModelVariableHelper.convertVariable(
            data: json['large'], variableType: 'String'),
        small: ModelVariableHelper.convertVariable(
            data: json['small'], variableType: 'String'),
      );
}

class PokemonItemModel {
  String? id;
  String? name;
  String? supertype;
  String? hp;
  String? artist;
  String? rarity;
  PokemonImage? image;
  PokemonSet? set;

  List<String>? subtypes;
  List<String>? types;
  List<PokemonAttack>? attacks;

  List<String>? evolvesTo;

  List<String>? retreatCost;
  num? convertedRetreatCost;

  PokemonItemModel(
      {this.id,
      this.name,
      this.supertype,
      this.set,
      this.rarity,
      this.artist,
      this.hp,
      this.convertedRetreatCost,
      this.subtypes,
      this.attacks,
      this.image});

  factory PokemonItemModel.fromJson(Map<String, dynamic> json) =>
      PokemonItemModel(
          id: ModelVariableHelper.convertVariable(
              data: json['id'], variableType: 'String'),
          name: ModelVariableHelper.convertVariable(
              data: json['name'], variableType: 'String'),
          artist: ModelVariableHelper.convertVariable(
              data: json['artist'], variableType: 'String'),
          rarity: ModelVariableHelper.convertVariable(
              data: json['rarity'], variableType: 'String'),
          subtypes: getList(data: json['subtypes']),
          attacks: json.containsKey('attacks') && json['attacks'] != null
              ? List<PokemonAttack>.from(
                  json["attacks"].map((x) => PokemonAttack.fromJson(x)))
              : [],
          set: json.containsKey('set') && json['set'] != null
              ? PokemonSet.fromJson(json['set'])
              : null,
          supertype: ModelVariableHelper.convertVariable(
              data: json['supertype'], variableType: 'String'),
          hp: ModelVariableHelper.convertVariable(
              data: json['hp'], variableType: 'String'),
          convertedRetreatCost: ModelVariableHelper.convertVariable(
              data: json['convertedRetreatCost'], variableType: 'int'),
          image: json.containsKey('images') && json['images'] != null
              ? PokemonImage.fromJson(json['images'])
              : null);

  static List<String> getList({List<dynamic>? data}) {
    if (data == null || data.isEmpty) {
      return [];
    }

    List<String> stringList = data.map((item) => item.toString()).toList();

    return stringList;
  }
}

class PokemonAttack {
  String? name;
  String? damage;
  String? text;
  num? convertedEnergyCost;

  PokemonAttack({this.name, this.text, this.convertedEnergyCost, this.damage});

  factory PokemonAttack.fromJson(Map<String, dynamic> json) => PokemonAttack(
        name: ModelVariableHelper.convertVariable(
            data: json['name'], variableType: 'String'),
        damage: ModelVariableHelper.convertVariable(
            data: json['damage'], variableType: 'String'),
        text: ModelVariableHelper.convertVariable(
            data: json['text'], variableType: 'String'),
      );
}

class PokemonWeaknesses {
  String? type;
  String? value;
}

class PokemonSet {
  String? id;
  String? name;
  String? series;
  num? printedTotal;
  num? total;
  PokemonSetImage? images;

  PokemonSet({
    this.name,
    this.id,
    this.images,
    this.printedTotal,
    this.series,
    this.total,
  });

  factory PokemonSet.fromJson(Map<String, dynamic> json) => PokemonSet(
        name: ModelVariableHelper.convertVariable(
            data: json['name'], variableType: 'String'),
        id: ModelVariableHelper.convertVariable(
            data: json['id'], variableType: 'String'),
        images: json.containsKey('images') && json['images'] != null
            ? PokemonSetImage.fromJson(json['images'])
            : null,
        printedTotal: ModelVariableHelper.convertVariable(
            data: json['printedTotal'], variableType: 'int'),
        series: ModelVariableHelper.convertVariable(
            data: json['series'], variableType: 'String'),
        total: ModelVariableHelper.convertVariable(
            data: json['total'], variableType: 'int'),
      );
}

class PokemonSetImage {
  String? symbol;
  String? logo;

  PokemonSetImage({this.logo, this.symbol});

  factory PokemonSetImage.fromJson(Map<String, dynamic> json) =>
      PokemonSetImage();
}
