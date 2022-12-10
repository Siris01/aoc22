#include <stdio.h>
#include <stdlib.h>

int main() {
  FILE *fp;
  char *line = NULL;
  size_t len = 0;

  int ans = 0, a = -1, b = -1, res = -1;
  char A, B;

  fp = fopen("input.txt", "r");
  if (fp == NULL)
    exit(EXIT_FAILURE);

  while ((getline(&line, &len, fp)) != -1) {
    A = line[0];
    B = line[2];

    switch (A) {
    case 'A':
      a = 1;
      break;
    case 'B':
      a = 2;
      break;
    case 'C':
      a = 3;
      break;
    }

    switch (B) {
    case 'X':
      res = 0;
      break;
    case 'Y':
      res = 3;
      break;
    case 'Z':
      res = 6;
      break;
    }

    switch (res) {
    case 0:
      if (a - 1 == 0)
        b = 3;
      else
        b = a - 1;
      break;
    case 6:
      if (a + 1 == 4)
        b = 1;
      else
        b = a + 1;
      break;
    case 3:
      b = a;
      break;
    }

    ans += res + b;
  }

  printf("%d", ans);

  fclose(fp);
  if (line)
    free(line);
  return 0;
}