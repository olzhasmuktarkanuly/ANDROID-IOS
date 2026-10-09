import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Card Lab'),
          centerTitle: true,
        ),
        body: const Center(
          child: ProfileCard(),
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final int defaultLikes = 150;
  final int defaultDislikes = 10;

  bool isFollowing = false;
  bool isLiked = false;
  bool isDisliked = false;

  late int likeCount;
  late int dislikeCount;

  @override
  void initState() {
    super.initState();
    likeCount = defaultLikes;
    dislikeCount = defaultDislikes;
  }

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
        isLiked = false;
      } else {
        likeCount++;
        isLiked = true;
        if (isDisliked) {
          dislikeCount--;
          isDisliked = false;
        }
      }
    });
  }

  void toggleDislike() {
    setState(() {
      if (isDisliked) {
        dislikeCount--;
        isDisliked = false;
      } else {
        dislikeCount++;
        isDisliked = true;

        if (isLiked) {
          likeCount--;
          isLiked = false;
        }
      }
    });
  }

  void resetProfile() {
    setState(() {
      isFollowing = false;
      isLiked = false;
      isDisliked = false;
      likeCount = defaultLikes;
      dislikeCount = defaultDislikes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/200'),
            ),
            const SizedBox(height: 15),

            const Text(
              'Muktarkanuly Olzhas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: toggleFollow,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing ? Colors.grey[300] : Colors.blue,
                foregroundColor: isFollowing ? Colors.black : Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: Text(isFollowing ? 'Following' : 'Follow'),
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                        color: isLiked ? Colors.blue : Colors.grey,
                      ),
                      onPressed: toggleLike,
                      iconSize: 26,
                    ),
                    Text(
                      '$likeCount',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                        color: isDisliked ? Colors.red : Colors.grey,
                      ),
                      onPressed: toggleDislike,
                      iconSize: 26,
                    ),
                    Text(
                      '$dislikeCount',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                OutlinedButton.icon(
                  onPressed: resetProfile,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}