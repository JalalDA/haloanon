import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  final String image;
  final String username;
  final String post;
  final String time;
  final void Function()? like;
  final void Function()? repost;
  final void Function()? comment;
  const CardPost(
      {super.key,
      required this.image,
      required this.username,
      required this.post,
      required this.time,
      this.comment,
      this.like,
      this.repost});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Ayam Jinak",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                          Text("Beberapa detik yang lalu")
                        ],
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       showMenu(
                  //         context: context,
                  //         position:
                  //             RelativeRect.fromLTRB(100.0, 100.0, 0.0, 0.0),
                  //         items: <PopupMenuEntry>[
                  //           const PopupMenuItem(
                  //             child: Text('Item 1'),
                  //             value: 'item1',
                  //           ),
                  //           PopupMenuItem(
                  //             child: Text('Item 2'),
                  //             value: 'item2',
                  //           ),
                  //           PopupMenuItem(
                  //             child: Text('Item 3'),
                  //             value: 'item3',
                  //           ),
                  //         ],
                  //       ).then((value) {
                  //         if (value != null) {
                  //           // Handle item selection
                  //           print('Selected: $value');
                  //         }
                  //       });
                  //     },
                  //     child: const Icon(Icons.more_vert))
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      print('Selected: $value');
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          onTap: (){},
                          value: 'chat',
                          child: Text('Ajak Chat'),
                        ),
                        PopupMenuItem<String>(
                          onTap: (){},
                          value: 'block',
                          child: Text('Blokir'),
                        ),
                        PopupMenuItem<String>(
                          onTap: (){},
                          value: 'report',
                          child: Text('Laporkan'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Halo saya ganteng banget hari ini",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.campaign),
                  Icon(Icons.message),
                  Icon(Icons.favorite),
                ],
              ),
            )
          ],
        ),
      );
}
