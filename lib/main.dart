import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_social_media/features/feed/presentation/bloc/feed_event.dart';

import 'features/feed/presentation/bloc/feed_bloc.dart';
import 'features/feed/presentation/pages/feed_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<FeedBloc>()..add(FeedFetched())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mini Social Media Feed',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const FeedPage(),
      ),
    );
  }
}
