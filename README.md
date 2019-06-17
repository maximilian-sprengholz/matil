# matil
Stata .ado to interlace rows into columns or columns into rows in matrices.

## Description
This program re-arranges columns and rows in a matrix in such a way that either:
1. Rows are interlaced into colums: Formerly stacked cells appear beside each other.
2. Columns are interlaced into rows: Cells formerly beside each other appear stacked.

The interlacing is done for a specified panel width/height and thus repeated for the number of panels in the matrix. This is useful, for example, to re-arrange statistics.

Consider the following 6x2 matrix _A_

|     | Model 1 | Model 2 |
| --- | ------- | ------- |
| __b__   | 0.111   | 0.444   |
| __se__  | 0.011   | 0.044   |
| __b__   | 0.222   | 0.555   |
| __se__  | 0.022   | 0.055   |
| __b__   | 0.333   | 0.666   |
| __se__  | 0.033   | 0.066   |

You want to interlace the standard errors from rows into columns, so that they are printed in the column
right of the beta values instead of being printed in the row below.

Using the command...

```Stata
matil, d(r2c) sp(1)
```
...would produce the desired result stored under _A\_matil_ (3x4)

| Model 1 |        | Model 2 |        |
| ------- | ------ | ------- | ------ |
| __b__   | __se__ | __b__   | __se__ |
| 0.111   | 0.011  | 0.444   | 0.044  |
| 0.222   | 0.022  | 0.555   | 0.055  |
| 0.333   | 0.033  | 0.666   | 0.066  |

However, please note that the row and column labels get mixed up too. The labels in this example are for illustrative purposes only.

## Installation
```Stata
net install matil, from("https://raw.githubusercontent.com/maximilian-sprengholz/matil/master/pkg/")
```

## Documentation
Please use the [help-file](pkg/matil.sthlp) installed with the package for details on syntax and options as well as further examples.

## Author
Maximilian Sprengholz<br />
Humboldt-Universität zu Berlin<br />
[maximilian.sprengholz@hu-berlin.de](mailto:maximilian.sprengholz@hu-berlin.de)
