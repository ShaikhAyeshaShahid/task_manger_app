import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/domain/usecases/add_task/add_task_usecase.dart';
import 'package:task_manger_app/domain/usecases/todo_list/get_todo_list_usecase.dart';
import 'package:task_manger_app/domain/usecases/user_login/userlogin_usecase.dart';
import 'package:task_manger_app/presentation/cubit/add_task/add_task_cubit.dart';
import 'package:task_manger_app/presentation/cubit/get_todo_list/get_todo_list_cubit.dart';
import 'package:task_manger_app/presentation/cubit/user_login/user_login_cubit.dart';
import 'package:task_manger_app/presentation/screens/home_screen.dart';
import 'package:task_manger_app/presentation/screens/signin_screen.dart';
import 'package:task_manger_app/presentation/screens/splash_screen.dart';

import 'constants/router.dart';
import 'domain/repository/task_manager_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'montserrat',
      ),
      onGenerateRoute: _onGenerateRoute,
      /*home: FutureBuilder(
        builder: (context, snapshot) {
         */ /* if (snapshot.hasData) {
            if (snapshot.data?.userId != null) {
              return _homeScreenRoute();
            }
          }*/ /*
          return SplashScreen();
        }, future: null,
      ),*/
      home: SplashScreen(),
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.signinScreenRoute) {
      return pageRouteBuilder(_signInScreenRoute());
    }
    if (settings.name == AppRoutes.homeScreenRoute) {
      return pageRouteBuilder(_homeScreenRoute());
    }
    assert(false, 'Need to implement ${settings.name}');
    return null;
  }

  PageRouteBuilder<dynamic> pageRouteBuilder(Widget screenRoute) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return screenRoute;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  BlocProvider<UserLoginCubit> _signInScreenRoute() {
    return BlocProvider(
      create: (context) => UserLoginCubit(UserLoginUsecase(repository)),
      child: const SignInScreen(),
    );
  }

  MultiBlocProvider _homeScreenRoute() {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => GetTodoListCubit(
          GetTodoListUsecase(repository),
        ),
      ),
      BlocProvider(
        create: (context) => AddTaskCubit(
          AddTaskUsecase(repository),
        ),
      ),
    ], child: HomeScreen());
  }
/*BlocProvider<GetTodoListCubit> _homeScreenRoute() {
    return BlocProvider(
      create: (context) => GetTodoListCubit(GetTodoListUsecase(repository)),
      child:  HomeScreen(),
    );*/
}

var repository = TaskManagerRepositoryImpl();
