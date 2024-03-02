import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/applcation_entity.dart';

class ApplicationModel extends ApplicationEntity {
  final String? applicationId;
  final String? uid;
  final String? name;
  final String? paragraph;
  final DateTime? createAt;

  const ApplicationModel({
    this.applicationId,
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
        );

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'uid': uid,
      'name': name,
      'paragraph': paragraph,
      'createAt': createAt,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      applicationId: map['applicationId'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      paragraph: map['paragraph'] as String,
      createAt: map['createAt']?.toDate(),
    );
  }
}
