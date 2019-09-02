
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int lock;
trnmnt_tree *tree;
int openShot;
int cs = 0;

int main(int argc, char *argv[]) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
    int pid;
    if ((pid = fork()) == 0) {
      11:	e8 c4 07 00 00       	call   7da <fork>
      16:	85 c0                	test   %eax,%eax
      18:	74 3f                	je     59 <main+0x59>
        ThreadTest();
    } else {
        if (pid < 0) {
      1a:	78 2a                	js     46 <main+0x46>
            printf(1, "Fork failed for thread test");
        } else {
            wait();
      1c:	e8 c9 07 00 00       	call   7ea <wait>
        }

    }


    if ((pid = fork()) == 0) {
      21:	e8 b4 07 00 00       	call   7da <fork>
      26:	85 c0                	test   %eax,%eax
      28:	74 34                	je     5e <main+0x5e>
        MutexTest();
    } else {
        if (pid < 0) {
      2a:	78 4a                	js     76 <main+0x76>
            printf(1, "Fork failed for mutex test");
        } else {
            wait();
      2c:	e8 b9 07 00 00       	call   7ea <wait>
        }

    }

    if ((pid = fork()) == 0) {
      31:	e8 a4 07 00 00       	call   7da <fork>
      36:	85 c0                	test   %eax,%eax
      38:	74 4f                	je     89 <main+0x89>
        tournamentTreeTest();
    } else {
        if (pid < 0) {
      3a:	78 27                	js     63 <main+0x63>
            printf(1, "Fork failed for Tournament Tree test");
        } else {
            wait();
      3c:	e8 a9 07 00 00       	call   7ea <wait>
        }

    }
    exit();
      41:	e8 9c 07 00 00       	call   7e2 <exit>
            printf(1, "Fork failed for thread test");
      46:	51                   	push   %ecx
      47:	51                   	push   %ecx
      48:	68 75 12 00 00       	push   $0x1275
      4d:	6a 01                	push   $0x1
      4f:	e8 1c 09 00 00       	call   970 <printf>
      54:	83 c4 10             	add    $0x10,%esp
      57:	eb c8                	jmp    21 <main+0x21>
        ThreadTest();
      59:	e8 42 02 00 00       	call   2a0 <ThreadTest>
        MutexTest();
      5e:	e8 dd 02 00 00       	call   340 <MutexTest>
            printf(1, "Fork failed for Tournament Tree test");
      63:	50                   	push   %eax
      64:	50                   	push   %eax
      65:	68 d0 13 00 00       	push   $0x13d0
      6a:	6a 01                	push   $0x1
      6c:	e8 ff 08 00 00       	call   970 <printf>
      71:	83 c4 10             	add    $0x10,%esp
      74:	eb cb                	jmp    41 <main+0x41>
            printf(1, "Fork failed for mutex test");
      76:	52                   	push   %edx
      77:	52                   	push   %edx
      78:	68 91 12 00 00       	push   $0x1291
      7d:	6a 01                	push   $0x1
      7f:	e8 ec 08 00 00       	call   970 <printf>
      84:	83 c4 10             	add    $0x10,%esp
      87:	eb a8                	jmp    31 <main+0x31>
        tournamentTreeTest();
      89:	e8 f2 03 00 00       	call   480 <tournamentTreeTest>
      8e:	66 90                	xchg   %ax,%ax

00000090 <foo>:
}

void foo(void) {
      90:	55                   	push   %ebp
    global = 1;
      91:	c7 05 14 19 00 00 01 	movl   $0x1,0x1914
      98:	00 00 00 
void foo(void) {
      9b:	89 e5                	mov    %esp,%ebp
    kthread_exit();
}
      9d:	5d                   	pop    %ebp
    kthread_exit();
      9e:	e9 ef 07 00 00       	jmp    892 <kthread_exit>
      a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <goo>:
    global = 0;

    exit();
}

void goo(void) {
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	83 ec 14             	sub    $0x14,%esp
    int result = kthread_mutex_lock(mutex_id);
      b6:	ff 35 20 19 00 00    	pushl  0x1920
      bc:	e8 f1 07 00 00       	call   8b2 <kthread_mutex_lock>
    if (result < 0) {
      c1:	83 c4 10             	add    $0x10,%esp
      c4:	85 c0                	test   %eax,%eax
      c6:	78 50                	js     118 <goo+0x68>
        printf(1, "problem with mutex lock\n");
        kthread_exit();
    }
    int unlock = kthread_mutex_unlock(mutex_id);
      c8:	83 ec 0c             	sub    $0xc,%esp
      cb:	ff 35 20 19 00 00    	pushl  0x1920
      d1:	e8 e4 07 00 00       	call   8ba <kthread_mutex_unlock>
    if (unlock < 0) {
      d6:	83 c4 10             	add    $0x10,%esp
      d9:	85 c0                	test   %eax,%eax
      db:	78 13                	js     f0 <goo+0x40>
        printf(1, "problem with mutex unlock\n");
        kthread_exit();
    }
    global++;
      dd:	83 05 14 19 00 00 01 	addl   $0x1,0x1914
    kthread_exit();
}
      e4:	c9                   	leave  
    kthread_exit();
      e5:	e9 a8 07 00 00       	jmp    892 <kthread_exit>
      ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "problem with mutex unlock\n");
      f0:	83 ec 08             	sub    $0x8,%esp
      f3:	68 f1 11 00 00       	push   $0x11f1
      f8:	6a 01                	push   $0x1
      fa:	e8 71 08 00 00       	call   970 <printf>
        kthread_exit();
      ff:	e8 8e 07 00 00       	call   892 <kthread_exit>
    global++;
     104:	83 05 14 19 00 00 01 	addl   $0x1,0x1914
        kthread_exit();
     10b:	83 c4 10             	add    $0x10,%esp
}
     10e:	c9                   	leave  
    kthread_exit();
     10f:	e9 7e 07 00 00       	jmp    892 <kthread_exit>
     114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "problem with mutex lock\n");
     118:	83 ec 08             	sub    $0x8,%esp
     11b:	68 d8 11 00 00       	push   $0x11d8
     120:	6a 01                	push   $0x1
     122:	e8 49 08 00 00       	call   970 <printf>
        kthread_exit();
     127:	e8 66 07 00 00       	call   892 <kthread_exit>
     12c:	83 c4 10             	add    $0x10,%esp
     12f:	eb 97                	jmp    c8 <goo+0x18>
     131:	eb 0d                	jmp    140 <koo1>
     133:	90                   	nop
     134:	90                   	nop
     135:	90                   	nop
     136:	90                   	nop
     137:	90                   	nop
     138:	90                   	nop
     139:	90                   	nop
     13a:	90                   	nop
     13b:	90                   	nop
     13c:	90                   	nop
     13d:	90                   	nop
     13e:	90                   	nop
     13f:	90                   	nop

00000140 <koo1>:

    global = 0;
    exit();
}

void koo1() {
     140:	55                   	push   %ebp
     141:	89 e5                	mov    %esp,%ebp
     143:	83 ec 08             	sub    $0x8,%esp
    while (openShot);
     146:	a1 18 19 00 00       	mov    0x1918,%eax
     14b:	90                   	nop
     14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     150:	85 c0                	test   %eax,%eax
     152:	75 fc                	jne    150 <koo1+0x10>

    if (trnmnt_tree_acquire(tree, 0) < 0) {
     154:	83 ec 08             	sub    $0x8,%esp
     157:	6a 00                	push   $0x0
     159:	ff 35 1c 19 00 00    	pushl  0x191c
     15f:	e8 6c 0e 00 00       	call   fd0 <trnmnt_tree_acquire>
     164:	83 c4 10             	add    $0x10,%esp
     167:	85 c0                	test   %eax,%eax
     169:	78 75                	js     1e0 <koo1+0xa0>
        printf(1, "trnmnt_tree locked unsuccessfully\n");
    }

    cs = 1;
    sleep(400);
     16b:	83 ec 0c             	sub    $0xc,%esp
    cs = 1;
     16e:	c7 05 00 19 00 00 01 	movl   $0x1,0x1900
     175:	00 00 00 
    sleep(400);
     178:	68 90 01 00 00       	push   $0x190
     17d:	e8 f0 06 00 00       	call   872 <sleep>

    if (cs != 1) {
     182:	a1 00 19 00 00       	mov    0x1900,%eax
     187:	83 c4 10             	add    $0x10,%esp
     18a:	83 f8 01             	cmp    $0x1,%eax
     18d:	74 13                	je     1a2 <koo1+0x62>
        printf(1, "mutual exclusion failed by %d\n", cs);
     18f:	83 ec 04             	sub    $0x4,%esp
     192:	50                   	push   %eax
     193:	68 d0 12 00 00       	push   $0x12d0
     198:	6a 01                	push   $0x1
     19a:	e8 d1 07 00 00       	call   970 <printf>
     19f:	83 c4 10             	add    $0x10,%esp
    }

    if (trnmnt_tree_release(tree, 0) < 0) {
     1a2:	83 ec 08             	sub    $0x8,%esp
     1a5:	6a 00                	push   $0x0
     1a7:	ff 35 1c 19 00 00    	pushl  0x191c
     1ad:	e8 7e 0f 00 00       	call   1130 <trnmnt_tree_release>
     1b2:	83 c4 10             	add    $0x10,%esp
     1b5:	85 c0                	test   %eax,%eax
     1b7:	78 07                	js     1c0 <koo1+0x80>
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
    }

    kthread_exit();
}
     1b9:	c9                   	leave  
    kthread_exit();
     1ba:	e9 d3 06 00 00       	jmp    892 <kthread_exit>
     1bf:	90                   	nop
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
     1c0:	83 ec 08             	sub    $0x8,%esp
     1c3:	68 f0 12 00 00       	push   $0x12f0
     1c8:	6a 01                	push   $0x1
     1ca:	e8 a1 07 00 00       	call   970 <printf>
     1cf:	83 c4 10             	add    $0x10,%esp
}
     1d2:	c9                   	leave  
    kthread_exit();
     1d3:	e9 ba 06 00 00       	jmp    892 <kthread_exit>
     1d8:	90                   	nop
     1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "trnmnt_tree locked unsuccessfully\n");
     1e0:	83 ec 08             	sub    $0x8,%esp
     1e3:	68 ac 12 00 00       	push   $0x12ac
     1e8:	6a 01                	push   $0x1
     1ea:	e8 81 07 00 00       	call   970 <printf>
     1ef:	83 c4 10             	add    $0x10,%esp
     1f2:	e9 74 ff ff ff       	jmp    16b <koo1+0x2b>
     1f7:	89 f6                	mov    %esi,%esi
     1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <koo2>:

