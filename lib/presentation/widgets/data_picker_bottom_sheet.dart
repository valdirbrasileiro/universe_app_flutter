import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../presentation.dart';

class DatePickerBottomSheet extends StatelessWidget {
  final List<NasaData> nasaData;
  final NasaDataBloc nasaDataBloc;
  const DatePickerBottomSheet(
      {super.key, required this.nasaData, required this.nasaDataBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.deepPurpleAccent,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
          const SizedBox(height: 20.0),
          DateRangePickerWidget(nasaData: nasaData, nasaDataBloc: nasaDataBloc),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
