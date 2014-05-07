AC_DEFUN([SING_CHECK_ARITH_RINGS],
[
AC_MSG_CHECKING(whether arithmetical rings should be enabled)

AC_ARG_ENABLE(arith-rings, AS_HELP_STRING([--disable-arith-rings], [Disable arithmetical rings]),
[if test $enableval = yes; then
     ENABLE_RINGS="yes"
 else
     ENABLE_RINGS="no"
 fi
],[ENABLE_RINGS="yes"])

if test x$ENABLE_RINGS = xyes; then
  AC_DEFINE(HAVE_RINGS,1,Enable arithmetical rings)
fi

AM_CONDITIONAL([ENABLE_RINGS],[test x$ENABLE_RINGS = xyes])
AC_MSG_RESULT($ENABLE_RINGS)
])

AC_DEFUN([SING_CHECK_PLURAL],
[
AC_MSG_CHECKING(whether non-commutative subsystem should be enabled)

AC_ARG_ENABLE(plural, AS_HELP_STRING([--disable-plural], [Disable non-commutative subsystem]),
[if test "x$enableval" = xyes; then
     ENABLE_PLURAL="yes"
 else
     ENABLE_PLURAL="no"
 fi
],[ENABLE_PLURAL="yes"])

if test "x$ENABLE_PLURAL" = xyes; then
  AC_DEFINE(HAVE_PLURAL,[1],[Enable non-commutative subsystem])
  #TODO make a seperate switch
  AC_DEFINE(HAVE_SHIFTBBA,[1],[Enable letterplace])
fi

AM_CONDITIONAL([ENABLE_PLURAL],[test x$ENABLE_PLURAL = xyes])

AC_MSG_RESULT($ENABLE_PLURAL)


AC_ARG_WITH(RatGB, AS_HELP_STRING([--with-ratGB], [do compile with ratGB support (experimental)]))

AC_MSG_CHECKING(whether to have ratGB)
if test "x$with_ratGB" != xyes && test "x$enable_ratGB" != xyes; then
  AC_MSG_RESULT(no)
else
  AC_DEFINE(HAVE_RATGRING, 1, [Enable RatGB support])
  AC_MSG_RESULT(yes)
fi


])


AC_DEFUN([SING_CHECK_OMALLOC],
[
  AC_ARG_ENABLE(omalloc, 
    [AS_HELP_STRING([--enable-omalloc],[build for use with omalloc])],
    [if test "x$enableval" = "xyes"; then
      ENABLE_OMALLOC=yes
    fi], 
      ENABLE_OMALLOC=no)

  AC_ARG_VAR( [OMALLOC_INCLUDES], [INCLUDES for libomalloc] )
  AC_ARG_VAR( [OMALLOC_LIBS], [LIBS for libomalloc] )

  AC_MSG_CHECKING([whether to use omalloc])

  AH_TEMPLATE([HAVE_OMALLOC], [define if build with OMALLOC])

  if test "x$ENABLE_OMALLOC" = xyes; then
    AC_MSG_RESULT(yes)

    AC_MSG_CHECKING([  OMALLOC_INCLUDES?..])
    AC_MSG_RESULT(${OMALLOC_INCLUDES:-unset})

    AC_MSG_CHECKING([  OMALLOC_LIBS?..])
    AC_MSG_RESULT(${OMALLOC_LIBS:-unset})

    CPPFLAGS_save="$CPPFLAGS"
    CFLAGS_save="$CFLAGS"
    LIBS_save="$LIBS"

    AC_LANG_PUSH([C])
#
    CPPFLAGS="$CPPFLAGS ${OMALLOC_INCLUDES}"
    CFLAGS="$CFLAGS ${OMALLOC_INCLUDES}"
    LIBS="$LIBS ${OMALLOC_LIBS}"

    AC_CHECK_HEADERS([omalloc/omalloc.h],,AC_MSG_WARN([trusting the omalloc locations given: ${OMALLOC_INCLUDES}]))

    CFLAGS="$CFLAGS_save"
    CPPFLAGS="$CPPFLAGS_save"
    LIBS="$LIBS_save"
#
    AC_LANG_POP([C])

    AC_DEFINE([HAVE_OMALLOC],[1])
 
    PKG_REQUIRE="$PKG_REQUIRE omalloc"
    AC_SUBST(PKG_REQUIRE)
  else
    AC_MSG_RESULT(no)
  fi

  AM_CONDITIONAL([ENABLE_OMALLOC],[test "x$ENABLE_OMALLOC" = xyes])
])

