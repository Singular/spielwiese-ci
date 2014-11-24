#ifndef GMPFLOAT_H
#define GMPFLOAT_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT: computations with GMP floating-point numbers
*/
#include <coeffs/coeffs.h>

/// Initialize r
BOOLEAN ngfInitChar(coeffs r, void *);

#ifndef HAVE_NUMSTATS
// will be reused by gnumpc.cc
/* extern */ const char *   ngfRead (const char *s, number *a, const coeffs r);
#endif


#endif
