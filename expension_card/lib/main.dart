

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_art_and_culture/src/feature/pameran/screen/detail_pameran.dart';

class RoundedImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String harga;
  final String location;

  const RoundedImageCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.harga,
    required this.location,
    required double width,
  }) : super(key: key);

  Future<void> fetchData() async {
    try {
      final response = await Dio().get('https://658144ba3dfdd1b11c42c970.mockapi.io/pameran');
      // Handle response data
      print(response.data);
    } catch (error) {
      // Handle error
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345, // Menentukan lebar card
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F999999),
            blurRadius: 8,
            offset: Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Image.asset(
              imagePath,
              width: 321,
              height: 127,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFFE8644B),
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Text(
                  "Pameran",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFF91A1D3),
                    borderRadius: BorderRadius.circular(20.0)),
                child: const Text(
                  "Berbayar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$title',
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 14,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$harga | ",
                style: const TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.location_on,
                size: 10,
                color: Colors.grey,
              ),
              Text(
                // ignore: unnecessary_string_interpolations
                '$location',
                style: const TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DetailPameran()),
                        (route) => false);
                  },
                  icon: SvgPicture.asset("assets/svg/arrow right.svg"),
                ),
              ),
              // const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}