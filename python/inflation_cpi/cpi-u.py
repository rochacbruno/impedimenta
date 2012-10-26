#!/usr/bin/env python

def print_us_stats():
    # Numbers from inflationdata.com. Numbers relevant to the US only.
    # CPI-U indices
    cpi_u = {
        2011: 224.939,
        2010: 218.056,
        2009: 214.537,
        2008: 215.303,
        2007: 207.342,
        2006: 201.600,
        2005: 195.300,
        2004: 188.900,
        2003: 183.960,
        2002: 179.880,
        2001: 177.100
    }
    # inflation rate percentages
    inflation = {
        2011: 3.16,
        2010: 1.64,
        2009: -0.34,
        2008: 3.85,
        2007: 2.85,
        2006: 3.24,
        2005: 3.39,
        2004: 2.68,
        2003: 2.27,
        2002: 1.59
    }

    # Find CPI-U percentages from 2010-2011 to 2001-2002.
    years = range(2011, 2001, -1)
    cpi_percents = [
        ((cpi_u[year] - cpi_u[year - 1]) / cpi_u[year - 1]) * 100
        for year in years
    ]
    # Find average cpi-u and inflation percentages.
    avg_cpi_percents = sum(cpi_percents) / len(cpi_percents)
    avg_inf_percents = sum(inflation[year] for year in years) / len(years)

    print("Year CPI-U   Inflation")
    for i in range(len(years)):
        print("{} {:7.2f} {:7.2f}".format(
            years[i],
            cpi_percents[i],
            inflation[years[i]],
        ))
    print("Average CPI-U % change: {:.2f}".format(avg_cpi_percents))
    print("Average inflation % change: {:.2f}".format(avg_inf_percents))

def print_rit_stats():
    # source: http://www.rit.edu/studentaffairs/ritpedia/wiki/Tuition
    # For years in which tier 1 and tier 2 rates existed, tier 2 is displayed.
    total_cost_change = {
        2011: 4.1,
        2010: 4.7,
        2009: 4.0,
        2008: 5.3,
        2007: 5.3,
        2006: 8.9,
        2005: 5.0,
        2004: 4.6,
        2003: 6.9,
        2002: 4.2
    }

    years = range(2011, 2001, -1)
    avg_tcc_percents = sum(
        total_cost_change[year] for year in years) / len(years
    )

    print("Year %change")
    for i in range(len(years)):
        print("{} {:7.2f}".format(
            years[i],
            total_cost_change[years[i]]
        ))
    print("Average annual % change in cost: {:.2f}".format(avg_tcc_percents))

def main():
    print_us_stats()
    print_rit_stats()

if "__main__" == __name__:
    main()
