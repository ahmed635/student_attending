import 'package:student_attending/views/auth/login_screen.dart';
import 'package:student_attending/views/auth/register_screen.dart';
import 'package:student_attending/views/listviews/assistant_list_view.dart';
import 'package:student_attending/views/listviews/center_list_view.dart';
import 'package:student_attending/views/listviews/group_list_view.dart';
import 'package:student_attending/views/listviews/lesson_list_view.dart';
import 'package:student_attending/views/listviews/student_list_view.dart';
import 'package:student_attending/views/screens/assistant_screen.dart';
import 'package:student_attending/views/screens/center_screen.dart';
import 'package:student_attending/views/screens/group_screen.dart';
import 'package:student_attending/views/screens/home_screen.dart';
import 'package:student_attending/views/screens/lesson_screen.dart';
import 'package:student_attending/views/screens/splash_screen.dart';
import 'package:student_attending/views/screens/student_screen.dart';

var appRoutes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  StudentListView.routeName: (context) => StudentListView(),
  AssistantListView.routeName: (context) => AssistantListView(),
  GroupListView.routeName: (context) => GroupListView(),
  CenterListView.routeName: (context) => CenterListView(),
  LessonListView.routeName: (context) => LessonListView(),
  GroupScreen.routeName: (context) => GroupScreen(),
  AssistantScreen.routeName: (context) => AssistantScreen(),
  CenterScreen.routeName: (context) => CenterScreen(),
  StudentScreen.routeName: (context) => StudentScreen(),
  LessonScreen.routeName: (context) => LessonScreen(),
};
