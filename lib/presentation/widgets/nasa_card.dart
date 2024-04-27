import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shimmer/shimmer.dart';
import 'package:universe_app_flutter/presentation/presentation.dart';

import '../../data/data.dart';

class NasaCard extends StatefulWidget {
  final NasaData nasaData;

  const NasaCard({
    super.key,
    required this.nasaData,
  });

  @override
  State<NasaCard> createState() => _NasaCardState();
}

class _NasaCardState extends State<NasaCard> {

  @override
  void initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsEscreen(nasaData: widget.nasaData),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Hero(
              tag: 'nasa_image_${widget.nasaData.title}',
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: CachedNetworkImage(
                    height: 300,
                    width: 500,
                    imageUrl: widget.nasaData.url,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 300,
                        width: 500,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GlassmorphicContainer(
                height: 80,
                width: 500,
                borderRadius: 12,
                blur: 10,
                border: 0,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.4),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.nasaData.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.nasaData.formatDate(DateTime.parse(widget.nasaData.date)),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
