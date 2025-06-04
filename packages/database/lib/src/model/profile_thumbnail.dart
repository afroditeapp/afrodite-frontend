
import 'package:database/database.dart';

class ProfileThumbnail {
  final ProfileEntry entry;
  final bool isFavorite;
  ProfileThumbnail(
    {
      required this.entry,
      required this.isFavorite,
    }
  );
}
