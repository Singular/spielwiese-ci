#ifndef RMODULO2M_H
#define RMODULO2M_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT: numbers modulo 2^m such that 2^m - 1
*           fits in an unsigned long
*/
#ifdef HAVE_RINGS
#include <coeffs/coeffs.h>
#include <coeffs/rintegers.h>

#ifndef NATNUMBER
#define NATNUMBER unsigned long
#endif

BOOLEAN nr2mInitChar    (coeffs r, void*);

#endif
#endif
