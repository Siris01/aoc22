#include <stdio.h>
#include <stdlib.h>

int main() {
  FILE *fp;
  char *line = NULL;
  size_t len = 0;

  int ans = 0, a = -1, b = -1;
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
      b = 1;
    } else if (B == 'Y') {
      b = 2;
    } else {
      b = 3;
    }

    switch (a - b) {
    case 0:
      ans += b + 3;
      break;
    case -1:
      ans += b + 6;
      break;
    case 2:
      ans += b + 6;
      break;
    default:
      ans += b;
      break;
    }
  }

  fclose(fp);
  if (line)
    free(line);

  printf("%d", ans);
  return 0;
}