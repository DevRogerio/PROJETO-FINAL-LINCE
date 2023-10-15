import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// Show cars passing by on the screen
class Carousel extends StatefulWidget {
  /// class of Carousel
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List data = [
    {
      'url':
          'https://garagem360.com.br/wp-content/uploads/2023/08/Fiat-Strada-Volcano-CVT-2024-1.jpg'
    },
    {
      'url':
          'https://garagem360.com.br/wp-content/uploads/2023/07/Honda-Elevate-frente.jpg'
    },
    {
      'url':
          'https://cdn.motor1.com/images/mgl/W89Qz3/s1/volkswagen-polo-track-2023.jpg'
    },
    {
      'url':
          'https://cdn.motor1.com/images/mgl/pb0wn1/s3/volkswagen-polo-track-2023.webp'
    },
    {
      'url':
          'https://garagem360.com.br/wp-content/uploads/2023/10/Novo-Projeto-2023-10-06T075005.864.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            height: 250,
          ),
          items: data.map((item) {
            return GridTile(
              child: Image.network(item['url'], fit: BoxFit.cover),
            );
          }).toList(),
        ),
      ],
    );
  }
}
