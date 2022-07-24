import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

enum AppDrawerItems { dashboard, projects, groups }

class AppDrawer extends StatelessWidget {
  final AppDrawerItems? selected;
  final AppAccount account;
  final Repository repository;

  const AppDrawer({
    Key? key,
    this.selected,
    required this.account,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _storage = Get.find<SPStorage>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            bottom: false,
            child: DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          child: CachedNetworkImage(
                            imageUrl: account.avatarUrl!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(image: imageProvider),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(Routes.accounts);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(account.name ?? "",
                                  style: const TextStyle(fontSize: 18)),
                              Text(account.username ?? "",
                                  style: const TextStyle()),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.accounts);
                        },
                        tooltip: 'Accounts',
                        icon: const Icon(Icons.keyboard_arrow_right)),
                  ],
                ),
              ),
            ),
          ),
          DrawerListTile(
              title: "Overview",
              icon: FontAwesome.gitlab,
              selected: selected == AppDrawerItems.dashboard,
              onTap: () {
                Get.back();
                Get.offNamed(Routes.home);
              }),
          DrawerListTile(
              title: "Projects",
              icon: MaterialCommunityIcons.git,
              selected: selected == AppDrawerItems.projects,
              onTap: () {
                Get.back();
                Get.offNamed(Routes.projects);
              }),
          DrawerListTile(
              title: "Groups",
              icon: Octicons.file_submodule,
              selected: selected == AppDrawerItems.groups,
              onTap: () {
                Get.back();
                Get.offNamed(Routes.groups);
              }),
          const DrawerListTileDivider(),
          DrawerListTile(
              title: "Settings",
              icon: Icons.settings,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.settings);
              }),
          DrawerListTile(
              title: "Help & Feedback",
              icon: Octicons.info,
              onTap: () {
                Get.back();
                Get.toNamed(Routes.about);
              }),
          DrawerListTile(
              title: "Logout",
              icon: Icons.logout,
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => QuestionMessagePresetsDialog(
                    title: 'Logout',
                    text: 'Are you sure?',
                    action: () async {
                      Get.back();
                      var sstorage = Get.find<SecureStorage>();
                      await sstorage.removeAccount(account);
                      if (sstorage.getAccounts().isEmpty) {
                        Get.offAllNamed(Routes.auth);
                      } else {
                        var newacc = sstorage.getAccounts()[0];
                        await sstorage
                            .setDefaultAccount(sstorage.getAccounts()[0]);
                        repository.account.value = AppAccount.fromJson(
                            sstorage.getDefaultAccount().toJson());
                        CommonWidget.toast(
                            "Account switched to " + newacc.name!);
                      }
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
