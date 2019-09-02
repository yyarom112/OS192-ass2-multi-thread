#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "kthread.h"

struct {
    struct spinlock lock;
    struct proc proc[NPROC];
} ptable;


struct {
    struct spinlock lock;
    struct mutex mutex[MAX_MUTEXES];
} mtable;

static struct proc *initproc;

int nextpid = 1;
int nexttid = 1;
int nextmid = 1;


extern void forkret(void);

extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void) {
    initlock(&mtable.lock, "mtable");
    initlock(&ptable.lock, "ptable");
    for (int i = 0; i < MAX_MUTEXES; i++) {
        initlock(&mtable.mutex[i].mutexLock, "mutexLock");
    }
}

void cprintState(struct thread *t) {
    switch (t->state) {
        case T_ZOMBIE:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_ZOMBIE\n", t->tid,t->shouldDie, t->parent->name);
            break;
        case T_RUNNABLE:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_RUNNABLE\n",t->tid,t->shouldDie, t->parent->name);
            break;
        case T_SLEEPING:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_SLEEPING\n", t->tid,t->shouldDie, t->parent->name);
            break;
        case T_UNUSED:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_UNUSED\n", t->tid,t->shouldDie, t->parent->name);
            break;
        case T_EMBRYO:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_EMBRYO\n", t->tid,t->shouldDie, t->parent->name);
            break;
        case T_RUNNING:
            cprintf("thread id %d and he killed=%d that is father is %s in state T_RUNNING\n", t->tid,t->shouldDie, t->parent->name);
            break;
    }
}


void cprintMutexState(struct mutex *m) {
    switch (m->state) {
        case UNINITIALIZED:
            cprintf("mutex id is %d and is state = UNINITIALIZED\n", m->mid);
            break;
        case OPEN:
            cprintf("mutex id is %d and is state = OPEN\n", m->mid);
            break;
        case CLOSE:
            cprintf("mutex id is %d and is state = CLOSE\n", m->mid);
            break;
    }
}

struct spinlock *
mySpinlock() {
    return &ptable.lock;
}

// Must be called with interrupts disabled
int
cpuid() {
    return mycpu() - cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void) {
    int apicid, i;

    if (readeflags() & FL_IF)
        panic("mycpu called with interrupts enabled\n");

    apicid = lapicid();
    // APIC IDs are not guaranteed to be contiguous. Maybe we should have
    // a reverse map, or reserve a register to store &cpus[i].
    for (i = 0; i < ncpu; ++i) {
        if (cpus[i].apicid == apicid)
            return &cpus[i];
    }
    panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
    c = mycpu();
    p = c->proc;
    popcli();
    return p;
}


// Disable interrupts so that we are not rescheduled
// while reading thread from the cpu structure
struct thread *
mythread(void) {
    struct cpu *c;
    struct thread *t;
    pushcli();
    c = mycpu();
    t = c->thread;
    popcli();
    return t;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void) {
    struct proc *p;
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->state == UNUSED)
            goto found;
    }
    release(&ptable.lock);
    return 0;

    found:
    p->state = USED;
    p->pid = nextpid++;
    release(&ptable.lock);

    return p;
}