void koo2() {
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 08             	sub    $0x8,%esp
    while (openShot);
     206:	a1 18 19 00 00       	mov    0x1918,%eax
     20b:	90                   	nop
     20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     210:	85 c0                	test   %eax,%eax
     212:	75 fc                	jne    210 <koo2+0x10>
    sleep(200);
     214:	83 ec 0c             	sub    $0xc,%esp
     217:	68 c8 00 00 00       	push   $0xc8
     21c:	e8 51 06 00 00       	call   872 <sleep>

    if (trnmnt_tree_acquire(tree, 1) < 0) {
     221:	58                   	pop    %eax
     222:	5a                   	pop    %edx
     223:	6a 01                	push   $0x1
     225:	ff 35 1c 19 00 00    	pushl  0x191c
     22b:	e8 a0 0d 00 00       	call   fd0 <trnmnt_tree_acquire>
     230:	83 c4 10             	add    $0x10,%esp
     233:	85 c0                	test   %eax,%eax
     235:	78 49                	js     280 <koo2+0x80>
        printf(1, "trnmnt_tree locked unsuccessfully\n");
    }
    cs = -1;
    if (trnmnt_tree_release(tree, 1) < 0) {
     237:	83 ec 08             	sub    $0x8,%esp
    cs = -1;
     23a:	c7 05 00 19 00 00 ff 	movl   $0xffffffff,0x1900
     241:	ff ff ff 
    if (trnmnt_tree_release(tree, 1) < 0) {
     244:	6a 01                	push   $0x1
     246:	ff 35 1c 19 00 00    	pushl  0x191c
     24c:	e8 df 0e 00 00       	call   1130 <trnmnt_tree_release>
     251:	83 c4 10             	add    $0x10,%esp
     254:	85 c0                	test   %eax,%eax
     256:	78 08                	js     260 <koo2+0x60>
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
    }
    kthread_exit();
}
     258:	c9                   	leave  
    kthread_exit();
     259:	e9 34 06 00 00       	jmp    892 <kthread_exit>
     25e:	66 90                	xchg   %ax,%ax
        printf(1, "trnmnt_tree unlocked unsuccessfully\n");
     260:	83 ec 08             	sub    $0x8,%esp
     263:	68 f0 12 00 00       	push   $0x12f0
     268:	6a 01                	push   $0x1
     26a:	e8 01 07 00 00       	call   970 <printf>
     26f:	83 c4 10             	add    $0x10,%esp
}
     272:	c9                   	leave  
    kthread_exit();
     273:	e9 1a 06 00 00       	jmp    892 <kthread_exit>
     278:	90                   	nop
     279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "trnmnt_tree locked unsuccessfully\n");
     280:	83 ec 08             	sub    $0x8,%esp
     283:	68 ac 12 00 00       	push   $0x12ac
     288:	6a 01                	push   $0x1
     28a:	e8 e1 06 00 00       	call   970 <printf>
     28f:	83 c4 10             	add    $0x10,%esp
     292:	eb a3                	jmp    237 <koo2+0x37>
     294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <ThreadTest>:
