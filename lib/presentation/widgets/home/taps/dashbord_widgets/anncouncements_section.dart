import 'package:dashboard/constatnts/colors.dart';
import 'package:dashboard/constatnts/strings.dart';
import 'package:dashboard/data/local.dart';
import 'package:dashboard/presentation/widgets/common/circular_image.dart';
import 'package:dashboard/utils/config/indicators.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dashboard/utils/extentions/text_styls.dart';
import '../../../../../bussniessLogic/announcement/announcement_cubit.dart';
import '../../../../../data/models/announcement_model.dart';
import '../../../../../utils/config/indicators.dart';
import '../../../../../utils/config/responsive.dart';
import '../../../../screens/auth_screen.dart';

class AnnouncementsSection extends StatefulWidget {
  AnnouncementsSection({super.key});

  @override
  State<AnnouncementsSection> createState() => _AnnouncementsSectionState();
}

class _AnnouncementsSectionState extends State<AnnouncementsSection>
    with Indicators, Responsive {
  late AnnouncementResponseModel _announcementResponseModel;
  late AnnouncementPage page;
  @override
  void initState() {
    super.initState();
    page = AnnouncementPage()
      ..limit = 10
      ..page = 1;
    _announcementResponseModel = AnnouncementResponseModel();
  }

  @override
  void didChangeDependencies() {
    getAnnouncements();
    super.didChangeDependencies();
  }

  void getAnnouncements() {
    BlocProvider.of<AnnouncmentCubit>(context)
        .getAnnouncement(page: page.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.containersColors,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          _topBar(),
          Expanded(
            child: _buildAnnouncements(),
          ),
        ],
      ),
    );
  }

  Container _topBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              title: Text(Strings().announcement).applyBold(context),
              subtitle: Text(
                  "The Announcements are ordered acording to creation date"),
            ),
          ),
          Text(Strings().all).applyBold(context, textColor: AppColors.secondary)
        ],
      ),
    );
  }

  Widget _buildAnnouncements() {
    return BlocConsumer<AnnouncmentCubit, AnnouncmentState>(
      listenWhen: (previous, current) => current is LoginAgain,
      buildWhen: (previous, current) =>
          current is GettingAnnouncementLoading ||
          current is GettingAnnouncementLoaded ||
          current is GettingAnnouncementError,
      builder: (context, state) {
        if (state is GettingAnnouncementLoading) {
          return Center(child: getLoadingIndicator());
        }
        if (state is GettingAnnouncementError) {
          return _buildErrorBody(state);
        }

        if (state is GettingAnnouncementLoaded) {
          _announcementResponseModel = state.responseModel;
        }
        return _buildSuccessBody();
      },
      listener: (context, state) {
        if (state is LoginAgain) {
          LocalData().deleteToken();
          Navigator.pushReplacementNamed(
              context, AuthenticationPage.PAGE_ROUTE);
        }
      },
    );
  }

  Center _buildErrorBody(GettingAnnouncementError state) {
    return Center(
      child: Column(
        children: [
          Text(state.errorMessage),
          SizedBox(height: 10),
          IconButton(onPressed: getAnnouncements, icon: Icon(Icons.refresh))
        ],
      ),
    );
  }

  ListView _buildSuccessBody() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsetsDirectional.only(bottom: 10, end: 10),
          child: AnnouncementItem(
              announcement: _announcementResponseModel.result![index]),
        );
      },
      itemCount: _announcementResponseModel.result == null
          ? 0
          : _announcementResponseModel.result!.length,
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementItem({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: ListTile(
              leading: CircularImage(
                  profileImage: announcement.creatorImage ?? "",
                  diamention: 50),
              title: Text(
                announcement.creatorName ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(announcement.topic ?? ""),
            )),
        Expanded(flex: 4, child: Text(announcement.announcement ?? ""))
      ],
    );
  }
}
