import "dart:math";

Random randomGenerator = Random();

class Grille {
  List<List<bool>> values;
  int width, height;

  Grille.randomize(int widthArg, int heightArg)
    : width = widthArg,
      height = heightArg,
      values = List.generate(heightArg, (_) => List.generate(widthArg, (_) =>
        randomGenerator.nextInt(100) <= 15
      ));
  
  Grille.empty(int widthArg, int heightArg)
    : width = widthArg,
      height = heightArg,
      values = List.generate(heightArg, (_) => List.generate(widthArg, (_) => false));

  int countVoisins(int x, int y) {
    int voisins = 0;
    for (int xB in [-1, 0, 1]) {
      for (int yB in [-1, 0, 1]) {
        if (xB == 0 && yB == 0) continue;
        if (x+xB < 0 || x+xB >= width || y+yB < 0 || y+yB >= height) continue;
        voisins += values[y+yB][x+xB] ? 1 : 0;
      }      
    }
    return voisins;
  }

  void update(List<int> survive, List<int> born, bool ignore) {
    if (ignore) return;
    List<List<bool>> updatedValues = [];
    for (int yB = 0; yB<values.length; yB++) {
      updatedValues.add([]);
      for (int xB = 0; xB<values[yB].length; xB++) {
        int voisins = countVoisins(xB, yB);
        if (born.contains(voisins)) {
          updatedValues[yB].add(true);
        } else if (survive.contains(voisins)) {
          updatedValues[yB].add(values[yB][xB]);
        } else {
          updatedValues[yB].add(false);
        }
        /* if (survive.contains(voisins)) {
          updatedValues[yB].add(values[yB][xB]);
        } else {
          updatedValues[yB].add(born.contains(voisins));
        } */
      }
    }
    values = updatedValues;
  }
}