static struct thread *
allocthread(struct proc *p) {
    struct thread *t;
    char *sp;
    int i;
    acquire(&ptable.lock);
    for (i = 1, t = p->ttable; t < &p->ttable[NTHREAD]; t++, i++) {
        if (t->state == T_UNUSED) {
            goto found;
        }
    }
    release(&ptable.lock);
    return 0;

    found:
    t->state = T_EMBRYO;
    t->tid = nexttid++;
    t->parent = p;
    t->next_thread = 0;
    t->mutex_flag = 0;
    t->shouldDie = 0;
    release(&ptable.lock);

    // Allocate kernel stack.
    if ((t->kstack = kalloc()) == 0) {
        p->state = UNUSED;
        t->state = T_UNUSED;
        return 0;
    }
    sp = t->kstack + KSTACKSIZE;

    // Leave room for trap frame.
    sp -= sizeof *t->tf;
    t->tf = (struct trapframe *) sp;

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
    *(uint *) sp = (uint) trapret;

    sp -= sizeof *t->context;
    t->context = (struct context *) sp;
    memset(t->context, 0, sizeof *t->context);
    t->context->eip = (uint) forkret;
    p->numOfthread++;
    return t;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void) {
    struct proc *p;
    struct thread *t;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
    t = allocthread(p);

    initproc = p;
    if ((p->pgdir = setupkvm()) == 0)
        panic("userinit: out of memory?");
    inituvm(p->pgdir, _binary_initcode_start, (int) _binary_initcode_size);
    p->sz = PGSIZE;
    memset(t->tf, 0, sizeof(*t->tf));
    t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
    t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
    t->tf->es = t->tf->ds;
    t->tf->ss = t->tf->ds;
    t->tf->eflags = FL_IF;
    t->tf->esp = PGSIZE;
    t->tf->eip = 0;  // beginning of initcode.S

    safestrcpy(p->name, "initcode", sizeof(p->name));
    safestrcpy(t->name, "initcodeThread", sizeof(t->name));

    p->cwd = namei("/");

    // this assignment to p->state lets other cores
    // run this process. the acquire forces the above
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = USED;
    t->state = T_RUNNABLE;

    release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n) {
    uint sz;
    struct proc *curproc = myproc();
    struct thread *curthread = mythread();

    acquire(&ptable.lock);
    sz = curproc->sz;
    if (n > 0) {
        if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0) {
            release(&ptable.lock);
            return -1;

        }
    } else if (n < 0) {
        if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0) {
            release(&ptable.lock);
            return -1;
        }
    }
    curproc->sz = sz;
    release(&ptable.lock);

    switchuvm(curthread, curproc);
    return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void) {
    int i, pid;
    struct proc *np;
    struct proc *curproc = myproc();
    struct thread *curthread = mythread();
    struct thread *nt;

    // Allocate process.
    if ((np = allocproc()) == 0) {
        return -1;
    }
    if ((nt = allocthread(np)) == 0) {
        return -1;
    }

    // Copy process state from proc.
    if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0) {
        kfree(nt->kstack);
        nt->kstack = 0;
        np->state = UNUSED;
        nt->state = T_UNUSED;
        return -1;
    }
    np->sz = curproc->sz;
    np->parent = curproc;
    *nt->tf = *curthread->tf;

    // Clear %eax so that fork returns 0 in the child.
    nt->tf->eax = 0;

    for (i = 0; i < NOFILE; i++)
        if (curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
    safestrcpy(nt->name, curthread->name, sizeof(curthread->name));


    pid = np->pid;

    acquire(&ptable.lock);

    np->state = USED;
    nt->state = T_RUNNABLE;

    release(&ptable.lock);

    return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void) {
    struct proc *curproc = myproc();
    struct thread *curthread = mythread();
    struct proc *p;
    struct thread *t;
    int fd;
    struct mutex* m;

    if (curproc == initproc)
        panic("init exiting");

    acquire(&ptable.lock);
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
        if (t->tid != curthread->tid)
            t->shouldDie = 1;
        if (t->state == T_SLEEPING)
            t->state = T_RUNNABLE;
    }
    release(&ptable.lock);
    int numthread = 1000;
    while (numthread > 1) {
        numthread = 0;
        for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
            if (t->state == T_ZOMBIE) {
                kfree(t->kstack);
                t->kstack = 0;
                t->tid = 0;
                t->state = T_UNUSED;
                curproc->numOfthread--;
            } else {
                if (t->state != T_UNUSED)
                    numthread++;
            }
        }
    }

    for(m=mtable.mutex;m<&(mtable.mutex[MAX_MUTEXES]);m++){
        if(m->pid_holder==curproc->pid)
            kthread_mutex_dealloc(m->mid);
    }


    // Close all open files.
    for (fd = 0; fd < NOFILE; fd++) {
        if (curproc->ofile[fd]) {
            fileclose(curproc->ofile[fd]);
            curproc->ofile[fd] = 0;
        }
    }

    begin_op();
    iput(curproc->cwd);
    end_op();
    curproc->cwd = 0;

    acquire(&ptable.lock);

    // Parent might be sleeping in wait().
    for (t = curproc->parent->ttable; t < &curproc->parent->ttable[NTHREAD]; t++)
        wakeup1(t);

    // Pass abandoned children to init.
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->parent == curproc) {
            p->parent = initproc;
            if (p->state == ZOMBIE) {
                for (t = initproc->ttable; t < &initproc->ttable[NTHREAD]; t++)
                    wakeup1(t);
            }
        }
    }

    // Jump into the scheduler, never to return.
    curproc->state = ZOMBIE;
    for (t = curproc->ttable; t < &curproc->ttable[NTHREAD]; t++)
        if (t->state != T_UNUSED)
            t->state = T_ZOMBIE;

    sched();
    panic("zombie exit");
}

