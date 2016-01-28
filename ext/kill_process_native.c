#include <math.h>
#include <ruby.h>
#include <signal.h>
#include <time.h>
#include <pthread.h>

#if _POSIX_C_SOURCE >= 199309L
  VALUE rb_posix_timer_set(VALUE self, VALUE seconds) {
    struct sigevent sev;
    timer_t tidlist;
    int return_val;
    struct timespec zero_time;
    struct timespec timeout_value;
    struct itimerspec timer_spec;
    double dbl_seconds = NUM2DBL(seconds);

    zero_time.tv_sec = 0;
    zero_time.tv_nsec = 0;

    timeout_value.tv_sec = (int)floor(dbl_seconds);
    timeout_value.tv_nsec = 0;

    timer_spec.it_interval = zero_time;
    timer_spec.it_value = timeout_value;

    sev.sigev_notify = SIGEV_SIGNAL;
    sev.sigev_signo = 9; //SIGKILL

    return_val = timer_create(CLOCK_REALTIME, &sev, &tidlist);
    if (return_val != 0) {
      rb_sys_fail(0);
    }
    return_val = timer_settime(tidlist, 0, &timer_spec, NULL);
    if (return_val != 0) {
      rb_sys_fail(0);
    }

    return Qtrue;
  }
#else
  VALUE rb_posix_timer_set(VALUE self, VALUE seconds) {
    return Qfalse;
  }
#endif

void Init_kill_process_native(void) {
  VALUE kill_process_module = rb_const_get(rb_cObject, rb_intern("KillProcess"));

  rb_define_singleton_method(kill_process_module, "posix_timer_set", rb_posix_timer_set, 1);
}
