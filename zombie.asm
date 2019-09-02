
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 64 02 00 00       	call   27a <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 ee 02 00 00       	call   312 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 56 02 00 00       	call   282 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	83 c1 01             	add    $0x1,%ecx
  89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x40>
  90:	38 d8                	cmp    %bl,%al
  92:	74 ec                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  94:	29 d8                	sub    %ebx,%eax
}
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  d0:	31 c0                	xor    %eax,%eax
}
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 f6                	xor    %esi,%esi
 148:	89 f3                	mov    %esi,%ebx
{
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 158:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 32 01 00 00       	call   29a <read>
    if(cc < 1)
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 181:	83 c3 01             	add    $0x1,%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	89 fe                	mov    %edi,%esi
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 190:	c6 03 00             	movb   $0x0,(%ebx)
}
 193:	8d 65 f4             	lea    -0xc(%ebp),%esp
 196:	5b                   	pop    %ebx
 197:	5e                   	pop    %esi
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 de                	add    %ebx,%esi
 1a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 f0 00 00 00       	call   2c2 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 f3 00 00 00       	call   2da <fstat>
  close(fd);
 1e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ea:	89 c6                	mov    %eax,%esi
  close(fd);
 1ec:	e8 b9 00 00 00       	call   2aa <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
}
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
  n = 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 d3                	cmp    %edx,%ebx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    

0000027a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27a:	b8 01 00 00 00       	mov    $0x1,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <exit>:
SYSCALL(exit)
 282:	b8 02 00 00 00       	mov    $0x2,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <wait>:
SYSCALL(wait)
 28a:	b8 03 00 00 00       	mov    $0x3,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <pipe>:
SYSCALL(pipe)
 292:	b8 04 00 00 00       	mov    $0x4,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <read>:
SYSCALL(read)
 29a:	b8 05 00 00 00       	mov    $0x5,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <write>:
SYSCALL(write)
 2a2:	b8 10 00 00 00       	mov    $0x10,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <close>:
SYSCALL(close)
 2aa:	b8 15 00 00 00       	mov    $0x15,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <kill>:
SYSCALL(kill)
 2b2:	b8 06 00 00 00       	mov    $0x6,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <exec>:
SYSCALL(exec)
 2ba:	b8 07 00 00 00       	mov    $0x7,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <open>:
SYSCALL(open)
 2c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mknod>:
SYSCALL(mknod)
 2ca:	b8 11 00 00 00       	mov    $0x11,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <unlink>:
SYSCALL(unlink)
 2d2:	b8 12 00 00 00       	mov    $0x12,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <fstat>:
SYSCALL(fstat)
 2da:	b8 08 00 00 00       	mov    $0x8,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <link>:
SYSCALL(link)
 2e2:	b8 13 00 00 00       	mov    $0x13,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mkdir>:
SYSCALL(mkdir)
 2ea:	b8 14 00 00 00       	mov    $0x14,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <chdir>:
SYSCALL(chdir)
 2f2:	b8 09 00 00 00       	mov    $0x9,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <dup>:
SYSCALL(dup)
 2fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getpid>:
SYSCALL(getpid)
 302:	b8 0b 00 00 00       	mov    $0xb,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <sbrk>:
SYSCALL(sbrk)
 30a:	b8 0c 00 00 00       	mov    $0xc,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <sleep>:
SYSCALL(sleep)
 312:	b8 0d 00 00 00       	mov    $0xd,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <uptime>:
SYSCALL(uptime)
 31a:	b8 0e 00 00 00       	mov    $0xe,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <kthread_create>:
SYSCALL(kthread_create)
 322:	b8 16 00 00 00       	mov    $0x16,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <kthread_id>:
SYSCALL(kthread_id)
 32a:	b8 17 00 00 00       	mov    $0x17,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <kthread_exit>:
SYSCALL(kthread_exit)
 332:	b8 18 00 00 00       	mov    $0x18,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <kthread_join>:
