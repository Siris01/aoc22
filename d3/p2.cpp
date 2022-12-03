#include <fstream>
#include <iostream>
#include <string>
using namespace std;

void populate_cache(int cache[52], string line) {
  int i = 0, len = line.length();

  for (i = 0; i < len; i++) {
    if (line[i] >= 97)
      cache[line[i] - 97]++;
    else
      cache[line[i] - 39]++;
  }
}

int main() {
  fstream new_file;

  new_file.open("input.txt", ios::in);
  if (!new_file.is_open())
    return -1;

  string line;
  int i, ans = 0, count = 0, cache1[52] = {0}, cache2[52] = {0},
         cache3[52] = {0};

  while (getline(new_file, line)) {
    ++count;

    if (count < 3) {
      if (count == 1)
        populate_cache(cache1, line);
      else if (count == 2)
        populate_cache(cache2, line);
      continue;
    } else if (count == 3)
      populate_cache(cache3, line);

    for (i = 0; i < 52; i++) {
      if (cache1[i] > 0 && cache2[i] > 0 && cache3[i] > 0) {
        ans += i + 1;
        break;
      }
    }

    count = 0;
    for (i = 0; i < 52; i++) {
      cache1[i] = 0;
      cache2[i] = 0;
      cache3[i] = 0;
    }
  }

  cout << ans << endl;

  new_file.close();
  return 0;
}