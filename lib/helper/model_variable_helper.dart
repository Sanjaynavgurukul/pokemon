class ModelVariableHelper {
  static dynamic convertVariable(
      {required dynamic data, required String variableType}) {
    if (variableType.isEmpty) return null;

    String value = data.toString();
    switch (variableType) {
      case 'double':
      case 'int':
        return ModelVariableHelper().convertToNum(value: value.toString());
      case 'bool':
        return ModelVariableHelper().convertToBool(value: value.toString());
      case 'binary':
        return ModelVariableHelper().convertBinaryBool(value: value.toString());
      case 'date':
        return ModelVariableHelper().convertDate(value: value.toString());
      default:
        if (value == 'null') return '';
        if (value.isEmpty) return '';
        return value.toString();
    }
  }

  DateTime convertDate({required String value}) {
    try {
      DateTime d = DateTime.parse(value.toString());
      return d;
    } on FormatException {
      return DateTime.now();
    } catch (e) {
      return DateTime.now();
    }
  }

  num convertToNum({required String value}) {
    if (value == 'null') {
      return 0;
    }
    try {
      num n = num.parse(value.toString());
      return n;
    } on FormatException {
      return 0;
    } catch (e) {
      return 0;
    }
  }

  int convertBinaryBool({required String value}) {
    try {
      int n = int.parse(value.toString());
      return n;
    } on FormatException {
      return 0;
    } catch (e) {
      return 0;
    }
  }

  bool convertToBool({required String value}) {
    if (value.isEmpty) return false;

    switch (value) {
      case 'null':
      case 'Null':
      case 'NULL':
      case '0':
        return false;
      case '1':
        return true;
      case 'true':
        return true;
      case 'false':
        return false;
      default:
        return false;
    }
  }
}
