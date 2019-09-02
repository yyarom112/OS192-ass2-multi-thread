
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  13:	8b 01                	mov    (%ecx),%eax
  15:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  18:	83 f8 01             	cmp    $0x1,%eax
  1b:	7e 2c                	jle    49 <main+0x49>
  1d:	8d 5a 04             	lea    0x4(%edx),%ebx
  20:	8d 34 82             	lea    (%edx,%eax,4),%esi
  23:	90                   	nop
  24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	ff 33                	pushl  (%ebx)
  2d:	83 c3 04             	add    $0x4,%ebx
  30:	e8 0b 02 00 00       	call   240 <atoi>
  35:	89 04 24             	mov    %eax,(%esp)
  38:	e8 a5 02 00 00       	call   2e2 <kill>
  for(i=1; i<argc; i++)
  3d:	83 c4 10             	add    $0x10,%esp
  40:	39 f3                	cmp    %esi,%ebx
  42:	75 e4                	jne    28 <main+0x28>
  exit();
  44:	e8 69 02 00 00       	call   2b2 <exit>
    printf(2, "usage: kill pid...\n");
  49:	50                   	push   %eax
  4a:	50                   	push   %eax
  4b:	68 a8 0c 00 00       	push   $0xca8
  50:	6a 02                	push   $0x2
  52:	e8 e9 03 00 00       	call   440 <printf>
    exit();
  57:	e8 56 02 00 00       	call   2b2 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c4:	29 d8                	sub    %ebx,%eax
}
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
{
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 32 01 00 00       	call   2ca <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 f0 00 00 00       	call   2f2 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 f3 00 00 00       	call   30a <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 b9 00 00 00       	call   2da <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
  return vdst;
}
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    

000002aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2aa:	b8 01 00 00 00       	mov    $0x1,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <exit>:
SYSCALL(exit)
 2b2:	b8 02 00 00 00       	mov    $0x2,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <wait>:
SYSCALL(wait)
 2ba:	b8 03 00 00 00       	mov    $0x3,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <pipe>:
SYSCALL(pipe)
 2c2:	b8 04 00 00 00       	mov    $0x4,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <read>:
SYSCALL(read)
 2ca:	b8 05 00 00 00       	mov    $0x5,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <write>:
SYSCALL(write)
 2d2:	b8 10 00 00 00       	mov    $0x10,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <close>:
SYSCALL(close)
 2da:	b8 15 00 00 00       	mov    $0x15,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kill>:
SYSCALL(kill)
 2e2:	b8 06 00 00 00       	mov    $0x6,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <exec>:
SYSCALL(exec)
 2ea:	b8 07 00 00 00       	mov    $0x7,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <open>:
SYSCALL(open)
 2f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mknod>:
SYSCALL(mknod)
 2fa:	b8 11 00 00 00       	mov    $0x11,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <unlink>:
SYSCALL(unlink)
 302:	b8 12 00 00 00       	mov    $0x12,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <fstat>:
SYSCALL(fstat)
 30a:	b8 08 00 00 00       	mov    $0x8,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <link>:
SYSCALL(link)
 312:	b8 13 00 00 00       	mov    $0x13,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <mkdir>:
SYSCALL(mkdir)
 31a:	b8 14 00 00 00       	mov    $0x14,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <chdir>:
SYSCALL(chdir)
 322:	b8 09 00 00 00       	mov    $0x9,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <dup>:
SYSCALL(dup)
 32a:	b8 0a 00 00 00       	mov    $0xa,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getpid>:
SYSCALL(getpid)
 332:	b8 0b 00 00 00       	mov    $0xb,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <sbrk>:
SYSCALL(sbrk)
 33a:	b8 0c 00 00 00       	mov    $0xc,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <sleep>:
SYSCALL(sleep)
 342:	b8 0d 00 00 00       	mov    $0xd,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <uptime>:
SYSCALL(uptime)
 34a:	b8 0e 00 00 00       	mov    $0xe,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kthread_create>:
SYSCALL(kthread_create)
 352:	b8 16 00 00 00       	mov    $0x16,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <kthread_id>:
SYSCALL(kthread_id)
 35a:	b8 17 00 00 00       	mov    $0x17,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kthread_exit>:
SYSCALL(kthread_exit)
 362:	b8 18 00 00 00       	mov    $0x18,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <kthread_join>:
