#include "types.h"
#include "stat.h"
#include "user.h"
#include "tournament_tree.h"

void ThreadTest();

void MutexTest();

void tournamentTreeTest();

int global;
int mutex_id;
int lock;
trnmnt_tree *tree;
int openShot;
int cs = 0;

int main(int argc, char *argv[]) {
    int pid;
    if ((pid = fork()) == 0) {
        ThreadTest();
    } else {
        if (pid < 0) {
            printf(1, "Fork failed for thread test");
        } else {
            wait();
        }

    }


    if ((pid = fork()) == 0) {
        MutexTest();
    } else {
        if (pid < 0) {
            printf(1, "Fork failed for mutex test");
        } else {
            wait();
        }

    }

    if ((pid = fork()) == 0) {
        tournamentTreeTest();
    } else {
        if (pid < 0) {
            printf(1, "Fork failed for Tournament Tree test");
        } else {
            wait();
        }

    }
    exit();
}

void foo(void) {
    global = 1;
    kthread_exit();
}

void ThreadTest() {
    int first;
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
    global = 0;
    first = kthread_create(foo, firstStack);
    if (kthread_join(first) == -1 || !global) {
        printf(1, "Waiting failed.\n");
        printf(1, "test thread  failed\n");
        kthread_exit();
    } else {
        printf(1, "Test thread  success\n");
    }

    free(firstStack);

    global = 0;

    exit();
}

void goo(void) {
    int result = kthread_mutex_lock(mutex_id);
    if (result < 0) {
        printf(1, "problem with mutex lock\n");
        kthread_exit();
    }
    int unlock = kthread_mutex_unlock(mutex_id);
    if (unlock < 0) {
        printf(1, "problem with mutex unlock\n");
        kthread_exit();
    }
    global++;
    kthread_exit();
}

void MutexTest() {
    int first, second, third;
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
    void *thirdStack = ((char *) malloc(500 * sizeof(char))) + 500;

    global = 0;
    first = kthread_create(goo, firstStack);
    second = kthread_create(goo, secondStack);
    third = kthread_create(goo, thirdStack);

    if ((mutex_id = kthread_mutex_alloc()) == -1) {
        printf(1, "mutex allocated failed\n");
        kthread_exit();
    }


    if (kthread_join(first) == -1 || kthread_join(second) == -1 || kthread_join(third) == -1 || global != 3) {
        printf(1, "test mutex failed and global = %d.\n", global);
        kthread_exit();
    } else {
        printf(1, "Test mutex success.\n");
    }
    kthread_mutex_dealloc(mutex_id);

    global = 0;
    exit();
}

void koo1() {
    while (openShot);

    if (trnmnt_tree_acquire(tree, 0) < 0) {
        printf(1, "trnmnt_tree locked unsuccessfully\n");
    }

    cs = 1;
    sleep(400);

    if (cs != 1) {
        printf(1, "mutual exclusion failed by %d\n", cs);
    }

    if (trnmnt_tree_release(tree, 0) < 0) {
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
    }

    kthread_exit();
}

void koo2() {
    while (openShot);
    sleep(200);

    if (trnmnt_tree_acquire(tree, 1) < 0) {
        printf(1, "trnmnt_tree locked unsuccessfully\n");
    }
    cs = -1;
    if (trnmnt_tree_release(tree, 1) < 0) {
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
    }
    kthread_exit();
}

void tournamentTreeTest() {
    openShot = 1;
    int first, second;

    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;

    if ((tree = trnmnt_tree_alloc(1)) == 0) {
        printf(1, "trnmnt_tree allocated unsuccessfully\n");
    }
    first = kthread_create(koo1, firstStack);
    second = kthread_create(koo2, secondStack);

    openShot = 0;

    if (kthread_join(first) == -1 || kthread_join(second) == -1 || cs != -1) {
        printf(1, "Test tournamentTreeTest failed\n");

    } else {
        printf(1, "Test tournamentTreeTest success\n");
    }

    if (trnmnt_tree_dealloc(tree) == -1) {
        printf(1, "trnmnt_tree deallocated unsuccessfully\n");
    }
    exit();
}

