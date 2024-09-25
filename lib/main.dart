import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(1, 1, 1, 1),
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(Page2()));
                },
                child: Text('To 2 page'))
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Page 2', style: TextStyle(
            color: Colors.white
          ),),],
        ),
      ),
    );
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(transitionsBuilder: (ctx, anim1, anim2, widget) {

    // final start = Offset(1.0, 0.0);
    // const end = Offset.zero;
    const curve = Curves.easeInOut;
    // final tween = Tween(begin: start, end: end).chain(CurveTween(curve: curve));
    //
    // final tweenFade = Tween(begin: start, end: end).chain(CurveTween(curve: curve));

    //
    //
    // final curvedAnim = CurvedAnimation(parent: anim1, curve: curve);


    final slideTween = Tween<Offset>(
      begin: const Offset(1.0, 0.0), end: Offset.zero
    ).chain(CurveTween(curve: curve));

    final fadeTween = Tween<double>(
      begin: 0.0, end: 1.0
    ).chain(CurveTween(curve: curve));

    final offsetAnim = anim1.drive(slideTween);
    final fadeAnim = anim1.drive(fadeTween);

    return SlideTransition(position: offsetAnim, child: FadeTransition(opacity: fadeAnim, child: widget,),);
  }, pageBuilder: (ctx, anim1, anim2) {
    return page;
  });
}
