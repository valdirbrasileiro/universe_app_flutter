import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../presentation.dart';

class DateRangePickerWidget extends StatefulWidget {
  final List<NasaData> nasaData;
  final NasaDataBloc nasaDataBloc;
  const DateRangePickerWidget(
      {super.key, required this.nasaData, required this.nasaDataBloc});

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: Column(
        children: [
          Input(
            inputController: inputController,
            hintText: 'Pesquise por um título',
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Data de início:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _startDate = selectedDate;
                            });
                          }
                        },
                        child: _startDate == null
                            ? const Icon(Icons.calendar_month)
                            : Text(
                                '${_startDate?.day.toString().padLeft(2, '0')}/${_startDate?.month.toString().padLeft(2, '0')}/${_startDate?.year}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Data de fim:',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _endDate = selectedDate;
                            });
                          }
                        },
                        child: _endDate == null
                            ? const Icon(Icons.calendar_month)
                            : Text(
                                '${_endDate?.day.toString().padLeft(2, '0')}/${_endDate?.month.toString().padLeft(2, '0')}/${_endDate?.year}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.nasaDataBloc.inputNasa.add(GetNasaFilteredEvent(
                title: inputController.text,
                  nasaData: widget.nasaData,
                  startData: _startDate,
                  endData: _endDate));

              Navigator.pop(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
