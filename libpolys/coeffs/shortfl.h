#ifndef SHORTFL_H
#define SHORTFL_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT
*/
#include <coeffs/coeffs.h>

/// Initialize r
BOOLEAN nrInitChar(coeffs r, void*);

// will be reused by gnumpc.cc and longrat.cc

#ifndef HAVE_NUMSTATS
/// Converts a n_R number into a float. Needed by Maps
/* extern */ float   nrFloat(number n);
#endif

#endif

