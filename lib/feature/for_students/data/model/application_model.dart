import '../../domain/entity/applcation_entity.dart';

class ApplicationModel extends ApplicationEntity {
  final String? applicationId;
  final String? uid;
  final String? name;
  final String? paragraph;
  final DateTime? createAt;
  final String? email;

  const ApplicationModel({
    this.applicationId,
    this.email,
    this.uid,
    this.name,
    this.paragraph,
    this.createAt,
  }) : super(
          applicationId: applicationId,
          uid: uid,
          name: name,
          paragraph: paragraph,
          createAt: createAt,
          email: email,
        );

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'uid': uid,
      'name': name,
      'paragraph': paragraph,
      'createAt': createAt,
      'email': email,
    };
  }

  factory ApplicationModel.fromSnapshot(Map<String, dynamic> map) {
    return ApplicationModel(
      applicationId: map['applicationId'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      paragraph: map['paragraph'] as String,
      createAt: map['createAt']?.toDate(),
      email: map['email'],
    );
  }
}
