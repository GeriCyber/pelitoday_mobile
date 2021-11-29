import 'package:flutter/material.dart';
import 'package:pelitoday/providers/movies_provider.dart';
import 'package:pelitoday/screens/screens.dart';
import 'package:provider/provider.dart';

 
void main() => runApp(AppState());
 
 class AppState extends StatelessWidget {
 
   @override
   Widget build(BuildContext context) {
     return MultiProvider(
       providers: [
         ChangeNotifierProvider(
           create: (_) => MoviesProvider(),
           lazy: false,
         )
       ],
       child: MyApp()
     );
   }
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen()
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.greenAccent
        )
      )
    );
  }
}