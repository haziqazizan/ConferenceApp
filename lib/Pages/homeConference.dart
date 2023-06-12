import 'package:app_conference/Pages/easy_conference_page.dart';
import 'package:flutter/material.dart';
import 'package:app_conference/common_widgets/easy_conference_builder.dart';
import 'package:app_conference/models/conference.dart';
import 'package:app_conference/models/specialization.dart';
import 'package:app_conference/services/conference_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeConference extends StatefulWidget {
  const HomeConference({Key? key}) : super(key: key);
  @override
  _HomeConferenceState createState() => _HomeConferenceState();
}

class _HomeConferenceState extends State<HomeConference> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Conference>> _getConference() async {
    return await _databaseService.conferenceInfo();
  }

  Future<List<Specialization>> _getSpecialization() async {
    return await _databaseService.Special_types();
  }

  Future<void> _onConference_infoDelete(Conference specialization) async {
    await _databaseService.deleteConferenceInfo(specialization.id!);
    setState(() {});
  }

  //design for home page
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade800,
          title: const Text('EASY CONFERENCE HOME PAGE'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('User Details'),
              ),
            ],
          ),
        ),

        //display saved booking
        body: TabBarView(
          children: [
            ConferenceBuilder(
              future: _getConference(),
              onEdit: (value) {
                {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ConferenceFormPage(specialization: value),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }
              },
              onDelete: _onConference_infoDelete,
            ),
          ],
        ),

        //forward to booking form page
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 12.0),
            FloatingActionButton(
              backgroundColor: Colors.deepPurple.shade400,
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => const ConferenceFormPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
              },
              heroTag: 'addRegister_info',
              child: const FaIcon(
                FontAwesomeIcons.plus,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
