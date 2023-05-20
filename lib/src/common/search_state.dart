import 'package:flutter/material.dart';
import 'package:flutter_admin/src/common/client/client.dart';
import 'package:flutter_admin/src/common/client/model.dart';

abstract class SearchState<W extends StatefulWidget, T, S extends Filter>
    extends State<W> {
  late SearchResult<T> dataList;
  bool _isLoading = false;

  @protected
  void setFilter();

  @protected
  S getFilter();

  @protected
  Client<T, String, ResultInfo<T>, S> getService();

  @protected
  Widget buildChild(BuildContext context);

  void search() async {
    _isLoading = true;
    final filter = getFilter();
    final res = await getService().search(true, true, filter);
    setState(() {
      dataList = res;
      this.setFilter();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildChild(context),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //       child: FutureBuilder<SearchResult<T>>(
  //           future: dataList,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               return buildChild(dataList);
  //             } else if (snapshot.hasError) {
  //               return Text('${snapshot.error}');
  //             }
  //             return const CircularProgressIndicator();
  //           }),
  //   );
  // }
}