SYSCALL(kthread_join)
 33a:	b8 19 00 00 00       	mov    $0x19,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 342:	b8 1a 00 00 00       	mov    $0x1a,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 34a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 352:	b8 1c 00 00 00       	mov    $0x1c,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 35a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    
 362:	66 90                	xchg   %ax,%ax
 364:	66 90                	xchg   %ax,%ax
 366:	66 90                	xchg   %ax,%ax
 368:	66 90                	xchg   %ax,%ax
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 379:	85 d2                	test   %edx,%edx
{
 37b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 37e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 380:	79 76                	jns    3f8 <printint+0x88>
 382:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 386:	74 70                	je     3f8 <printint+0x88>
    x = -xx;
 388:	f7 d8                	neg    %eax
    neg = 1;
 38a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 391:	31 f6                	xor    %esi,%esi
 393:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 396:	eb 0a                	jmp    3a2 <printint+0x32>
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3a0:	89 fe                	mov    %edi,%esi
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	8d 7e 01             	lea    0x1(%esi),%edi
 3a7:	f7 f1                	div    %ecx
 3a9:	0f b6 92 80 0c 00 00 	movzbl 0xc80(%edx),%edx
  }while((x /= base) != 0);
 3b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3b5:	75 e9                	jne    3a0 <printint+0x30>
  if(neg)
 3b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ba:	85 c0                	test   %eax,%eax
 3bc:	74 08                	je     3c6 <printint+0x56>
    buf[i++] = '-';
 3be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3c3:	8d 7e 02             	lea    0x2(%esi),%edi
 3c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3d3:	83 ec 04             	sub    $0x4,%esp
 3d6:	83 ee 01             	sub    $0x1,%esi
 3d9:	6a 01                	push   $0x1
 3db:	53                   	push   %ebx
 3dc:	57                   	push   %edi
 3dd:	88 45 d7             	mov    %al,-0x29(%ebp)
 3e0:	e8 bd fe ff ff       	call   2a2 <write>

  while(--i >= 0)
 3e5:	83 c4 10             	add    $0x10,%esp
 3e8:	39 de                	cmp    %ebx,%esi
 3ea:	75 e4                	jne    3d0 <printint+0x60>
    putc(fd, buf[i]);
}
 3ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ef:	5b                   	pop    %ebx
 3f0:	5e                   	pop    %esi
 3f1:	5f                   	pop    %edi
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3f8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3ff:	eb 90                	jmp    391 <printint+0x21>
 401:	eb 0d                	jmp    410 <printf>
 403:	90                   	nop
 404:	90                   	nop
 405:	90                   	nop
 406:	90                   	nop
 407:	90                   	nop
 408:	90                   	nop
 409:	90                   	nop
 40a:	90                   	nop
 40b:	90                   	nop
 40c:	90                   	nop
 40d:	90                   	nop
 40e:	90                   	nop
 40f:	90                   	nop

