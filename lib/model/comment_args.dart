import 'package:hm_service/model/technician.dart';

class CommentArgs {
  final Technician technician;
  final bool fromUser;

  CommentArgs({required this.technician, this.fromUser = false});
}