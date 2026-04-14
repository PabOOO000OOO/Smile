
void main(){
  String str="ABC";
  print(str);
  print(str.runes);
  print(String.fromCharCode(67));
  print(str.length);
  print(str.runes.length);
  String smile ="🍌";
  print(smile);
  print(smile.runes);
  print(smile.runes.length);
  print(String.fromCharCode(127820));
  print(smile.runes.last.toRadixString(16));
  String j = "\u{1f34c}";
  print(j);

  
}