# pg_misc_functions
A PostgreSQL extension providing various miscellaneous useful functions. 

SQL functions
=============
- pg_cause_panic() - generates a PANIC to take down the entire running database cluster, for instance, useful to test failovers in HA environments
- pg_cause_fatal() - generates a FATAL error to abort the backend
- pg_signal_backend(pid int4, signum int4) - sends a specified signal to specified PostgreSQL backend including auxiliary processes and postmaster
- pg_signal_backend(type text, signum int4) - sends a specified signal to specified PostgreSQL backend type (checkpointer, client backend, autovacuum launcher,
  background writer etc.) including auxiliary processes and but not postmaster
- pg_control_checkpoint_tli() - returns timeline ID of the last checkpoint from pg_control file
- pg_control_checkpoint_previous_tli() - returns previous timeline ID of the last checkpoint from pg_control file
- pg_current_wal_tli() - returns current insert timeline ID of the server
- pg_last_wal_replay_tli() - returns timeline ID of last replayed WAL record
- pg_last_wal_receive_tli() - returns timeline ID of last WAL record received by WAL receiver

Compatibility with PostgreSQL
=============================
Version 15 and above.

Installation
============
Easiest way to use the extension's source code is to copy it as contrib/pg_misc_functions in PostgreSQL source code and run "make install" to compile and "make check" for tests.

Usage
=====
Create the extension with CREATE EXTENSION pg_misc_functions; command and use its functions.

Dependencies
============
NA

LICENSE
=======
pg_misc_functions is free software distributed under the PostgreSQL Licence.

Copyright (c) 1996-2022, PostgreSQL Global Development Group

Developer
=========
This extension is developed and being maintained by Bharath Rupireddy.

- Twitter: https://twitter.com/BRupireddy
- LinkedIn: www.linkedin.com/in/bharath-rupireddy

Bug Report: https://github.com/BRupireddy/pg_misc_functions or <bharath.rupireddyforpostgres@gmail.com>
