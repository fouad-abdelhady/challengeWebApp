class AnnouncementResponseModel {
  AnnouncementPage? next;
  AnnouncementPage? previous;
  List<Announcement>? result;

  AnnouncementResponseModel({this.next, this.previous, this.result});

  AnnouncementResponseModel.fromJson(Map<String, dynamic> json) {
    next =
        json['next'] != null ? AnnouncementPage.fromJson(json['next']) : null;
    previous = json['previous'] != null
        ? AnnouncementPage.fromJson(json['previous'])
        : null;
    if (json['result'] != null) {
      result = <Announcement>[];
      json['result'].forEach((announcement) {
        result!.add(Announcement.fromJson(announcement));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (next != null) {
      data['next'] = next!.toJson();
    }
    if (previous != null) {
      data['previous'] = previous!.toJson();
    }
    if (result != null) {
      data['result'] =
          result!.map((announcement) => announcement.toJson()).toList();
    }
    return data;
  }
}

class AnnouncementPage {
  int? page;
  int? limit;

  AnnouncementPage({this.page, this.limit});

  AnnouncementPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['limit'] = limit;
    return data;
  }
}

class Announcement {
  String? sId;
  String? announcement;
  String? topic;
  String? creatorId;
  String? creatorName;
  String? creatorImage;
  String? creationDate;

  Announcement(
      {this.sId,
      this.announcement,
      this.topic,
      this.creatorId,
      this.creatorName,
      this.creatorImage,
      this.creationDate});

  Announcement.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    announcement = json['announcement'];
    topic = json['topic'];
    creatorId = json['creatorId'];
    creatorName = json['creatorName'];
    creatorImage = json['creatorImage'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['announcement'] = announcement;
    data['topic'] = topic;
    data['creatorId'] = creatorId;
    data['creatorName'] = creatorName;
    data['creatorImage'] = creatorImage;
    data['creationDate'] = creationDate;
    return data;
  }
}
