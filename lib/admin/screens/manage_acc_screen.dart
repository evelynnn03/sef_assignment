import 'package:flutter/material.dart';
import '../../admin/screens/guard_register_screen.dart';
import '../../admin/screens/resident_register_screen.dart';
import '../../common/read%20data/guard_details.dart';
import '../../common/read%20data/resident_details.dart';
import '../../common/my_tab_bar.dart';
import '../../constants/global_variables.dart';

class ManageAccountScreen extends StatefulWidget {
  static const String routeName = '/manage-account';
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  //In the initState method, _tabController.addListener(_handleTabSelection); sets up the listener. When a tab is selected, _handleTabSelection is executed automatically. Inside _handleTabSelection, you can add logic to update the state or perform any actions you need when a tab is selected.
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      // Update the selected index when a tab is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(140, 0, 0, 0),
            size: 35,
          ),
          onPressed: () {
            if (_tabController.index == 0) {
              // Navigate to GuardRegisterScreen
              Navigator.pushNamed(
                context,
                GuardRegisterScreen.routeName,
              );
            } else {
              // Navigate to ResidentRegisterScreen
              Navigator.pushNamed(
                context,
                ResidentRegisterScreen.routeName,
              );
            }
          },
        ),
        appBar: AppBar(
          foregroundColor: GlobalVariables.backgroundColor,
          backgroundColor: GlobalVariables.backgroundColor,
          shadowColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.close,
                  color: GlobalVariables.primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: MyTabBar(
                  firstTabText: 'Guards',
                  secondTabText: 'Residents',
                  tabController: _tabController),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  //1st tab
                  GuardDetails(
                    showImage: false,
                    hasSlidable: true,
                  ),

                  //2nd tab
                  ResidentDetails()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
