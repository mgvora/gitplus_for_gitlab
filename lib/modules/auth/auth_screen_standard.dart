import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/modules/auth/auth.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreenStandard extends GetView<AuthController> {
  const AuthScreenStandard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var style = SystemUiOverlayStyle.dark;
    if (Get.isDarkMode) {
      style = SystemUiOverlayStyle.light;
    }
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: style,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  const SizedBox(height: 15),
                  SvgPicture.asset(
                    "././assets/logo/2.svg",
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Git+ for GitLab',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      FilterChip(
                        label: Text('HTTPS'.tr),
                        selected: controller.isHttps.value,
                        onSelected: (value) {
                          controller.isHttps.value = true;
                          controller.prefix.value = "https";
                        },
                      ),
                      SizedBox(width: 5),
                      FilterChip(
                        label: Text('HTTP'.tr),
                        selected: !controller.isHttps.value,
                        onSelected: (value) {
                          controller.isHttps.value = false;
                          controller.prefix.value = "http";
                        },
                      ),
                    ],
                  ),
                  InputField(
                    labelText: "Server",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Server is required.';
                      }
                      return null;
                    },
                    autofocus: false,
                    context: context,
                    controller: controller.textcontroller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10),
                  CupertinoSlidingSegmentedControl(
                    padding: const EdgeInsets.all(0),
                    // thumbColor: AppColors.selectedButton,
                    // backgroundColor: AppColors.button,
                    groupValue: controller.selectedTab.value,

                    children: const <int, Widget>{
                      0: Text('Basic Auth'),
                      1: Text('Access Token'),
                      // 2: Text('Wheel'),
                    },
                    onValueChanged: (i) async {
                      controller.onTabChanged(i as int);
                    },
                  ),
                  SizedBox(height: 10),
                  if (controller.selectedTab.value == 0)
                    Column(
                      children: [
                        InputField(
                          labelText: "Username",
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required.';
                            }
                            return null;
                          },
                          autofocus: false,
                          context: context,
                          controller: controller.nameController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        InputField(
                          labelText: "Password",
                          autofillHints: const [AutofillHints.password],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            controller.submitPassAuth();
                          },
                          autofocus: false,
                          obscureText: true,
                          context: context,
                          controller: controller.passController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.selectedTab.value == 0) {
                                    controller.submitPassAuth();
                                  } else {
                                    controller.submitAccessTokenAuth();
                                  }
                                },
                                child: const Text('Login'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        if (Platform.isAndroid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _register();
                                },
                                child: const Text('Register',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        InputField(
                          labelText: "Personal Access Token",
                          autofocus: false,
                          context: context,
                          controller: controller.accessTokenController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.selectedTab.value == 0) {
                                    controller.submitPassAuth();
                                  } else {
                                    controller.submitAccessTokenAuth();
                                  }
                                },
                                child: const Text('Login'),
                                // style: ButtonStyle(
                                //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                //     RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(15.0),
                                //         side: BorderSide(color: Colors.transparent)),
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                        if (Platform.isAndroid) const SizedBox(height: 5),
                        if (Platform.isAndroid)
                          OutlinedButton(
                            onPressed: () {
                              var baseUrl = controller.prefix +
                                  "://" +
                                  controller.textcontroller.text;
                              launch(
                                  '$baseUrl/-/profile/personal_access_tokens');
                            },
                            child: const Text('Get Access Token',
                                style: TextStyle(fontSize: 16)),
                          ),
                        if (Platform.isAndroid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _register();
                                },
                                child: const Text('Register',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
              if (Navigator.canPop(context))
                IconButton(
                    tooltip: 'Back',
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(platformPopIcon())),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    var baseUrl = controller.prefix + "://" + controller.textcontroller.text;
    launch('$baseUrl/users/sign_up');
  }

  IconData platformPopIcon() {
    if (Platform.isIOS) {
      return Icons.arrow_back_ios_new;
    } else {
      return Icons.arrow_back;
    }
  }
}
