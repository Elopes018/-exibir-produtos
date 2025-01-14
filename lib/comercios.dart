import 'package:flutter/material.dart';
import 'produtos.dart'; // Certifique-se de importar o arquivo correto com a tela de produtos.

class Comercios extends StatefulWidget {
  @override
  _ComerciosState createState() => _ComerciosState();
}

class _ComerciosState extends State<Comercios> {
  final List<String> comercios = [];
  final TextEditingController comercioController = TextEditingController();

  void _showAddComercioDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Comércio"),
          content: TextField(
            controller: comercioController,
            decoration: InputDecoration(hintText: "Nome do comércio"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar",
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                if (comercioController.text.isNotEmpty) {
                  setState(() {
                    comercios.add(comercioController.text);
                  });
                  comercioController.clear();
                }
                Navigator.of(context).pop();
              },
              child: Text("Adicionar"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Exclusão"),
          content: Text(
            "Tem certeza de que deseja excluir o comércio '${comercios[index]}'?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  comercios.removeAt(index);
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
          title: Text(""),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      body: comercios.isEmpty
          ? Center(
              child: Text(
                'Nenhum comércio cadastrado!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: comercios.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(comercios[index],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      leading: Icon(Icons.storefront, color: Colors.blue[600]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                        onPressed: () => _showDeleteConfirmationDialog(index),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Produtos()),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddComercioDialog,
        backgroundColor: Colors.blue[600],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
