import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetalhesProduto extends StatefulWidget {
  final String nomeInicial;
  final double precoInicial;
  final String descricaoInicial;

  DetalhesProduto({
    required this.nomeInicial,
    required this.precoInicial,
    required this.descricaoInicial,
  });

  @override
  _DetalhesProdutoState createState() => _DetalhesProdutoState();
}

class _DetalhesProdutoState extends State<DetalhesProduto> {
  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _descricaoController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(); // Campo inicial vazio
    _precoController = TextEditingController(); // Campo inicial vazio
    _descricaoController = TextEditingController(); // Campo inicial vazio
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[600],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo Nome é obrigatório.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Permite números com ponto decimal
                ],
                decoration: InputDecoration(labelText: 'Preço'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo Preço é obrigatório.';
                  }
                  return null;
                },
              ),
              TextField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição (opcional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'nome': _nomeController.text,
                      'preco': double.tryParse(_precoController.text) ?? 0.0,
                      'descricao': _descricaoController.text,
                    });
                  }
                },
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  fixedSize: Size(100, 35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