void exitThread(void) {
    struct thread *t;
    acquire(&ptable.lock);
    for (t = myproc()->ttable; t < &(myproc()->ttable[NTHREAD]); t++) {
        wakeup1(mythread());
    }
    mythread()->shouldDie = 0;
    mythread()->state = T_ZOMBIE;
    sched();
    panic("exitThread exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void) {
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();
    struct thread *curthread = mythread();
    struct thread *t;

    acquire(&ptable.lock);
    for (;;) {
        // Scan through table looking for exited children.
        havekids = 0;
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
            if (p->parent != curproc)
                continue;
            havekids = 1;
            if (p->state == ZOMBIE) {
                for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
                    if (t->state == T_ZOMBIE) {
                        kfree(t->kstack);
                        t->kstack = 0;
                        t->tid = 0;
                        t->state = T_UNUSED;
                    }
                }
                // Found one.
                pid = p->pid;
                freevm(p->pgdir);
                p->pid = 0;
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
                p->state = UNUSED;
                release(&ptable.lock);
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if (!havekids || curproc->killed) {
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curthread, &ptable.lock);  //DOC: wait-sleep
    }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void) {
    struct proc *p;
    struct cpu *c = mycpu();
    c->proc = 0;
    struct thread *t;

    for (;;) {
        // Enable interrupts on this processor.
        sti();

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
                if (t->state != T_RUNNABLE)
                    continue;
                // Switch to chosen process.  It is the process's job
                // to release ptable.lock and then reacquire it
                // before jumping back to us.
                c->proc = p;
                c->thread = t;
                switchuvm(t, p);
                p->state = USED;
                t->state = T_RUNNING;

                swtch(&(c->scheduler), t->context);
                switchkvm();

                // Process is done running for now.
                // It should have changed its p->state before coming back.
                c->proc = 0;
                c->thread = 0;
            }
        }
        release(&ptable.lock);

    }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void) {
    int intena;
    if (!holding(&ptable.lock))
        panic("sched ptable.lock");
    if (mycpu()->ncli != 1)
        panic("sched locks");
    if (mythread()->state == T_RUNNING)
        panic("sched running curthread");
    if (readeflags() & FL_IF)
        panic("sched interruptible");
    intena = mycpu()->intena;
    swtch(&mythread()->context, mycpu()->scheduler);
    mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void) {
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = USED;
    mythread()->state = T_RUNNABLE;
    sched();
    release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void) {
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);

    if (first) {
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot
        // be run from main().
        first = 0;
        iinit(ROOTDEV);
        initlog(ROOTDEV);
    }

    // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk) {
    struct proc *p = myproc();
    struct thread *t = mythread();

    if (p == 0)
        panic("sleep");
    if (t == 0)
        panic("sleep");

    if (lk == 0)
        panic("sleep without lk");

    // Must acquire ptable.lock in order to
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if (lk != &ptable.lock) {  //DOC: sleeplock0
        acquire(&ptable.lock);  //DOC: sleeplock1
        release(lk);
    }
    // Go to sleep.
    t->chan = chan;
    t->state = T_SLEEPING;

    sched();

    if(t->shouldDie){
        release(&ptable.lock);
        kthread_exit();

    }
    // Tidy up.
    t->chan = 0;

    // Reacquire original lock.
    if (lk != &ptable.lock) {  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
    }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan) {
    struct proc *p;
    struct thread *t;

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
            if (t->state == T_SLEEPING && t->chan == chan) {
                p->state = USED;
                t->state = T_RUNNABLE;
            }
        }
    }

}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan) {
    acquire(&ptable.lock);
    wakeup1(chan);
    release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid) {
    struct proc *p;
    struct thread *t;

    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->pid == pid) {
            p->killed = 1;
            // Wake process from sleep if necessary.
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
                if (t->state == T_SLEEPING)
                    t->state = T_RUNNABLE;
            }
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) {
    static char *states[] = {
            [T_UNUSED]    "t_unused",
            [T_EMBRYO]    "t_embryo",
            [T_SLEEPING]  "t_sleep ",
            [T_RUNNABLE]  "t_runble",
            [T_RUNNING]   "t_run   ",
            [T_ZOMBIE]    "t_zombie"
    };
    int i;
    struct proc *p;
    struct thread *t;
    char *state;
    uint pc[10];

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->state == UNUSED)
            continue;
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
            if (t->state >= 0 && t->state < NELEM(states) && states[t->state])
                state = states[t->state];
            else
                state = "???";
            cprintf("%d %s %s", t->tid, state, t->name);
            if (t->state == T_SLEEPING) {
                getcallerpcs((uint *) t->context->ebp + 2, pc);
                for (i = 0; i < 10 && pc[i] != 0; i++)
                    cprintf(" %p", pc[i]);
            }
            cprintf("\n");
        }

    }
}

int kthread_create(void (*start_func)(), void *stack) {
    struct thread *t;
    struct thread *curthread = mythread();

    if (curthread == 0 || start_func <= 0 || stack <= 0) {
        return -1;
    }
    if ((t = allocthread(myproc())) == 0) {
        return -1;
    }
    acquire(&ptable.lock);

    safestrcpy(t->name, "thread", sizeof("thread"));
    *t->tf = *curthread->tf;
    t->tf->esp = (uint) (stack);
    t->tf->eip = (uint) start_func;

    t->state = T_RUNNABLE;
    release(&ptable.lock);

    return t->tid;


}

