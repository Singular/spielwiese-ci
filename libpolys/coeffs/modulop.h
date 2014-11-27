#ifndef MODULOP_H
#define MODULOP_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT: numbers modulo p (<=32003)
*/
#include <misc/auxiliary.h>

struct n_Procs_s; typedef struct  n_Procs_s  *coeffs;
struct snumber; typedef struct snumber *   number;

BOOLEAN npInitChar(coeffs r, void* p);

#ifndef HAVE_NUMSTATS
// The folloing is reused inside gnumpc.cc, gnumpfl.cc and longrat.cc 
int     npInt         (number &n, const coeffs r);

// The following seems to be necessary for OPAE.cc, OPAEQ.cc and OPAEp.cc for setting their SetMap... WHY???
nMapFunc npSetMap(const coeffs src, const coeffs dst);// FIXME: BUG?
#endif


#endif
