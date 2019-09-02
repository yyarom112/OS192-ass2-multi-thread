

typedef struct trnmnt_tree{
    int Lock;
    int* mutextree;
    int* threadMap;
    int depth;
}trnmnt_tree;




struct trnmnt_tree* trnmnt_tree_alloc(int depth);
int trnmnt_tree_dealloc(struct trnmnt_tree* tree);
int trnmnt_tree_acquire(struct trnmnt_tree* tree,int ID);
int trnmnt_tree_release(struct trnmnt_tree* tree,int ID);