AC_DEFUN([SING_USE_OMALLOC],
[
 AC_ARG_ENABLE(omalloc, 
  [AS_HELP_STRING([--disable-omalloc], [do NOT use omalloc within the factory])],
  [if test "x$enableval"  = "xyes"; then
    ENABLE_OMALLOC=yes
   fi], 
    ENABLE_OMALLOC=add)

 ENABLE_OMALLOC_ARG=""

 if test "x$ENABLE_OMALLOC" = xadd; then
   ENABLE_OMALLOC=yes
   ENABLE_OMALLOC_ARG="--enable-omalloc $ENABLE_OMALLOC_ARG"
 fi

 AC_MSG_CHECKING(whether to use omalloc in factory and co.)

 if test "x$ENABLE_OMALLOC" = xyes; then
  AC_MSG_RESULT(yes)
  OMALLOC_INCLUDES="-I$ac_abs_top_srcdir"

  if test "x$ac_abs_top_srcdir" != "x$ac_abs_top_builddir"; then
    OMALLOC_INCLUDES="$OMALLOC_INCLUDES -I$ac_abs_top_builddir"
  fi

  OMALLOC_LIBS="$ac_abs_top_builddir/omalloc/libomalloc.la"

  AC_SUBST(OMALLOC_INCLUDES)
  AC_SUBST(OMALLOC_LIBS)

  ENABLE_OMALLOC_ARG="$ENABLE_OMALLOC_ARG OMALLOC_LIBS='$OMALLOC_LIBS' OMALLOC_INCLUDES='$OMALLOC_INCLUDES'"
  ac_configure_args="$ac_configure_args $ENABLE_OMALLOC_ARG"

  PKG_REQUIRE="$PKG_REQUIRE omalloc"
  AC_SUBST(PKG_REQUIRE)
 else
  AC_MSG_RESULT(no)
 fi


 AM_CONDITIONAL([ENABLE_OMALLOC],[test "x$ENABLE_OMALLOC" = xyes])
])

AC_DEFUN([SING_USE_RESOURCES],
[
 AC_ARG_ENABLE(resources, 
  [AS_HELP_STRING([--disable-resources], [do NOT use libresources within the factory])],
  [if test "x$enableval"  = "xyes"; then
    ENABLE_RESOURCES=yes
   fi], 
    ENABLE_RESOURCES=yes)

 AC_MSG_CHECKING(whether to use libresources in factory and co.)
 if test "x$ENABLE_RESOURCES" = xyes; then
  AC_MSG_RESULT(yes)
  RESOURCES_INCLUDES="-I$ac_abs_top_srcdir "

  RESOURCES_LIBS="$ac_abs_top_builddir/resources/libresources.la"

  AC_SUBST(RESOURCES_INCLUDES)
  AC_SUBST(RESOURCES_LIBS)

  ENABLE_ARG="--with-Singular RESOURCES_LIBS='$RESOURCES_LIBS' RESOURCES_INCLUDES='$RESOURCES_INCLUDES'"

  ac_configure_args="$ac_configure_args $ENABLE_ARG"

  PKG_REQUIRE="$PKG_REQUIRE resources"
  AC_SUBST(PKG_REQUIRE)
 else
  AC_MSG_RESULT(no)
 fi

 AM_CONDITIONAL([ENABLE_RESOURCES],[test "x$ENABLE_RESOURCES" = xyes])
])


AC_DEFUN([SING_USE_FACTORY],
[
 AC_MSG_CHECKING(whether factory should be enabled)

 AC_ARG_ENABLE(factory, AS_HELP_STRING([--disable-factory], [Disable factory]),
 [if test $enableval = yes; then
     ENABLE_FACTORY="yes"
  else
     ENABLE_FACTORY="no"
  fi],[ENABLE_FACTORY="yes"])

 if test x$ENABLE_FACTORY = xyes; then

  FACTORY_INCLUDES="-I$ac_abs_top_srcdir -I$ac_abs_top_srcdir/factory/include"
  if test "x$ac_abs_top_srcdir" != "x$ac_abs_top_builddir"; then
    FACTORY_INCLUDES="$FACTORY_INCLUDES -I$ac_abs_top_builddir -I$ac_abs_top_builddir/factory/include"
  fi

  FACTORY_LIBS="$ac_abs_top_builddir/factory/libfactory.la"

  AC_SUBST(FACTORY_INCLUDES)
  AC_SUBST(FACTORY_LIBS)

  AC_MSG_CHECKING([  FACTORY_INCLUDES?..])
  AC_MSG_RESULT(${FACTORY_INCLUDES:-unset})

  AC_MSG_CHECKING([  FACTORY_LIBS?..])
  AC_MSG_RESULT(${FACTORY_LIBS:-unset})

  AC_DEFINE(HAVE_FACTORY,[1],[Enable factory])

  ENABLE_ARG="FACTORY_LIBS='$FACTORY_LIBS' FACTORY_INCLUDES='$FACTORY_INCLUDES'"

  ac_configure_args="$ac_configure_args $ENABLE_ARG"

  PKG_REQUIRE="$PKG_REQUIRE factory"
  AC_SUBST(PKG_REQUIRE)
 fi


 AM_CONDITIONAL([ENABLE_FACTORY],[test x$ENABLE_FACTORY = xyes])
 AC_MSG_RESULT($ENABLE_FACTORY)

])

