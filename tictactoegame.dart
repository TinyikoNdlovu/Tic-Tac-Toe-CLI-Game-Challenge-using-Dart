import 'dart:io';
import 'dart:core';

bool winner = false;
bool isXturn = true;
int moveCount = 0;

List<String> values = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
List<String> combinations = ['012', '048', '036', '147', '246', '258', '678'];

// Check if a combination is true or false for a player (X or 0)
bool checkCombination(String combination, String checkFor) {
  // Split the numbers in alist of integers
  List<int> numbers = combination.split('').map((item) {
    return int.parse(item);
  }).toList();
  bool match = false;
  for (final item in numbers) {
    if (values[item] == checkFor) {
      match = true;
    } else {
      match = false;
      break;
    }
  }
  return match;
}

void checkWinner(player) {
  for (final item in combinations) {
    bool combinationValidity = checkCombination(item, player);
    if (combinationValidity == true) {
      print('$player WON!!!');
      winner = true;
      break;
    }
  }
}

// Create and Show Current State of Board
void generateBoard() {
  print('    |    |    ');
  print('${values[0]} | ${values[1]} | ${values[2]} ');
  print('___ |___ | ___');
  print('${values[3]} | ${values[4]} | ${values[5]} ');
  print('___ |___ | ___');
  print('${values[6]} | ${values[7]} | ${values[8]} ');
  print('    |    |    ');
}

// Get input, check winners
void getnextCharacter() {
  // Get input from Player
  print('Choose number for ${isXturn == true ? "X" : "0"}');
  int number = int.parse(stdin.readLineSync()!);
  // Change the value of selected number in values
  values[number - 1] = isXturn ? 'X' : '0';
  // Change player turn
  isXturn = !isXturn;
  // Increment move count
  moveCount++;
  if (moveCount == 9) {
    winner = true;
    print('DRAW!');
  } else {
    // Clear the console
    clearScreen();
    // Redraw the board with the new information
    generateBoard();
  }
  //
  // Check Validity for players, declare winner
  //
  // Check validity for player X
  checkWinner('X');
  // Check validity for player 0
  checkWinner('0');
  // Until we have a winner, we call current function again
  if (winner == false) getnextCharacter();
}

// Clear console screen
void clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout);
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

void main() {
  generateBoard();
  getnextCharacter();
}
