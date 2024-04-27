import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/data.dart';

class DetailsEscreen extends StatelessWidget {
  final NasaData nasaData;

  const DetailsEscreen({Key? key, required this.nasaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[300],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor:  Colors.grey[200],
            centerTitle: true,
            title: Text(
              overflow: TextOverflow.ellipsis,
              nasaData.title,
              style: const TextStyle(color: Colors.deepPurpleAccent),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                          tag: 'nasa_image_${nasaData.title}',
                          child: CachedNetworkImage(
                            imageUrl: nasaData.url,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ))
                      .animate()
                      .fade(duration: 300.ms)
                      .then(delay: 50.ms)
                      .slide(),
                  const SizedBox(height: 18.0),
                  Text(
                    nasaData.title,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .then(delay: 200.ms)
                      .slideX(),
                  const SizedBox(height: 8.0),
                  Text(
                    nasaData.formatDate(DateTime.parse(nasaData.date)),
                    style: const TextStyle(fontSize: 16.0),
                  ).animate().then(delay: 300.ms).slideX(),
                  const SizedBox(height: 8.0),
                  Text(
                    nasaData.explanation,
                    style: const TextStyle(fontSize: 16.0),
                  ).animate().then(delay: 250.ms).slideX(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