AC_DEFUN([SING_CHECK_FACTORY],
[
AC_ARG_ENABLE(factory, AS_HELP_STRING([--disable-factory], [Disable factory]),
[if test $enableval = yes; then
     ENABLE_FACTORY="yes"
 else
     ENABLE_FACTORY="no"
 fi
],[ENABLE_FACTORY="yes"])

  AC_ARG_VAR( [FACTORY_INCLUDES], [INCLUDES for FACTORY] )
  AC_ARG_VAR( [FACTORY_LIBS], [LIBS for FACTORY] )

  AC_MSG_CHECKING(whether factory should be enabled)
  if test "x$ENABLE_FACTORY" = xyes; then
    AC_MSG_RESULT(yes)

    AC_MSG_CHECKING([  FACTORY_INCLUDES?..])
    AC_MSG_RESULT(${FACTORY_INCLUDES:-unset})

    AC_MSG_CHECKING([  FACTORY_LIBS?..])
    AC_MSG_RESULT(${FACTORY_LIBS:-unset})


    CPPFLAGS_save="$CPPFLAGS"
    CFLAGS_save="$CFLAGS"
    CXXFLAGS_save="$CXXFLAGS"
    LIBS_save="$LIBS"

    AC_LANG_PUSH([C++])
#
    CPPFLAGS="$CPPFLAGS ${FACTORY_INCLUDES}"
    CFLAGS="$CFLAGS ${FACTORY_INCLUDES}"
    CXXFLAGS="$CXXFLAGS ${FACTORY_INCLUDES}"
    LIBS="$LIBS ${FACTORY_LIBS}"
 
    AC_CHECK_HEADERS([factory/factory.h],,AC_MSG_WARN([trusting the factory locations given: ${FACTORY_INCLUDES}]))

    CFLAGS="$CFLAGS_save"
    CXXFLAGS="$CXXFLAGS_save"
    CPPFLAGS="$CPPFLAGS_save"
    LIBS="$LIBS_save"
#
    AC_LANG_POP([C++])

    AC_DEFINE(HAVE_FACTORY,[1],[Enable factory])
 
    PKG_REQUIRE="$PKG_REQUIRE factory"
    AC_SUBST(PKG_REQUIRE)
  else
    AC_MSG_RESULT(no)
  fi

  AM_CONDITIONAL([ENABLE_FACTORY],[test x$ENABLE_FACTORY = xyes])
  AC_MSG_RESULT($ENABLE_FACTORY)

])



AC_DEFUN([SING_BUILTIN_MODULES],
[
 AC_MSG_CHECKING([whether for builtin modules])

 AC_ARG_VAR( [BUILTIN_LIBS], [LIBS for building-in] )
 AC_ARG_WITH(builtinmodules, AS_HELP_STRING([--with-builtinmodules], [list? of builtin modules (experimental)]))

 if test "x$builtinmodules" == xno; then
  AC_MSG_RESULT(no)
 else
  AC_DEFINE_UNQUOTED([SI_BUILTINMODULES],"$builtinmodules",[List? of Builtin modules])
  AC_MSG_RESULT(yes)
 fi
 AC_SUBST(BUILTIN_LIBS)

 AM_CONDITIONAL([SI_BUILTIN_PYOBJECT],[test "x$builtinmodules" == xyes])
 AM_CONDITIONAL([SI_BUILTIN_SYZEXTRA],[test "x$builtinmodules" == xyes])
 AM_CONDITIONAL([SI_BUILTIN_GFANLIB],[test "x$builtinmodules" == xyes])

])