void ThreadTest() {
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	53                   	push   %ebx
     2a4:	83 ec 10             	sub    $0x10,%esp
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     2a7:	68 f4 01 00 00       	push   $0x1f4
     2ac:	e8 1f 09 00 00       	call   bd0 <malloc>
     2b1:	8d 98 f4 01 00 00    	lea    0x1f4(%eax),%ebx
    global = 0;
     2b7:	c7 05 14 19 00 00 00 	movl   $0x0,0x1914
     2be:	00 00 00 
    first = kthread_create(foo, firstStack);
     2c1:	58                   	pop    %eax
     2c2:	5a                   	pop    %edx
     2c3:	53                   	push   %ebx
     2c4:	68 90 00 00 00       	push   $0x90
     2c9:	e8 b4 05 00 00       	call   882 <kthread_create>
    if (kthread_join(first) == -1 || !global) {
     2ce:	89 04 24             	mov    %eax,(%esp)
     2d1:	e8 c4 05 00 00       	call   89a <kthread_join>
     2d6:	83 c4 10             	add    $0x10,%esp
     2d9:	83 f8 ff             	cmp    $0xffffffff,%eax
     2dc:	74 09                	je     2e7 <ThreadTest+0x47>
     2de:	a1 14 19 00 00       	mov    0x1914,%eax
     2e3:	85 c0                	test   %eax,%eax
     2e5:	75 3d                	jne    324 <ThreadTest+0x84>
        printf(1, "Waiting failed.\n");
     2e7:	83 ec 08             	sub    $0x8,%esp
     2ea:	68 0c 12 00 00       	push   $0x120c
     2ef:	6a 01                	push   $0x1
     2f1:	e8 7a 06 00 00       	call   970 <printf>
        printf(1, "test thread  failed\n");
     2f6:	5a                   	pop    %edx
     2f7:	59                   	pop    %ecx
     2f8:	68 1d 12 00 00       	push   $0x121d
     2fd:	6a 01                	push   $0x1
     2ff:	e8 6c 06 00 00       	call   970 <printf>
        kthread_exit();
     304:	e8 89 05 00 00       	call   892 <kthread_exit>
     309:	83 c4 10             	add    $0x10,%esp
    free(firstStack);
     30c:	83 ec 0c             	sub    $0xc,%esp
     30f:	53                   	push   %ebx
     310:	e8 2b 08 00 00       	call   b40 <free>
    global = 0;
     315:	c7 05 14 19 00 00 00 	movl   $0x0,0x1914
     31c:	00 00 00 
    exit();
     31f:	e8 be 04 00 00       	call   7e2 <exit>
        printf(1, "Test thread  success\n");
     324:	50                   	push   %eax
     325:	50                   	push   %eax
     326:	68 32 12 00 00       	push   $0x1232
     32b:	6a 01                	push   $0x1
     32d:	e8 3e 06 00 00       	call   970 <printf>
     332:	83 c4 10             	add    $0x10,%esp
     335:	eb d5                	jmp    30c <ThreadTest+0x6c>
     337:	89 f6                	mov    %esi,%esi
     339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <MutexTest>:
void MutexTest() {
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	57                   	push   %edi
     344:	56                   	push   %esi
     345:	53                   	push   %ebx
     346:	83 ec 18             	sub    $0x18,%esp
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     349:	68 f4 01 00 00       	push   $0x1f4
     34e:	e8 7d 08 00 00       	call   bd0 <malloc>
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     353:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     35a:	89 c6                	mov    %eax,%esi
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     35c:	e8 6f 08 00 00       	call   bd0 <malloc>
    void *thirdStack = ((char *) malloc(500 * sizeof(char))) + 500;
     361:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     368:	89 c7                	mov    %eax,%edi
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     36a:	81 c6 f4 01 00 00    	add    $0x1f4,%esi
    void *thirdStack = ((char *) malloc(500 * sizeof(char))) + 500;
     370:	e8 5b 08 00 00       	call   bd0 <malloc>
    first = kthread_create(goo, firstStack);
     375:	59                   	pop    %ecx
    void *thirdStack = ((char *) malloc(500 * sizeof(char))) + 500;
     376:	89 c3                	mov    %eax,%ebx
    global = 0;
     378:	c7 05 14 19 00 00 00 	movl   $0x0,0x1914
     37f:	00 00 00 
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     382:	81 c7 f4 01 00 00    	add    $0x1f4,%edi
    first = kthread_create(goo, firstStack);
     388:	58                   	pop    %eax
     389:	56                   	push   %esi
     38a:	68 b0 00 00 00       	push   $0xb0
    void *thirdStack = ((char *) malloc(500 * sizeof(char))) + 500;
     38f:	81 c3 f4 01 00 00    	add    $0x1f4,%ebx
    first = kthread_create(goo, firstStack);
     395:	e8 e8 04 00 00       	call   882 <kthread_create>
     39a:	89 c6                	mov    %eax,%esi
    second = kthread_create(goo, secondStack);
     39c:	58                   	pop    %eax
     39d:	5a                   	pop    %edx
     39e:	57                   	push   %edi
     39f:	68 b0 00 00 00       	push   $0xb0
     3a4:	e8 d9 04 00 00       	call   882 <kthread_create>
    third = kthread_create(goo, thirdStack);
     3a9:	59                   	pop    %ecx
    second = kthread_create(goo, secondStack);
     3aa:	89 c7                	mov    %eax,%edi
    third = kthread_create(goo, thirdStack);
     3ac:	58                   	pop    %eax
     3ad:	53                   	push   %ebx
     3ae:	68 b0 00 00 00       	push   $0xb0
     3b3:	e8 ca 04 00 00       	call   882 <kthread_create>
     3b8:	89 c3                	mov    %eax,%ebx
    if ((mutex_id = kthread_mutex_alloc()) == -1) {
     3ba:	e8 e3 04 00 00       	call   8a2 <kthread_mutex_alloc>
     3bf:	83 c4 10             	add    $0x10,%esp
     3c2:	83 f8 ff             	cmp    $0xffffffff,%eax
     3c5:	a3 20 19 00 00       	mov    %eax,0x1920
     3ca:	0f 84 89 00 00 00    	je     459 <MutexTest+0x119>
    if (kthread_join(first) == -1 || kthread_join(second) == -1 || kthread_join(third) == -1 || global != 3) {
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	56                   	push   %esi
     3d4:	e8 c1 04 00 00       	call   89a <kthread_join>
     3d9:	83 c4 10             	add    $0x10,%esp
     3dc:	83 f8 ff             	cmp    $0xffffffff,%eax
     3df:	74 11                	je     3f2 <MutexTest+0xb2>
     3e1:	83 ec 0c             	sub    $0xc,%esp
     3e4:	57                   	push   %edi
     3e5:	e8 b0 04 00 00       	call   89a <kthread_join>
     3ea:	83 c4 10             	add    $0x10,%esp
     3ed:	83 c0 01             	add    $0x1,%eax
     3f0:	75 3a                	jne    42c <MutexTest+0xec>
        printf(1, "test mutex failed and global = %d.\n", global);
     3f2:	83 ec 04             	sub    $0x4,%esp
     3f5:	ff 35 14 19 00 00    	pushl  0x1914
     3fb:	68 18 13 00 00       	push   $0x1318
     400:	6a 01                	push   $0x1
     402:	e8 69 05 00 00       	call   970 <printf>
        kthread_exit();
     407:	e8 86 04 00 00       	call   892 <kthread_exit>
     40c:	83 c4 10             	add    $0x10,%esp
    kthread_mutex_dealloc(mutex_id);
     40f:	83 ec 0c             	sub    $0xc,%esp
     412:	ff 35 20 19 00 00    	pushl  0x1920
     418:	e8 8d 04 00 00       	call   8aa <kthread_mutex_dealloc>
    global = 0;
     41d:	c7 05 14 19 00 00 00 	movl   $0x0,0x1914
     424:	00 00 00 
    exit();
     427:	e8 b6 03 00 00       	call   7e2 <exit>
    if (kthread_join(first) == -1 || kthread_join(second) == -1 || kthread_join(third) == -1 || global != 3) {
     42c:	83 ec 0c             	sub    $0xc,%esp
     42f:	53                   	push   %ebx
     430:	e8 65 04 00 00       	call   89a <kthread_join>
     435:	83 c4 10             	add    $0x10,%esp
     438:	83 c0 01             	add    $0x1,%eax
     43b:	74 b5                	je     3f2 <MutexTest+0xb2>
     43d:	83 3d 14 19 00 00 03 	cmpl   $0x3,0x1914
     444:	75 ac                	jne    3f2 <MutexTest+0xb2>
        printf(1, "Test mutex success.\n");
     446:	50                   	push   %eax
     447:	50                   	push   %eax
     448:	68 60 12 00 00       	push   $0x1260
     44d:	6a 01                	push   $0x1
     44f:	e8 1c 05 00 00       	call   970 <printf>
     454:	83 c4 10             	add    $0x10,%esp
     457:	eb b6                	jmp    40f <MutexTest+0xcf>
        printf(1, "mutex allocated failed\n");
     459:	52                   	push   %edx
     45a:	52                   	push   %edx
     45b:	68 48 12 00 00       	push   $0x1248
     460:	6a 01                	push   $0x1
     462:	e8 09 05 00 00       	call   970 <printf>
        kthread_exit();
     467:	e8 26 04 00 00       	call   892 <kthread_exit>
     46c:	83 c4 10             	add    $0x10,%esp
     46f:	e9 5c ff ff ff       	jmp    3d0 <MutexTest+0x90>
     474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     47a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000480 <tournamentTreeTest>:

void tournamentTreeTest() {
     480:	55                   	push   %ebp
    openShot = 1;
     481:	c7 05 18 19 00 00 01 	movl   $0x1,0x1918
     488:	00 00 00 
void tournamentTreeTest() {
     48b:	89 e5                	mov    %esp,%ebp
     48d:	56                   	push   %esi
     48e:	53                   	push   %ebx
    int first, second;

    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     48f:	83 ec 0c             	sub    $0xc,%esp
     492:	68 f4 01 00 00       	push   $0x1f4
     497:	e8 34 07 00 00       	call   bd0 <malloc>
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     49c:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
    void *firstStack = ((char *) malloc(500 * sizeof(char))) + 500;
     4a3:	8d b0 f4 01 00 00    	lea    0x1f4(%eax),%esi
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     4a9:	e8 22 07 00 00       	call   bd0 <malloc>

    if ((tree = trnmnt_tree_alloc(1)) == 0) {
     4ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    void *secondStack = ((char *) malloc(500 * sizeof(char))) + 500;
     4b5:	8d 98 f4 01 00 00    	lea    0x1f4(%eax),%ebx
    if ((tree = trnmnt_tree_alloc(1)) == 0) {
     4bb:	e8 30 08 00 00       	call   cf0 <trnmnt_tree_alloc>
     4c0:	83 c4 10             	add    $0x10,%esp
     4c3:	85 c0                	test   %eax,%eax
     4c5:	a3 1c 19 00 00       	mov    %eax,0x191c
     4ca:	0f 84 a6 00 00 00    	je     576 <tournamentTreeTest+0xf6>
        printf(1, "trnmnt_tree allocated unsuccessfully\n");
    }
    first = kthread_create(koo1, firstStack);
     4d0:	83 ec 08             	sub    $0x8,%esp
     4d3:	56                   	push   %esi
     4d4:	68 40 01 00 00       	push   $0x140
     4d9:	e8 a4 03 00 00       	call   882 <kthread_create>
    second = kthread_create(koo2, secondStack);
     4de:	59                   	pop    %ecx
    first = kthread_create(koo1, firstStack);
     4df:	89 c6                	mov    %eax,%esi
    second = kthread_create(koo2, secondStack);
     4e1:	58                   	pop    %eax
     4e2:	53                   	push   %ebx
     4e3:	68 00 02 00 00       	push   $0x200
     4e8:	e8 95 03 00 00       	call   882 <kthread_create>

    openShot = 0;

    if (kthread_join(first) == -1 || kthread_join(second) == -1 || cs != -1) {
     4ed:	89 34 24             	mov    %esi,(%esp)
    second = kthread_create(koo2, secondStack);
     4f0:	89 c3                	mov    %eax,%ebx
    openShot = 0;
     4f2:	c7 05 18 19 00 00 00 	movl   $0x0,0x1918
     4f9:	00 00 00 
    if (kthread_join(first) == -1 || kthread_join(second) == -1 || cs != -1) {
     4fc:	e8 99 03 00 00       	call   89a <kthread_join>
     501:	83 c4 10             	add    $0x10,%esp
     504:	83 f8 ff             	cmp    $0xffffffff,%eax
     507:	74 1a                	je     523 <tournamentTreeTest+0xa3>
     509:	83 ec 0c             	sub    $0xc,%esp
     50c:	53                   	push   %ebx
     50d:	e8 88 03 00 00       	call   89a <kthread_join>
     512:	83 c4 10             	add    $0x10,%esp
     515:	83 c0 01             	add    $0x1,%eax
     518:	74 09                	je     523 <tournamentTreeTest+0xa3>
     51a:	83 3d 00 19 00 00 ff 	cmpl   $0xffffffff,0x1900
     521:	74 40                	je     563 <tournamentTreeTest+0xe3>
        printf(1, "Test tournamentTreeTest failed\n");
     523:	83 ec 08             	sub    $0x8,%esp
     526:	68 64 13 00 00       	push   $0x1364
     52b:	6a 01                	push   $0x1
     52d:	e8 3e 04 00 00       	call   970 <printf>
     532:	83 c4 10             	add    $0x10,%esp

    } else {
        printf(1, "Test tournamentTreeTest success\n");
    }

    if (trnmnt_tree_dealloc(tree) == -1) {
     535:	83 ec 0c             	sub    $0xc,%esp
     538:	ff 35 1c 19 00 00    	pushl  0x191c
     53e:	e8 4d 09 00 00       	call   e90 <trnmnt_tree_dealloc>
     543:	83 c4 10             	add    $0x10,%esp
     546:	83 f8 ff             	cmp    $0xffffffff,%eax
     549:	74 05                	je     550 <tournamentTreeTest+0xd0>
        printf(1, "trnmnt_tree deallocated unsuccessfully\n");
    }
    exit();
     54b:	e8 92 02 00 00       	call   7e2 <exit>
        printf(1, "trnmnt_tree deallocated unsuccessfully\n");
     550:	50                   	push   %eax
     551:	50                   	push   %eax
     552:	68 a8 13 00 00       	push   $0x13a8
     557:	6a 01                	push   $0x1
     559:	e8 12 04 00 00       	call   970 <printf>
     55e:	83 c4 10             	add    $0x10,%esp
     561:	eb e8                	jmp    54b <tournamentTreeTest+0xcb>
        printf(1, "Test tournamentTreeTest success\n");
     563:	52                   	push   %edx
     564:	52                   	push   %edx
     565:	68 84 13 00 00       	push   $0x1384
     56a:	6a 01                	push   $0x1
     56c:	e8 ff 03 00 00       	call   970 <printf>
     571:	83 c4 10             	add    $0x10,%esp
     574:	eb bf                	jmp    535 <tournamentTreeTest+0xb5>
        printf(1, "trnmnt_tree allocated unsuccessfully\n");
     576:	50                   	push   %eax
     577:	50                   	push   %eax
     578:	68 3c 13 00 00       	push   $0x133c
     57d:	6a 01                	push   $0x1
     57f:	e8 ec 03 00 00       	call   970 <printf>
     584:	83 c4 10             	add    $0x10,%esp
     587:	e9 44 ff ff ff       	jmp    4d0 <tournamentTreeTest+0x50>
     58c:	66 90                	xchg   %ax,%ax
     58e:	66 90                	xchg   %ax,%ax

00000590 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	53                   	push   %ebx
     594:	8b 45 08             	mov    0x8(%ebp),%eax
     597:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     59a:	89 c2                	mov    %eax,%edx
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     5a0:	83 c1 01             	add    $0x1,%ecx
     5a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     5a7:	83 c2 01             	add    $0x1,%edx
     5aa:	84 db                	test   %bl,%bl
     5ac:	88 5a ff             	mov    %bl,-0x1(%edx)
     5af:	75 ef                	jne    5a0 <strcpy+0x10>
    ;
  return os;
}
     5b1:	5b                   	pop    %ebx
     5b2:	5d                   	pop    %ebp
     5b3:	c3                   	ret    
     5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	53                   	push   %ebx
     5c4:	8b 55 08             	mov    0x8(%ebp),%edx
     5c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     5ca:	0f b6 02             	movzbl (%edx),%eax
     5cd:	0f b6 19             	movzbl (%ecx),%ebx
     5d0:	84 c0                	test   %al,%al
     5d2:	75 1c                	jne    5f0 <strcmp+0x30>
     5d4:	eb 2a                	jmp    600 <strcmp+0x40>
     5d6:	8d 76 00             	lea    0x0(%esi),%esi
     5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     5e0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     5e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     5e6:	83 c1 01             	add    $0x1,%ecx
     5e9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     5ec:	84 c0                	test   %al,%al
     5ee:	74 10                	je     600 <strcmp+0x40>
     5f0:	38 d8                	cmp    %bl,%al
     5f2:	74 ec                	je     5e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     5f4:	29 d8                	sub    %ebx,%eax
}
     5f6:	5b                   	pop    %ebx
     5f7:	5d                   	pop    %ebp
     5f8:	c3                   	ret    
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     600:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     602:	29 d8                	sub    %ebx,%eax
}
     604:	5b                   	pop    %ebx
     605:	5d                   	pop    %ebp
     606:	c3                   	ret    
     607:	89 f6                	mov    %esi,%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000610 <strlen>:

uint
strlen(const char *s)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     616:	80 39 00             	cmpb   $0x0,(%ecx)
     619:	74 15                	je     630 <strlen+0x20>
     61b:	31 d2                	xor    %edx,%edx
     61d:	8d 76 00             	lea    0x0(%esi),%esi
     620:	83 c2 01             	add    $0x1,%edx
     623:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     627:	89 d0                	mov    %edx,%eax
     629:	75 f5                	jne    620 <strlen+0x10>
    ;
  return n;
}
     62b:	5d                   	pop    %ebp
     62c:	c3                   	ret    
     62d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     630:	31 c0                	xor    %eax,%eax
}
     632:	5d                   	pop    %ebp
     633:	c3                   	ret    
     634:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     63a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000640 <memset>:

void*
memset(void *dst, int c, uint n)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     647:	8b 4d 10             	mov    0x10(%ebp),%ecx
     64a:	8b 45 0c             	mov    0xc(%ebp),%eax
     64d:	89 d7                	mov    %edx,%edi
     64f:	fc                   	cld    
     650:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     652:	89 d0                	mov    %edx,%eax
     654:	5f                   	pop    %edi
     655:	5d                   	pop    %ebp
     656:	c3                   	ret    
     657:	89 f6                	mov    %esi,%esi
     659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <strchr>:

char*
strchr(const char *s, char c)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	53                   	push   %ebx
     664:	8b 45 08             	mov    0x8(%ebp),%eax
     667:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     66a:	0f b6 10             	movzbl (%eax),%edx
     66d:	84 d2                	test   %dl,%dl
     66f:	74 1d                	je     68e <strchr+0x2e>
    if(*s == c)
     671:	38 d3                	cmp    %dl,%bl
     673:	89 d9                	mov    %ebx,%ecx
     675:	75 0d                	jne    684 <strchr+0x24>
     677:	eb 17                	jmp    690 <strchr+0x30>
     679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     680:	38 ca                	cmp    %cl,%dl
     682:	74 0c                	je     690 <strchr+0x30>
  for(; *s; s++)
     684:	83 c0 01             	add    $0x1,%eax
     687:	0f b6 10             	movzbl (%eax),%edx
     68a:	84 d2                	test   %dl,%dl
     68c:	75 f2                	jne    680 <strchr+0x20>
      return (char*)s;
  return 0;
     68e:	31 c0                	xor    %eax,%eax
}
     690:	5b                   	pop    %ebx
     691:	5d                   	pop    %ebp
     692:	c3                   	ret    
     693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <gets>:

char*
gets(char *buf, int max)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	57                   	push   %edi
     6a4:	56                   	push   %esi
     6a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     6a6:	31 f6                	xor    %esi,%esi
     6a8:	89 f3                	mov    %esi,%ebx
{
     6aa:	83 ec 1c             	sub    $0x1c,%esp
     6ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     6b0:	eb 2f                	jmp    6e1 <gets+0x41>
     6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     6b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     6bb:	83 ec 04             	sub    $0x4,%esp
     6be:	6a 01                	push   $0x1
     6c0:	50                   	push   %eax
     6c1:	6a 00                	push   $0x0
     6c3:	e8 32 01 00 00       	call   7fa <read>
    if(cc < 1)
     6c8:	83 c4 10             	add    $0x10,%esp
     6cb:	85 c0                	test   %eax,%eax
     6cd:	7e 1c                	jle    6eb <gets+0x4b>
      break;
    buf[i++] = c;
     6cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     6d3:	83 c7 01             	add    $0x1,%edi
     6d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     6d9:	3c 0a                	cmp    $0xa,%al
     6db:	74 23                	je     700 <gets+0x60>
     6dd:	3c 0d                	cmp    $0xd,%al
     6df:	74 1f                	je     700 <gets+0x60>
  for(i=0; i+1 < max; ){
     6e1:	83 c3 01             	add    $0x1,%ebx
     6e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     6e7:	89 fe                	mov    %edi,%esi
     6e9:	7c cd                	jl     6b8 <gets+0x18>
     6eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     6ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     6f0:	c6 03 00             	movb   $0x0,(%ebx)
}
     6f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6f6:	5b                   	pop    %ebx
     6f7:	5e                   	pop    %esi
     6f8:	5f                   	pop    %edi
     6f9:	5d                   	pop    %ebp
     6fa:	c3                   	ret    
     6fb:	90                   	nop
     6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     700:	8b 75 08             	mov    0x8(%ebp),%esi
     703:	8b 45 08             	mov    0x8(%ebp),%eax
     706:	01 de                	add    %ebx,%esi
     708:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     70a:	c6 03 00             	movb   $0x0,(%ebx)
}
     70d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     710:	5b                   	pop    %ebx
     711:	5e                   	pop    %esi
     712:	5f                   	pop    %edi
     713:	5d                   	pop    %ebp
     714:	c3                   	ret    
     715:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <stat>:

int
stat(const char *n, struct stat *st)
{
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	56                   	push   %esi
     724:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     725:	83 ec 08             	sub    $0x8,%esp
     728:	6a 00                	push   $0x0
     72a:	ff 75 08             	pushl  0x8(%ebp)
     72d:	e8 f0 00 00 00       	call   822 <open>
  if(fd < 0)
     732:	83 c4 10             	add    $0x10,%esp
     735:	85 c0                	test   %eax,%eax
     737:	78 27                	js     760 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     739:	83 ec 08             	sub    $0x8,%esp
     73c:	ff 75 0c             	pushl  0xc(%ebp)
     73f:	89 c3                	mov    %eax,%ebx
     741:	50                   	push   %eax
     742:	e8 f3 00 00 00       	call   83a <fstat>
  close(fd);
     747:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     74a:	89 c6                	mov    %eax,%esi
  close(fd);
     74c:	e8 b9 00 00 00       	call   80a <close>
  return r;
     751:	83 c4 10             	add    $0x10,%esp
}
     754:	8d 65 f8             	lea    -0x8(%ebp),%esp
     757:	89 f0                	mov    %esi,%eax
     759:	5b                   	pop    %ebx
     75a:	5e                   	pop    %esi
     75b:	5d                   	pop    %ebp
     75c:	c3                   	ret    
     75d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     760:	be ff ff ff ff       	mov    $0xffffffff,%esi
     765:	eb ed                	jmp    754 <stat+0x34>
     767:	89 f6                	mov    %esi,%esi
     769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000770 <atoi>:

int
atoi(const char *s)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	53                   	push   %ebx
     774:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     777:	0f be 11             	movsbl (%ecx),%edx
     77a:	8d 42 d0             	lea    -0x30(%edx),%eax
     77d:	3c 09                	cmp    $0x9,%al
  n = 0;
     77f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     784:	77 1f                	ja     7a5 <atoi+0x35>
     786:	8d 76 00             	lea    0x0(%esi),%esi
     789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     790:	8d 04 80             	lea    (%eax,%eax,4),%eax
     793:	83 c1 01             	add    $0x1,%ecx
     796:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     79a:	0f be 11             	movsbl (%ecx),%edx
     79d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     7a0:	80 fb 09             	cmp    $0x9,%bl
     7a3:	76 eb                	jbe    790 <atoi+0x20>
  return n;
}
     7a5:	5b                   	pop    %ebx
     7a6:	5d                   	pop    %ebp
     7a7:	c3                   	ret    
     7a8:	90                   	nop
     7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	56                   	push   %esi
     7b4:	53                   	push   %ebx
     7b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     7b8:	8b 45 08             	mov    0x8(%ebp),%eax
     7bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     7be:	85 db                	test   %ebx,%ebx
     7c0:	7e 14                	jle    7d6 <memmove+0x26>
     7c2:	31 d2                	xor    %edx,%edx
     7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     7c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     7cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     7cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     7d2:	39 d3                	cmp    %edx,%ebx
     7d4:	75 f2                	jne    7c8 <memmove+0x18>
  return vdst;
}
     7d6:	5b                   	pop    %ebx
     7d7:	5e                   	pop    %esi
     7d8:	5d                   	pop    %ebp
     7d9:	c3                   	ret    

000007da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     7da:	b8 01 00 00 00       	mov    $0x1,%eax
     7df:	cd 40                	int    $0x40
     7e1:	c3                   	ret    

000007e2 <exit>:
SYSCALL(exit)
     7e2:	b8 02 00 00 00       	mov    $0x2,%eax
     7e7:	cd 40                	int    $0x40
     7e9:	c3                   	ret    

000007ea <wait>:
SYSCALL(wait)
     7ea:	b8 03 00 00 00       	mov    $0x3,%eax
     7ef:	cd 40                	int    $0x40
     7f1:	c3                   	ret    

000007f2 <pipe>:
SYSCALL(pipe)
     7f2:	b8 04 00 00 00       	mov    $0x4,%eax
     7f7:	cd 40                	int    $0x40
     7f9:	c3                   	ret    

000007fa <read>:
SYSCALL(read)
     7fa:	b8 05 00 00 00       	mov    $0x5,%eax
     7ff:	cd 40                	int    $0x40
     801:	c3                   	ret    

00000802 <write>:
SYSCALL(write)
     802:	b8 10 00 00 00       	mov    $0x10,%eax
     807:	cd 40                	int    $0x40
     809:	c3                   	ret    

0000080a <close>:
SYSCALL(close)
     80a:	b8 15 00 00 00       	mov    $0x15,%eax
     80f:	cd 40                	int    $0x40
     811:	c3                   	ret    

00000812 <kill>:
SYSCALL(kill)
     812:	b8 06 00 00 00       	mov    $0x6,%eax
     817:	cd 40                	int    $0x40
     819:	c3                   	ret    

0000081a <exec>:
SYSCALL(exec)
     81a:	b8 07 00 00 00       	mov    $0x7,%eax
     81f:	cd 40                	int    $0x40
     821:	c3                   	ret    

00000822 <open>:
SYSCALL(open)
     822:	b8 0f 00 00 00       	mov    $0xf,%eax
     827:	cd 40                	int    $0x40
     829:	c3                   	ret    

0000082a <mknod>:
SYSCALL(mknod)
     82a:	b8 11 00 00 00       	mov    $0x11,%eax
     82f:	cd 40                	int    $0x40
     831:	c3                   	ret    

00000832 <unlink>:
SYSCALL(unlink)
     832:	b8 12 00 00 00       	mov    $0x12,%eax
     837:	cd 40                	int    $0x40
     839:	c3                   	ret    

0000083a <fstat>:
SYSCALL(fstat)
     83a:	b8 08 00 00 00       	mov    $0x8,%eax
     83f:	cd 40                	int    $0x40
     841:	c3                   	ret    

00000842 <link>:
SYSCALL(link)
     842:	b8 13 00 00 00       	mov    $0x13,%eax
     847:	cd 40                	int    $0x40
     849:	c3                   	ret    

0000084a <mkdir>:
SYSCALL(mkdir)
     84a:	b8 14 00 00 00       	mov    $0x14,%eax
     84f:	cd 40                	int    $0x40
     851:	c3                   	ret    

00000852 <chdir>:
SYSCALL(chdir)
     852:	b8 09 00 00 00       	mov    $0x9,%eax
     857:	cd 40                	int    $0x40
     859:	c3                   	ret    

0000085a <dup>:
SYSCALL(dup)
     85a:	b8 0a 00 00 00       	mov    $0xa,%eax
     85f:	cd 40                	int    $0x40
     861:	c3                   	ret    

00000862 <getpid>:
SYSCALL(getpid)
     862:	b8 0b 00 00 00       	mov    $0xb,%eax
     867:	cd 40                	int    $0x40
     869:	c3                   	ret    

0000086a <sbrk>:
SYSCALL(sbrk)
     86a:	b8 0c 00 00 00       	mov    $0xc,%eax
     86f:	cd 40                	int    $0x40
     871:	c3                   	ret    

00000872 <sleep>:
SYSCALL(sleep)
     872:	b8 0d 00 00 00       	mov    $0xd,%eax
     877:	cd 40                	int    $0x40
     879:	c3                   	ret    

0000087a <uptime>:
SYSCALL(uptime)
     87a:	b8 0e 00 00 00       	mov    $0xe,%eax
     87f:	cd 40                	int    $0x40
     881:	c3                   	ret    

00000882 <kthread_create>:
SYSCALL(kthread_create)
     882:	b8 16 00 00 00       	mov    $0x16,%eax
     887:	cd 40                	int    $0x40
     889:	c3                   	ret    

0000088a <kthread_id>:
SYSCALL(kthread_id)
     88a:	b8 17 00 00 00       	mov    $0x17,%eax
     88f:	cd 40                	int    $0x40
     891:	c3                   	ret    

00000892 <kthread_exit>:
SYSCALL(kthread_exit)
     892:	b8 18 00 00 00       	mov    $0x18,%eax
     897:	cd 40                	int    $0x40
     899:	c3                   	ret    

0000089a <kthread_join>:
SYSCALL(kthread_join)
     89a:	b8 19 00 00 00       	mov    $0x19,%eax
     89f:	cd 40                	int    $0x40
     8a1:	c3                   	ret    

000008a2 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
     8a2:	b8 1a 00 00 00       	mov    $0x1a,%eax
     8a7:	cd 40                	int    $0x40
     8a9:	c3                   	ret    

000008aa <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
     8aa:	b8 1b 00 00 00       	mov    $0x1b,%eax
     8af:	cd 40                	int    $0x40
     8b1:	c3                   	ret    

000008b2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
     8b2:	b8 1c 00 00 00       	mov    $0x1c,%eax
     8b7:	cd 40                	int    $0x40
     8b9:	c3                   	ret    

000008ba <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
     8ba:	b8 1d 00 00 00       	mov    $0x1d,%eax
     8bf:	cd 40                	int    $0x40
     8c1:	c3                   	ret    
     8c2:	66 90                	xchg   %ax,%ax
     8c4:	66 90                	xchg   %ax,%ax
     8c6:	66 90                	xchg   %ax,%ax
     8c8:	66 90                	xchg   %ax,%ax
     8ca:	66 90                	xchg   %ax,%ax
     8cc:	66 90                	xchg   %ax,%ax
     8ce:	66 90                	xchg   %ax,%ax

000008d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     8d9:	85 d2                	test   %edx,%edx
{
     8db:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     8de:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     8e0:	79 76                	jns    958 <printint+0x88>
     8e2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     8e6:	74 70                	je     958 <printint+0x88>
    x = -xx;
     8e8:	f7 d8                	neg    %eax
    neg = 1;
     8ea:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     8f1:	31 f6                	xor    %esi,%esi
     8f3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     8f6:	eb 0a                	jmp    902 <printint+0x32>
     8f8:	90                   	nop
     8f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     900:	89 fe                	mov    %edi,%esi
     902:	31 d2                	xor    %edx,%edx
     904:	8d 7e 01             	lea    0x1(%esi),%edi
     907:	f7 f1                	div    %ecx
     909:	0f b6 92 00 14 00 00 	movzbl 0x1400(%edx),%edx
  }while((x /= base) != 0);
     910:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     912:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     915:	75 e9                	jne    900 <printint+0x30>
  if(neg)
     917:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     91a:	85 c0                	test   %eax,%eax
     91c:	74 08                	je     926 <printint+0x56>
    buf[i++] = '-';
     91e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     923:	8d 7e 02             	lea    0x2(%esi),%edi
     926:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     92a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     92d:	8d 76 00             	lea    0x0(%esi),%esi
     930:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     933:	83 ec 04             	sub    $0x4,%esp
     936:	83 ee 01             	sub    $0x1,%esi
     939:	6a 01                	push   $0x1
     93b:	53                   	push   %ebx
     93c:	57                   	push   %edi
     93d:	88 45 d7             	mov    %al,-0x29(%ebp)
     940:	e8 bd fe ff ff       	call   802 <write>

  while(--i >= 0)
     945:	83 c4 10             	add    $0x10,%esp
     948:	39 de                	cmp    %ebx,%esi
     94a:	75 e4                	jne    930 <printint+0x60>
    putc(fd, buf[i]);
}
     94c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     94f:	5b                   	pop    %ebx
     950:	5e                   	pop    %esi
     951:	5f                   	pop    %edi
     952:	5d                   	pop    %ebp
     953:	c3                   	ret    
     954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     958:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     95f:	eb 90                	jmp    8f1 <printint+0x21>
     961:	eb 0d                	jmp    970 <printf>
     963:	90                   	nop
     964:	90                   	nop
     965:	90                   	nop
     966:	90                   	nop
     967:	90                   	nop
     968:	90                   	nop
     969:	90                   	nop
     96a:	90                   	nop
     96b:	90                   	nop
     96c:	90                   	nop
     96d:	90                   	nop
     96e:	90                   	nop
     96f:	90                   	nop

00000970 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	57                   	push   %edi
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
     976:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     979:	8b 75 0c             	mov    0xc(%ebp),%esi
     97c:	0f b6 1e             	movzbl (%esi),%ebx
     97f:	84 db                	test   %bl,%bl
     981:	0f 84 b3 00 00 00    	je     a3a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     987:	8d 45 10             	lea    0x10(%ebp),%eax
     98a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     98d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     98f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     992:	eb 2f                	jmp    9c3 <printf+0x53>
     994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     998:	83 f8 25             	cmp    $0x25,%eax
     99b:	0f 84 a7 00 00 00    	je     a48 <printf+0xd8>
  write(fd, &c, 1);
     9a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     9a4:	83 ec 04             	sub    $0x4,%esp
     9a7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     9aa:	6a 01                	push   $0x1
     9ac:	50                   	push   %eax
     9ad:	ff 75 08             	pushl  0x8(%ebp)
     9b0:	e8 4d fe ff ff       	call   802 <write>
     9b5:	83 c4 10             	add    $0x10,%esp
     9b8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     9bb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     9bf:	84 db                	test   %bl,%bl
     9c1:	74 77                	je     a3a <printf+0xca>
    if(state == 0){
     9c3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     9c5:	0f be cb             	movsbl %bl,%ecx
     9c8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     9cb:	74 cb                	je     998 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     9cd:	83 ff 25             	cmp    $0x25,%edi
     9d0:	75 e6                	jne    9b8 <printf+0x48>
      if(c == 'd'){
     9d2:	83 f8 64             	cmp    $0x64,%eax
     9d5:	0f 84 05 01 00 00    	je     ae0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     9db:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     9e1:	83 f9 70             	cmp    $0x70,%ecx
     9e4:	74 72                	je     a58 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     9e6:	83 f8 73             	cmp    $0x73,%eax
     9e9:	0f 84 99 00 00 00    	je     a88 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     9ef:	83 f8 63             	cmp    $0x63,%eax
     9f2:	0f 84 08 01 00 00    	je     b00 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     9f8:	83 f8 25             	cmp    $0x25,%eax
     9fb:	0f 84 ef 00 00 00    	je     af0 <printf+0x180>
  write(fd, &c, 1);
     a01:	8d 45 e7             	lea    -0x19(%ebp),%eax
     a04:	83 ec 04             	sub    $0x4,%esp
     a07:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     a0b:	6a 01                	push   $0x1
     a0d:	50                   	push   %eax
     a0e:	ff 75 08             	pushl  0x8(%ebp)
     a11:	e8 ec fd ff ff       	call   802 <write>
     a16:	83 c4 0c             	add    $0xc,%esp
     a19:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     a1c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     a1f:	6a 01                	push   $0x1
     a21:	50                   	push   %eax
     a22:	ff 75 08             	pushl  0x8(%ebp)
     a25:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     a28:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     a2a:	e8 d3 fd ff ff       	call   802 <write>
  for(i = 0; fmt[i]; i++){
     a2f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     a33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     a36:	84 db                	test   %bl,%bl
     a38:	75 89                	jne    9c3 <printf+0x53>
    }
  }
}
     a3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a3d:	5b                   	pop    %ebx
     a3e:	5e                   	pop    %esi
     a3f:	5f                   	pop    %edi
     a40:	5d                   	pop    %ebp
     a41:	c3                   	ret    
     a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     a48:	bf 25 00 00 00       	mov    $0x25,%edi
     a4d:	e9 66 ff ff ff       	jmp    9b8 <printf+0x48>
     a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     a58:	83 ec 0c             	sub    $0xc,%esp
     a5b:	b9 10 00 00 00       	mov    $0x10,%ecx
     a60:	6a 00                	push   $0x0
     a62:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     a65:	8b 45 08             	mov    0x8(%ebp),%eax
     a68:	8b 17                	mov    (%edi),%edx
     a6a:	e8 61 fe ff ff       	call   8d0 <printint>
        ap++;
     a6f:	89 f8                	mov    %edi,%eax
     a71:	83 c4 10             	add    $0x10,%esp
      state = 0;
     a74:	31 ff                	xor    %edi,%edi
        ap++;
     a76:	83 c0 04             	add    $0x4,%eax
     a79:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     a7c:	e9 37 ff ff ff       	jmp    9b8 <printf+0x48>
     a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     a88:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     a8b:	8b 08                	mov    (%eax),%ecx
        ap++;
     a8d:	83 c0 04             	add    $0x4,%eax
     a90:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     a93:	85 c9                	test   %ecx,%ecx
     a95:	0f 84 8e 00 00 00    	je     b29 <printf+0x1b9>
        while(*s != 0){
     a9b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     a9e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     aa0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     aa2:	84 c0                	test   %al,%al
     aa4:	0f 84 0e ff ff ff    	je     9b8 <printf+0x48>
     aaa:	89 75 d0             	mov    %esi,-0x30(%ebp)
     aad:	89 de                	mov    %ebx,%esi
     aaf:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ab2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     ab5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     ab8:	83 ec 04             	sub    $0x4,%esp
          s++;
     abb:	83 c6 01             	add    $0x1,%esi
     abe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     ac1:	6a 01                	push   $0x1
     ac3:	57                   	push   %edi
     ac4:	53                   	push   %ebx
     ac5:	e8 38 fd ff ff       	call   802 <write>
        while(*s != 0){
     aca:	0f b6 06             	movzbl (%esi),%eax
     acd:	83 c4 10             	add    $0x10,%esp
     ad0:	84 c0                	test   %al,%al
     ad2:	75 e4                	jne    ab8 <printf+0x148>
     ad4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
     ad7:	31 ff                	xor    %edi,%edi
     ad9:	e9 da fe ff ff       	jmp    9b8 <printf+0x48>
     ade:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     ae0:	83 ec 0c             	sub    $0xc,%esp
     ae3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     ae8:	6a 01                	push   $0x1
     aea:	e9 73 ff ff ff       	jmp    a62 <printf+0xf2>
     aef:	90                   	nop
  write(fd, &c, 1);
     af0:	83 ec 04             	sub    $0x4,%esp
     af3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     af6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     af9:	6a 01                	push   $0x1
     afb:	e9 21 ff ff ff       	jmp    a21 <printf+0xb1>
        putc(fd, *ap);
     b00:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
     b03:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     b06:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
     b08:	6a 01                	push   $0x1
        ap++;
     b0a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
     b0d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     b10:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     b13:	50                   	push   %eax
     b14:	ff 75 08             	pushl  0x8(%ebp)
     b17:	e8 e6 fc ff ff       	call   802 <write>
        ap++;
     b1c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     b1f:	83 c4 10             	add    $0x10,%esp
      state = 0;
     b22:	31 ff                	xor    %edi,%edi
     b24:	e9 8f fe ff ff       	jmp    9b8 <printf+0x48>
          s = "(null)";
     b29:	bb f8 13 00 00       	mov    $0x13f8,%ebx
        while(*s != 0){
     b2e:	b8 28 00 00 00       	mov    $0x28,%eax
     b33:	e9 72 ff ff ff       	jmp    aaa <printf+0x13a>
     b38:	66 90                	xchg   %ax,%ax
     b3a:	66 90                	xchg   %ax,%ax
     b3c:	66 90                	xchg   %ax,%ax
     b3e:	66 90                	xchg   %ax,%ax

00000b40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b41:	a1 04 19 00 00       	mov    0x1904,%eax
{
     b46:	89 e5                	mov    %esp,%ebp
     b48:	57                   	push   %edi
     b49:	56                   	push   %esi
     b4a:	53                   	push   %ebx
     b4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     b4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
     b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b58:	39 c8                	cmp    %ecx,%eax
     b5a:	8b 10                	mov    (%eax),%edx
     b5c:	73 32                	jae    b90 <free+0x50>
     b5e:	39 d1                	cmp    %edx,%ecx
     b60:	72 04                	jb     b66 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b62:	39 d0                	cmp    %edx,%eax
     b64:	72 32                	jb     b98 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b66:	8b 73 fc             	mov    -0x4(%ebx),%esi
     b69:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     b6c:	39 fa                	cmp    %edi,%edx
     b6e:	74 30                	je     ba0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     b70:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     b73:	8b 50 04             	mov    0x4(%eax),%edx
     b76:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     b79:	39 f1                	cmp    %esi,%ecx
     b7b:	74 3a                	je     bb7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     b7d:	89 08                	mov    %ecx,(%eax)
  freep = p;
     b7f:	a3 04 19 00 00       	mov    %eax,0x1904
}
     b84:	5b                   	pop    %ebx
     b85:	5e                   	pop    %esi
     b86:	5f                   	pop    %edi
     b87:	5d                   	pop    %ebp
     b88:	c3                   	ret    
     b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b90:	39 d0                	cmp    %edx,%eax
     b92:	72 04                	jb     b98 <free+0x58>
     b94:	39 d1                	cmp    %edx,%ecx
     b96:	72 ce                	jb     b66 <free+0x26>
{
     b98:	89 d0                	mov    %edx,%eax
     b9a:	eb bc                	jmp    b58 <free+0x18>
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
     ba0:	03 72 04             	add    0x4(%edx),%esi
     ba3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     ba6:	8b 10                	mov    (%eax),%edx
     ba8:	8b 12                	mov    (%edx),%edx
     baa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     bad:	8b 50 04             	mov    0x4(%eax),%edx
     bb0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     bb3:	39 f1                	cmp    %esi,%ecx
     bb5:	75 c6                	jne    b7d <free+0x3d>
    p->s.size += bp->s.size;
     bb7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
     bba:	a3 04 19 00 00       	mov    %eax,0x1904
    p->s.size += bp->s.size;
     bbf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     bc2:	8b 53 f8             	mov    -0x8(%ebx),%edx
     bc5:	89 10                	mov    %edx,(%eax)
}
     bc7:	5b                   	pop    %ebx
     bc8:	5e                   	pop    %esi
     bc9:	5f                   	pop    %edi
     bca:	5d                   	pop    %ebp
     bcb:	c3                   	ret    
     bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
     bd6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
     bdc:	8b 15 04 19 00 00    	mov    0x1904,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     be2:	8d 78 07             	lea    0x7(%eax),%edi
     be5:	c1 ef 03             	shr    $0x3,%edi
     be8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
     beb:	85 d2                	test   %edx,%edx
     bed:	0f 84 9d 00 00 00    	je     c90 <malloc+0xc0>
     bf3:	8b 02                	mov    (%edx),%eax
     bf5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
     bf8:	39 cf                	cmp    %ecx,%edi
     bfa:	76 6c                	jbe    c68 <malloc+0x98>
     bfc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
     c02:	bb 00 10 00 00       	mov    $0x1000,%ebx
     c07:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
     c0a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
     c11:	eb 0e                	jmp    c21 <malloc+0x51>
     c13:	90                   	nop
     c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
     c1a:	8b 48 04             	mov    0x4(%eax),%ecx
     c1d:	39 f9                	cmp    %edi,%ecx
     c1f:	73 47                	jae    c68 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
     c21:	39 05 04 19 00 00    	cmp    %eax,0x1904
     c27:	89 c2                	mov    %eax,%edx
     c29:	75 ed                	jne    c18 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
     c2b:	83 ec 0c             	sub    $0xc,%esp
     c2e:	56                   	push   %esi
     c2f:	e8 36 fc ff ff       	call   86a <sbrk>
  if(p == (char*)-1)
     c34:	83 c4 10             	add    $0x10,%esp
     c37:	83 f8 ff             	cmp    $0xffffffff,%eax
     c3a:	74 1c                	je     c58 <malloc+0x88>
  hp->s.size = nu;
     c3c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
     c3f:	83 ec 0c             	sub    $0xc,%esp
     c42:	83 c0 08             	add    $0x8,%eax
     c45:	50                   	push   %eax
     c46:	e8 f5 fe ff ff       	call   b40 <free>
  return freep;
     c4b:	8b 15 04 19 00 00    	mov    0x1904,%edx
      if((p = morecore(nunits)) == 0)
     c51:	83 c4 10             	add    $0x10,%esp
     c54:	85 d2                	test   %edx,%edx
     c56:	75 c0                	jne    c18 <malloc+0x48>
        return 0;
  }
}
     c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
     c5b:	31 c0                	xor    %eax,%eax
}
     c5d:	5b                   	pop    %ebx
     c5e:	5e                   	pop    %esi
     c5f:	5f                   	pop    %edi
     c60:	5d                   	pop    %ebp
     c61:	c3                   	ret    
     c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
     c68:	39 cf                	cmp    %ecx,%edi
     c6a:	74 54                	je     cc0 <malloc+0xf0>
        p->s.size -= nunits;
     c6c:	29 f9                	sub    %edi,%ecx
     c6e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
     c71:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
     c74:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
     c77:	89 15 04 19 00 00    	mov    %edx,0x1904
}
     c7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
     c80:	83 c0 08             	add    $0x8,%eax
}
     c83:	5b                   	pop    %ebx
     c84:	5e                   	pop    %esi
     c85:	5f                   	pop    %edi
     c86:	5d                   	pop    %ebp
     c87:	c3                   	ret    
     c88:	90                   	nop
     c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
     c90:	c7 05 04 19 00 00 08 	movl   $0x1908,0x1904
     c97:	19 00 00 
     c9a:	c7 05 08 19 00 00 08 	movl   $0x1908,0x1908
     ca1:	19 00 00 
    base.s.size = 0;
     ca4:	b8 08 19 00 00       	mov    $0x1908,%eax
     ca9:	c7 05 0c 19 00 00 00 	movl   $0x0,0x190c
     cb0:	00 00 00 
     cb3:	e9 44 ff ff ff       	jmp    bfc <malloc+0x2c>
     cb8:	90                   	nop
     cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
     cc0:	8b 08                	mov    (%eax),%ecx
     cc2:	89 0a                	mov    %ecx,(%edx)
     cc4:	eb b1                	jmp    c77 <malloc+0xa7>
     cc6:	66 90                	xchg   %ax,%ax
     cc8:	66 90                	xchg   %ax,%ax
     cca:	66 90                	xchg   %ax,%ax
     ccc:	66 90                	xchg   %ax,%ax
     cce:	66 90                	xchg   %ax,%ax

