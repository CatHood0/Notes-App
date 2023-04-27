import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
    required this.now,
  });

  final DateTime now;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      floating: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
      flexibleSpace: FlexibleSpaceBar(
          background: CachedNetworkImage(
            imageUrl:
                "https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80",
            fit: BoxFit.cover,
          ),
          titlePadding:
              const EdgeInsets.only(right: 10, left: 20, bottom: 30),
          title: Text(
            "¡Good evening Santiago! \n  ${DateFormat.yMMMMd().format(now)}",
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600),
          )),
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      elevation: 5,
      title: const Text("Home"),
    );
  }
}
