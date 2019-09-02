#include "spinlock.h"


#define MAX_STACK_SIZE 4000
#define MAX_MUTEXES 64

/********************************
        The API of the KLT package
 ********************************/


int kthread_create(void (*start_func)(), void* stack);
int kthread_id();
void kthread_exit();
int kthread_join(int thread_id);

int kthread_mutex_alloc();
int kthread_mutex_dealloc(int mutex_id);
int kthread_mutex_lock(int mutex_id);
int kthread_mutex_unlock(int mutex_id);

enum mutexState {UNINITIALIZED, OPEN , CLOSE };
struct mutex{
    int mid;
    int lock;
    int numOfWaiting;
    struct spinlock mutexLock;
    enum mutexState state;
    struct thread* holding;
    int pid_holder;
}mutex;


