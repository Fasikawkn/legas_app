import 'package:crowd_funding_app/Models/user.dart';

class Update {
  String? id;
  User? userID;
  String? image;
  String content;
  String? dateCreated;
  bool? isDeleted;

  Update({
    this.id,
    this.userID,
    this.image,
    required this.content,
    this.dateCreated,
    this.isDeleted,
  });

  // parsing json object to update object

  factory Update.fromJson(Map<String, dynamic> data) {
    print("update $data");
    String id = data['_id'];
    User userID = User.fromJson(data['userId']);
    String image = data['image'];
    String content = data['content'];
    String dateString = data['dateCreated'];
   
    return Update(
      id: id,
      userID: userID,
      image: image,
      content: content,
      dateCreated: dateString,
    );
  }

  // converting update object to map
  Map<String, dynamic> toJson() {
    return {
      'userId': userID!.id ?? "",
      'image': image ?? "",
      'content': content,
      'dateCreated': dateCreated.toString(),
    };
  }

  // covert the update object to string representation
  @override
  String toString() {
    return 'Update (  userID: $userID,image: $image,content: $content,dateCreated: $dateCreated,)';
  }
}
