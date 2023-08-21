import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/comprovativo_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_resultado_alugado.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_resultado_filtro.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/ImovelController.dart';

class AluguerListView extends StatefulWidget {
  late List<Aluguer> lista;
  late Function carregarMais;
  late int totalItems;
  late NavigationController navigationController;

  AluguerListView(
      {Key? key,
      required this.lista,
      required this.carregarMais,
      required this.totalItems,
      required this.navigationController})
      : super(key: key);

  @override
  AluguerListViewState createState() => AluguerListViewState();
}

class AluguerListViewState extends State<AluguerListView> {
  late ScrollController _scrollController;
  late bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._scrollController = new ScrollController()
      ..addListener(_scrollListener);
    this.isLoading = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            this._scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (this.widget.lista.length < this.widget.totalItems) {
        setState(() {
          this.isLoading = true;
          this._loadMore();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 0),
        child: Stack(
          children: [
            ListView.builder(
                padding: EdgeInsets.only(top: 0),
                itemCount: this.isLoading
                    ? this.widget.lista.length
                    : this.widget.lista.length,
                shrinkWrap: true,
                controller: this._scrollController,
                itemBuilder: (BuildContext itemBuilder, index) {
                  if (index == this.widget.lista.length - 1) {
                    return ItemResultadoAlugado(
                      margin: EdgeInsets.only(top: 5, bottom: 100),
                      aluguer: this.widget.lista[index],
                      navigationController: this.widget.navigationController,
                      onPress: (Aluguer item) {
                        this.widget.navigationController.navigateTo(
                              context,
                              ComprovativoPage(
                                item,
                                navigation: this.widget.navigationController,
                              ),
                            );
                      },
                    );
                  }

                  return ItemResultadoAlugado(
                    margin: index == 0
                        ? EdgeInsets.only(top: 5, bottom: 5)
                        : EdgeInsets.only(bottom: 5),
                    aluguer: this.widget.lista[index],
                    navigationController: this.widget.navigationController,
                    onPress: (Aluguer item) {
                      //
                      this.widget.navigationController.navigateTo(
                            context,
                            ComprovativoPage(
                              item,
                              navigation: this.widget.navigationController,
                            ),
                          );
                    },
                  );
                }),
            this.isLoading ? this._containerLoading() : Container()
          ],
        ));
  }

  void _loadMore() {
    setState(() {
      this.widget.carregarMais(this);
    });
  }

  Widget _containerLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white.withOpacity(0.2),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
