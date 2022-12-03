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
      b = 1;
      break;
    case 'Y':
      b = 2;
      break;
    case 'Z':
      b = 3;
      break;
    }

    switch (a - b) {
    case 0:
      res = 3;
      break;
    case -1:
      res = 6;
      break;
    case 2:
      res = 6;
      break;
    default: // Other cases
      res = 0;
      break;
    }

    ans += b + res;
  }

  printf("%d", ans);

  fclose(fp);
  if (line)
    free(line);
  return 0;
}