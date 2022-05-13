import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  List _images = [
    'https://dimg04.c-ctrip.com/images/0zg1q120009ggsv8s38DA.jpg',
    'https://dimg04.c-ctrip.com/images/0zg1p120009ggswfhA338.jpg',
    'https://dimg04.c-ctrip.com/images/0zg43120009ggsk3n380D.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              child: Swiper(
                itemCount: _images.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _images[index],
                    fit: BoxFit.fill,
                  );
                },
                pagination: SwiperPagination(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
