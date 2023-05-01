import 'package:flutter/material.dart';
import 'package:notes_project/main.dart';
import '../blocs/blocs.dart';
import '../domain/bloc/Store/StoreState.dart';
import '../UI/notes/widget/listNoteWidget.dart';

class TemplateListWidget extends StatelessWidget {
  TemplateListWidget({
    super.key,
  });

  final StoreBloc storeBloc = locator.Get<StoreBloc>();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: StreamBuilder<StoreState>(
            stream: storeBloc.stateStream,
            builder: (context, snapshot) {
              if (snapshot.data is LoadedAllTemplatesState) {
                final data =
                    (snapshot.data as LoadedAllTemplatesState).templates;
                return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                children: [
                                  Text(data[index].name),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data[index].likes.toString()),
                                      Text(data[index].shares.toString())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
              } else if (snapshot.data is LoadingStoreTemplatesState) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data is NotFoundTemplatesState) {
                final error =
                    (snapshot.data as NotFoundTemplatesState).notFoundMessage;
                return ErrorMessageWidget(error: error);
              } else if (snapshot.data is ErrorStoreState) {}
              return const Center(
                  child: Text(
                '¡Ops!, may that the service is not working',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.justify,
              ));
            }),
      ),
    );
  }
}
