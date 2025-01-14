import 'package:appcompras/login.dart';
import 'package:flutter/material.dart';

class Cadastros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text("Cadastro",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome de Usuário",
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.person, color: Colors.blue[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.blue[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
                },
                label: Text("Cadastrar", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.person_add_alt_1_outlined),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[600],
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    iconColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
