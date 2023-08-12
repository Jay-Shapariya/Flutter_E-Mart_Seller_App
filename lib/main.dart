import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
   
    super.initState();
    checkUser();
  }
  
  var isLoggedin = false;
  checkUser() async{
    auth.authStateChanges().listen((User? user) { 
      if(user == null && mounted){
        isLoggedin = false;
      }
      else{
        isLoggedin = true;
      }
      setState(() {
        
      });
    });

  }
  
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      title: appname,
      
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,elevation: 0.0)
        ,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedin ? const Home() : const LoginScreen(),
    );
  }
}

