// import 'package:alumni_app_1/pages/profile_page.dart';
import 'package:alumni_app_1/pages/userprofile.dart';
// import 'package:alumni_app_1/pages/userprofile.dart';
import 'package:get/get.dart';
import 'home_page.dart';
// import 'package:groapp/userprofile.dart';
// import 'home_page.dart';
// import 'barscan.dart';
// import 'data_base.dart';
import 'job_page.dart';
class BottomNavContoller extends GetxController {
  RxInt index = 0.obs;

   var pages = [HomePage(),const JobsPage(), UserProfileScreen()];
  //  ,EventsPage(),SucessStoryPage(),DonationPageForAlumni(),VirtualTourPage()
  // for alumni  jiske pass job nhi h usse hum counselling krwa skte h 
  // homepage pr hi virtual tour implement krna h

}