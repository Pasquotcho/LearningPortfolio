#include <cs50.h>
#include <stdio.h>

// 25c 10c 5c 1c
// How many coins

int main(void)
{
    int coin_count = 0;
    int owed;
    do
    {
        owed = get_int("owed: ");
    }
    while (owed < 0);

    while (true)
    {
        if (owed >= 25)
        {
            coin_count++;
            owed -= 25;
        }
        else if (owed >= 10)
        {
            coin_count++;
            owed -= 10;
        }
        else if (owed >= 5)
        {
            coin_count++;
            owed -= 5;
        }
        else if (owed >= 1)
        {
            coin_count++;
            owed -= 1;
        }
        else if (owed == 0)
        {
            break;
        }
    }
    printf("%i\n", coin_count);
}
