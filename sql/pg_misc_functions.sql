CREATE EXTENSION pg_misc_functions;

-- send SIGINT to checkpointer
SELECT pg_signal_backend(pid, 2) FROM pg_stat_activity
  WHERE backend_type = 'checkpointer';

SELECT pg_signal_backend('checkpointer', 2);
