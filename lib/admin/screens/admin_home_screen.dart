import 'package:flutter/material.dart';
import 'package:sef_ass/admin/screens/make_announcement_screen.dart';
import 'package:sef_ass/admin/screens/view_feedback_screen.dart';
import 'package:sef_ass/admin/widgets/admin_argument.dart';
import '../../common/pop_up_window.dart';
import '../../constants/global_variables.dart';
import 'manage_acc_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  static const String routeName = '/admin_home';

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class HomepageTile extends StatelessWidget {
  final String tileName;
  HomepageTile({
    super.key,
    required this.tileName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          height: 200,
          width: 400,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: GlobalVariables.primaryColor),
          child: Text(
            tileName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
        ));
  }
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  late String adminId;
  late String adminName;

  @override
  void initState() {
    super.initState();
  }

  void adminArgument() {
    final args = ModalRoute.of(context)?.settings.arguments as AdminArguments?;
    if (args != null) {
      adminId = args.adminId;
      adminName = args.adminName;
      print('Admin ID: $adminId');
      print('Admin Name: $adminName');
    }
  }

  @override
  Widget build(BuildContext context) {
    adminArgument();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Loco Residence',
                    style: TextStyle(
                        color: GlobalVariables.darkPurple,
                        fontSize: 20,
                        fontFamily: 'Anton'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Popup(
                        title: 'Warning',
                        content: Text("Are you sure you want to log out"),
                        buttons: [
                          ButtonConfig(
                            text: 'Cancel',
                            onPressed: () async {},
                          ),
                          ButtonConfig(
                            text: 'Yes',
                            onPressed: () async {
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        ],
                      ).show(context);
                    },
                    child: Icon(
                      Icons.logout_rounded,
                      size: 25, color: Colors.black,

                      //color: GlobalVariables.darkPurple
                    ),
                  ),
                ],
              ),

              SizedBox(height: 60), // Adjust the space between widgets

              Text(
                'HOLA,',
                style: TextStyle(
                  color: GlobalVariables.primaryGrey,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '$adminName',
                style: TextStyle(
                  color: GlobalVariables.primaryGrey,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ManageAccountScreen.routeName),
                child: HomepageTile(tileName: 'Manage \nAccounts'),
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, MakeAnnouncementScreen.routeName),
                child: HomepageTile(tileName: 'Make \nAnnouncements'),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ViewFeedbackScreen.routeName),
                child: HomepageTile(tileName: 'View \nFeedback'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
