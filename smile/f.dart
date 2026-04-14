import 'dart:io';
import 'dart:math';
import 'package:characters/characters.dart';

enum Mood {
  excited('взволнованный', '\u{1F60E}', 9),
  happy('счастливый', '\u{1F600}', 10),
  calm('спокойный', '\u{1F60A}', 6),
  sad('грустный', '\u{1F61E}', 3),
  energetic('энергичный', '\u{1F4AA}', 8),
  thoughtful('задумчивый', '\u{1F914}', 5),
  sleepy('сонный', '\u{1F634}', 2),
  mischievous('озорной', '\u{1F608}', 7);

  final String description;
  final String emoji;
  final int energy;

  const Mood(this.description, this.emoji, this.energy);
  
  String get unicodePoint {
    final runes = emoji.runes.toList();
    if (runes.isEmpty) return 'U+000000';
    return 'U+${runes[0].toRadixString(16)}';
  }
}

void main() {
  print('Введите ваше имя:');
  String? name = stdin.readLineSync();
  
  if (name == null || name.trim().isEmpty) {
    name = 'чел';
  } else {
    name = name.trim();
  }
  
  final random = Random();
  final moods = Mood.values;
  final selectedMood = moods[random.nextInt(moods.length)];
  
  print('Привет, ${name}! Твое настроение: ${selectedMood.emoji} ${selectedMood.description} (энергия: ${selectedMood.energy}/10)');
  
  print('Юникод вашего эмодзи: ${selectedMood.unicodePoint}');
  
  print('Хотите просмотреть сложные эмодзи? (/нет):');
  String? answer = stdin.readLineSync();
  
  if (answer != null && (answer.toLowerCase() == 'да' || answer.toLowerCase() == 'yes' || answer.toLowerCase() == 'д' || answer.toLowerCase() == 'yeah' || answer.toLowerCase() == 'lf' || answer.toLowerCase() == 'конечно' || answer.toLowerCase() == 'хочу' || answer.toLowerCase() == 'угу' || answer.toLowerCase() == 'ага')) {
    print('Введите комбинацию эмодзи:');
    String? complexEmoji = stdin.readLineSync();
    
    if (complexEmoji != null && complexEmoji.isNotEmpty) {
      analyzeComplexEmoji(complexEmoji);
    } else {
      print('Вы не ввели эмодзи.');
    }
  }
  
  print('Спасибо, приходите снова!');
}

void analyzeComplexEmoji(String input) {
  int shestnadcat = input.length;
  
  int runes = input.runes.length;
  
  int real = input.characters.length;
  
  print('\nАнализ строки "$input":');
  print('- 16-битных единиц: $shestnadcat');
  print('- Кодовых точек: $runes');
  print('- Реальных символов: $real');
  
  print('Подробный вывод юникода:');
  
  int symbolIndex = 1;
  for (final character in input.characters) {
    final runesList = character.runes.toList();
    
    if (runesList.length == 1) {
      print('Символ $symbolIndex: $character -> ${formatUnicode(runesList[0])}');
    } else {

      print('Символ $symbolIndex: $character ->');
      for (int i = 0; i < runesList.length; i++) {
        final isZWJ = runesList[i] == 0x200D;
        final prefix = (i == runesList.length - 1) ? '└─ ' : '├─ ';
        final zwjNote = isZWJ ? ' (ZWJ)' : '';
        print('  $prefix${formatUnicode(runesList[i])}$zwjNote');
      }
    }
    symbolIndex++;
  }
}

String formatUnicode(int rune) {
  return 'U+${rune.toRadixString(16)}';
}