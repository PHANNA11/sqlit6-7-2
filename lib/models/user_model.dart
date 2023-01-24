import 'package:pro_local_storage/utils/property.dart';

class UserModel {
  int? id;
  String? name;
  String profile;
  UserModel({this.id, this.name, required this.profile});
  Map<String, dynamic> userModeltoJson() {
    return {fid: id, fname: name, fprofile: profile};
  }

  UserModel.userModelFromJson(Map<String, dynamic> res)
      : id = res[fid],
        name = res[fname],
        profile = res[fprofile];
}
