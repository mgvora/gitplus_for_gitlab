import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'edit_user.dart';
import 'dart:ui';

class EditUser extends GetView<EditUserController> {
  const EditUser({Key? key}) : super(key: key);

  final double coverHeight = 180;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var x = controller.defaultId.value.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User edit'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            headerUser(),
            nameUser(),
            bodyUser(),
            formUser(context),
          ],
        ),
      ),
    );
  }

  Widget formUser(BuildContext context) {
    return Positioned(
      top: 200,
      child: Container(
        height: 380,
        width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Change name or password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MaterialCommunityIcons.head,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  hintText: "New user name",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MaterialCommunityIcons.lock,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  hintText: "New password",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MaterialCommunityIcons.lock,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  hintText: "Repeat new password",
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            Text('TextButton'),
          ],
        ),
      ),
    );
  }

  Widget nameUser() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        Text(
          controller.account.value.name!,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.account.value.username!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              controller.account.value.baseUrl!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }

  Widget bodyUser() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            cusWidIcon(FontAwesome.camera),
            cusWidIcon(FontAwesome.photo),
          ],
        ),
        const Divider(
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cusWidCalcul('Accounts', controller.countAcc),
            cusWidCalcul('All projects', controller.countProjects.value),
            cusWidCalcul(
                'Personal projects', controller.countPersonProjects.value),
          ],
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget cusWidCalcul(String title, int number) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            '$number',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget cusWidIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 30, 5, 10),
      child: CircleAvatar(
        radius: 25,
        child: Center(
          child: Icon(
            icon,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget headerUser() {
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          //child: coverImage(),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: coverImage(),
          ),
          margin: EdgeInsets.only(bottom: profileHeight / 2),
        ),
        Positioned(
          top: top,
          child: profileImage(),
        ),
      ],
    );
  }

  Widget coverImage() {
    var avatarUrl = controller.account.value.avatarUrl!;
    return Container(
      color: Colors.grey,
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget profileImage() {
    var avatarUrl = controller.account.value.avatarUrl!;
    return CircleAvatar(
      radius: profileHeight / 2,
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(image: imageProvider),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.person),
        //fit: BoxFit.cover,
      ),
    );
  }
}
