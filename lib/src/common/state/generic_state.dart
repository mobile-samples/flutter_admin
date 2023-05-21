import 'package:flutter/material.dart';
import 'package:flutter_admin/src/common/client/client.dart';
import 'package:flutter_admin/src/common/client/model.dart';

abstract class GenericState<W extends StatefulWidget, T, S extends Filter>
    extends State<W> {
  late Future<SearchResult<T>> data;

  @protected
  void setFilter();

  @protected
  S getFilter();

  @protected
  Client<T, String, ResultInfo<T>, S> getService();

  @protected
  Widget buildChild(BuildContext context, SearchResult<T> searchResult);

  @override
  void initState() {
    super.initState();
    setFilter();
    search();
  }

  void search() {
    final filter = getFilter();
    final res = getService().search(true, true, filter);
    setState(() {
      data = res;
      this.setFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<SearchResult<T>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildChild(context, snapshot.data!);
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cannot get data')));
              });
              return buildChild(context, SearchResult(0, [], '', true));
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
