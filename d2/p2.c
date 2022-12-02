#include <stdio.h>
#include <stdlib.h>

int main() {
  FILE *fp;
  char *line = NULL;
  size_t len = 0;

  int ans = 0, a = -1, res = -1;
  char A, B;

  fp = fopen("input.txt", "r");
  if (fp == NULL)
    exit(EXIT_FAILURE);

  while ((getline(&line, &len, fp)) != -1) {
    A = line[0];
    B = line[2];

    if (A == 'A') {
      a = 1;
    } else if (A == 'B') {
      a = 2;
    } else {
      a = 3;
    }

    if (B == 'X') {
      res = 0;
    } else if (B == 'Y') {
      res = 3;
    } else {
      res = 6;
    }

    switch (res) {
    case 0:
      if (a - 1 == 0)
        ans += res + 3;
      else
        ans += res + a - 1;
      break;
    case 6:
      if (a + 1 == 4)
        ans += res + 1;
      else
        ans += res + a + 1;
      break;
    default:
      ans += res + a;
      break;
    }
  }

  fclose(fp);
  if (line)
    free(line);

  printf("%d", ans);
  return 0;
}