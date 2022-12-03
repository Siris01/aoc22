#include <fstream>
#include <iostream>
#include <string>
using namespace std;

int main() {
  fstream new_file;

  new_file.open("input.txt", ios::in);
  if (!new_file.is_open())
    return -1;

  string line;
  int i, mid, len, ans = 0, cache[52] = {0};

  while (getline(new_file, line)) {
    int len = line.length();
    int mid = len / 2;

    for (i = 0; i < mid; i++) {
      if (line[i] >= 97)
        cache[line[i] - 97]++;
      else
        cache[line[i] - 39]++;
    }

    for (i = mid; i < len; i++) {
      if (line[i] >= 97) {
        if (cache[line[i] - 97] > 0) {
          ans += line[i] - 96;
          break;
        }
      } else {
        if (cache[line[i] - 39] > 0) {
          ans += line[i] - 38;
          break;
        }
      }
    }

    for (i = 0; i < 52; i++)
      cache[i] = 0;
  }

  cout << ans << endl;

  new_file.close();
  return 0;
}