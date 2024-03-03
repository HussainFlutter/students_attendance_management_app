import 'package:equatable/equatable.dart';

class ApplicationEntity extends Equatable {
  final String? applicationId;
  final String? uid;
  final String? email;
  final String? name;
  final String? paragraph;
  final DateTime? createAt;

  const ApplicationEntity({
    this.applicationId,
    this.uid,
    this.email,
    this.name,
    this.paragraph,
    this.createAt,
  });
  @override
  List<Object?> get props => [
        applicationId,
        uid,
        name,
        paragraph,
        createAt,
        email,
      ];
}
