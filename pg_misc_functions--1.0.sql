/* contrib/pg_misc_functions/pg_misc_functions--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_misc_functions" to load this file. \quit

--
-- pg_cause_panic()
--
-- Generates a PANIC taking down the entire database cluster.
--
CREATE FUNCTION pg_cause_panic()
RETURNS VOID
AS 'MODULE_PATHNAME', 'pg_cause_panic'
LANGUAGE C STRICT PARALLEL SAFE;

REVOKE EXECUTE ON FUNCTION pg_cause_panic() FROM PUBLIC;

--
-- pg_cause_fatal()
--
-- Generates a FATAL error taking down the backend.
--
CREATE FUNCTION pg_cause_fatal()
RETURNS VOID
AS 'MODULE_PATHNAME', 'pg_cause_fatal'
LANGUAGE C STRICT PARALLEL SAFE;

REVOKE EXECUTE ON FUNCTION pg_cause_fatal() FROM PUBLIC;

--
-- pg_signal_backend()
--
-- Signals a PostgreSQL backend (including auxiliary processes and postmaster)
-- of given PID with given signal.
--
CREATE FUNCTION pg_signal_backend(pid int4, signum int4)
RETURNS boolean
AS 'MODULE_PATHNAME', 'pg_signal_backend_with_pid'
LANGUAGE C STRICT VOLATILE PARALLEL SAFE;

REVOKE EXECUTE ON FUNCTION pg_signal_backend(int4, int4) FROM PUBLIC;

--
-- pg_signal_backend()
--
-- Signals a PostgreSQL backend (including auxiliary processes, but not
-- postmaster for now) of given type with given signal.
--
CREATE FUNCTION pg_signal_backend(type text, signum int4)
RETURNS boolean AS $$
DECLARE
 pid_v  INTEGER;
 r  BOOLEAN;
BEGIN
 SELECT pid INTO pid_v FROM pg_stat_activity WHERE backend_type = type;
 IF NOT FOUND
    THEN pid_v := -1;
 END IF;
 SELECT * INTO r FROM pg_signal_backend(pid_v, signum);
 RETURN r;
END; $$
LANGUAGE plpgsql STRICT VOLATILE PARALLEL SAFE;

REVOKE EXECUTE ON FUNCTION pg_signal_backend(text, int4) FROM PUBLIC;

--
-- pg_control_checkpoint_tli()
--
-- Returns timeline ID of the last checkpoint from pg_control file.
--
CREATE FUNCTION pg_control_checkpoint_tli()
RETURNS int4
AS 'SELECT timeline_id FROM pg_control_checkpoint();'
LANGUAGE SQL VOLATILE STRICT;

--
-- pg_control_checkpoint_previous_tli()
--
-- Returns previous timeline ID of the last checkpoint from pg_control file.
--
CREATE FUNCTION pg_control_checkpoint_previous_tli()
RETURNS int4
AS 'SELECT prev_timeline_id FROM pg_control_checkpoint();'
LANGUAGE SQL VOLATILE PARALLEL SAFE;

--
-- pg_current_wal_tli()
--
-- Returns current insert timeline ID of the server.
--
CREATE FUNCTION pg_current_wal_tli()
RETURNS int4
AS 'MODULE_PATHNAME', 'pg_current_wal_tli'
LANGUAGE C VOLATILE PARALLEL SAFE;

--
-- pg_last_wal_replay_tli()
--
-- Returns timeline ID of last replayed WAL record.
--
CREATE FUNCTION pg_last_wal_replay_tli()
RETURNS int4
AS 'MODULE_PATHNAME', 'pg_last_wal_replay_tli'
LANGUAGE C VOLATILE PARALLEL SAFE;

--
-- pg_last_wal_receive_tli()
--
-- Returns timeline ID of last WAL record received by WAL receiver.
--
CREATE FUNCTION pg_last_wal_receive_tli()
RETURNS int4
AS 'MODULE_PATHNAME', 'pg_last_wal_receive_tli'
LANGUAGE C VOLATILE PARALLEL SAFE;