SYSCALL(kthread_join)
 36a:	b8 19 00 00 00       	mov    $0x19,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 372:	b8 1a 00 00 00       	mov    $0x1a,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 37a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 382:	b8 1c 00 00 00       	mov    $0x1c,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 38a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    
 392:	66 90                	xchg   %ax,%ax
 394:	66 90                	xchg   %ax,%ax
 396:	66 90                	xchg   %ax,%ax
 398:	66 90                	xchg   %ax,%ax
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a9:	85 d2                	test   %edx,%edx
{
 3ab:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 3ae:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 3b0:	79 76                	jns    428 <printint+0x88>
 3b2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3b6:	74 70                	je     428 <printint+0x88>
    x = -xx;
 3b8:	f7 d8                	neg    %eax
    neg = 1;
 3ba:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3c1:	31 f6                	xor    %esi,%esi
 3c3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3c6:	eb 0a                	jmp    3d2 <printint+0x32>
 3c8:	90                   	nop
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3d0:	89 fe                	mov    %edi,%esi
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	8d 7e 01             	lea    0x1(%esi),%edi
 3d7:	f7 f1                	div    %ecx
 3d9:	0f b6 92 c4 0c 00 00 	movzbl 0xcc4(%edx),%edx
  }while((x /= base) != 0);
 3e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3e2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3e5:	75 e9                	jne    3d0 <printint+0x30>
  if(neg)
 3e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ea:	85 c0                	test   %eax,%eax
 3ec:	74 08                	je     3f6 <printint+0x56>
    buf[i++] = '-';
 3ee:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3f3:	8d 7e 02             	lea    0x2(%esi),%edi
 3f6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3fa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 403:	83 ec 04             	sub    $0x4,%esp
 406:	83 ee 01             	sub    $0x1,%esi
 409:	6a 01                	push   $0x1
 40b:	53                   	push   %ebx
 40c:	57                   	push   %edi
 40d:	88 45 d7             	mov    %al,-0x29(%ebp)
 410:	e8 bd fe ff ff       	call   2d2 <write>

  while(--i >= 0)
 415:	83 c4 10             	add    $0x10,%esp
 418:	39 de                	cmp    %ebx,%esi
 41a:	75 e4                	jne    400 <printint+0x60>
    putc(fd, buf[i]);
}
 41c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 41f:	5b                   	pop    %ebx
 420:	5e                   	pop    %esi
 421:	5f                   	pop    %edi
 422:	5d                   	pop    %ebp
 423:	c3                   	ret    
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 428:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 42f:	eb 90                	jmp    3c1 <printint+0x21>
 431:	eb 0d                	jmp    440 <printf>
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
 446:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 449:	8b 75 0c             	mov    0xc(%ebp),%esi
 44c:	0f b6 1e             	movzbl (%esi),%ebx
 44f:	84 db                	test   %bl,%bl
 451:	0f 84 b3 00 00 00    	je     50a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 457:	8d 45 10             	lea    0x10(%ebp),%eax
 45a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 45d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 45f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 462:	eb 2f                	jmp    493 <printf+0x53>
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 468:	83 f8 25             	cmp    $0x25,%eax
 46b:	0f 84 a7 00 00 00    	je     518 <printf+0xd8>
  write(fd, &c, 1);
 471:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 474:	83 ec 04             	sub    $0x4,%esp
 477:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 47a:	6a 01                	push   $0x1
 47c:	50                   	push   %eax
 47d:	ff 75 08             	pushl  0x8(%ebp)
 480:	e8 4d fe ff ff       	call   2d2 <write>
 485:	83 c4 10             	add    $0x10,%esp
 488:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 48b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 48f:	84 db                	test   %bl,%bl
 491:	74 77                	je     50a <printf+0xca>
    if(state == 0){
 493:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 495:	0f be cb             	movsbl %bl,%ecx
 498:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 49b:	74 cb                	je     468 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 49d:	83 ff 25             	cmp    $0x25,%edi
 4a0:	75 e6                	jne    488 <printf+0x48>
      if(c == 'd'){
 4a2:	83 f8 64             	cmp    $0x64,%eax
 4a5:	0f 84 05 01 00 00    	je     5b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4ab:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4b1:	83 f9 70             	cmp    $0x70,%ecx
 4b4:	74 72                	je     528 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4b6:	83 f8 73             	cmp    $0x73,%eax
 4b9:	0f 84 99 00 00 00    	je     558 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4bf:	83 f8 63             	cmp    $0x63,%eax
 4c2:	0f 84 08 01 00 00    	je     5d0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	0f 84 ef 00 00 00    	je     5c0 <printf+0x180>
  write(fd, &c, 1);
 4d1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d4:	83 ec 04             	sub    $0x4,%esp
 4d7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4db:	6a 01                	push   $0x1
 4dd:	50                   	push   %eax
 4de:	ff 75 08             	pushl  0x8(%ebp)
 4e1:	e8 ec fd ff ff       	call   2d2 <write>
 4e6:	83 c4 0c             	add    $0xc,%esp
 4e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4ec:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4ef:	6a 01                	push   $0x1
 4f1:	50                   	push   %eax
 4f2:	ff 75 08             	pushl  0x8(%ebp)
 4f5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4fa:	e8 d3 fd ff ff       	call   2d2 <write>
  for(i = 0; fmt[i]; i++){
 4ff:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 503:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 506:	84 db                	test   %bl,%bl
 508:	75 89                	jne    493 <printf+0x53>
    }
  }
}
 50a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50d:	5b                   	pop    %ebx
 50e:	5e                   	pop    %esi
 50f:	5f                   	pop    %edi
 510:	5d                   	pop    %ebp
 511:	c3                   	ret    
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 518:	bf 25 00 00 00       	mov    $0x25,%edi
 51d:	e9 66 ff ff ff       	jmp    488 <printf+0x48>
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 528:	83 ec 0c             	sub    $0xc,%esp
 52b:	b9 10 00 00 00       	mov    $0x10,%ecx
 530:	6a 00                	push   $0x0
 532:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 535:	8b 45 08             	mov    0x8(%ebp),%eax
 538:	8b 17                	mov    (%edi),%edx
 53a:	e8 61 fe ff ff       	call   3a0 <printint>
        ap++;
 53f:	89 f8                	mov    %edi,%eax
 541:	83 c4 10             	add    $0x10,%esp
      state = 0;
 544:	31 ff                	xor    %edi,%edi
        ap++;
 546:	83 c0 04             	add    $0x4,%eax
 549:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 54c:	e9 37 ff ff ff       	jmp    488 <printf+0x48>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 55b:	8b 08                	mov    (%eax),%ecx
        ap++;
 55d:	83 c0 04             	add    $0x4,%eax
 560:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 563:	85 c9                	test   %ecx,%ecx
 565:	0f 84 8e 00 00 00    	je     5f9 <printf+0x1b9>
        while(*s != 0){
 56b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 56e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 570:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 572:	84 c0                	test   %al,%al
 574:	0f 84 0e ff ff ff    	je     488 <printf+0x48>
 57a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 57d:	89 de                	mov    %ebx,%esi
 57f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 582:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 585:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 588:	83 ec 04             	sub    $0x4,%esp
          s++;
 58b:	83 c6 01             	add    $0x1,%esi
 58e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 591:	6a 01                	push   $0x1
 593:	57                   	push   %edi
 594:	53                   	push   %ebx
 595:	e8 38 fd ff ff       	call   2d2 <write>
        while(*s != 0){
 59a:	0f b6 06             	movzbl (%esi),%eax
 59d:	83 c4 10             	add    $0x10,%esp
 5a0:	84 c0                	test   %al,%al
 5a2:	75 e4                	jne    588 <printf+0x148>
 5a4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 5a7:	31 ff                	xor    %edi,%edi
 5a9:	e9 da fe ff ff       	jmp    488 <printf+0x48>
 5ae:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 5b0:	83 ec 0c             	sub    $0xc,%esp
 5b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5b8:	6a 01                	push   $0x1
 5ba:	e9 73 ff ff ff       	jmp    532 <printf+0xf2>
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5c6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5c9:	6a 01                	push   $0x1
 5cb:	e9 21 ff ff ff       	jmp    4f1 <printf+0xb1>
        putc(fd, *ap);
 5d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5d3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5d6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5d8:	6a 01                	push   $0x1
        ap++;
 5da:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5dd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5e0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 e6 fc ff ff       	call   2d2 <write>
        ap++;
 5ec:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5ef:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f2:	31 ff                	xor    %edi,%edi
 5f4:	e9 8f fe ff ff       	jmp    488 <printf+0x48>
          s = "(null)";
 5f9:	bb bc 0c 00 00       	mov    $0xcbc,%ebx
        while(*s != 0){
 5fe:	b8 28 00 00 00       	mov    $0x28,%eax
 603:	e9 72 ff ff ff       	jmp    57a <printf+0x13a>
 608:	66 90                	xchg   %ax,%ax
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 c0 10 00 00       	mov    0x10c0,%eax
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 61e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 628:	39 c8                	cmp    %ecx,%eax
 62a:	8b 10                	mov    (%eax),%edx
 62c:	73 32                	jae    660 <free+0x50>
 62e:	39 d1                	cmp    %edx,%ecx
 630:	72 04                	jb     636 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 632:	39 d0                	cmp    %edx,%eax
 634:	72 32                	jb     668 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 636:	8b 73 fc             	mov    -0x4(%ebx),%esi
 639:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 63c:	39 fa                	cmp    %edi,%edx
 63e:	74 30                	je     670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 640:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 643:	8b 50 04             	mov    0x4(%eax),%edx
 646:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 649:	39 f1                	cmp    %esi,%ecx
 64b:	74 3a                	je     687 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 64d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 64f:	a3 c0 10 00 00       	mov    %eax,0x10c0
}
 654:	5b                   	pop    %ebx
 655:	5e                   	pop    %esi
 656:	5f                   	pop    %edi
 657:	5d                   	pop    %ebp
 658:	c3                   	ret    
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 04                	jb     668 <free+0x58>
 664:	39 d1                	cmp    %edx,%ecx
 666:	72 ce                	jb     636 <free+0x26>
{
 668:	89 d0                	mov    %edx,%eax
 66a:	eb bc                	jmp    628 <free+0x18>
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 670:	03 72 04             	add    0x4(%edx),%esi
 673:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 676:	8b 10                	mov    (%eax),%edx
 678:	8b 12                	mov    (%edx),%edx
 67a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 50 04             	mov    0x4(%eax),%edx
 680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	75 c6                	jne    64d <free+0x3d>
    p->s.size += bp->s.size;
 687:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 68a:	a3 c0 10 00 00       	mov    %eax,0x10c0
    p->s.size += bp->s.size;
 68f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 692:	8b 53 f8             	mov    -0x8(%ebx),%edx
 695:	89 10                	mov    %edx,(%eax)
}
 697:	5b                   	pop    %ebx
 698:	5e                   	pop    %esi
 699:	5f                   	pop    %edi
 69a:	5d                   	pop    %ebp
 69b:	c3                   	ret    
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 15 c0 10 00 00    	mov    0x10c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	8d 78 07             	lea    0x7(%eax),%edi
 6b5:	c1 ef 03             	shr    $0x3,%edi
 6b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6bb:	85 d2                	test   %edx,%edx
 6bd:	0f 84 9d 00 00 00    	je     760 <malloc+0xc0>
 6c3:	8b 02                	mov    (%edx),%eax
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c8:	39 cf                	cmp    %ecx,%edi
 6ca:	76 6c                	jbe    738 <malloc+0x98>
 6cc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6d2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6d7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6da:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6e1:	eb 0e                	jmp    6f1 <malloc+0x51>
 6e3:	90                   	nop
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ea:	8b 48 04             	mov    0x4(%eax),%ecx
 6ed:	39 f9                	cmp    %edi,%ecx
 6ef:	73 47                	jae    738 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f1:	39 05 c0 10 00 00    	cmp    %eax,0x10c0
 6f7:	89 c2                	mov    %eax,%edx
 6f9:	75 ed                	jne    6e8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6fb:	83 ec 0c             	sub    $0xc,%esp
 6fe:	56                   	push   %esi
 6ff:	e8 36 fc ff ff       	call   33a <sbrk>
  if(p == (char*)-1)
 704:	83 c4 10             	add    $0x10,%esp
 707:	83 f8 ff             	cmp    $0xffffffff,%eax
 70a:	74 1c                	je     728 <malloc+0x88>
  hp->s.size = nu;
 70c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 70f:	83 ec 0c             	sub    $0xc,%esp
 712:	83 c0 08             	add    $0x8,%eax
 715:	50                   	push   %eax
 716:	e8 f5 fe ff ff       	call   610 <free>
  return freep;
 71b:	8b 15 c0 10 00 00    	mov    0x10c0,%edx
      if((p = morecore(nunits)) == 0)
 721:	83 c4 10             	add    $0x10,%esp
 724:	85 d2                	test   %edx,%edx
 726:	75 c0                	jne    6e8 <malloc+0x48>
        return 0;
  }
}
 728:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 72b:	31 c0                	xor    %eax,%eax
}
 72d:	5b                   	pop    %ebx
 72e:	5e                   	pop    %esi
 72f:	5f                   	pop    %edi
 730:	5d                   	pop    %ebp
 731:	c3                   	ret    
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 738:	39 cf                	cmp    %ecx,%edi
 73a:	74 54                	je     790 <malloc+0xf0>
        p->s.size -= nunits;
 73c:	29 f9                	sub    %edi,%ecx
 73e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 741:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 744:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 747:	89 15 c0 10 00 00    	mov    %edx,0x10c0
}
 74d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 750:	83 c0 08             	add    $0x8,%eax
}
 753:	5b                   	pop    %ebx
 754:	5e                   	pop    %esi
 755:	5f                   	pop    %edi
 756:	5d                   	pop    %ebp
 757:	c3                   	ret    
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 760:	c7 05 c0 10 00 00 c4 	movl   $0x10c4,0x10c0
 767:	10 00 00 
 76a:	c7 05 c4 10 00 00 c4 	movl   $0x10c4,0x10c4
 771:	10 00 00 
    base.s.size = 0;
 774:	b8 c4 10 00 00       	mov    $0x10c4,%eax
 779:	c7 05 c8 10 00 00 00 	movl   $0x0,0x10c8
 780:	00 00 00 
 783:	e9 44 ff ff ff       	jmp    6cc <malloc+0x2c>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb b1                	jmp    747 <malloc+0xa7>
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
 7a0:	55                   	push   %ebp
    int init = 2;
    int output = 1;
 7a1:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
 7ab:	85 d2                	test   %edx,%edx
 7ad:	74 08                	je     7b7 <powordepth+0x17>
 7af:	90                   	nop
        output *= init;
 7b0:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 7b2:	83 ea 01             	sub    $0x1,%edx
 7b5:	75 f9                	jne    7b0 <powordepth+0x10>
        exp--;
    }
    return output;
}
 7b7:	5d                   	pop    %ebp
 7b8:	c3                   	ret    
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007c0 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
 7c9:	6a 10                	push   $0x10
 7cb:	e8 d0 fe ff ff       	call   6a0 <malloc>
 7d0:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
 7d2:	8b 45 08             	mov    0x8(%ebp),%eax
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	83 e8 01             	sub    $0x1,%eax
 7db:	83 f8 05             	cmp    $0x5,%eax
 7de:	0f 87 f6 00 00 00    	ja     8da <trnmnt_tree_alloc+0x11a>
 7e4:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
 7e7:	bf 01 00 00 00       	mov    $0x1,%edi
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 7f0:	01 ff                	add    %edi,%edi
    while (exp != 0) {
 7f2:	83 e8 01             	sub    $0x1,%eax
 7f5:	75 f9                	jne    7f0 <trnmnt_tree_alloc+0x30>
 7f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
 7fa:	8d 47 ff             	lea    -0x1(%edi),%eax
 7fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
 800:	8b 45 08             	mov    0x8(%ebp),%eax
 803:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
 806:	e8 67 fb ff ff       	call   372 <kthread_mutex_alloc>
 80b:	83 f8 ff             	cmp    $0xffffffff,%eax
 80e:	89 06                	mov    %eax,(%esi)
 810:	0f 84 34 01 00 00    	je     94a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
 816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 819:	83 ec 0c             	sub    $0xc,%esp
 81c:	c1 e0 02             	shl    $0x2,%eax
 81f:	50                   	push   %eax
 820:	89 45 e0             	mov    %eax,-0x20(%ebp)
 823:	e8 78 fe ff ff       	call   6a0 <malloc>
 828:	83 c4 10             	add    $0x10,%esp
 82b:	85 c0                	test   %eax,%eax
 82d:	89 46 04             	mov    %eax,0x4(%esi)
 830:	0f 84 14 01 00 00    	je     94a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
 836:	31 db                	xor    %ebx,%ebx
 838:	eb 09                	jmp    843 <trnmnt_tree_alloc+0x83>
 83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 840:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
 843:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
 846:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 849:	e8 24 fb ff ff       	call   372 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
 84e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 851:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
 853:	75 eb                	jne    840 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
 855:	8b 4e 04             	mov    0x4(%esi),%ecx
 858:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
 85b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
 860:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 863:	89 c8                	mov    %ecx,%eax
 865:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
 867:	31 c9                	xor    %ecx,%ecx
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
 870:	83 38 ff             	cmpl   $0xffffffff,(%eax)
 873:	0f 44 cf             	cmove  %edi,%ecx
 876:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
 879:	39 d0                	cmp    %edx,%eax
 87b:	75 f3                	jne    870 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
 87d:	85 c9                	test   %ecx,%ecx
 87f:	8b 7d 08             	mov    0x8(%ebp),%edi
 882:	b8 01 00 00 00       	mov    $0x1,%eax
 887:	0f 85 9b 00 00 00    	jne    928 <trnmnt_tree_alloc+0x168>
 88d:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
 890:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 892:	83 ef 01             	sub    $0x1,%edi
 895:	75 f9                	jne    890 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
 897:	83 ec 0c             	sub    $0xc,%esp
 89a:	c1 e0 02             	shl    $0x2,%eax
 89d:	50                   	push   %eax
 89e:	e8 fd fd ff ff       	call   6a0 <malloc>
 8a3:	83 c4 10             	add    $0x10,%esp
 8a6:	85 c0                	test   %eax,%eax
 8a8:	89 46 08             	mov    %eax,0x8(%esi)
 8ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8ae:	74 36                	je     8e6 <trnmnt_tree_alloc+0x126>
 8b0:	89 c8                	mov    %ecx,%eax
    int output = 1;
 8b2:	ba 01 00 00 00       	mov    $0x1,%edx
 8b7:	89 f6                	mov    %esi,%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 8c0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 8c2:	83 e8 01             	sub    $0x1,%eax
 8c5:	75 f9                	jne    8c0 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
 8c7:	39 d7                	cmp    %edx,%edi
 8c9:	7d 11                	jge    8dc <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
 8cb:	8b 46 08             	mov    0x8(%esi),%eax
 8ce:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
 8d5:	83 c7 01             	add    $0x1,%edi
 8d8:	eb d6                	jmp    8b0 <trnmnt_tree_alloc+0xf0>
        return 0;
 8da:	31 f6                	xor    %esi,%esi

    return output;
}
 8dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8df:	89 f0                	mov    %esi,%eax
 8e1:	5b                   	pop    %ebx
 8e2:	5e                   	pop    %esi
 8e3:	5f                   	pop    %edi
 8e4:	5d                   	pop    %ebp
 8e5:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
 8e6:	8b 46 04             	mov    0x4(%esi),%eax
 8e9:	83 ec 0c             	sub    $0xc,%esp
 8ec:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 8ef:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 8f2:	e8 83 fa ff ff       	call   37a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 8f7:	83 c4 10             	add    $0x10,%esp
 8fa:	39 df                	cmp    %ebx,%edi
 8fc:	75 e8                	jne    8e6 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
 8fe:	83 ec 0c             	sub    $0xc,%esp
 901:	ff 36                	pushl  (%esi)
 903:	e8 72 fa ff ff       	call   37a <kthread_mutex_dealloc>
        free(output->mutextree);
 908:	58                   	pop    %eax
 909:	ff 76 04             	pushl  0x4(%esi)
 90c:	e8 ff fc ff ff       	call   610 <free>
        free(output);
 911:	89 34 24             	mov    %esi,(%esp)
        return 0;
 914:	31 f6                	xor    %esi,%esi
        free(output);
 916:	e8 f5 fc ff ff       	call   610 <free>
        return 0;
 91b:	83 c4 10             	add    $0x10,%esp
}
 91e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 921:	89 f0                	mov    %esi,%eax
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
 928:	8b 7d dc             	mov    -0x24(%ebp),%edi
 92b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 92e:	eb 03                	jmp    933 <trnmnt_tree_alloc+0x173>
 930:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
 933:	83 ec 0c             	sub    $0xc,%esp
 936:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 939:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 93c:	e8 39 fa ff ff       	call   37a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 941:	83 c4 10             	add    $0x10,%esp
 944:	39 df                	cmp    %ebx,%edi
 946:	75 e8                	jne    930 <trnmnt_tree_alloc+0x170>
 948:	eb b4                	jmp    8fe <trnmnt_tree_alloc+0x13e>
        free(output);
 94a:	83 ec 0c             	sub    $0xc,%esp
 94d:	56                   	push   %esi
        return 0;
 94e:	31 f6                	xor    %esi,%esi
        free(output);
 950:	e8 bb fc ff ff       	call   610 <free>
        return 0;
 955:	83 c4 10             	add    $0x10,%esp
 958:	eb 82                	jmp    8dc <trnmnt_tree_alloc+0x11c>
 95a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000960 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	53                   	push   %ebx
 966:	83 ec 28             	sub    $0x28,%esp
 969:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
 96c:	ff 36                	pushl  (%esi)
 96e:	e8 0f fa ff ff       	call   382 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
 973:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
 976:	83 c4 10             	add    $0x10,%esp
 979:	85 ff                	test   %edi,%edi
 97b:	0f 84 0b 01 00 00    	je     a8c <trnmnt_tree_dealloc+0x12c>
 981:	89 f8                	mov    %edi,%eax
    int output = 1;
 983:	bb 01 00 00 00       	mov    $0x1,%ebx
 988:	90                   	nop
 989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 990:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
 992:	83 e8 01             	sub    $0x1,%eax
 995:	75 f9                	jne    990 <trnmnt_tree_dealloc+0x30>
 997:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
 99a:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
 99c:	85 ff                	test   %edi,%edi
 99e:	74 2f                	je     9cf <trnmnt_tree_dealloc+0x6f>
 9a0:	89 f8                	mov    %edi,%eax
    int output = 1;
 9a2:	ba 01 00 00 00       	mov    $0x1,%edx
 9a7:	89 f6                	mov    %esi,%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 9b0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 9b2:	83 e8 01             	sub    $0x1,%eax
 9b5:	75 f9                	jne    9b0 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
 9b7:	39 d1                	cmp    %edx,%ecx
 9b9:	7d 25                	jge    9e0 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
 9bb:	8b 46 08             	mov    0x8(%esi),%eax
 9be:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
 9c2:	0f 85 a8 00 00 00    	jne    a70 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
 9c8:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
 9cb:	85 ff                	test   %edi,%edi
 9cd:	75 d1                	jne    9a0 <trnmnt_tree_dealloc+0x40>
    int output = 1;
 9cf:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
 9d4:	39 d1                	cmp    %edx,%ecx
 9d6:	7c e3                	jl     9bb <trnmnt_tree_dealloc+0x5b>
 9d8:	90                   	nop
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
 9e0:	85 db                	test   %ebx,%ebx
 9e2:	74 46                	je     a2a <trnmnt_tree_dealloc+0xca>
 9e4:	31 ff                	xor    %edi,%edi
 9e6:	eb 0f                	jmp    9f7 <trnmnt_tree_dealloc+0x97>
 9e8:	90                   	nop
 9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9f0:	83 c7 01             	add    $0x1,%edi
 9f3:	39 fb                	cmp    %edi,%ebx
 9f5:	74 33                	je     a2a <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
 9f7:	8b 46 04             	mov    0x4(%esi),%eax
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	ff 34 b8             	pushl  (%eax,%edi,4)
 a00:	e8 75 f9 ff ff       	call   37a <kthread_mutex_dealloc>
 a05:	83 c4 10             	add    $0x10,%esp
 a08:	83 f8 ff             	cmp    $0xffffffff,%eax
 a0b:	75 e3                	jne    9f0 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
 a0d:	83 ec 0c             	sub    $0xc,%esp
 a10:	ff 36                	pushl  (%esi)
 a12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 a15:	e8 70 f9 ff ff       	call   38a <kthread_mutex_unlock>
            return -1;
 a1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 a1d:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
 a20:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a23:	5b                   	pop    %ebx
 a24:	89 d0                	mov    %edx,%eax
 a26:	5e                   	pop    %esi
 a27:	5f                   	pop    %edi
 a28:	5d                   	pop    %ebp
 a29:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
 a2a:	83 ec 0c             	sub    $0xc,%esp
 a2d:	ff 36                	pushl  (%esi)
 a2f:	e8 56 f9 ff ff       	call   38a <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
 a34:	58                   	pop    %eax
 a35:	ff 36                	pushl  (%esi)
 a37:	e8 3e f9 ff ff       	call   37a <kthread_mutex_dealloc>
    free(tree->threadMap);
 a3c:	5a                   	pop    %edx
 a3d:	ff 76 08             	pushl  0x8(%esi)
 a40:	e8 cb fb ff ff       	call   610 <free>
    free(tree->mutextree);
 a45:	59                   	pop    %ecx
 a46:	ff 76 04             	pushl  0x4(%esi)
 a49:	e8 c2 fb ff ff       	call   610 <free>
    free(tree);
 a4e:	89 34 24             	mov    %esi,(%esp)
 a51:	e8 ba fb ff ff       	call   610 <free>
    tree->depth = 0;
 a56:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
 a5d:	83 c4 10             	add    $0x10,%esp
}
 a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 a63:	31 d2                	xor    %edx,%edx
}
 a65:	5b                   	pop    %ebx
 a66:	89 d0                	mov    %edx,%eax
 a68:	5e                   	pop    %esi
 a69:	5f                   	pop    %edi
 a6a:	5d                   	pop    %ebp
 a6b:	c3                   	ret    
 a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
 a70:	83 ec 0c             	sub    $0xc,%esp
 a73:	ff 36                	pushl  (%esi)
 a75:	e8 10 f9 ff ff       	call   38a <kthread_mutex_unlock>
            return -1;
 a7a:	83 c4 10             	add    $0x10,%esp
}
 a7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
 a80:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
 a85:	89 d0                	mov    %edx,%eax
 a87:	5b                   	pop    %ebx
 a88:	5e                   	pop    %esi
 a89:	5f                   	pop    %edi
 a8a:	5d                   	pop    %ebp
 a8b:	c3                   	ret    
    while (exp != 0) {
 a8c:	31 db                	xor    %ebx,%ebx
 a8e:	e9 07 ff ff ff       	jmp    99a <trnmnt_tree_dealloc+0x3a>
 a93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	57                   	push   %edi
 aa4:	56                   	push   %esi
 aa5:	53                   	push   %ebx
 aa6:	83 ec 0c             	sub    $0xc,%esp
 aa9:	8b 7d 0c             	mov    0xc(%ebp),%edi
 aac:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 aaf:	85 ff                	test   %edi,%edi
 ab1:	0f 88 d1 00 00 00    	js     b88 <trnmnt_tree_acquire+0xe8>
 ab7:	85 f6                	test   %esi,%esi
 ab9:	0f 84 c9 00 00 00    	je     b88 <trnmnt_tree_acquire+0xe8>
 abf:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
 ac2:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
 ac7:	85 c0                	test   %eax,%eax
 ac9:	74 0c                	je     ad7 <trnmnt_tree_acquire+0x37>
 acb:	90                   	nop
 acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 ad0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 ad2:	83 e8 01             	sub    $0x1,%eax
 ad5:	75 f9                	jne    ad0 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 ad7:	39 d7                	cmp    %edx,%edi
 ad9:	0f 8d a9 00 00 00    	jge    b88 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
 adf:	83 ec 0c             	sub    $0xc,%esp
 ae2:	ff 36                	pushl  (%esi)
 ae4:	e8 99 f8 ff ff       	call   382 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
 ae9:	8b 46 08             	mov    0x8(%esi),%eax
 aec:	83 c4 10             	add    $0x10,%esp
 aef:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
 af2:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 af5:	0f 85 94 00 00 00    	jne    b8f <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
 afb:	e8 5a f8 ff ff       	call   35a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
 b00:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
 b03:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
 b05:	ff 36                	pushl  (%esi)
 b07:	e8 7e f8 ff ff       	call   38a <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
 b0c:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
 b0f:	83 c4 10             	add    $0x10,%esp
 b12:	85 c0                	test   %eax,%eax
 b14:	74 5a                	je     b70 <trnmnt_tree_acquire+0xd0>
    int output = 1;
 b16:	ba 01 00 00 00       	mov    $0x1,%edx
 b1b:	90                   	nop
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 b20:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 b22:	83 e8 01             	sub    $0x1,%eax
 b25:	75 f9                	jne    b20 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
 b27:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
 b2b:	89 c3                	mov    %eax,%ebx
 b2d:	c1 eb 1f             	shr    $0x1f,%ebx
 b30:	01 c3                	add    %eax,%ebx
 b32:	d1 fb                	sar    %ebx
 b34:	eb 0c                	jmp    b42 <trnmnt_tree_acquire+0xa2>
 b36:	8d 76 00             	lea    0x0(%esi),%esi
 b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
 b40:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
 b42:	8b 46 04             	mov    0x4(%esi),%eax
 b45:	83 ec 0c             	sub    $0xc,%esp
 b48:	ff 34 98             	pushl  (%eax,%ebx,4)
 b4b:	e8 32 f8 ff ff       	call   382 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
 b50:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
 b53:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
 b56:	89 d0                	mov    %edx,%eax
 b58:	c1 e8 1f             	shr    $0x1f,%eax
 b5b:	01 d0                	add    %edx,%eax
 b5d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
 b5f:	85 db                	test   %ebx,%ebx
 b61:	75 dd                	jne    b40 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
 b63:	31 c0                	xor    %eax,%eax
}
 b65:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b68:	5b                   	pop    %ebx
 b69:	5e                   	pop    %esi
 b6a:	5f                   	pop    %edi
 b6b:	5d                   	pop    %ebp
 b6c:	c3                   	ret    
 b6d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
 b70:	8d 47 ff             	lea    -0x1(%edi),%eax
 b73:	89 c3                	mov    %eax,%ebx
 b75:	c1 eb 1f             	shr    $0x1f,%ebx
 b78:	01 c3                	add    %eax,%ebx
 b7a:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
 b7c:	85 ff                	test   %edi,%edi
 b7e:	74 e3                	je     b63 <trnmnt_tree_acquire+0xc3>
 b80:	eb c0                	jmp    b42 <trnmnt_tree_acquire+0xa2>
 b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 b88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b8d:	eb d6                	jmp    b65 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
 b8f:	83 ec 0c             	sub    $0xc,%esp
 b92:	ff 36                	pushl  (%esi)
 b94:	e8 f1 f7 ff ff       	call   38a <kthread_mutex_unlock>
        return -1;
 b99:	83 c4 10             	add    $0x10,%esp
 b9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ba1:	eb c2                	jmp    b65 <trnmnt_tree_acquire+0xc5>
 ba3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 bb0:	55                   	push   %ebp
 bb1:	89 e5                	mov    %esp,%ebp
 bb3:	56                   	push   %esi
 bb4:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
 bb5:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 bb8:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
 bbb:	8d 50 ff             	lea    -0x1(%eax),%edx
 bbe:	89 d0                	mov    %edx,%eax
 bc0:	c1 e8 1f             	shr    $0x1f,%eax
 bc3:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
 bc5:	d1 f8                	sar    %eax
 bc7:	89 c3                	mov    %eax,%ebx
 bc9:	75 15                	jne    be0 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 bcb:	8b 46 04             	mov    0x4(%esi),%eax
 bce:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 bd1:	89 45 08             	mov    %eax,0x8(%ebp)
}
 bd4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 bd7:	5b                   	pop    %ebx
 bd8:	5e                   	pop    %esi
 bd9:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 bda:	e9 ab f7 ff ff       	jmp    38a <kthread_mutex_unlock>
 bdf:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
 be0:	83 ec 08             	sub    $0x8,%esp
 be3:	50                   	push   %eax
 be4:	56                   	push   %esi
 be5:	e8 c6 ff ff ff       	call   bb0 <trnmnt_tree_release_rec>
 bea:	83 c4 10             	add    $0x10,%esp
 bed:	83 f8 ff             	cmp    $0xffffffff,%eax
 bf0:	75 d9                	jne    bcb <trnmnt_tree_release_rec+0x1b>
}
 bf2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 bf5:	5b                   	pop    %ebx
 bf6:	5e                   	pop    %esi
 bf7:	5d                   	pop    %ebp
 bf8:	c3                   	ret    
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c00 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	83 ec 28             	sub    $0x28,%esp
 c09:	8b 7d 08             	mov    0x8(%ebp),%edi
 c0c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
 c0f:	ff 37                	pushl  (%edi)
 c11:	e8 6c f7 ff ff       	call   382 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
 c16:	8b 47 08             	mov    0x8(%edi),%eax
 c19:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 c1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c1f:	e8 36 f7 ff ff       	call   35a <kthread_id>
 c24:	83 c4 10             	add    $0x10,%esp
 c27:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
 c2a:	75 56                	jne    c82 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 c2c:	8b 47 0c             	mov    0xc(%edi),%eax
 c2f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
 c36:	85 c0                	test   %eax,%eax
 c38:	74 11                	je     c4b <trnmnt_tree_release+0x4b>
    int output = 1;
 c3a:	b9 01 00 00 00       	mov    $0x1,%ecx
 c3f:	90                   	nop
        output *= init;
 c40:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
 c42:	83 e8 01             	sub    $0x1,%eax
 c45:	75 f9                	jne    c40 <trnmnt_tree_release+0x40>
 c47:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 c4b:	83 ec 08             	sub    $0x8,%esp
 c4e:	53                   	push   %ebx
 c4f:	57                   	push   %edi
 c50:	e8 5b ff ff ff       	call   bb0 <trnmnt_tree_release_rec>
 c55:	83 c4 10             	add    $0x10,%esp
 c58:	83 f8 ff             	cmp    $0xffffffff,%eax
 c5b:	89 c3                	mov    %eax,%ebx
 c5d:	74 37                	je     c96 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
 c5f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
 c62:	83 ec 0c             	sub    $0xc,%esp
    return 0;
 c65:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
 c67:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
 c6e:	ff 37                	pushl  (%edi)
 c70:	e8 15 f7 ff ff       	call   38a <kthread_mutex_unlock>
    return 0;
 c75:	83 c4 10             	add    $0x10,%esp
}
 c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c7b:	89 d8                	mov    %ebx,%eax
 c7d:	5b                   	pop    %ebx
 c7e:	5e                   	pop    %esi
 c7f:	5f                   	pop    %edi
 c80:	5d                   	pop    %ebp
 c81:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
 c82:	83 ec 0c             	sub    $0xc,%esp
 c85:	ff 37                	pushl  (%edi)
        return -1;
 c87:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
 c8c:	e8 f9 f6 ff ff       	call   38a <kthread_mutex_unlock>
        return -1;
 c91:	83 c4 10             	add    $0x10,%esp
 c94:	eb e2                	jmp    c78 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
 c96:	83 ec 0c             	sub    $0xc,%esp
 c99:	ff 37                	pushl  (%edi)
 c9b:	e8 ea f6 ff ff       	call   38a <kthread_mutex_unlock>
        return -1;
 ca0:	83 c4 10             	add    $0x10,%esp
 ca3:	eb d3                	jmp    c78 <trnmnt_tree_release+0x78>
