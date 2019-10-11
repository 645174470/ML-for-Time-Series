Monthly mean total sunspot number

Time range: 1/1749 - last elapsed month (provisional values)

Data description:
Monthly mean total sunspot number obtained by taking a simple arithmetic mean of the daily total sunspot number over all days of each calendar month. Monthly means are available only since 1749 because the original observations compiled by Rudolph Wolf were too sparse before that year. (Only yearly means are available back to 1700)

Error values:
The monthly standard deviation of individual data is derived from the daily values by: sigma(m)=sqrt(SUM(N(d)*sigma(d)^2)/SUM(N(d)))
where sigma(d) is the standard deviation for a single day and N(d) is the
number of observations for that day.
The standard error on the monthly mean values can be computed by:
sigma/sqrt(N) where sigma is the listed standard deviation and N the total number of observations in the month.

NB: February 1824 does not contain any daily value. As it is the only month without data after 1749, the monthly mean value was interpolated by R. Wolf between the adjacent months.

CSV file properties:
Filename: SN_m_tot_V2.0.csv
Format: Comma Separated values (adapted for import in spreadsheets)
The separator is the semicolon ';'.

Contents:
Column 1-2: Gregorian calendar date
- Year
- Month
Column 3: Date in fraction of year.
Column 4: Monthly mean total sunspot number.
Column 5: Monthly mean standard deviation of the input sunspot numbers.
Column 6: Number of observations used to compute the monthly mean total sunspot number.
Column 7: Definitive/provisional marker. '1' indicates that the value is definitive. '0' indicates that the value is still provisional.
dat