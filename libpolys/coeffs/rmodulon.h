#ifndef RMODULON_H
#define RMODULON_H
/****************************************
*  Computer Algebra System SINGULAR     *
****************************************/
/*
* ABSTRACT: numbers modulo n
*/
#include <coeffs/coeffs.h>
#include <coeffs/rintegers.h>

#ifdef HAVE_RINGS

#ifndef NATNUMBER
#define NATNUMBER unsigned long
#endif

typedef struct { int_number base; NATNUMBER exp; } ZnmInfo;

BOOLEAN nrnInitChar    (coeffs r, void*);

#endif

#endif
