#include <cs50.h>
#include <stdio.h>

void print_row(int spaces, int hashes);

int main(void)
{
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height <= 0);

    int placeholder = height - 1;
    for (int i = 0; i < height; i += 1)
    {
        print_row(placeholder, i + 1);
        placeholder--;
    }
}

void print_row(int spaces, int hashes)
{
    for (int j = 0; j < spaces; j++)
    {
        printf(" ");
    }
    for (int i = 0; i < hashes; i += 1)
    {
        printf("#");
    }
    printf("\n");
}
