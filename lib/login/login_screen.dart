import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/login/shop_cubit/shop_login_cubit.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/register/register_screen.dart';
import 'package:shop/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  // var condition=state.loginModel?.status;
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data?.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: (state.loginModel.message!), state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browse our hot offers ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultFormFeild(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFormFeild(
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },

                          ///بعمل هنا onSubmit عشان بمجرد ما اليوزر يدخل الداتا صح يعمل لوجن علطول من غير الضغط علي البتن
                          onSubmet: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.password_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopLoginScreen,

                            ///لو الشرط اللي فوق دا اتحقق وهي مش لودنج اظهر اللي جوا البلدر ولو لا اظهر اللي جوا ال fullback
                            builder: (contetxt) => DefaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).UserLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    } else {}
                                  },
                                  text: 'LOGIN',
                                  isUppercase: true,
                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account ?'),
                            DefaultTextButton(
                                function: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'register'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
