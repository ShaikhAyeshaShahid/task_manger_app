import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manger_app/presentation/cubit/user_login/user_login_cubit.dart';

import '../../constants/colors.dart';
import '../../constants/router.dart';
import '../../constants/size_config.dart';
import '../widgets/task_manager_app_button.dart';
import '../widgets/task_manager_password_text_form_field.dart';
import '../widgets/task_manager_text_form_field.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late UserLoginCubit cubit;

  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    usernameController.text = "kminchelle";
    passwordController.text = "0lelplR";
    cubit = BlocProvider.of<UserLoginCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message);

          return false;
        } else {
          Fluttertoast.cancel();

          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.height(context, 1),
            decoration:
                const BoxDecoration(gradient: GlobalColors.backgroundGradient),
            child: Column(
              children: [
                Hero(
                  tag: 'donation_logo',
                  child: SizedBox(
                    height: SizeConfig.height(context, 0.15),
                    // padding: EdgeInsets.all(SizeConfig.width(context, 0.01)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(context, 0.05),
                          ),
                          child: Row(
                            // padding: EdgeInsets.only(left: SizeConfig.width(context, 0.16)),
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: 0.0,
                                child:
                                    Image.asset('assets/icons/drawer_icon.png'),
                              ),
                              Image.asset(
                                'assets/images/account-login.png',
                                width: SizeConfig.width(context, 0.15),
                              ),
                              /* Image.asset(
                              'assets/images/donation4all_logo.png'),*/
                              Opacity(
                                opacity: 0.0,
                                child:
                                    Image.asset('assets/icons/drawer_icon.png'),
                              ),
                              // SizedBox(width: SizeConfig.width(context, 0.05)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          SizeConfig.width(context, 0.4),
                        ),
                      ),
                      child: Container(
                        width: SizeConfig.width(context, 1),
                        // padding: EdgeInsets.all(SizeConfig.width(context, 0.05)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(SizeConfig.width(context, 0.4)),
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(context, 0.06),
                          ),
                          children: [
                            SizedBox(height: SizeConfig.height(context, 0.05)),

                            /// Sign In heading
                            Text(
                              'SIGN IN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: SizeConfig.width(context, 0.06),
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.primaryColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: SizeConfig.width(context, 0.07)),

                            /// Email Text Field
                            TaskManagerTextFormField(
                              hintText: 'Username',
                              prefixIcon: const Icon(Icons.email),
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              validator: emailValidation,
                            ),
                            SizedBox(height: SizeConfig.width(context, 0.07)),

                            /// Password Text Field
                            TaskManagerPasswordTextField(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              visibility: false,
                              controller: passwordController,
                              validator: passwordValidation,
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.017)),

                            /// Forgot Password
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.forgotPasswordScreenRoute,
                                );
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Forgot password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize:
                                            SizeConfig.height(context, 0.017),
                                        fontWeight: FontWeight.bold,
                                        color: GlobalColors.primaryColor,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.05)),

                            /// Sign In Button
                            BlocConsumer<UserLoginCubit, UserLoginState>(
                              listener: (context, state) {
                                if (state is UserLoginFailed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage),
                                    ),
                                  );
                                }
                                if (state is UserLoginSuccess) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.homeScreenRoute,
                                    (route) => false,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is UserLoginLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return AppButton(
                                  buttonText: 'SIGN IN',
                                  onPressed: () {
                                    print("Button is pressed");
                                   /* Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );*/

                                    if (_formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        usernameController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.03)),

                            /// Divider OR Divider
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.height(context, 0.01),
                                      right: SizeConfig.height(context, 0.01),
                                    ),
                                    child: Divider(
                                      color: const Color(0xFF9E9E9E),
                                      height: SizeConfig.height(context, 0.05),
                                    ),
                                  ),
                                ),
                                Text(
                                  "OR",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize:
                                            SizeConfig.height(context, 0.02),
                                        color: const Color(0xFF9E9E9E),
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: SizeConfig.height(context, 0.01),
                                      right: SizeConfig.height(context, 0.01),
                                    ),
                                    child: Divider(
                                      color: const Color(0xFF9E9E9E),
                                      height: SizeConfig.height(context, 0.05),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.03)),

                            /// Social Sign in buttons
                            SizedBox(
                              width: SizeConfig.width(context, 0.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/twitter.png',
                                    width: SizeConfig.width(context, 0.13),
                                    fit: BoxFit.fill,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      /* _googleSignIn
                                          .signIn()
                                          .then((GoogleSignInAccount? value) {
                                        String userName =
                                            value?.displayName ?? 'displayName';
                                        String profilePicture =
                                            value?.photoUrl ?? 'photoUrl';

                                        LogManager.debug(
                                          'googleSignIn::userName = $userName',
                                        );
                                        LogManager.debug(
                                          'googleSignIn::profilePicture = $profilePicture',
                                        );
                                      });*/
                                    },
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      width: SizeConfig.width(context, 0.10),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/facebook.png',
                                    width: SizeConfig.width(context, 0.12),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.05)),

                            /// Don't have an account? Create
                            SizedBox(
                              height: SizeConfig.height(context, 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize:
                                              SizeConfig.width(context, 0.04),
                                          color: const Color(0xff4E4D4D),
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.width(context, 0.02),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      /*Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen(),
                                        ),
                                      );*/
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        AppRoutes.signinScreenRoute,
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      'Create',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontSize: SizeConfig.width(
                                              context,
                                              0.04,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff4E4D4D),
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.height(context, 0.03)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? passwordValidation(String? value) {
    if (value == null) {
      return 'required';
    }
    if (value.isEmpty) {
      return 'Please enter your Password';
    }
   /* if (value.length < 8) {
      return 'Password must be at least 8 Characters';
    }*/
   /* if (!RegExp('(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one Lowercase Letter';
    }
    if (!RegExp('(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one Uppercase Letter';
    }
    if (!RegExp('(?=.*\\d)').hasMatch(value)) {
      return 'Password must contain at least one Number';
    }
    if (!RegExp('(?=.*[-+_!@#\$%^&*., ?])').hasMatch(value)) {
      return 'Password must contain at least one Special Character';
    }*/
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null) {
      return 'required';
    }
    if (value.isEmpty) {
      return 'Please enter Email Address';
    }
    /* if (!EmailValidator.validate(value)) {
      return 'Please enter valid Email Address';
    }*/
    return null;
  }
}
