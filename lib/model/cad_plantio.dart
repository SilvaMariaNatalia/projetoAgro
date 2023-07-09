

class Plantio{
  String _nome= "nome";
  String _cultura ="cultura";
  String _dataplantio ="Data do Plantio";
  String _datacolheita= "Data da Colheita";
  double _custo= 0.0;


  Plantio();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map={
      "nome": this.nome,
      "cultura":this.cultura,
      "Data do Plantio":this.dataplantio,
      "Data da Colheita":this.datacolheita,
      "custo":this.custo,

    };
    return map;
  }
  String get nome => _nome;

  set nome (String value){
    _nome = value;
  }

  String get cultura => _cultura;

  set cultura (String value){
    _cultura = value;
  }
  String get dataplantio => _dataplantio;

  set dataplantio(String value){
    _dataplantio = value;
  }
  String get datacolheita => _datacolheita;

  set datacolheita(String value){
    _datacolheita = value;
  }
  double get custo=> _custo;

  set custo(double value){
    _custo = value;
  }
  

}