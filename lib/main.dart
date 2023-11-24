import 'package:diary/controllers/auth_controller.dart';
import 'package:diary/models/diary_entry.dart';
import 'package:diary/models/profile_details.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/screens/login_signin_screen/login_screen.dart';
import 'package:diary/screens/main_screen/main_screen.dart';
import 'package:diary/providers/provider_mainscreen.dart';
import 'package:diary/providers/provider_onboarding.dart';
import 'package:diary/screens/splash_screen/splash.dart';
import 'package:diary/providers/provider_calendar.dart';
import 'package:diary/providers/provider_create.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(DiaryEntryAdapter().typeId)) {
    Hive.registerAdapter(DiaryEntryAdapter());
  }
  await Hive.openBox<DiaryEntry>('_boxName');

  if (!Hive.isAdapterRegistered(ProfileDetailsAdapter().typeId)) {
    Hive.registerAdapter(ProfileDetailsAdapter());
  }
  await Hive.openBox<ProfileDetails>('_profileBoxName');

  if (!Hive.isAdapterRegistered(SavedListAdapter().typeId)) {
    Hive.registerAdapter(SavedListAdapter());
  }
  await Hive.openBox<SavedList>('_savedListBoxName');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CreatePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Changer(),
        ),
        ChangeNotifierProvider(
          create: (context) => OnboardingState(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SFPRO',
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // initialRoute: '/splash',
      // routes: {
      //   '/splash': (context) => const Splash(),

      //   '/main': (context) => MainScreen(),
      // },
    );
  }
}
