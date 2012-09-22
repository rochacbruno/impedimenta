#include <stdio.h>
#include <string.h>

char tracks[][80] ={
    "I left my heart in harvard med school",
    "Newark, Newark - a wonderful town",
    "Dancing with a dork",
    "Fron here to maternity",
    "The girl from Iwo Jima",
};

// find search_for in tracks
void find_track(char search_for[])
{
    int i;
    for(i = 0; i < 5; i++){
        if(strstr(tracks[i], search_for)) // find search_for in tracks[i]
            printf("Track %i: '%s'\n", i, tracks[i]);
    }
}

// FIXME: modifies the string passed in, rather than passing out a new string
void strip_newline(char * search_me) {
    char * newline;

    // search for both \r and \n to account for windows-style newlines
    newline = strchr(search_me, '\r');
    if(newline)
        *newline = '\0';
    newline = strchr(search_me, '\n');
    if(newline)
        *newline = '\0';
}

int main()
{
    char search_for[80];

    printf("Search for: ");
    fgets(search_for, 80, stdin);
    strip_newline(search_for);
    find_track(search_for);

    return 0;
}
