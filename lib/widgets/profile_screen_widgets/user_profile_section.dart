import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/app/router/router.dart';
import 'package:social_media_app/auth/controllers/auth_controller.dart';
import 'package:social_media_app/auth/model/user_model.dart';
import 'package:social_media_app/common/controllers/post_controller.dart';
import 'package:social_media_app/utils/image_dialgue.dart';

import 'no_of_followers_posts_and_followings.dart';

class UserProfileSection extends StatefulWidget {
  const UserProfileSection({
    required this.user,
    Key? key,
  }) : super(key: key);
  final UserModel user;

  @override
  State<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends State<UserProfileSection> {
  int postsCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final controller = context.read<PostController>();
      postsCount = await controller.getTotalPostCount(uid: widget.user.uid);
      followersCount =
          await controller.getTotalFollowerCount(uid: widget.user.uid);
      followingCount =
          await controller.getTotalFollowingCount(uid: widget.user.uid);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AuthController>(builder: (context, provider, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.user.uid == provider.appUser!.uid
                  ? provider.isUploading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            provider.appUser!.profileUrl != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        provider.appUser!.profileUrl!),
                                  )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 163, 194),
                                    backgroundImage:
                                        AssetImage("assets/images/1.png"),
                                  ),
                            Positioned(
                              right: 0,
                              bottom: 00,
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    imageDialogue(
                                      context,
                                      onSelect: (file) {
                                        provider.changeImage(image: file);
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.camera),
                                ),
                              ),
                            ),
                          ],
                        )
                  : widget.user.profileUrl != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(widget.user.profileUrl!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 255, 163, 194),
                          backgroundImage: AssetImage("assets/images/1.png"),
                        ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.designation,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 68, 68, 68),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.user.uid != provider.appUser!.uid
                      ? Row(
                          children: [
                            Container(
                              width: 120,
                              height: 35,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 228, 211, 62),
                                    Colors.deepOrange,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text(
                                  "Follow Me",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              // height: 30,

                              child: const Center(
                                child: Icon(
                                  Icons.message,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          );
        }),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NoOfFollowersPostAndFollowings(
              counting: followingCount.toString(),
              text: "Following",
              onpressed: () {
                Navigator.pushNamed(context, AppRouter.followingScreen,
                    arguments: widget.user.uid);
              },
            ),
            NoOfFollowersPostAndFollowings(
              counting: postsCount.toString(),
              text: "Posts",
            ),
            NoOfFollowersPostAndFollowings(
              counting: followersCount.toString(),
              text: "Followers",
              onpressed: () {
                Navigator.pushNamed(context, AppRouter.followersScreen,
                    arguments: widget.user.uid);
              },
            ),
          ],
        )
      ],
    );
  }
}
