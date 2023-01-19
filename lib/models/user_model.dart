import 'package:pro_local_storage/utils/property.dart';

class UserModel {
  int? id;
  String? name;
  UserModel({this.id, this.name});
  Map<String, dynamic> userModeltoJson() {
    return {fid: id, fname: name};
  }

  UserModel.userModelFromJson(Map<String, dynamic> res)
      : id = res[fid],
        name = res[fname];
}
