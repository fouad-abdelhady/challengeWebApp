import 'package:dashboard/data/models/announcement_model.dart';
import '../services/services.dart';

class AnnouncementRepo {
  final _addAnnounceMentRoute = "addAnnouncement";
  final _updateAnnounceMentRoute = "updateAnnouncement";
  final _deleteAnnounceMentRoute = "deleteAnnouncement";
  final _getAnnounceMentRoute = "announcements";
  final _services = Services();

  Future<Announcement> addAnnouncement(String announcement) async {
    var body = {"announcement": announcement};
    var response =
        await _services.postRequest(route: _addAnnounceMentRoute, body: body);
    return Announcement.fromJson(response.data);
  }

  Future<AnnouncementResponseModel> getAnnouncement(
      Map<String, dynamic> page, String? creatorId) async {
    if (creatorId != null) {
      page['creatorId'] = creatorId;
    }
    var response =
        await _services.postRequest(route: _getAnnounceMentRoute, body: page);
    return AnnouncementResponseModel.fromJson(response.data);
  }
}
