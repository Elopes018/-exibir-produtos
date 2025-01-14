import 'package:appcompras/cadastros.dart';
import 'package:appcompras/comercios.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text("",
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
                  labelText: "Nome",
                  labelStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  prefixIcon: Icon(Icons.alternate_email_sharp,
                      color: Colors.blue[600]),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Comercios()));
                },
                label: Text("Entrar", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.login_outlined),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[600],
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    iconColor: Colors.white),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Cadastros(),
                  ));
                },
                child: Text(
                  "Crie Uma Conta",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
