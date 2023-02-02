import 'package:uuid/uuid.dart';

String generateUniqueId() {
  Uuid uuid = Uuid();
  final uniqueId = uuid.v4();
  return uniqueId;
}
