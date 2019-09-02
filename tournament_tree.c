#include "types.h"
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
    int init = 2;
    int output = 1;
    while (exp != 0) {
        output *= init;
        exp--;
    }
    return output;
}

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
    int i;
    if (depth <= 0 || depth > 6)
        return 0;
    int treeSize = powordepth(depth) - 1;

    //depth field
    output->depth = depth;

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
        output->mutextree[i] = kthread_mutex_alloc();

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
            initCheck = 1;
    }
    if (initCheck) {
        for (int i = 0; i < treeSize; i++) {
            kthread_mutex_dealloc(output->mutextree[i]);
        }
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
        for (int i = 0; i < treeSize; i++) {
            kthread_mutex_dealloc(output->mutextree[i]);
        }
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
        output->threadMap[i] = -1;

    return output;
}

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
    int i;
    kthread_mutex_lock(tree->Lock);
    int treeSize = powordepth(tree->depth) - 1;
    for (i = 0; i < powordepth(tree->depth); i++) {
        if (tree->threadMap[i] != -1){
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    kthread_mutex_unlock(tree->Lock);
    kthread_mutex_dealloc(tree->Lock);
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
        return -1;
    }
    kthread_mutex_lock(tree->Lock);

    if (tree->threadMap[ID] != -1) {
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
    kthread_mutex_unlock(tree->Lock);
    treePosition = (powordepth(tree->depth) - 1) + ID;
    fatherPosition = (treePosition - 1) / 2;
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
    }
    return 0;
}

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
    int fatherPosition = (position - 1) / 2;
    if (fatherPosition != 0){
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
}


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
    kthread_mutex_lock(tree->Lock);
    if (tree->threadMap[ID] != kthread_id()) {
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
    kthread_mutex_unlock(tree->Lock);
    return 0;
}




