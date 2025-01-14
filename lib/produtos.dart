import 'package:appcompras/detalhes_produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Produtos extends StatefulWidget {
  @override
  _ProdutosState createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _pesquisaController = TextEditingController();
  List<Map<String, dynamic>> _produtos = [];
  List<Map<String, dynamic>> _produtosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _pesquisaController.addListener(_filtrarProdutos);
    _produtosFiltrados = List.from(_produtos);
  }

  void _filtrarProdutos() {
    setState(() {
      String filtro = _pesquisaController.text.trim().toLowerCase();
      _produtosFiltrados = _produtos.where((produto) {
        final nomeProduto = produto['nome'].toString().toLowerCase();
        return nomeProduto.contains(filtro);
      }).toList();
    });
  }

  void _abrirDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inserir Código de Barras'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _codigoController,
                keyboardType: TextInputType.number,
                maxLength: 13,
                decoration: InputDecoration(
                  labelText: 'Código de Barras',
                  counterText: '',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String codigo = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
                  if (codigo != '-1') {
                    _codigoController.text = codigo;
                  }
                },
                child: Text('Ler Código de Barras'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Color.fromARGB(255, 73, 69, 69)),
              ),
            ),
            TextButton(
              onPressed: () {
                String codigo = _codigoController.text.trim();
                if (codigo.length != 13) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Código de Barras inválido. Deve ter 13 dígitos.')),
                  );
                } else {
                  setState(() {
                    _produtos.add({
                      'nome': 'Produto $codigo',
                      'preco': 0.0,
                      'descricao': ''
                    });
                    _produtosFiltrados = List.from(_produtos);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editarProduto(BuildContext context, int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesProduto(
          nomeInicial: _produtosFiltrados[index]['nome'],
          precoInicial: _produtosFiltrados[index]['preco'],
          descricaoInicial: _produtosFiltrados[index]['descricao'],
        ),
      ),
    );

    if (resultado != null && resultado is Map<String, dynamic>) {
      setState(() {
        int originalIndex = _produtos.indexWhere(
            (produto) => produto['nome'] == _produtosFiltrados[index]['nome']);
        _produtos[originalIndex] = resultado;
        _produtosFiltrados = List.from(_produtos);
      });
    }
  }

  void _confirmarExclusao(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Deseja realmente excluir este produto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _produtos.removeAt(index);
                  _produtosFiltrados = List.from(_produtos);
                });
                Navigator.of(context).pop();
              },
              child: Text("Excluir"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[600],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _pesquisaController,
              decoration: InputDecoration(
                hintText: 'Pesquisar produtos...',
                hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none,
                icon: Icon(Icons.search),
                iconColor: Colors.black,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.black,
        tooltip: 'Adicionar Produto',
      ),
      body: _produtosFiltrados.isEmpty
          ? Center(
              child: Text(
                'Nenhum produto cadastrado!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: _produtosFiltrados.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    title: Text(
                      _produtosFiltrados[index]['nome'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descrição: ${_produtosFiltrados[index]['descricao']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'R\$ ${_produtosFiltrados[index]['preco'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editarProduto(context, index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red[400],
                          onPressed: () => _confirmarExclusao(context, index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
