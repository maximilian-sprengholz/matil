********************************************************************************
*
*		matil –––
*		Interlace rows into columns or columns into rows in matrices.
*
*		Author:   Maximilian Sprengholz
*		          maximilian.sprengholz@hu-berlin.de
*		Version:  0.9
*		Date:     Jun 2019
*
********************************************************************************

	cap program drop matil
	program matil
	version 11.0

		syntax namelist(name=M max=1) ///
		 , ///
			Direction(str) ///
		[	///
			SPan(integer 1) ///
		]

	*** prep/check
	*	direction
		local direction = strtrim("`direction'")
		if !inlist("`direction'", "r2c", "c2r") {
			dis as error "Option direction() must be 'r2c' or 'c2r'."
			error 198
			exit
		}
		else {
			if "`direction'"=="r2c" {
				local msg1 "Rows in columns"
				local msg2 "Row(s)"
			}
			else {
				local msg1 "Columns in rows"
				local msg2 "Column(s)"
			}
		}

	*** INTERLACE
	***	transpose if cols in rows requested:
	***	interlacing is always rows in cols, transposing before and after

	*	check direction
		if "`direction'"=="c2r" {
			mat `M'=`M''
		}
	* save names
		local rnames : rownames `M'
		local cnames : colnames `M'
	*	parameters
		local cols=colsof(`M')
		local rows=rowsof(`M')
	*	distance between begin of row blocks to be interlaced
		local multi = `span'+1
	*	check if possible, if so: display
		local divby = `rows'/`multi'
		dis "`divby'"
		if mod(`divby',1)!=0 {
			dis as error "Not possible to perform operation with specified span(`span')." ///
			_newline "Make sure that the total number of `msg2' is divisible by span()+1."
			error 125
			exit
		}
		display "" ///
		_newline as result 	"matil" ///
		_newline as text 	"Interlacing:" _col(25) "`msg1'" ///
		_newline			"Spanning:" _col(25) "`span' `msg2' after `msg2' 1(`multi')`rows'" ///
		_newline
	*	obtain row numbers to be interlaced
			local ilend = `span'-1
			local ilcellcnt 0
			forvalues row=2(`multi')`rows' {
				forvalues k=0/`ilend' {
						local ilrow = `row'+`k'
						if `ilrow'<=`rows' local ilrows "`ilrows', `ilrow'"
						local ++ilcellcnt
				}
			}
	*	gen new matrix to be filled
		local newrows = `rows'-`ilcellcnt'
		local newcols = `cols'*`multi'
		mat `M'_matil = J(`newrows',`newcols',.)
	*	loop through columns
		forvalues col=1/`cols' {
		*	loop through rows
			local ilc 0 // interlaced rows counter
			local shc 0 // non-interlaced cell shifts counter
			local ilshc 1 // alternating counter between fixed & interlaced rows within panel
			forvalues row=1/`rows' {
				if inlist(`row' `ilrows') {
					local ++ilc
					local newcellcol = (`col'*`multi')+`ilshc'-`span'
					local newcellrow = `row'-`ilc'
					if `newcellrow'<=`newrows' & `newcellcol'<=`newcols' {
						mat `M'_matil[`newcellrow',`newcellcol'] = `M'[`row',`col']
					}
					local ++ilshc
				}
				else {
					local ilshc = 1
					local newcellcol = `col'*`multi'-`span'
					local newcellrow = `row'-`shc'*`span'
				*	avoid conformability problems
					if `newcellrow'<=`newrows' & `newcellcol'<=`newcols' {
						mat `M'_matil[`newcellrow',`newcellcol'] = `M'[`row',`col']
					}
					local ++shc
				}
			}
		}
	***	assign row and column names
		local newrows = `rows'-`ilcellcnt'
		local newcols = `cols'*`multi'
	*	add missing titles for transposed rows/cols
		local rnameno : word count `rnames'
		while `rnameno' < `newcols' {
			local rnames "`rnames' `rnames'"
			local rnameno : word count `rnames'
		}
	*	trim to correct number
		forvalues n=1/`newcols' {
			local rname : word `n' of `rnames'
			local colnames "`colnames' `rname'"
		}
	*	add panel no as new label
		forvalues n=1/`newrows' {
			local rownames "`rownames' Panel`n'"
		}
		dis "`rnames'"
		dis "`cnames'"
		dis "`rownames'"
		dis "`colnames'"
		mat list `M'_matil
		matname `M'_matil `rownames' , rows(1..`newrows') explicit
		matname `M'_matil `colnames' , columns(1..`newcols') explicit
	*** transpose again if cols to rows
		if "`direction'"=="c2r" {
			mat `M'=`M''
			mat `M'_matil=`M'_matil'
		}
	***	show result
		dis as result "Old matrix:"
		mat list `M'
		dis as result ///
		_newline "Interlaced matrix:"
		mat list `M'_matil
	end
