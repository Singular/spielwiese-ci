#ifndef MOD_LIB_H
#define MOD_LIB_H

// Note that STATIC_VERSION and DYNAMIC_VERSION should not be defined in the following config header mod2.h!
#include <kernel/mod2.h> /* for SI_BUILTINMODULES_ADD */

#include <polys/mod_raw.h>  /* for lib_types */

lib_types type_of_LIB(const char *newlib, char *fullname);

/// Data for @c type_of_LIB to determine built-in modules,
/// use @c add(name) to add built-in library to macro
#define SI_FOREACH_BUILTIN(add) \
    add(staticdemo)\
    SI_BUILTINMODULES_ADD(add)

#ifdef STATIC_VERSION
#  define SI_MOD_INIT(name) name##_mod_init
#elif defined(DYNAMIC_VERSION)
#  define SI_MOD_INIT(name) mod_init
#else
#  error Please use SI_MOD_INIT inside a Singular (dynamic/shared/static/builtin) module only!
#endif

#endif

/*
#if HAVE_GFANLIB
#define SI_BUILTIN_GFANLIB(add) add(gfanlib)
#endif
#ifdef HAVE_MATHICGB
# define SI_BUILTIN_MATHIC(add) add(singmathic)
#endif
#ifdef EMBED_PYTHON
//TODO: the line above means that syzextra should be staticly embedded IFF pyobjects do so :(((((
#define SI_BUILTIN_PYOBJECT(add) add(pyobject) add(syzextra) SI_BUILTIN_GFANLIB(add) SI_BUILTIN_MATHIC(add)
#endif
*/
