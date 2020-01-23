import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:primobile/artigo/artigo_modelo.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:primobile/util.dart';

BuildContext contexto;

class EncomendaPage extends StatefulWidget {
  EncomendaPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EncomendaPageState createState() => new _EncomendaPageState();
}

class _EncomendaPageState extends State<EncomendaPage> {
  TextEditingController txtClienteController = TextEditingController();
  BuildContext context;
  var items = List<dynamic>();
  final encomendaItens = <dynamic>[
    // encomendaItemVazio(),
  ];

  double mercadServicValor = 0.0;
  double ivaTotal = 0.0;
  double subtotal = 0.0;
  double totalVenda = 0.0;

  double iva = 17.0;

  @override
  void initState() {
    items.addAll(encomendaItens);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contexto = context;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: new Text("Encomenda"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.blue[400],
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue[900], // fromRGBO(7, 89, 250, 100)
                // gradient: LinearGradient(
                //     // begin: ``
                //     colors: [Colors.blueAccent, Colors.blueAccent]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                         totalVenda.toStringAsFixed(2).toString() + "\n",
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 200,
                    // margin: EdgeInsets.only(top: 64),/s
                    padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            // blurRadius: 5
                          )
                        ]),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        espaco(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Mercad/Servico",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[300]),
                            ),
                            Text(
                              mercadServicValor.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        espaco(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "IVA",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[300],
                              ),
                            ),
                            Text(
                              iva.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        espaco(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[300]),
                            ),
                            Text(
                              subtotal.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width / 1.3) - 6,
                              height: 45,

                              // margin: EdgeInsets.only(top: 64),/s
                              padding: EdgeInsets.only(
                                  top: 4, left: 16, right: 16, bottom: 4),
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.all(
                                  //   // Radius.circular(50)
                                  // ),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.blue),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue,
                                      // blurRadius: 5
                                    )
                                  ]),
                              child: TextField(
                                // enabled: false,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.person_outline,
                                      color: Colors.blue,
                                    ),
                                    hintText: 'Selecionar Cliente'),
                                onChanged: (value) {
                                  // filtroResultadoBusca( value );
                                },
                                onTap: () async {
                                  final result = Navigator.pushNamed(
                                      context, '/cliente_selecionar_lista');
                                      // print(result);
                                      result.then((obj) {
                                       print('obj');
                                        print(obj);
                                      txtClienteController.text = obj.toString();

                                      });

                                },

                                controller: txtClienteController,
                              ),
                            ),
                            //  Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[index];
                  // ListTile(
                  //   title: Text('${items[index]}'),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app, color: Colors.blue),
            title: Text('Sair'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.blue),
            title: Text('Adicionar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline, color: Colors.blue),
            title: Text('terminar'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() async {
      // Sair
      if (index == 0) {
        // Adicionar
      }
      if (index == 1) {
        final result =
            await Navigator.pushNamed(contexto, '/artigo_selecionar_lista');
        List<Artigo> artigos = result;
        if (encomendaItens.length == 1 && encomendaItens.runtimeType == Card().runtimeType) {
          encomendaItens.clear();
        }

        // encomendaItens.clear();
        artigos.forEach((a) {
          print('result form 1');
          print(a.descricao);
          mercadServicValor += a.preco;
          subtotal += ( a.preco * (iva / 100) ) + a.preco ;
          totalVenda += subtotal;
          encomendaItens.add(artigoEncomenda(a));
        });
        setState(() {
          // items.[0]
          // items.clear();

          items.addAll(encomendaItens);
        });
      }

      // Terminar
      if (index == 2) {
        Navigator.pushNamed(contexto, '/encomenda_sucesso');
      }
      _selectedIndex = index;
    });
  }
}

Padding espaco() {
  return Padding(
    padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 4),
  );
}

Card encomendaItem(Artigo artigo) {
  return Card(
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(artigo.artigo,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            Text(artigo.descricao,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            Text(artigo.unidade == null ? " " : artigo.unidade,
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 4),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Qtd.: 1", style: TextStyle(color: Colors.blue)),
            Text("Prc.Unit: " + artigo.preco.toString(),
                style: TextStyle(color: Colors.blue)),
            Text("Subtotal: " + (artigo.preco * 1).toString(),
                style: TextStyle(color: Colors.blue))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 16, right: 16, bottom: 4),
        ),
      ],
    ),
  );
}

Card encomendaItemVazio() {
  return Card(
      child: Column(
    children: <Widget>[
      const SizedBox(height: 50),
      RaisedButton(
        color: Colors.blue,
        onPressed: () async {
          // Navigator.pushNamed(contexto, '/artigo_selecionar_lista');
          final result =
              await Navigator.pushNamed(contexto, '/artigo_selecionar_lista');
          List<Artigo> artigos = result;
          artigos.forEach((a) {
            print('result form 2');
            print(a.descricao);
          });
        },
        child: const Text('Adicionar ',
            style: TextStyle(fontSize: 15, color: Colors.white)),
      ),
      const SizedBox(height: 50),
    ],
  ));
}

Slidable artigoEncomenda(Artigo artigo) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    child: encomendaItem(artigo),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Remover',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => null,
      ),
    ],
  );
}
