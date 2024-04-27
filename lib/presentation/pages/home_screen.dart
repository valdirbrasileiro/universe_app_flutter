import 'package:flutter/material.dart';
import 'package:universe_app_flutter/commons/commons.dart';

import '../../data/data.dart';
import '../presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NasaDataBloc _nasaDataBloc;
  late List<NasaData> nasaDataList;

  @override
  void initState() {
    super.initState();
    _nasaDataBloc = NasaDataBloc();
    _nasaDataBloc.inputNasa.add(GetNasaEvent());
  }

  @override
  void dispose() {
    _nasaDataBloc.inputNasa.close();
    super.dispose();
  }

  void _showDatePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DatePickerBottomSheet(
          nasaData: nasaDataList,
          nasaDataBloc: _nasaDataBloc,
        );
      },
    );
  }

  void onRefreshFiltered(
      DateTime? startDate, DateTime? endDate, String? title) {
    _nasaDataBloc.inputNasa.add(GetNasaFilteredEvent(
        nasaData: nasaDataList, startData: startDate, endData: endDate));
  }

  Future<void> _onRefresh() async {
    _nasaDataBloc.inputNasa.add(GetNasaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder<NasaDataState>(
          stream: _nasaDataBloc.outputNasa,
          builder: (context, state) {
            if (state.data is NasaDataLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ));
            } else if (state.data is NasaDataLoadedState) {
              nasaDataList = state.data?.nasaData ?? [];
              if (_nasaDataBloc.nasaDataComplete.value.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () => _onRefresh(),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        shadowColor: Colors.grey,
                        actions: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.deepPurpleAccent,
                            ),
                            onPressed: () {
                              _nasaDataBloc.inputNasa.add(RecoveryNasaEvent());
                            },
                          ),
                        ],
                        floating: true,
                        snap: true,
                        toolbarHeight: 50.0,
                        flexibleSpace: const FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            'Universe',
                            style: TextStyle(color: Colors.deepPurpleAccent),
                          ),
                        ),
                        automaticallyImplyLeading: false,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AnimatedTextList(
                                    phrases: [
                                      'Ops, parece que não encontramos suas imagens',
                                      'Tente refazer a busca'
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return NestedScrollView(
                    headerSliverBuilder: (context, _) => [
                          SliverAppBar(
                            backgroundColor: Colors.grey[200],
                            shadowColor: Colors.black,
                            actions: [
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onPressed: () {
                                  _showDatePickerBottomSheet(context);
                                },
                              ),
                            ],
                            floating: true,
                            snap: true,
                            toolbarHeight: 50.0,
                            flexibleSpace: const FlexibleSpaceBar(
                              centerTitle: true,
                              title: Text(
                                'Universe',
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
                              ),
                            ),
                            automaticallyImplyLeading: false,
                          )
                        ],
                    body: RefreshIndicator(
                      onRefresh: () => _onRefresh(),
                      child: NasaList(nasaDataList: nasaDataList),
                    ));
              }
            }
            if (state is NasaDataErrorState) {
              navigateToNamed('/generic_error');
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
