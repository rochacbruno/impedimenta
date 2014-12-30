#include <stdio.h>
#define MONTHS 12
#define YEARS 5 // number of years of data

int main(void) {
    const float rain[YEARS][MONTHS] = {
        {4.3, 4.3, 4.3, 3.0, 2.0, 1.2, 0.2, 0.2, 0.4, 2.4, 3.5, 6.6},
        {8.5, 8.2, 1.2, 1.6, 2.4, 0.0, 5.2, 0.9, 0.3, 0.9, 1.4, 7.3},
        {9.1, 8.5, 6.7, 4.3, 2.1, 0.8, 0.2, 0.2, 1.1, 2.3, 6.1, 8.4},
        {7.2, 9.9, 8.4, 3.3, 1.2, 0.8, 0.4, 0.0, 0.6, 1.7, 4.3, 6.2},
        {7.6, 5.6, 3.8, 2.8, 3.8, 0.2, 0.0, 0.0, 0.0, 1.3, 2.6, 5.2}
    };
    float rain_one_year, rain_all_years;
    int year, month;  // indexes

    // Find rain_one_year and rain_all_years.
    printf(" YEAR  RAINFALL  (inches)\n");
    for(year = 0, rain_all_years = 0; year < YEARS; year++) {
        for(month = 0, rain_one_year = 0; month < MONTHS; month++) {
            rain_one_year += rain[year][month];
        }
        printf("%5d %15.1f\n", 2000 + year, rain_one_year);
        rain_all_years += rain_one_year;
    }
    printf("\nThe yearly average is %.1f inches.\n\n", rain_all_years / YEARS);

    return 0;
}