int kthread_id() {
    if (mythread() == 0)
        return -1;
    return mythread()->tid;
}

void kthread_exit() {
    struct thread *t;
    struct thread *curthread = mythread();
    struct proc *curproc = myproc();
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
        if (curthread->tid != t->tid && (t->state != T_ZOMBIE && t->state != T_UNUSED))
            goto found;
    }
    exit();
    found:
    exitThread();
}

int kthread_join(int thread_id) {
    struct thread *t;
    struct proc *p;

    acquire(&ptable.lock);
    for (;;) {
        if(mythread()->shouldDie){
            release(&ptable.lock);
            kthread_exit();

        }
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
            if (p->state == UNUSED)
                continue;
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
                if (t->tid == thread_id)
                    goto found;
            }

        }
        release(&ptable.lock);
        return -1;

        found:
        if (t->state == T_UNUSED)
            panic("kthread_join-thread unused is necessary");
        if (t->state == T_ZOMBIE) {
            release(&ptable.lock);
            kfree(t->kstack);
            t->kstack = 0;
            t->tid = 0;
            t->shouldDie = 0;
            t->state = T_UNUSED;
            return 0;
        } else {
            // Wait for children to exit.  (See wakeup1 call in proc_exit.)
            sleep(t, &ptable.lock);  //DOC: wait-sleep
        }
    }
}

int kthread_mutex_alloc() {
    int i;
    acquire(&mtable.lock);
    for (i = 0; i < MAX_MUTEXES; i++) {
        if (mtable.mutex[i].state == UNINITIALIZED)
            goto found;
    }
    release(&mtable.lock);
    return -1;

    found:
    acquire(&mtable.mutex[i].mutexLock);
    release(&mtable.lock);
    mtable.mutex[i].lock = 0;
    mtable.mutex[i].mid = nextmid++;
    mtable.mutex[i].pid_holder=myproc()->pid;
    mtable.mutex[i].numOfWaiting = 0;
    mtable.mutex[i].state = OPEN;
    mtable.mutex[i].holding = 0;
    release(&mtable.mutex[i].mutexLock);
    return mtable.mutex[i].mid;
}

int kthread_mutex_dealloc(int mutex_id) {
    int i;
    struct mutex *m;
    acquire(&mtable.lock);
    for (i = 0; i < MAX_MUTEXES; i++) {
        if (mtable.mutex[i].mid == mutex_id)
            goto found;
    }
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
    if (m == 0 || m->state == CLOSE || m->numOfWaiting != 0) {
        release(&mtable.lock);
        return -1;
    }
    acquire(&m->mutexLock);
    m->holding = 0;
    m->mid = 0;
    m->lock = 0;
    m->numOfWaiting = 0;
    mtable.mutex[i].pid_holder=0;
    m->state = UNINITIALIZED;
    release(&m->mutexLock);
    release(&mtable.lock);
    return 0;
}


int kthread_mutex_lock(int mutex_id) {
    int i;
    struct mutex *m;
    acquire(&mtable.lock);
    for (i = 0; i < MAX_MUTEXES; i++) {
        if (mtable.mutex[i].mid == mutex_id)
            goto found;
    }
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
    if (m == 0 || m->state == UNINITIALIZED || m->holding->tid == mythread()->tid) {
        release(&mtable.lock);
        return -1;
    }
    acquire(&m->mutexLock);
    release(&mtable.lock);
    while (xchg((uint *) &m->lock, 1) != 0) {
        sleep(m, &m->mutexLock);
    }
    m->state = CLOSE;
    m->holding = mythread();
    release(&m->mutexLock);
    return 0;
}


int kthread_mutex_unlock(int mutex_id) {
    int i;
    struct mutex *m;
    struct proc *curproc = myproc();
    struct thread *t;
    acquire(&mtable.lock);
    for (i = 0; i < MAX_MUTEXES; i++) {
        if (mtable.mutex[i].mid == mutex_id)
            goto found;
    }
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
    acquire(&m->mutexLock);
    release(&mtable.lock);
    if (m == 0 || m->state != CLOSE || m->holding->tid != mythread()->tid) {
        release(&m->mutexLock);
        return -1;
    }
    m->lock = 0;
    m->state=OPEN;
    m->holding=0;
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
        if (t->state == T_SLEEPING && t->chan == m) {
            t->state = T_RUNNABLE;
            release(&m->mutexLock);
            return 0;
        }
    }
    release(&m->mutexLock);
    return 0;
}








