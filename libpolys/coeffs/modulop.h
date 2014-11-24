#ifndef MODULOP_H
#define MODULOP_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT: numbers modulo p (<=32003)
*/
#include <coeffs/coeffs.h>

BOOLEAN npInitChar(coeffs r, void* p);

#ifndef HAVE_NUMSTATS
// The folloing is reused inside gnumpc.cc, gnumpfl.cc and longrat.cc 
/* extern */ int     npInt         (number &n, const coeffs r);

// The following seems to be necessary for OPAE.cc, OPAEQ.cc and OPAEp.cc for setting their SetMap... WHY???
// BUG?
/* extern */ nMapFunc npSetMap(const coeffs src, const coeffs dst);
#endif


#endif
