import 'package:crowd_funding_app/Models/team_member.dart';
import 'package:crowd_funding_app/Models/user.dart';
import 'package:crowd_funding_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

class FundraiserTeamMemberPage extends StatelessWidget {
  FundraiserTeamMemberPage(
      {Key? key, required this.teamMembers, required this.organizer})
      : super(key: key);
  final List<TeamMember> teamMembers;
  final User? organizer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fundraising Team",
          style: appbarTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: organizer != null
                    ? Teams(
                        isOrganizer: true,
                        teamMember: organizer!,
                      )
                    : Container()),
            Column(
              children: teamMembers
                  .map((team) => Teams(
                        isOrganizer: false,
                        teamMember: team.member!.userID!,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class Teams extends StatelessWidget {
  Teams({Key? key, required this.teamMember, required this.isOrganizer})
      : super(key: key);

  User teamMember;
  final bool isOrganizer;

  String fullName = "";
  String avatarChild = "";
  getData() {
    fullName = teamMember.firstName! + " " + teamMember.lastName!;
    avatarChild = teamMember.firstName![0].toUpperCase() +
        teamMember.lastName![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
            child: Text(
              "$avatarChild",
              style: labelTextStyle.copyWith(
                  color: Theme.of(context).backgroundColor),
            ),
          ),
          title: Text("$fullName"),
          subtitle: Text(
            isOrganizer ? "Campaign Organizer" : "Team member",
            style: labelTextStyle.copyWith(
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.5)),
          ),
        ),
        Divider(color: Theme.of(context).secondaryHeaderColor.withOpacity(0.7))
      ],
    );
  }
}
