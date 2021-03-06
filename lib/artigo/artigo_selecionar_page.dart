import 'package:flutter/material.dart';
import 'package:primobile/Database/Database.dart';

import 'artigo_modelo.dart';

class ArtigoSelecionarPage extends StatefulWidget {
 List<Artigo> artigos;

  ArtigoSelecionarPage({Key key, this.artigos}) : super(key: key);
  // final String title;
  @override
  _ArtigoSelecionarPageState createState() => new _ArtigoSelecionarPageState();
}

class _ArtigoSelecionarPageState extends State<ArtigoSelecionarPage> {
  TextEditingController editingController = TextEditingController();

  List<Artigo> listaArtigoSelecionado = List<Artigo>();

  var duplicateItems;

  var items = List<_ListaTile>();

  @override
  void initState() {
    super.initState();

  }

  void filterSearchResults(String query) {
    List<_ListaTile> dummySearchList = List<_ListaTile>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<_ListaTile> dummyListData = List<_ListaTile>();
      dummySearchList.forEach((item) {
        if (item.contem(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  bool isSelected = false;
  var color = Colors.white;

  bool adicionarArtigo(Artigo a) {
    bool existe = false;

    setState(() {
      for (var i = 0; i < listaArtigoSelecionado.length; i++) {
      if (listaArtigoSelecionado[i].artigo == a.artigo) {
        existe = true;
        listaArtigoSelecionado.removeAt(i);
      }
    }

    if (! existe) {
      listaArtigoSelecionado.add(a);
    }
    });

    return existe;
  }

  bool existeArtigo(Artigo a) {
    bool existe = false;

    for (var i = 0; i < listaArtigoSelecionado.length; i++) {
      if (listaArtigoSelecionado[i].artigo == a.artigo) {
        existe = true;
      }
    }
    return existe;
  }

  @override
  Widget build(BuildContext context) {
        widget.artigos = ModalRoute.of(context).settings.arguments;
    if (widget.artigos !=  null) {
      listaArtigoSelecionado = widget.artigos;
    }
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: new Text("Artigos"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration:
                  BoxDecoration(color: Color.fromRGBO(241, 249, 255, 100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                      )
                    ]),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: 'Procurar'),
                      onChanged: (value) {
                        // filtroResultadoBusca( value );
                        filterSearchResults(value);
                      },
                      controller: editingController,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: listaArtigo()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          Navigator.pop(context, listaArtigoSelecionado);
        },
      ),
    );
  }

  Widget listaArtigo() {
    return FutureBuilder(
      future: getTodosArtigos(),
      builder: (context, snap) {
        if ((snap.connectionState == ConnectionState.none &&
                snap.hasData == null ||
            snap.connectionState == ConnectionState.waiting)) {
          return Container(
            child: CircularProgressIndicator(),
          );
        } else if (snap.connectionState == ConnectionState.done) {
          if (snap.hasError) {
            return Text('Erro: ${snap.error}');
          }
          return new ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              Artigo artigo = snap.data[index];

              return new Card(
                color: existeArtigo(artigo) == false ? Colors.white : Colors.red,
                child:
                    // new CheckboxListTile(
                    //   value: artigo.quantidade > 10 ? true : false,
                    //   title: new Text(
                    //     artigo.descricao + '\n' + artigo.artigo + ' ' + artigo.unidade + ' ' + artigo.preco.toString(),
                    //     style: TextStyle(color: Colors.blueAccent, fontSize: 16) ,),
                    //   controlAffinity: ListTileControlAffinity.leading,
                    //   onChanged:(bool val){
                    //     setState(() {
                    //       print('val $val');
                    //     is_selected = val;
                    //     });
                    //   }

                    // )
                    _ListaTile(
                  selected: isSelected,
                  onTap:  () {
                    adicionarArtigo(artigo);
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.local_offer,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    artigo.descricao,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    artigo.artigo +
                        ' ' +
                        artigo.unidade +
                        ', ' +
                        artigo.preco.toString() +
                        ' MT',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                  data: artigo.descricao,
                ),
              );
            },
          );
        }
        return Text('Ocorreu um erro desconhecido: ${snap.error}');
      },
    );
  }
}

class _ListaTile extends ListTile {
  _ListaTile(
      {Key key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.isThreeLine = false,
      this.dense,
      this.contentPadding,
      this.enabled = true,
      this.onTap,
      this.onLongPress,
      this.selected = false,
      this.data = ""})
      : super(
            key: key,
            leading: leading,
            title: title,
            subtitle: subtitle,
            trailing: trailing,
            isThreeLine: isThreeLine,
            dense: dense,
            contentPadding: contentPadding,
            enabled: enabled,
            onTap: onTap,
            onLongPress: onLongPress,
            selected: selected);
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool isThreeLine;
  final bool dense;
  final EdgeInsetsGeometry contentPadding;
  final bool enabled;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final bool selected;
  final String data;

  String getTitle() {
    return this.data;
  }

  bool contem(value) {
    return this.data.toLowerCase().contains(value.toString().toLowerCase());
  }
}

Future getTodosArtigos() async {
  var res = await DBProvider.db.getTodosArtigos();
  return res;
}