00000410 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 419:	8b 75 0c             	mov    0xc(%ebp),%esi
 41c:	0f b6 1e             	movzbl (%esi),%ebx
 41f:	84 db                	test   %bl,%bl
 421:	0f 84 b3 00 00 00    	je     4da <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 427:	8d 45 10             	lea    0x10(%ebp),%eax
 42a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 42d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 42f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 432:	eb 2f                	jmp    463 <printf+0x53>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	0f 84 a7 00 00 00    	je     4e8 <printf+0xd8>
  write(fd, &c, 1);
 441:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 444:	83 ec 04             	sub    $0x4,%esp
 447:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 44a:	6a 01                	push   $0x1
 44c:	50                   	push   %eax
 44d:	ff 75 08             	pushl  0x8(%ebp)
 450:	e8 4d fe ff ff       	call   2a2 <write>
 455:	83 c4 10             	add    $0x10,%esp
 458:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 45b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 45f:	84 db                	test   %bl,%bl
 461:	74 77                	je     4da <printf+0xca>
    if(state == 0){
 463:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 465:	0f be cb             	movsbl %bl,%ecx
 468:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 46b:	74 cb                	je     438 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 46d:	83 ff 25             	cmp    $0x25,%edi
 470:	75 e6                	jne    458 <printf+0x48>
      if(c == 'd'){
 472:	83 f8 64             	cmp    $0x64,%eax
 475:	0f 84 05 01 00 00    	je     580 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 47b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 481:	83 f9 70             	cmp    $0x70,%ecx
 484:	74 72                	je     4f8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 486:	83 f8 73             	cmp    $0x73,%eax
 489:	0f 84 99 00 00 00    	je     528 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48f:	83 f8 63             	cmp    $0x63,%eax
 492:	0f 84 08 01 00 00    	je     5a0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 498:	83 f8 25             	cmp    $0x25,%eax
 49b:	0f 84 ef 00 00 00    	je     590 <printf+0x180>
  write(fd, &c, 1);
 4a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a4:	83 ec 04             	sub    $0x4,%esp
 4a7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4ab:	6a 01                	push   $0x1
 4ad:	50                   	push   %eax
 4ae:	ff 75 08             	pushl  0x8(%ebp)
 4b1:	e8 ec fd ff ff       	call   2a2 <write>
 4b6:	83 c4 0c             	add    $0xc,%esp
 4b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4bc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4bf:	6a 01                	push   $0x1
 4c1:	50                   	push   %eax
 4c2:	ff 75 08             	pushl  0x8(%ebp)
 4c5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4ca:	e8 d3 fd ff ff       	call   2a2 <write>
  for(i = 0; fmt[i]; i++){
 4cf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 4d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4d6:	84 db                	test   %bl,%bl
 4d8:	75 89                	jne    463 <printf+0x53>
    }
  }
}
 4da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dd:	5b                   	pop    %ebx
 4de:	5e                   	pop    %esi
 4df:	5f                   	pop    %edi
 4e0:	5d                   	pop    %ebp
 4e1:	c3                   	ret    
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4e8:	bf 25 00 00 00       	mov    $0x25,%edi
 4ed:	e9 66 ff ff ff       	jmp    458 <printf+0x48>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 500:	6a 00                	push   $0x0
 502:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 505:	8b 45 08             	mov    0x8(%ebp),%eax
 508:	8b 17                	mov    (%edi),%edx
 50a:	e8 61 fe ff ff       	call   370 <printint>
        ap++;
 50f:	89 f8                	mov    %edi,%eax
 511:	83 c4 10             	add    $0x10,%esp
      state = 0;
 514:	31 ff                	xor    %edi,%edi
        ap++;
 516:	83 c0 04             	add    $0x4,%eax
 519:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 51c:	e9 37 ff ff ff       	jmp    458 <printf+0x48>
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 528:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 52b:	8b 08                	mov    (%eax),%ecx
        ap++;
 52d:	83 c0 04             	add    $0x4,%eax
 530:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 533:	85 c9                	test   %ecx,%ecx
 535:	0f 84 8e 00 00 00    	je     5c9 <printf+0x1b9>
        while(*s != 0){
 53b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 53e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 540:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 542:	84 c0                	test   %al,%al
 544:	0f 84 0e ff ff ff    	je     458 <printf+0x48>
 54a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 54d:	89 de                	mov    %ebx,%esi
 54f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 552:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 555:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 558:	83 ec 04             	sub    $0x4,%esp
          s++;
 55b:	83 c6 01             	add    $0x1,%esi
 55e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 561:	6a 01                	push   $0x1
 563:	57                   	push   %edi
 564:	53                   	push   %ebx
 565:	e8 38 fd ff ff       	call   2a2 <write>
        while(*s != 0){
 56a:	0f b6 06             	movzbl (%esi),%eax
 56d:	83 c4 10             	add    $0x10,%esp
 570:	84 c0                	test   %al,%al
 572:	75 e4                	jne    558 <printf+0x148>
 574:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 577:	31 ff                	xor    %edi,%edi
 579:	e9 da fe ff ff       	jmp    458 <printf+0x48>
 57e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
 588:	6a 01                	push   $0x1
 58a:	e9 73 ff ff ff       	jmp    502 <printf+0xf2>
 58f:	90                   	nop
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 596:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 599:	6a 01                	push   $0x1
 59b:	e9 21 ff ff ff       	jmp    4c1 <printf+0xb1>
        putc(fd, *ap);
 5a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5a6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5a8:	6a 01                	push   $0x1
        ap++;
 5aa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5ad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5b3:	50                   	push   %eax
 5b4:	ff 75 08             	pushl  0x8(%ebp)
 5b7:	e8 e6 fc ff ff       	call   2a2 <write>
        ap++;
 5bc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5bf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5c2:	31 ff                	xor    %edi,%edi
 5c4:	e9 8f fe ff ff       	jmp    458 <printf+0x48>
          s = "(null)";
 5c9:	bb 78 0c 00 00       	mov    $0xc78,%ebx
        while(*s != 0){
 5ce:	b8 28 00 00 00       	mov    $0x28,%eax
 5d3:	e9 72 ff ff ff       	jmp    54a <printf+0x13a>
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e1:	a1 80 10 00 00       	mov    0x1080,%eax
{
 5e6:	89 e5                	mov    %esp,%ebp
 5e8:	57                   	push   %edi
 5e9:	56                   	push   %esi
 5ea:	53                   	push   %ebx
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f8:	39 c8                	cmp    %ecx,%eax
 5fa:	8b 10                	mov    (%eax),%edx
 5fc:	73 32                	jae    630 <free+0x50>
 5fe:	39 d1                	cmp    %edx,%ecx
 600:	72 04                	jb     606 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 602:	39 d0                	cmp    %edx,%eax
 604:	72 32                	jb     638 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 606:	8b 73 fc             	mov    -0x4(%ebx),%esi
 609:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 60c:	39 fa                	cmp    %edi,%edx
 60e:	74 30                	je     640 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 610:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 613:	8b 50 04             	mov    0x4(%eax),%edx
 616:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 619:	39 f1                	cmp    %esi,%ecx
 61b:	74 3a                	je     657 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 61d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 61f:	a3 80 10 00 00       	mov    %eax,0x1080
}
 624:	5b                   	pop    %ebx
 625:	5e                   	pop    %esi
 626:	5f                   	pop    %edi
 627:	5d                   	pop    %ebp
 628:	c3                   	ret    
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 630:	39 d0                	cmp    %edx,%eax
 632:	72 04                	jb     638 <free+0x58>
 634:	39 d1                	cmp    %edx,%ecx
 636:	72 ce                	jb     606 <free+0x26>
{
 638:	89 d0                	mov    %edx,%eax
 63a:	eb bc                	jmp    5f8 <free+0x18>
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 640:	03 72 04             	add    0x4(%edx),%esi
 643:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 646:	8b 10                	mov    (%eax),%edx
 648:	8b 12                	mov    (%edx),%edx
 64a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	75 c6                	jne    61d <free+0x3d>
    p->s.size += bp->s.size;
 657:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 65a:	a3 80 10 00 00       	mov    %eax,0x1080
    p->s.size += bp->s.size;
 65f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 662:	8b 53 f8             	mov    -0x8(%ebx),%edx
 665:	89 10                	mov    %edx,(%eax)
}
 667:	5b                   	pop    %ebx
 668:	5e                   	pop    %esi
 669:	5f                   	pop    %edi
 66a:	5d                   	pop    %ebp
 66b:	c3                   	ret    
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 679:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 67c:	8b 15 80 10 00 00    	mov    0x1080,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 682:	8d 78 07             	lea    0x7(%eax),%edi
 685:	c1 ef 03             	shr    $0x3,%edi
 688:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 68b:	85 d2                	test   %edx,%edx
 68d:	0f 84 9d 00 00 00    	je     730 <malloc+0xc0>
 693:	8b 02                	mov    (%edx),%eax
 695:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 698:	39 cf                	cmp    %ecx,%edi
 69a:	76 6c                	jbe    708 <malloc+0x98>
 69c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6a7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6aa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6b1:	eb 0e                	jmp    6c1 <malloc+0x51>
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ba:	8b 48 04             	mov    0x4(%eax),%ecx
 6bd:	39 f9                	cmp    %edi,%ecx
 6bf:	73 47                	jae    708 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6c1:	39 05 80 10 00 00    	cmp    %eax,0x1080
 6c7:	89 c2                	mov    %eax,%edx
 6c9:	75 ed                	jne    6b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6cb:	83 ec 0c             	sub    $0xc,%esp
 6ce:	56                   	push   %esi
 6cf:	e8 36 fc ff ff       	call   30a <sbrk>
  if(p == (char*)-1)
 6d4:	83 c4 10             	add    $0x10,%esp
 6d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6da:	74 1c                	je     6f8 <malloc+0x88>
  hp->s.size = nu;
 6dc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6df:	83 ec 0c             	sub    $0xc,%esp
 6e2:	83 c0 08             	add    $0x8,%eax
 6e5:	50                   	push   %eax
 6e6:	e8 f5 fe ff ff       	call   5e0 <free>
  return freep;
 6eb:	8b 15 80 10 00 00    	mov    0x1080,%edx
      if((p = morecore(nunits)) == 0)
 6f1:	83 c4 10             	add    $0x10,%esp
 6f4:	85 d2                	test   %edx,%edx
 6f6:	75 c0                	jne    6b8 <malloc+0x48>
        return 0;
  }
}
 6f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6fb:	31 c0                	xor    %eax,%eax
}
 6fd:	5b                   	pop    %ebx
 6fe:	5e                   	pop    %esi
 6ff:	5f                   	pop    %edi
 700:	5d                   	pop    %ebp
 701:	c3                   	ret    
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 708:	39 cf                	cmp    %ecx,%edi
 70a:	74 54                	je     760 <malloc+0xf0>
        p->s.size -= nunits;
 70c:	29 f9                	sub    %edi,%ecx
 70e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 711:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 714:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 717:	89 15 80 10 00 00    	mov    %edx,0x1080
}
 71d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 720:	83 c0 08             	add    $0x8,%eax
}
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
 728:	90                   	nop
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 730:	c7 05 80 10 00 00 84 	movl   $0x1084,0x1080
 737:	10 00 00 
 73a:	c7 05 84 10 00 00 84 	movl   $0x1084,0x1084
 741:	10 00 00 
    base.s.size = 0;
 744:	b8 84 10 00 00       	mov    $0x1084,%eax
 749:	c7 05 88 10 00 00 00 	movl   $0x0,0x1088
 750:	00 00 00 
 753:	e9 44 ff ff ff       	jmp    69c <malloc+0x2c>
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 760:	8b 08                	mov    (%eax),%ecx
 762:	89 0a                	mov    %ecx,(%edx)
 764:	eb b1                	jmp    717 <malloc+0xa7>
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
 770:	55                   	push   %ebp
    int init = 2;
    int output = 1;
 771:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
 776:	89 e5                	mov    %esp,%ebp
 778:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
 77b:	85 d2                	test   %edx,%edx
 77d:	74 08                	je     787 <powordepth+0x17>
 77f:	90                   	nop
        output *= init;
 780:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 782:	83 ea 01             	sub    $0x1,%edx
 785:	75 f9                	jne    780 <powordepth+0x10>
        exp--;
    }
    return output;
}
 787:	5d                   	pop    %ebp
 788:	c3                   	ret    
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
 799:	6a 10                	push   $0x10
 79b:	e8 d0 fe ff ff       	call   670 <malloc>
 7a0:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
 7a2:	8b 45 08             	mov    0x8(%ebp),%eax
 7a5:	83 c4 10             	add    $0x10,%esp
 7a8:	83 e8 01             	sub    $0x1,%eax
 7ab:	83 f8 05             	cmp    $0x5,%eax
 7ae:	0f 87 f6 00 00 00    	ja     8aa <trnmnt_tree_alloc+0x11a>
 7b4:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
 7b7:	bf 01 00 00 00       	mov    $0x1,%edi
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 7c0:	01 ff                	add    %edi,%edi
    while (exp != 0) {
 7c2:	83 e8 01             	sub    $0x1,%eax
 7c5:	75 f9                	jne    7c0 <trnmnt_tree_alloc+0x30>
 7c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
 7ca:	8d 47 ff             	lea    -0x1(%edi),%eax
 7cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
 7d0:	8b 45 08             	mov    0x8(%ebp),%eax
 7d3:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
 7d6:	e8 67 fb ff ff       	call   342 <kthread_mutex_alloc>
 7db:	83 f8 ff             	cmp    $0xffffffff,%eax
 7de:	89 06                	mov    %eax,(%esi)
 7e0:	0f 84 34 01 00 00    	je     91a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
 7e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e9:	83 ec 0c             	sub    $0xc,%esp
 7ec:	c1 e0 02             	shl    $0x2,%eax
 7ef:	50                   	push   %eax
 7f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
 7f3:	e8 78 fe ff ff       	call   670 <malloc>
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	85 c0                	test   %eax,%eax
 7fd:	89 46 04             	mov    %eax,0x4(%esi)
 800:	0f 84 14 01 00 00    	je     91a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
 806:	31 db                	xor    %ebx,%ebx
 808:	eb 09                	jmp    813 <trnmnt_tree_alloc+0x83>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 810:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
 813:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
 816:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 819:	e8 24 fb ff ff       	call   342 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
 81e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 821:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
 823:	75 eb                	jne    810 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
 825:	8b 4e 04             	mov    0x4(%esi),%ecx
 828:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
 82b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
 830:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 833:	89 c8                	mov    %ecx,%eax
 835:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
 837:	31 c9                	xor    %ecx,%ecx
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
 840:	83 38 ff             	cmpl   $0xffffffff,(%eax)
 843:	0f 44 cf             	cmove  %edi,%ecx
 846:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
 849:	39 d0                	cmp    %edx,%eax
 84b:	75 f3                	jne    840 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
 84d:	85 c9                	test   %ecx,%ecx
 84f:	8b 7d 08             	mov    0x8(%ebp),%edi
 852:	b8 01 00 00 00       	mov    $0x1,%eax
 857:	0f 85 9b 00 00 00    	jne    8f8 <trnmnt_tree_alloc+0x168>
 85d:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
 860:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 862:	83 ef 01             	sub    $0x1,%edi
 865:	75 f9                	jne    860 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
 867:	83 ec 0c             	sub    $0xc,%esp
 86a:	c1 e0 02             	shl    $0x2,%eax
 86d:	50                   	push   %eax
 86e:	e8 fd fd ff ff       	call   670 <malloc>
 873:	83 c4 10             	add    $0x10,%esp
 876:	85 c0                	test   %eax,%eax
 878:	89 46 08             	mov    %eax,0x8(%esi)
 87b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 87e:	74 36                	je     8b6 <trnmnt_tree_alloc+0x126>
 880:	89 c8                	mov    %ecx,%eax
    int output = 1;
 882:	ba 01 00 00 00       	mov    $0x1,%edx
 887:	89 f6                	mov    %esi,%esi
 889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 890:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 892:	83 e8 01             	sub    $0x1,%eax
 895:	75 f9                	jne    890 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
 897:	39 d7                	cmp    %edx,%edi
 899:	7d 11                	jge    8ac <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
 89b:	8b 46 08             	mov    0x8(%esi),%eax
 89e:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
 8a5:	83 c7 01             	add    $0x1,%edi
 8a8:	eb d6                	jmp    880 <trnmnt_tree_alloc+0xf0>
        return 0;
 8aa:	31 f6                	xor    %esi,%esi

    return output;
}
 8ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8af:	89 f0                	mov    %esi,%eax
 8b1:	5b                   	pop    %ebx
 8b2:	5e                   	pop    %esi
 8b3:	5f                   	pop    %edi
 8b4:	5d                   	pop    %ebp
 8b5:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
 8b6:	8b 46 04             	mov    0x4(%esi),%eax
 8b9:	83 ec 0c             	sub    $0xc,%esp
 8bc:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 8bf:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 8c2:	e8 83 fa ff ff       	call   34a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 8c7:	83 c4 10             	add    $0x10,%esp
 8ca:	39 df                	cmp    %ebx,%edi
 8cc:	75 e8                	jne    8b6 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
 8ce:	83 ec 0c             	sub    $0xc,%esp
 8d1:	ff 36                	pushl  (%esi)
 8d3:	e8 72 fa ff ff       	call   34a <kthread_mutex_dealloc>
        free(output->mutextree);
 8d8:	58                   	pop    %eax
 8d9:	ff 76 04             	pushl  0x4(%esi)
 8dc:	e8 ff fc ff ff       	call   5e0 <free>
        free(output);
 8e1:	89 34 24             	mov    %esi,(%esp)
        return 0;
 8e4:	31 f6                	xor    %esi,%esi
        free(output);
 8e6:	e8 f5 fc ff ff       	call   5e0 <free>
        return 0;
 8eb:	83 c4 10             	add    $0x10,%esp
}
 8ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8f1:	89 f0                	mov    %esi,%eax
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	8b 7d dc             	mov    -0x24(%ebp),%edi
 8fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8fe:	eb 03                	jmp    903 <trnmnt_tree_alloc+0x173>
 900:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
 903:	83 ec 0c             	sub    $0xc,%esp
 906:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 909:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 90c:	e8 39 fa ff ff       	call   34a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 911:	83 c4 10             	add    $0x10,%esp
 914:	39 df                	cmp    %ebx,%edi
 916:	75 e8                	jne    900 <trnmnt_tree_alloc+0x170>
 918:	eb b4                	jmp    8ce <trnmnt_tree_alloc+0x13e>
        free(output);
 91a:	83 ec 0c             	sub    $0xc,%esp
 91d:	56                   	push   %esi
        return 0;
 91e:	31 f6                	xor    %esi,%esi
        free(output);
 920:	e8 bb fc ff ff       	call   5e0 <free>
        return 0;
 925:	83 c4 10             	add    $0x10,%esp
 928:	eb 82                	jmp    8ac <trnmnt_tree_alloc+0x11c>
 92a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000930 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
 936:	83 ec 28             	sub    $0x28,%esp
 939:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
 93c:	ff 36                	pushl  (%esi)
 93e:	e8 0f fa ff ff       	call   352 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
 943:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
 946:	83 c4 10             	add    $0x10,%esp
 949:	85 ff                	test   %edi,%edi
 94b:	0f 84 0b 01 00 00    	je     a5c <trnmnt_tree_dealloc+0x12c>
 951:	89 f8                	mov    %edi,%eax
    int output = 1;
 953:	bb 01 00 00 00       	mov    $0x1,%ebx
 958:	90                   	nop
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 960:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
 962:	83 e8 01             	sub    $0x1,%eax
 965:	75 f9                	jne    960 <trnmnt_tree_dealloc+0x30>
 967:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
 96a:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
 96c:	85 ff                	test   %edi,%edi
 96e:	74 2f                	je     99f <trnmnt_tree_dealloc+0x6f>
 970:	89 f8                	mov    %edi,%eax
    int output = 1;
 972:	ba 01 00 00 00       	mov    $0x1,%edx
 977:	89 f6                	mov    %esi,%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 980:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 982:	83 e8 01             	sub    $0x1,%eax
 985:	75 f9                	jne    980 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
 987:	39 d1                	cmp    %edx,%ecx
 989:	7d 25                	jge    9b0 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
 98b:	8b 46 08             	mov    0x8(%esi),%eax
 98e:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
 992:	0f 85 a8 00 00 00    	jne    a40 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
 998:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
 99b:	85 ff                	test   %edi,%edi
 99d:	75 d1                	jne    970 <trnmnt_tree_dealloc+0x40>
    int output = 1;
 99f:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
 9a4:	39 d1                	cmp    %edx,%ecx
 9a6:	7c e3                	jl     98b <trnmnt_tree_dealloc+0x5b>
 9a8:	90                   	nop
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
 9b0:	85 db                	test   %ebx,%ebx
 9b2:	74 46                	je     9fa <trnmnt_tree_dealloc+0xca>
 9b4:	31 ff                	xor    %edi,%edi
 9b6:	eb 0f                	jmp    9c7 <trnmnt_tree_dealloc+0x97>
 9b8:	90                   	nop
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9c0:	83 c7 01             	add    $0x1,%edi
 9c3:	39 fb                	cmp    %edi,%ebx
 9c5:	74 33                	je     9fa <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
 9c7:	8b 46 04             	mov    0x4(%esi),%eax
 9ca:	83 ec 0c             	sub    $0xc,%esp
 9cd:	ff 34 b8             	pushl  (%eax,%edi,4)
 9d0:	e8 75 f9 ff ff       	call   34a <kthread_mutex_dealloc>
 9d5:	83 c4 10             	add    $0x10,%esp
 9d8:	83 f8 ff             	cmp    $0xffffffff,%eax
 9db:	75 e3                	jne    9c0 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
 9dd:	83 ec 0c             	sub    $0xc,%esp
 9e0:	ff 36                	pushl  (%esi)
 9e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 9e5:	e8 70 f9 ff ff       	call   35a <kthread_mutex_unlock>
            return -1;
 9ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 9ed:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
 9f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9f3:	5b                   	pop    %ebx
 9f4:	89 d0                	mov    %edx,%eax
 9f6:	5e                   	pop    %esi
 9f7:	5f                   	pop    %edi
 9f8:	5d                   	pop    %ebp
 9f9:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	ff 36                	pushl  (%esi)
 9ff:	e8 56 f9 ff ff       	call   35a <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
 a04:	58                   	pop    %eax
 a05:	ff 36                	pushl  (%esi)
 a07:	e8 3e f9 ff ff       	call   34a <kthread_mutex_dealloc>
    free(tree->threadMap);
 a0c:	5a                   	pop    %edx
 a0d:	ff 76 08             	pushl  0x8(%esi)
 a10:	e8 cb fb ff ff       	call   5e0 <free>
    free(tree->mutextree);
 a15:	59                   	pop    %ecx
 a16:	ff 76 04             	pushl  0x4(%esi)
 a19:	e8 c2 fb ff ff       	call   5e0 <free>
    free(tree);
 a1e:	89 34 24             	mov    %esi,(%esp)
 a21:	e8 ba fb ff ff       	call   5e0 <free>
    tree->depth = 0;
 a26:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
 a2d:	83 c4 10             	add    $0x10,%esp
}
 a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 a33:	31 d2                	xor    %edx,%edx
}
 a35:	5b                   	pop    %ebx
 a36:	89 d0                	mov    %edx,%eax
 a38:	5e                   	pop    %esi
 a39:	5f                   	pop    %edi
 a3a:	5d                   	pop    %ebp
 a3b:	c3                   	ret    
 a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
 a40:	83 ec 0c             	sub    $0xc,%esp
 a43:	ff 36                	pushl  (%esi)
 a45:	e8 10 f9 ff ff       	call   35a <kthread_mutex_unlock>
            return -1;
 a4a:	83 c4 10             	add    $0x10,%esp
}
 a4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
 a50:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
 a55:	89 d0                	mov    %edx,%eax
 a57:	5b                   	pop    %ebx
 a58:	5e                   	pop    %esi
 a59:	5f                   	pop    %edi
 a5a:	5d                   	pop    %ebp
 a5b:	c3                   	ret    
    while (exp != 0) {
 a5c:	31 db                	xor    %ebx,%ebx
 a5e:	e9 07 ff ff ff       	jmp    96a <trnmnt_tree_dealloc+0x3a>
 a63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a70 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	83 ec 0c             	sub    $0xc,%esp
 a79:	8b 7d 0c             	mov    0xc(%ebp),%edi
 a7c:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 a7f:	85 ff                	test   %edi,%edi
 a81:	0f 88 d1 00 00 00    	js     b58 <trnmnt_tree_acquire+0xe8>
 a87:	85 f6                	test   %esi,%esi
 a89:	0f 84 c9 00 00 00    	je     b58 <trnmnt_tree_acquire+0xe8>
 a8f:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
 a92:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
 a97:	85 c0                	test   %eax,%eax
 a99:	74 0c                	je     aa7 <trnmnt_tree_acquire+0x37>
 a9b:	90                   	nop
 a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 aa0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 aa2:	83 e8 01             	sub    $0x1,%eax
 aa5:	75 f9                	jne    aa0 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 aa7:	39 d7                	cmp    %edx,%edi
 aa9:	0f 8d a9 00 00 00    	jge    b58 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
 aaf:	83 ec 0c             	sub    $0xc,%esp
 ab2:	ff 36                	pushl  (%esi)
 ab4:	e8 99 f8 ff ff       	call   352 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
 ab9:	8b 46 08             	mov    0x8(%esi),%eax
 abc:	83 c4 10             	add    $0x10,%esp
 abf:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
 ac2:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 ac5:	0f 85 94 00 00 00    	jne    b5f <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
 acb:	e8 5a f8 ff ff       	call   32a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
 ad0:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
 ad3:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
 ad5:	ff 36                	pushl  (%esi)
 ad7:	e8 7e f8 ff ff       	call   35a <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
 adc:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
 adf:	83 c4 10             	add    $0x10,%esp
 ae2:	85 c0                	test   %eax,%eax
 ae4:	74 5a                	je     b40 <trnmnt_tree_acquire+0xd0>
    int output = 1;
 ae6:	ba 01 00 00 00       	mov    $0x1,%edx
 aeb:	90                   	nop
 aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 af0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 af2:	83 e8 01             	sub    $0x1,%eax
 af5:	75 f9                	jne    af0 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
 af7:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
 afb:	89 c3                	mov    %eax,%ebx
 afd:	c1 eb 1f             	shr    $0x1f,%ebx
 b00:	01 c3                	add    %eax,%ebx
 b02:	d1 fb                	sar    %ebx
 b04:	eb 0c                	jmp    b12 <trnmnt_tree_acquire+0xa2>
 b06:	8d 76 00             	lea    0x0(%esi),%esi
 b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
 b10:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
 b12:	8b 46 04             	mov    0x4(%esi),%eax
 b15:	83 ec 0c             	sub    $0xc,%esp
 b18:	ff 34 98             	pushl  (%eax,%ebx,4)
 b1b:	e8 32 f8 ff ff       	call   352 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
 b20:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
 b23:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
 b26:	89 d0                	mov    %edx,%eax
 b28:	c1 e8 1f             	shr    $0x1f,%eax
 b2b:	01 d0                	add    %edx,%eax
 b2d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
 b2f:	85 db                	test   %ebx,%ebx
 b31:	75 dd                	jne    b10 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
 b33:	31 c0                	xor    %eax,%eax
}
 b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b38:	5b                   	pop    %ebx
 b39:	5e                   	pop    %esi
 b3a:	5f                   	pop    %edi
 b3b:	5d                   	pop    %ebp
 b3c:	c3                   	ret    
 b3d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
 b40:	8d 47 ff             	lea    -0x1(%edi),%eax
 b43:	89 c3                	mov    %eax,%ebx
 b45:	c1 eb 1f             	shr    $0x1f,%ebx
 b48:	01 c3                	add    %eax,%ebx
 b4a:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
 b4c:	85 ff                	test   %edi,%edi
 b4e:	74 e3                	je     b33 <trnmnt_tree_acquire+0xc3>
 b50:	eb c0                	jmp    b12 <trnmnt_tree_acquire+0xa2>
 b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b5d:	eb d6                	jmp    b35 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
 b5f:	83 ec 0c             	sub    $0xc,%esp
 b62:	ff 36                	pushl  (%esi)
 b64:	e8 f1 f7 ff ff       	call   35a <kthread_mutex_unlock>
        return -1;
 b69:	83 c4 10             	add    $0x10,%esp
 b6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b71:	eb c2                	jmp    b35 <trnmnt_tree_acquire+0xc5>
 b73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b80 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	56                   	push   %esi
 b84:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
 b85:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 b88:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
 b8b:	8d 50 ff             	lea    -0x1(%eax),%edx
 b8e:	89 d0                	mov    %edx,%eax
 b90:	c1 e8 1f             	shr    $0x1f,%eax
 b93:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
 b95:	d1 f8                	sar    %eax
 b97:	89 c3                	mov    %eax,%ebx
 b99:	75 15                	jne    bb0 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 b9b:	8b 46 04             	mov    0x4(%esi),%eax
 b9e:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 ba1:	89 45 08             	mov    %eax,0x8(%ebp)
}
 ba4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ba7:	5b                   	pop    %ebx
 ba8:	5e                   	pop    %esi
 ba9:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 baa:	e9 ab f7 ff ff       	jmp    35a <kthread_mutex_unlock>
 baf:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
 bb0:	83 ec 08             	sub    $0x8,%esp
 bb3:	50                   	push   %eax
 bb4:	56                   	push   %esi
 bb5:	e8 c6 ff ff ff       	call   b80 <trnmnt_tree_release_rec>
 bba:	83 c4 10             	add    $0x10,%esp
 bbd:	83 f8 ff             	cmp    $0xffffffff,%eax
 bc0:	75 d9                	jne    b9b <trnmnt_tree_release_rec+0x1b>
}
 bc2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 bc5:	5b                   	pop    %ebx
 bc6:	5e                   	pop    %esi
 bc7:	5d                   	pop    %ebp
 bc8:	c3                   	ret    
 bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000bd0 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
 bd0:	55                   	push   %ebp
 bd1:	89 e5                	mov    %esp,%ebp
 bd3:	57                   	push   %edi
 bd4:	56                   	push   %esi
 bd5:	53                   	push   %ebx
 bd6:	83 ec 28             	sub    $0x28,%esp
 bd9:	8b 7d 08             	mov    0x8(%ebp),%edi
 bdc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
 bdf:	ff 37                	pushl  (%edi)
 be1:	e8 6c f7 ff ff       	call   352 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
 be6:	8b 47 08             	mov    0x8(%edi),%eax
 be9:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 bec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 bef:	e8 36 f7 ff ff       	call   32a <kthread_id>
 bf4:	83 c4 10             	add    $0x10,%esp
 bf7:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
 bfa:	75 56                	jne    c52 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 bfc:	8b 47 0c             	mov    0xc(%edi),%eax
 bff:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
 c06:	85 c0                	test   %eax,%eax
 c08:	74 11                	je     c1b <trnmnt_tree_release+0x4b>
    int output = 1;
 c0a:	b9 01 00 00 00       	mov    $0x1,%ecx
 c0f:	90                   	nop
        output *= init;
 c10:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
 c12:	83 e8 01             	sub    $0x1,%eax
 c15:	75 f9                	jne    c10 <trnmnt_tree_release+0x40>
 c17:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 c1b:	83 ec 08             	sub    $0x8,%esp
 c1e:	53                   	push   %ebx
 c1f:	57                   	push   %edi
 c20:	e8 5b ff ff ff       	call   b80 <trnmnt_tree_release_rec>
 c25:	83 c4 10             	add    $0x10,%esp
 c28:	83 f8 ff             	cmp    $0xffffffff,%eax
 c2b:	89 c3                	mov    %eax,%ebx
 c2d:	74 37                	je     c66 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
 c2f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
 c32:	83 ec 0c             	sub    $0xc,%esp
    return 0;
 c35:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
 c37:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
 c3e:	ff 37                	pushl  (%edi)
 c40:	e8 15 f7 ff ff       	call   35a <kthread_mutex_unlock>
    return 0;
 c45:	83 c4 10             	add    $0x10,%esp
}
 c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c4b:	89 d8                	mov    %ebx,%eax
 c4d:	5b                   	pop    %ebx
 c4e:	5e                   	pop    %esi
 c4f:	5f                   	pop    %edi
 c50:	5d                   	pop    %ebp
 c51:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
 c52:	83 ec 0c             	sub    $0xc,%esp
 c55:	ff 37                	pushl  (%edi)
        return -1;
 c57:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
 c5c:	e8 f9 f6 ff ff       	call   35a <kthread_mutex_unlock>
        return -1;
 c61:	83 c4 10             	add    $0x10,%esp
 c64:	eb e2                	jmp    c48 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
 c66:	83 ec 0c             	sub    $0xc,%esp
 c69:	ff 37                	pushl  (%edi)
 c6b:	e8 ea f6 ff ff       	call   35a <kthread_mutex_unlock>
        return -1;
 c70:	83 c4 10             	add    $0x10,%esp
 c73:	eb d3                	jmp    c48 <trnmnt_tree_release+0x78>
