import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../presentation.dart';

class NasaList extends StatefulWidget {
  final List<NasaData> nasaDataList;

  const NasaList({super.key, required this.nasaDataList});

  @override
  State<NasaList> createState() => _NasaListState();
}

class _NasaListState extends State<NasaList> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          startAnimation = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: widget.nasaDataList.length,
        itemBuilder: (context, index) {
          return AnimatedContainer(
              width: screenWidth,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 100 + (index * 100)),
              transform: Matrix4.translationValues(
                  startAnimation ? 0 : screenWidth, 0, 0),
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18, bottom: 18),
                  child: NasaCard(nasaData: widget.nasaDataList[index])));
        });
  }
}
