{smcl}
{* *! version 0.9  14jun2019}
{title:Title}

{pstd}
{help matil()} {hline 2} Interlace rows into columns or columns into rows in matrices

{marker syntax}{...}
{title:Syntax}

{p 4 29 2}
{cmdab:matil}
{it:name}
{cmd:,}
{cmd:Direction(}{it:string}{cmd:)}
[
{cmd:SPan(}{it:int}{cmd:)}
]

{pstd}
where {it:name} is the name of the matrix. The interlaced matrix has the name {it: name}_matil.

{title:Description}

{pstd}
This program interlaces rows or columns in a matrix. This is useful, for example,
to re-arrange statistics.{break}

{pstd}
Consider the following 6x2 matrix A:

{col 13}{cmd: b} {col 20}0.111 {col 27}0.444
{col 13}{cmd: se} {col 20}0.011 {col 27}0.044
{col 13}{cmd: b} {col 20}0.222 {col 27}0.555
{col 13}{cmd: se} {col 20}0.022 {col 27}0.055
{col 13}{cmd: b} {col 20}0.333 {col 27}0.666
{col 13}{cmd: se} {col 20}0.033 {col 27}0.066

{pstd}
You want to interlace the standard errors from rows into columns, so that they
are printed in the column right of the beta values instead of being printed
in the row below.

{p 4 8 2}
Using the command:{break}

{p 8 12 2}
{cmd: matil} A, d(r2c) sp(1) {break}

{p 4 8 2}
would produce the desired result stored under {it: A_matil}(3x4):

{col 27}{cmd:se} {col 41}{cmd:se}
{col 13}{cmd: b} {col 20}0.111 {col 27}0.011 {col 34}0.444 {col 41}0.044
{col 13}{cmd: b} {col 20}0.222 {col 27}0.022 {col 34}0.555 {col 41}0.055
{col 13}{cmd: b} {col 20}0.333 {col 27}0.033 {col 34}0.666 {col 41}0.066


{marker options}
{title:Options}

{p 4 8 2}
{cmd:direction(}{it:string}{cmd:)} specifies in which direction the interlacing
is done:

{p 8 8 2}
{cmd:r2c} - rows are interlaced into columns{break}
{cmd:c2r} - columns are interlaced into rows

{p 4 8 2}
{cmd:span(}{it:int}{cmd:)} specifies the span of rows/columns to be interlaced. The default is 1.

{p 8 8 2}
For instance, if you had a third statistic like a bootstrapped standard error in
the example matrix A (making it a 9x3 matrix) and wanted to have all statistics next
to each other instead of stacked, you could type:

{p 8 8 2}
{cmd: matil} A, d(r2c) sp(2) {break}

{p 8 8 2}
The first interlaced row/column is alway row/column 2, because everything else would produce
rather strange results. However, the span is not limited.


{marker examples}
{title:Examples}

{p 4 8 2}
Interlace rows 2-4 in every panel of 4 into columns:{break}
{cmd:mat} M = matuniform(8,4) {break}
{cmd:matil} M {cmd:,} d(r2c) sp(3)

{p 4 8 2}
Interlace columns 2-3 in every panel of 3 into rows:{break}
{cmd:mat} M = matuniform(3,9) {break}
{cmd:matil} M {cmd:,} d(c2r) sp(3)

{marker author}
{title:Author}

{pstd}
Maximilian Sprengholz {break}
{browse "mailto:maximilian.sprengholz@hu-berlin.de"}