00000cd0 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
     cd0:	55                   	push   %ebp
    int init = 2;
    int output = 1;
     cd1:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
     cdb:	85 d2                	test   %edx,%edx
     cdd:	74 08                	je     ce7 <powordepth+0x17>
     cdf:	90                   	nop
        output *= init;
     ce0:	01 c0                	add    %eax,%eax
    while (exp != 0) {
     ce2:	83 ea 01             	sub    $0x1,%edx
     ce5:	75 f9                	jne    ce0 <powordepth+0x10>
        exp--;
    }
    return output;
}
     ce7:	5d                   	pop    %ebp
     ce8:	c3                   	ret    
     ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cf0 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	57                   	push   %edi
     cf4:	56                   	push   %esi
     cf5:	53                   	push   %ebx
     cf6:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
     cf9:	6a 10                	push   $0x10
     cfb:	e8 d0 fe ff ff       	call   bd0 <malloc>
     d00:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
     d02:	8b 45 08             	mov    0x8(%ebp),%eax
     d05:	83 c4 10             	add    $0x10,%esp
     d08:	83 e8 01             	sub    $0x1,%eax
     d0b:	83 f8 05             	cmp    $0x5,%eax
     d0e:	0f 87 f6 00 00 00    	ja     e0a <trnmnt_tree_alloc+0x11a>
     d14:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
     d17:	bf 01 00 00 00       	mov    $0x1,%edi
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
     d20:	01 ff                	add    %edi,%edi
    while (exp != 0) {
     d22:	83 e8 01             	sub    $0x1,%eax
     d25:	75 f9                	jne    d20 <trnmnt_tree_alloc+0x30>
     d27:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
     d2a:	8d 47 ff             	lea    -0x1(%edi),%eax
     d2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
     d30:	8b 45 08             	mov    0x8(%ebp),%eax
     d33:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
     d36:	e8 67 fb ff ff       	call   8a2 <kthread_mutex_alloc>
     d3b:	83 f8 ff             	cmp    $0xffffffff,%eax
     d3e:	89 06                	mov    %eax,(%esi)
     d40:	0f 84 34 01 00 00    	je     e7a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
     d46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d49:	83 ec 0c             	sub    $0xc,%esp
     d4c:	c1 e0 02             	shl    $0x2,%eax
     d4f:	50                   	push   %eax
     d50:	89 45 e0             	mov    %eax,-0x20(%ebp)
     d53:	e8 78 fe ff ff       	call   bd0 <malloc>
     d58:	83 c4 10             	add    $0x10,%esp
     d5b:	85 c0                	test   %eax,%eax
     d5d:	89 46 04             	mov    %eax,0x4(%esi)
     d60:	0f 84 14 01 00 00    	je     e7a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
     d66:	31 db                	xor    %ebx,%ebx
     d68:	eb 09                	jmp    d73 <trnmnt_tree_alloc+0x83>
     d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d70:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
     d73:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
     d76:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
     d79:	e8 24 fb ff ff       	call   8a2 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
     d7e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
     d81:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
     d83:	75 eb                	jne    d70 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
     d85:	8b 4e 04             	mov    0x4(%esi),%ecx
     d88:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
     d8b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
     d90:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     d93:	89 c8                	mov    %ecx,%eax
     d95:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
     d97:	31 c9                	xor    %ecx,%ecx
     d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
     da0:	83 38 ff             	cmpl   $0xffffffff,(%eax)
     da3:	0f 44 cf             	cmove  %edi,%ecx
     da6:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
     da9:	39 d0                	cmp    %edx,%eax
     dab:	75 f3                	jne    da0 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
     dad:	85 c9                	test   %ecx,%ecx
     daf:	8b 7d 08             	mov    0x8(%ebp),%edi
     db2:	b8 01 00 00 00       	mov    $0x1,%eax
     db7:	0f 85 9b 00 00 00    	jne    e58 <trnmnt_tree_alloc+0x168>
     dbd:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
     dc0:	01 c0                	add    %eax,%eax
    while (exp != 0) {
     dc2:	83 ef 01             	sub    $0x1,%edi
     dc5:	75 f9                	jne    dc0 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
     dc7:	83 ec 0c             	sub    $0xc,%esp
     dca:	c1 e0 02             	shl    $0x2,%eax
     dcd:	50                   	push   %eax
     dce:	e8 fd fd ff ff       	call   bd0 <malloc>
     dd3:	83 c4 10             	add    $0x10,%esp
     dd6:	85 c0                	test   %eax,%eax
     dd8:	89 46 08             	mov    %eax,0x8(%esi)
     ddb:	8b 4d 08             	mov    0x8(%ebp),%ecx
     dde:	74 36                	je     e16 <trnmnt_tree_alloc+0x126>
     de0:	89 c8                	mov    %ecx,%eax
    int output = 1;
     de2:	ba 01 00 00 00       	mov    $0x1,%edx
     de7:	89 f6                	mov    %esi,%esi
     de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
     df0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
     df2:	83 e8 01             	sub    $0x1,%eax
     df5:	75 f9                	jne    df0 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
     df7:	39 d7                	cmp    %edx,%edi
     df9:	7d 11                	jge    e0c <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
     dfb:	8b 46 08             	mov    0x8(%esi),%eax
     dfe:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
     e05:	83 c7 01             	add    $0x1,%edi
     e08:	eb d6                	jmp    de0 <trnmnt_tree_alloc+0xf0>
        return 0;
     e0a:	31 f6                	xor    %esi,%esi

    return output;
}
     e0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e0f:	89 f0                	mov    %esi,%eax
     e11:	5b                   	pop    %ebx
     e12:	5e                   	pop    %esi
     e13:	5f                   	pop    %edi
     e14:	5d                   	pop    %ebp
     e15:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
     e16:	8b 46 04             	mov    0x4(%esi),%eax
     e19:	83 ec 0c             	sub    $0xc,%esp
     e1c:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
     e1f:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
     e22:	e8 83 fa ff ff       	call   8aa <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
     e27:	83 c4 10             	add    $0x10,%esp
     e2a:	39 df                	cmp    %ebx,%edi
     e2c:	75 e8                	jne    e16 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
     e2e:	83 ec 0c             	sub    $0xc,%esp
     e31:	ff 36                	pushl  (%esi)
     e33:	e8 72 fa ff ff       	call   8aa <kthread_mutex_dealloc>
        free(output->mutextree);
     e38:	58                   	pop    %eax
     e39:	ff 76 04             	pushl  0x4(%esi)
     e3c:	e8 ff fc ff ff       	call   b40 <free>
        free(output);
     e41:	89 34 24             	mov    %esi,(%esp)
        return 0;
     e44:	31 f6                	xor    %esi,%esi
        free(output);
     e46:	e8 f5 fc ff ff       	call   b40 <free>
        return 0;
     e4b:	83 c4 10             	add    $0x10,%esp
}
     e4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e51:	89 f0                	mov    %esi,%eax
     e53:	5b                   	pop    %ebx
     e54:	5e                   	pop    %esi
     e55:	5f                   	pop    %edi
     e56:	5d                   	pop    %ebp
     e57:	c3                   	ret    
     e58:	8b 7d dc             	mov    -0x24(%ebp),%edi
     e5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e5e:	eb 03                	jmp    e63 <trnmnt_tree_alloc+0x173>
     e60:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
     e63:	83 ec 0c             	sub    $0xc,%esp
     e66:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
     e69:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
     e6c:	e8 39 fa ff ff       	call   8aa <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
     e71:	83 c4 10             	add    $0x10,%esp
     e74:	39 df                	cmp    %ebx,%edi
     e76:	75 e8                	jne    e60 <trnmnt_tree_alloc+0x170>
     e78:	eb b4                	jmp    e2e <trnmnt_tree_alloc+0x13e>
        free(output);
     e7a:	83 ec 0c             	sub    $0xc,%esp
     e7d:	56                   	push   %esi
        return 0;
     e7e:	31 f6                	xor    %esi,%esi
        free(output);
     e80:	e8 bb fc ff ff       	call   b40 <free>
        return 0;
     e85:	83 c4 10             	add    $0x10,%esp
     e88:	eb 82                	jmp    e0c <trnmnt_tree_alloc+0x11c>
     e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e90 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	57                   	push   %edi
     e94:	56                   	push   %esi
     e95:	53                   	push   %ebx
     e96:	83 ec 28             	sub    $0x28,%esp
     e99:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
     e9c:	ff 36                	pushl  (%esi)
     e9e:	e8 0f fa ff ff       	call   8b2 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
     ea3:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
     ea6:	83 c4 10             	add    $0x10,%esp
     ea9:	85 ff                	test   %edi,%edi
     eab:	0f 84 0b 01 00 00    	je     fbc <trnmnt_tree_dealloc+0x12c>
     eb1:	89 f8                	mov    %edi,%eax
    int output = 1;
     eb3:	bb 01 00 00 00       	mov    $0x1,%ebx
     eb8:	90                   	nop
     eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
     ec0:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
     ec2:	83 e8 01             	sub    $0x1,%eax
     ec5:	75 f9                	jne    ec0 <trnmnt_tree_dealloc+0x30>
     ec7:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
     eca:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
     ecc:	85 ff                	test   %edi,%edi
     ece:	74 2f                	je     eff <trnmnt_tree_dealloc+0x6f>
     ed0:	89 f8                	mov    %edi,%eax
    int output = 1;
     ed2:	ba 01 00 00 00       	mov    $0x1,%edx
     ed7:	89 f6                	mov    %esi,%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
     ee0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
     ee2:	83 e8 01             	sub    $0x1,%eax
     ee5:	75 f9                	jne    ee0 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
     ee7:	39 d1                	cmp    %edx,%ecx
     ee9:	7d 25                	jge    f10 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
     eeb:	8b 46 08             	mov    0x8(%esi),%eax
     eee:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
     ef2:	0f 85 a8 00 00 00    	jne    fa0 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
     ef8:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
     efb:	85 ff                	test   %edi,%edi
     efd:	75 d1                	jne    ed0 <trnmnt_tree_dealloc+0x40>
    int output = 1;
     eff:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
     f04:	39 d1                	cmp    %edx,%ecx
     f06:	7c e3                	jl     eeb <trnmnt_tree_dealloc+0x5b>
     f08:	90                   	nop
     f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
     f10:	85 db                	test   %ebx,%ebx
     f12:	74 46                	je     f5a <trnmnt_tree_dealloc+0xca>
     f14:	31 ff                	xor    %edi,%edi
     f16:	eb 0f                	jmp    f27 <trnmnt_tree_dealloc+0x97>
     f18:	90                   	nop
     f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f20:	83 c7 01             	add    $0x1,%edi
     f23:	39 fb                	cmp    %edi,%ebx
     f25:	74 33                	je     f5a <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
     f27:	8b 46 04             	mov    0x4(%esi),%eax
     f2a:	83 ec 0c             	sub    $0xc,%esp
     f2d:	ff 34 b8             	pushl  (%eax,%edi,4)
     f30:	e8 75 f9 ff ff       	call   8aa <kthread_mutex_dealloc>
     f35:	83 c4 10             	add    $0x10,%esp
     f38:	83 f8 ff             	cmp    $0xffffffff,%eax
     f3b:	75 e3                	jne    f20 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
     f3d:	83 ec 0c             	sub    $0xc,%esp
     f40:	ff 36                	pushl  (%esi)
     f42:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f45:	e8 70 f9 ff ff       	call   8ba <kthread_mutex_unlock>
            return -1;
     f4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     f4d:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
     f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f53:	5b                   	pop    %ebx
     f54:	89 d0                	mov    %edx,%eax
     f56:	5e                   	pop    %esi
     f57:	5f                   	pop    %edi
     f58:	5d                   	pop    %ebp
     f59:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
     f5a:	83 ec 0c             	sub    $0xc,%esp
     f5d:	ff 36                	pushl  (%esi)
     f5f:	e8 56 f9 ff ff       	call   8ba <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
     f64:	58                   	pop    %eax
     f65:	ff 36                	pushl  (%esi)
     f67:	e8 3e f9 ff ff       	call   8aa <kthread_mutex_dealloc>
    free(tree->threadMap);
     f6c:	5a                   	pop    %edx
     f6d:	ff 76 08             	pushl  0x8(%esi)
     f70:	e8 cb fb ff ff       	call   b40 <free>
    free(tree->mutextree);
     f75:	59                   	pop    %ecx
     f76:	ff 76 04             	pushl  0x4(%esi)
     f79:	e8 c2 fb ff ff       	call   b40 <free>
    free(tree);
     f7e:	89 34 24             	mov    %esi,(%esp)
     f81:	e8 ba fb ff ff       	call   b40 <free>
    tree->depth = 0;
     f86:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
     f8d:	83 c4 10             	add    $0x10,%esp
}
     f90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
     f93:	31 d2                	xor    %edx,%edx
}
     f95:	5b                   	pop    %ebx
     f96:	89 d0                	mov    %edx,%eax
     f98:	5e                   	pop    %esi
     f99:	5f                   	pop    %edi
     f9a:	5d                   	pop    %ebp
     f9b:	c3                   	ret    
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
     fa0:	83 ec 0c             	sub    $0xc,%esp
     fa3:	ff 36                	pushl  (%esi)
     fa5:	e8 10 f9 ff ff       	call   8ba <kthread_mutex_unlock>
            return -1;
     faa:	83 c4 10             	add    $0x10,%esp
}
     fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
     fb0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
     fb5:	89 d0                	mov    %edx,%eax
     fb7:	5b                   	pop    %ebx
     fb8:	5e                   	pop    %esi
     fb9:	5f                   	pop    %edi
     fba:	5d                   	pop    %ebp
     fbb:	c3                   	ret    
    while (exp != 0) {
     fbc:	31 db                	xor    %ebx,%ebx
     fbe:	e9 07 ff ff ff       	jmp    eca <trnmnt_tree_dealloc+0x3a>
     fc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000fd0 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	57                   	push   %edi
     fd4:	56                   	push   %esi
     fd5:	53                   	push   %ebx
     fd6:	83 ec 0c             	sub    $0xc,%esp
     fd9:	8b 7d 0c             	mov    0xc(%ebp),%edi
     fdc:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
     fdf:	85 ff                	test   %edi,%edi
     fe1:	0f 88 d1 00 00 00    	js     10b8 <trnmnt_tree_acquire+0xe8>
     fe7:	85 f6                	test   %esi,%esi
     fe9:	0f 84 c9 00 00 00    	je     10b8 <trnmnt_tree_acquire+0xe8>
     fef:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
     ff2:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
     ff7:	85 c0                	test   %eax,%eax
     ff9:	74 0c                	je     1007 <trnmnt_tree_acquire+0x37>
     ffb:	90                   	nop
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
    1000:	01 d2                	add    %edx,%edx
    while (exp != 0) {
    1002:	83 e8 01             	sub    $0x1,%eax
    1005:	75 f9                	jne    1000 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
    1007:	39 d7                	cmp    %edx,%edi
    1009:	0f 8d a9 00 00 00    	jge    10b8 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
    100f:	83 ec 0c             	sub    $0xc,%esp
    1012:	ff 36                	pushl  (%esi)
    1014:	e8 99 f8 ff ff       	call   8b2 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
    1019:	8b 46 08             	mov    0x8(%esi),%eax
    101c:	83 c4 10             	add    $0x10,%esp
    101f:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
    1022:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
    1025:	0f 85 94 00 00 00    	jne    10bf <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
    102b:	e8 5a f8 ff ff       	call   88a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
    1030:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
    1033:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
    1035:	ff 36                	pushl  (%esi)
    1037:	e8 7e f8 ff ff       	call   8ba <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
    103c:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
    103f:	83 c4 10             	add    $0x10,%esp
    1042:	85 c0                	test   %eax,%eax
    1044:	74 5a                	je     10a0 <trnmnt_tree_acquire+0xd0>
    int output = 1;
    1046:	ba 01 00 00 00       	mov    $0x1,%edx
    104b:	90                   	nop
    104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
    1050:	01 d2                	add    %edx,%edx
    while (exp != 0) {
    1052:	83 e8 01             	sub    $0x1,%eax
    1055:	75 f9                	jne    1050 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
    1057:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
    105b:	89 c3                	mov    %eax,%ebx
    105d:	c1 eb 1f             	shr    $0x1f,%ebx
    1060:	01 c3                	add    %eax,%ebx
    1062:	d1 fb                	sar    %ebx
    1064:	eb 0c                	jmp    1072 <trnmnt_tree_acquire+0xa2>
    1066:	8d 76 00             	lea    0x0(%esi),%esi
    1069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
    1070:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
    1072:	8b 46 04             	mov    0x4(%esi),%eax
    1075:	83 ec 0c             	sub    $0xc,%esp
    1078:	ff 34 98             	pushl  (%eax,%ebx,4)
    107b:	e8 32 f8 ff ff       	call   8b2 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
    1080:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
    1083:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
    1086:	89 d0                	mov    %edx,%eax
    1088:	c1 e8 1f             	shr    $0x1f,%eax
    108b:	01 d0                	add    %edx,%eax
    108d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
    108f:	85 db                	test   %ebx,%ebx
    1091:	75 dd                	jne    1070 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
    1093:	31 c0                	xor    %eax,%eax
}
    1095:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1098:	5b                   	pop    %ebx
    1099:	5e                   	pop    %esi
    109a:	5f                   	pop    %edi
    109b:	5d                   	pop    %ebp
    109c:	c3                   	ret    
    109d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
    10a0:	8d 47 ff             	lea    -0x1(%edi),%eax
    10a3:	89 c3                	mov    %eax,%ebx
    10a5:	c1 eb 1f             	shr    $0x1f,%ebx
    10a8:	01 c3                	add    %eax,%ebx
    10aa:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
    10ac:	85 ff                	test   %edi,%edi
    10ae:	74 e3                	je     1093 <trnmnt_tree_acquire+0xc3>
    10b0:	eb c0                	jmp    1072 <trnmnt_tree_acquire+0xa2>
    10b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
    10b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10bd:	eb d6                	jmp    1095 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
    10bf:	83 ec 0c             	sub    $0xc,%esp
    10c2:	ff 36                	pushl  (%esi)
    10c4:	e8 f1 f7 ff ff       	call   8ba <kthread_mutex_unlock>
        return -1;
    10c9:	83 c4 10             	add    $0x10,%esp
    10cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    10d1:	eb c2                	jmp    1095 <trnmnt_tree_acquire+0xc5>
    10d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010e0 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	56                   	push   %esi
    10e4:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
    10e5:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
    10e8:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
    10eb:	8d 50 ff             	lea    -0x1(%eax),%edx
    10ee:	89 d0                	mov    %edx,%eax
    10f0:	c1 e8 1f             	shr    $0x1f,%eax
    10f3:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
    10f5:	d1 f8                	sar    %eax
    10f7:	89 c3                	mov    %eax,%ebx
    10f9:	75 15                	jne    1110 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
    10fb:	8b 46 04             	mov    0x4(%esi),%eax
    10fe:	8b 04 98             	mov    (%eax,%ebx,4),%eax
    1101:	89 45 08             	mov    %eax,0x8(%ebp)
}
    1104:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1107:	5b                   	pop    %ebx
    1108:	5e                   	pop    %esi
    1109:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
    110a:	e9 ab f7 ff ff       	jmp    8ba <kthread_mutex_unlock>
    110f:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
    1110:	83 ec 08             	sub    $0x8,%esp
    1113:	50                   	push   %eax
    1114:	56                   	push   %esi
    1115:	e8 c6 ff ff ff       	call   10e0 <trnmnt_tree_release_rec>
    111a:	83 c4 10             	add    $0x10,%esp
    111d:	83 f8 ff             	cmp    $0xffffffff,%eax
    1120:	75 d9                	jne    10fb <trnmnt_tree_release_rec+0x1b>
}
    1122:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1125:	5b                   	pop    %ebx
    1126:	5e                   	pop    %esi
    1127:	5d                   	pop    %ebp
    1128:	c3                   	ret    
    1129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001130 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
    1130:	55                   	push   %ebp
    1131:	89 e5                	mov    %esp,%ebp
    1133:	57                   	push   %edi
    1134:	56                   	push   %esi
    1135:	53                   	push   %ebx
    1136:	83 ec 28             	sub    $0x28,%esp
    1139:	8b 7d 08             	mov    0x8(%ebp),%edi
    113c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
    113f:	ff 37                	pushl  (%edi)
    1141:	e8 6c f7 ff ff       	call   8b2 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
    1146:	8b 47 08             	mov    0x8(%edi),%eax
    1149:	8b 04 98             	mov    (%eax,%ebx,4),%eax
    114c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    114f:	e8 36 f7 ff ff       	call   88a <kthread_id>
    1154:	83 c4 10             	add    $0x10,%esp
    1157:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    115a:	75 56                	jne    11b2 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
    115c:	8b 47 0c             	mov    0xc(%edi),%eax
    115f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
    1166:	85 c0                	test   %eax,%eax
    1168:	74 11                	je     117b <trnmnt_tree_release+0x4b>
    int output = 1;
    116a:	b9 01 00 00 00       	mov    $0x1,%ecx
    116f:	90                   	nop
        output *= init;
    1170:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
    1172:	83 e8 01             	sub    $0x1,%eax
    1175:	75 f9                	jne    1170 <trnmnt_tree_release+0x40>
    1177:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
    117b:	83 ec 08             	sub    $0x8,%esp
    117e:	53                   	push   %ebx
    117f:	57                   	push   %edi
    1180:	e8 5b ff ff ff       	call   10e0 <trnmnt_tree_release_rec>
    1185:	83 c4 10             	add    $0x10,%esp
    1188:	83 f8 ff             	cmp    $0xffffffff,%eax
    118b:	89 c3                	mov    %eax,%ebx
    118d:	74 37                	je     11c6 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
    118f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
    1192:	83 ec 0c             	sub    $0xc,%esp
    return 0;
    1195:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
    1197:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
    119e:	ff 37                	pushl  (%edi)
    11a0:	e8 15 f7 ff ff       	call   8ba <kthread_mutex_unlock>
    return 0;
    11a5:	83 c4 10             	add    $0x10,%esp
}
    11a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11ab:	89 d8                	mov    %ebx,%eax
    11ad:	5b                   	pop    %ebx
    11ae:	5e                   	pop    %esi
    11af:	5f                   	pop    %edi
    11b0:	5d                   	pop    %ebp
    11b1:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
    11b2:	83 ec 0c             	sub    $0xc,%esp
    11b5:	ff 37                	pushl  (%edi)
        return -1;
    11b7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
    11bc:	e8 f9 f6 ff ff       	call   8ba <kthread_mutex_unlock>
        return -1;
    11c1:	83 c4 10             	add    $0x10,%esp
    11c4:	eb e2                	jmp    11a8 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
    11c6:	83 ec 0c             	sub    $0xc,%esp
    11c9:	ff 37                	pushl  (%edi)
    11cb:	e8 ea f6 ff ff       	call   8ba <kthread_mutex_unlock>
        return -1;
    11d0:	83 c4 10             	add    $0x10,%esp
    11d3:	eb d3                	jmp    11a8 <trnmnt_tree_release+0x78>
