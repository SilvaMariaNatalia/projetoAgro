class Produtos{
  String _nome= "nome";
  String _descricao=" descrição";
  


  Produtos();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map={
      "nome": this.nome,
      "descricao":this.descricao,
      
      

    };
    return map;
  }
   String get nome => _nome;

  set nome (String value){
    _nome = value;
  }


  
  String get descricao => _descricao;

  set descricao (String value){
    _descricao = value;
  }
 
}
  


