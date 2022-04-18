# contrib/pg_misc_functions/Makefile

MODULE_big = pg_misc_functions
OBJS = \
	$(WIN32RES) \
	pg_misc_functions.o
PGFILEDESC = "pg_misc_functions - Module to provide various miscellaneous PostgreSQL functions"

EXTENSION = pg_misc_functions
DATA = pg_misc_functions--1.0.sql

REGRESS = pg_misc_functions

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/pg_misc_functions
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
