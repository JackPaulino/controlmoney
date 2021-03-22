import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Image.asset('assets/images/Layer.png',
                width: constraints.maxWidth * 9,
                fit: BoxFit.cover,
                alignment: Alignment.bottomRight),
            Padding(
              padding: EdgeInsets.only(top: 75),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: new Text('Saldo Atual',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 28.0)),
                        ),
                        Container(
                          child: new Text("R\$ 24.9914,33",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 16.0, right: 10.0),
                            child: new Text('Receita: R\$ 1.880.34',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 15.0)),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 16.0, left: 10.0),
                            child: new Text('Despesas: R\$ 1.880.34',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                    fontSize: 15.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
