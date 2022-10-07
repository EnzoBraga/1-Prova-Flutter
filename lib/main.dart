      import 'package:flutter/material.dart';
      import 'package:flutter/services.dart';

      void main() {
        //Código do Braga
        runApp(MaterialApp(
            title: "Primeira prova de flutter",
            home: Home()));
      }

      class CommaTextInputFormatter extends TextInputFormatter{
        @override
        TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
          String truncated = newValue.text;
          final TextSelection newSelection = newValue.selection;
          if (newValue.text.contains(',')){
            truncated = newValue.text.replaceFirst(RegExp(','), '.');
          }
          return TextEditingValue(
            text: truncated,
            selection: newSelection,
          );
        }
      }

      class DecimalTextInputFormatter extends TextInputFormatter{
        @override
        TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue){
          final regEx = RegExp(r'^\d*\.?\d*');
          final String newString = regEx.stringMatch(newValue.text) ?? '';
          return newString == newValue.text ? newValue : oldValue;
        }
      }

      class Home extends StatefulWidget {
        const Home({Key? key}) : super(key: key);

        @override
        State<Home> createState() => _HomeState();
      }

      class _HomeState extends State<Home> {
        TextEditingController salarioController = TextEditingController();
        TextEditingController filhosController = TextEditingController();
        TextEditingController filhosEscolaController = TextEditingController();
        TextEditingController filhosVacinadosController = TextEditingController();

        int _maeSolteira = 0;

        String _infoText= "Auxílio:";

        GlobalKey<FormState> _formKey = GlobalKey<FormState>();

        void _resetFields(){
          salarioController.text = "";
          filhosController.text = "";
          filhosEscolaController.text = "";
          filhosVacinadosController.text = "";
          _formKey = GlobalKey<FormState>();
          setState(() {
            _maeSolteira = 0;
            _infoText="Auxílio:";
          });
        }

        void _calculate(){
          setState(() {
            double quantidadeSalario = double.parse(salarioController.text);
            int quantidadeFilhos = int.parse(filhosController.text);
            int quantidadeFilhosEscola = int.parse(filhosEscolaController.text);
            int quantidadeFilhosVacinados = int.parse(filhosVacinadosController.text);
            double auxilioTotal=0;

            if(quantidadeSalario<2424)
            {
              if(quantidadeFilhos>0 && quantidadeFilhos<=2)
              {
                if((quantidadeFilhos==quantidadeFilhosEscola) && (quantidadeFilhos==quantidadeFilhosVacinados))
                {
                  auxilioTotal+= 1212*1.5;
                  if(quantidadeSalario<1212)
                  {
                    auxilioTotal+=1212;
                  }
                }
              }
              else
              {
                if(quantidadeFilhos>=3)
                {
                  if ((quantidadeFilhos == quantidadeFilhosEscola) &&
                      (quantidadeFilhos == quantidadeFilhosVacinados))
                  {
                    auxilioTotal+=1212*3;
                  }
                }
              }
            }
            if(quantidadeFilhos>0 && _maeSolteira==2){
              auxilioTotal+=600;
            }
            _infoText="Auxílio: $auxilioTotal";
          }
          );
        }

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Ysolutions"),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: <Widget>[
                IconButton(icon: Icon(Icons.refresh),
                    onPressed: _resetFields),
              ],
            ),
            backgroundColor: Colors.white,
            body:SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                          CommaTextInputFormatter(),
                          DecimalTextInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          labelText: "Qual é a renda da família?",
                          labelStyle: TextStyle(color:
                          Colors.green
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green,
                            fontSize: 20.0),
                        controller: salarioController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Insira a renda";
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          labelText: "A família tem quantos filhos?",
                          labelStyle: TextStyle(color:
                          Colors.green),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green,
                            fontSize: 20.0),
                        controller: filhosController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Insira a quantidade de filhos";
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          labelText: "Quantos filhos estão na escola?",
                          labelStyle: TextStyle(color:
                          Colors.green
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green,
                            fontSize: 20.0),
                        controller: filhosEscolaController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Insira a quantidade de filhos na escola";
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          labelText: "Quantos filhos são vacinados?",
                          labelStyle: TextStyle(color:
                          Colors.green
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green,
                            fontSize: 20.0),
                        controller: filhosVacinadosController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Insira a quantidade de filhos";
                          }
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child:  Text('A chefe da família é mãe solteira?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green,
                      fontSize: 20.0),
                      ),
                ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          title: Text("Não"),
                          value: 1,
                          groupValue: _maeSolteira,
                          onChanged: (value){
                            setState(() {
                              _maeSolteira = 1;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          title: Text("Sim"),
                          value: 2,
                          groupValue: _maeSolteira,
                          onChanged: (value){
                            setState(() {
                              _maeSolteira = 2;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              _calculate();
                            }
                          },
                          child: Text("Confirma", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ),
                      Text("$_infoText", style: TextStyle(color: Colors.green, fontSize: 25.0), textAlign: TextAlign.center,),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }