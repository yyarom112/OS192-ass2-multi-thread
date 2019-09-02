
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 54                	jle    7d <main+0x7d>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 66 03 00 00       	call   3a2 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 24                	js     69 <main+0x69>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  45:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  48:	83 c6 01             	add    $0x1,%esi
  4b:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  4e:	50                   	push   %eax
  4f:	e8 3c 00 00 00       	call   90 <cat>
    close(fd);
  54:	89 3c 24             	mov    %edi,(%esp)
  57:	e8 2e 03 00 00       	call   38a <close>
  for(i = 1; i < argc; i++){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  62:	75 cc                	jne    30 <main+0x30>
  }
  exit();
  64:	e8 f9 02 00 00       	call   362 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  69:	50                   	push   %eax
  6a:	ff 33                	pushl  (%ebx)
  6c:	68 7b 0d 00 00       	push   $0xd7b
  71:	6a 01                	push   $0x1
  73:	e8 78 04 00 00       	call   4f0 <printf>
      exit();
  78:	e8 e5 02 00 00       	call   362 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 d6 02 00 00       	call   362 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 e0 11 00 00       	push   $0x11e0
  a9:	6a 01                	push   $0x1
  ab:	e8 d2 02 00 00       	call   382 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 26                	jne    dd <cat+0x4d>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 e0 11 00 00       	push   $0x11e0
  c4:	56                   	push   %esi
  c5:	e8 b0 02 00 00       	call   37a <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	83 f8 00             	cmp    $0x0,%eax
  d0:	89 c3                	mov    %eax,%ebx
  d2:	7f cc                	jg     a0 <cat+0x10>
  if(n < 0){
  d4:	75 1b                	jne    f1 <cat+0x61>
}
  d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d9:	5b                   	pop    %ebx
  da:	5e                   	pop    %esi
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
      printf(1, "cat: write error\n");
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	68 58 0d 00 00       	push   $0xd58
  e5:	6a 01                	push   $0x1
  e7:	e8 04 04 00 00       	call   4f0 <printf>
      exit();
  ec:	e8 71 02 00 00       	call   362 <exit>
    printf(1, "cat: read error\n");
  f1:	50                   	push   %eax
  f2:	50                   	push   %eax
  f3:	68 6a 0d 00 00       	push   $0xd6a
  f8:	6a 01                	push   $0x1
  fa:	e8 f1 03 00 00       	call   4f0 <printf>
    exit();
  ff:	e8 5e 02 00 00       	call   362 <exit>
 104:	66 90                	xchg   %ax,%ax
 106:	66 90                	xchg   %ax,%ax
 108:	66 90                	xchg   %ax,%ax
 10a:	66 90                	xchg   %ax,%ax
 10c:	66 90                	xchg   %ax,%ax
 10e:	66 90                	xchg   %ax,%ax

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	8b 45 08             	mov    0x8(%ebp),%eax
 117:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	89 c2                	mov    %eax,%edx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	83 c1 01             	add    $0x1,%ecx
 123:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 db                	test   %bl,%bl
 12c:	88 5a ff             	mov    %bl,-0x1(%edx)
 12f:	75 ef                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 131:	5b                   	pop    %ebx
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	84 c0                	test   %al,%al
 152:	75 1c                	jne    170 <strcmp+0x30>
 154:	eb 2a                	jmp    180 <strcmp+0x40>
 156:	8d 76 00             	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 160:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 163:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 166:	83 c1 01             	add    $0x1,%ecx
 169:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 16c:	84 c0                	test   %al,%al
 16e:	74 10                	je     180 <strcmp+0x40>
 170:	38 d8                	cmp    %bl,%al
 172:	74 ec                	je     160 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 174:	29 d8                	sub    %ebx,%eax
}
 176:	5b                   	pop    %ebx
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 182:	29 d8                	sub    %ebx,%eax
}
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	89 f6                	mov    %esi,%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 39 00             	cmpb   $0x0,(%ecx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 d2                	xor    %edx,%edx
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1b0:	31 c0                	xor    %eax,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cd:	89 d7                	mov    %edx,%edi
 1cf:	fc                   	cld    
 1d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d2:	89 d0                	mov    %edx,%eax
 1d4:	5f                   	pop    %edi
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	74 1d                	je     20e <strchr+0x2e>
    if(*s == c)
 1f1:	38 d3                	cmp    %dl,%bl
 1f3:	89 d9                	mov    %ebx,%ecx
 1f5:	75 0d                	jne    204 <strchr+0x24>
 1f7:	eb 17                	jmp    210 <strchr+0x30>
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	38 ca                	cmp    %cl,%dl
 202:	74 0c                	je     210 <strchr+0x30>
  for(; *s; s++)
 204:	83 c0 01             	add    $0x1,%eax
 207:	0f b6 10             	movzbl (%eax),%edx
 20a:	84 d2                	test   %dl,%dl
 20c:	75 f2                	jne    200 <strchr+0x20>
      return (char*)s;
  return 0;
 20e:	31 c0                	xor    %eax,%eax
}
 210:	5b                   	pop    %ebx
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 226:	31 f6                	xor    %esi,%esi
 228:	89 f3                	mov    %esi,%ebx
{
 22a:	83 ec 1c             	sub    $0x1c,%esp
 22d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 230:	eb 2f                	jmp    261 <gets+0x41>
 232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 238:	8d 45 e7             	lea    -0x19(%ebp),%eax
 23b:	83 ec 04             	sub    $0x4,%esp
 23e:	6a 01                	push   $0x1
 240:	50                   	push   %eax
 241:	6a 00                	push   $0x0
 243:	e8 32 01 00 00       	call   37a <read>
    if(cc < 1)
 248:	83 c4 10             	add    $0x10,%esp
 24b:	85 c0                	test   %eax,%eax
 24d:	7e 1c                	jle    26b <gets+0x4b>
      break;
    buf[i++] = c;
 24f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 253:	83 c7 01             	add    $0x1,%edi
 256:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 259:	3c 0a                	cmp    $0xa,%al
 25b:	74 23                	je     280 <gets+0x60>
 25d:	3c 0d                	cmp    $0xd,%al
 25f:	74 1f                	je     280 <gets+0x60>
  for(i=0; i+1 < max; ){
 261:	83 c3 01             	add    $0x1,%ebx
 264:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 267:	89 fe                	mov    %edi,%esi
 269:	7c cd                	jl     238 <gets+0x18>
 26b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 270:	c6 03 00             	movb   $0x0,(%ebx)
}
 273:	8d 65 f4             	lea    -0xc(%ebp),%esp
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	8b 75 08             	mov    0x8(%ebp),%esi
 283:	8b 45 08             	mov    0x8(%ebp),%eax
 286:	01 de                	add    %ebx,%esi
 288:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 28a:	c6 03 00             	movb   $0x0,(%ebx)
}
 28d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 290:	5b                   	pop    %ebx
 291:	5e                   	pop    %esi
 292:	5f                   	pop    %edi
 293:	5d                   	pop    %ebp
 294:	c3                   	ret    
 295:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a5:	83 ec 08             	sub    $0x8,%esp
 2a8:	6a 00                	push   $0x0
 2aa:	ff 75 08             	pushl  0x8(%ebp)
 2ad:	e8 f0 00 00 00       	call   3a2 <open>
  if(fd < 0)
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	85 c0                	test   %eax,%eax
 2b7:	78 27                	js     2e0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2b9:	83 ec 08             	sub    $0x8,%esp
 2bc:	ff 75 0c             	pushl  0xc(%ebp)
 2bf:	89 c3                	mov    %eax,%ebx
 2c1:	50                   	push   %eax
 2c2:	e8 f3 00 00 00       	call   3ba <fstat>
  close(fd);
 2c7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ca:	89 c6                	mov    %eax,%esi
  close(fd);
 2cc:	e8 b9 00 00 00       	call   38a <close>
  return r;
 2d1:	83 c4 10             	add    $0x10,%esp
}
 2d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d7:	89 f0                	mov    %esi,%eax
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2e5:	eb ed                	jmp    2d4 <stat+0x34>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 2fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 304:	77 1f                	ja     325 <atoi+0x35>
 306:	8d 76 00             	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 310:	8d 04 80             	lea    (%eax,%eax,4),%eax
 313:	83 c1 01             	add    $0x1,%ecx
 316:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 31a:	0f be 11             	movsbl (%ecx),%edx
 31d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 320:	80 fb 09             	cmp    $0x9,%bl
 323:	76 eb                	jbe    310 <atoi+0x20>
  return n;
}
 325:	5b                   	pop    %ebx
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 5d 10             	mov    0x10(%ebp),%ebx
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 33e:	85 db                	test   %ebx,%ebx
 340:	7e 14                	jle    356 <memmove+0x26>
 342:	31 d2                	xor    %edx,%edx
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 348:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 34c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 34f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 352:	39 d3                	cmp    %edx,%ebx
 354:	75 f2                	jne    348 <memmove+0x18>
  return vdst;
}
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    

0000035a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35a:	b8 01 00 00 00       	mov    $0x1,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <exit>:
SYSCALL(exit)
 362:	b8 02 00 00 00       	mov    $0x2,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <wait>:
SYSCALL(wait)
 36a:	b8 03 00 00 00       	mov    $0x3,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <pipe>:
SYSCALL(pipe)
 372:	b8 04 00 00 00       	mov    $0x4,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <read>:
SYSCALL(read)
 37a:	b8 05 00 00 00       	mov    $0x5,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <write>:
SYSCALL(write)
 382:	b8 10 00 00 00       	mov    $0x10,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <close>:
SYSCALL(close)
 38a:	b8 15 00 00 00       	mov    $0x15,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kill>:
SYSCALL(kill)
 392:	b8 06 00 00 00       	mov    $0x6,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <exec>:
SYSCALL(exec)
 39a:	b8 07 00 00 00       	mov    $0x7,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <open>:
SYSCALL(open)
 3a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mknod>:
SYSCALL(mknod)
 3aa:	b8 11 00 00 00       	mov    $0x11,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <unlink>:
SYSCALL(unlink)
 3b2:	b8 12 00 00 00       	mov    $0x12,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <fstat>:
SYSCALL(fstat)
 3ba:	b8 08 00 00 00       	mov    $0x8,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <link>:
SYSCALL(link)
 3c2:	b8 13 00 00 00       	mov    $0x13,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mkdir>:
SYSCALL(mkdir)
 3ca:	b8 14 00 00 00       	mov    $0x14,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <chdir>:
SYSCALL(chdir)
 3d2:	b8 09 00 00 00       	mov    $0x9,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <dup>:
SYSCALL(dup)
 3da:	b8 0a 00 00 00       	mov    $0xa,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getpid>:
SYSCALL(getpid)
 3e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sbrk>:
SYSCALL(sbrk)
 3ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sleep>:
SYSCALL(sleep)
 3f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <uptime>:
SYSCALL(uptime)
 3fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <kthread_create>:
SYSCALL(kthread_create)
 402:	b8 16 00 00 00       	mov    $0x16,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <kthread_id>:
SYSCALL(kthread_id)
 40a:	b8 17 00 00 00       	mov    $0x17,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <kthread_exit>:
SYSCALL(kthread_exit)
 412:	b8 18 00 00 00       	mov    $0x18,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <kthread_join>:
SYSCALL(kthread_join)
 41a:	b8 19 00 00 00       	mov    $0x19,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 422:	b8 1a 00 00 00       	mov    $0x1a,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 42a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 432:	b8 1c 00 00 00       	mov    $0x1c,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 43a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    
 442:	66 90                	xchg   %ax,%ax
 444:	66 90                	xchg   %ax,%ax
 446:	66 90                	xchg   %ax,%ax
 448:	66 90                	xchg   %ax,%ax
 44a:	66 90                	xchg   %ax,%ax
 44c:	66 90                	xchg   %ax,%ax
 44e:	66 90                	xchg   %ax,%ax

00000450 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	56                   	push   %esi
 455:	53                   	push   %ebx
 456:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 459:	85 d2                	test   %edx,%edx
{
 45b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 45e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 460:	79 76                	jns    4d8 <printint+0x88>
 462:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 466:	74 70                	je     4d8 <printint+0x88>
    x = -xx;
 468:	f7 d8                	neg    %eax
    neg = 1;
 46a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 471:	31 f6                	xor    %esi,%esi
 473:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 476:	eb 0a                	jmp    482 <printint+0x32>
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 480:	89 fe                	mov    %edi,%esi
 482:	31 d2                	xor    %edx,%edx
 484:	8d 7e 01             	lea    0x1(%esi),%edi
 487:	f7 f1                	div    %ecx
 489:	0f b6 92 98 0d 00 00 	movzbl 0xd98(%edx),%edx
  }while((x /= base) != 0);
 490:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 492:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 495:	75 e9                	jne    480 <printint+0x30>
  if(neg)
 497:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 49a:	85 c0                	test   %eax,%eax
 49c:	74 08                	je     4a6 <printint+0x56>
    buf[i++] = '-';
 49e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4a3:	8d 7e 02             	lea    0x2(%esi),%edi
 4a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4b3:	83 ec 04             	sub    $0x4,%esp
 4b6:	83 ee 01             	sub    $0x1,%esi
 4b9:	6a 01                	push   $0x1
 4bb:	53                   	push   %ebx
 4bc:	57                   	push   %edi
 4bd:	88 45 d7             	mov    %al,-0x29(%ebp)
 4c0:	e8 bd fe ff ff       	call   382 <write>

  while(--i >= 0)
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	39 de                	cmp    %ebx,%esi
 4ca:	75 e4                	jne    4b0 <printint+0x60>
    putc(fd, buf[i]);
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4df:	eb 90                	jmp    471 <printint+0x21>
 4e1:	eb 0d                	jmp    4f0 <printf>
 4e3:	90                   	nop
 4e4:	90                   	nop
 4e5:	90                   	nop
 4e6:	90                   	nop
 4e7:	90                   	nop
 4e8:	90                   	nop
 4e9:	90                   	nop
 4ea:	90                   	nop
 4eb:	90                   	nop
 4ec:	90                   	nop
 4ed:	90                   	nop
 4ee:	90                   	nop
 4ef:	90                   	nop

000004f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4fc:	0f b6 1e             	movzbl (%esi),%ebx
 4ff:	84 db                	test   %bl,%bl
 501:	0f 84 b3 00 00 00    	je     5ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 507:	8d 45 10             	lea    0x10(%ebp),%eax
 50a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 50d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 50f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 512:	eb 2f                	jmp    543 <printf+0x53>
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 518:	83 f8 25             	cmp    $0x25,%eax
 51b:	0f 84 a7 00 00 00    	je     5c8 <printf+0xd8>
  write(fd, &c, 1);
 521:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 524:	83 ec 04             	sub    $0x4,%esp
 527:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 52a:	6a 01                	push   $0x1
 52c:	50                   	push   %eax
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 4d fe ff ff       	call   382 <write>
 535:	83 c4 10             	add    $0x10,%esp
 538:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 53b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 53f:	84 db                	test   %bl,%bl
 541:	74 77                	je     5ba <printf+0xca>
    if(state == 0){
 543:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 545:	0f be cb             	movsbl %bl,%ecx
 548:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 54b:	74 cb                	je     518 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 54d:	83 ff 25             	cmp    $0x25,%edi
 550:	75 e6                	jne    538 <printf+0x48>
      if(c == 'd'){
 552:	83 f8 64             	cmp    $0x64,%eax
 555:	0f 84 05 01 00 00    	je     660 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 55b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 561:	83 f9 70             	cmp    $0x70,%ecx
 564:	74 72                	je     5d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 566:	83 f8 73             	cmp    $0x73,%eax
 569:	0f 84 99 00 00 00    	je     608 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56f:	83 f8 63             	cmp    $0x63,%eax
 572:	0f 84 08 01 00 00    	je     680 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 578:	83 f8 25             	cmp    $0x25,%eax
 57b:	0f 84 ef 00 00 00    	je     670 <printf+0x180>
  write(fd, &c, 1);
 581:	8d 45 e7             	lea    -0x19(%ebp),%eax
 584:	83 ec 04             	sub    $0x4,%esp
 587:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 58b:	6a 01                	push   $0x1
 58d:	50                   	push   %eax
 58e:	ff 75 08             	pushl  0x8(%ebp)
 591:	e8 ec fd ff ff       	call   382 <write>
 596:	83 c4 0c             	add    $0xc,%esp
 599:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 59c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 59f:	6a 01                	push   $0x1
 5a1:	50                   	push   %eax
 5a2:	ff 75 08             	pushl  0x8(%ebp)
 5a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5aa:	e8 d3 fd ff ff       	call   382 <write>
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 5b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5b6:	84 db                	test   %bl,%bl
 5b8:	75 89                	jne    543 <printf+0x53>
    }
  }
}
 5ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bd:	5b                   	pop    %ebx
 5be:	5e                   	pop    %esi
 5bf:	5f                   	pop    %edi
 5c0:	5d                   	pop    %ebp
 5c1:	c3                   	ret    
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 5c8:	bf 25 00 00 00       	mov    $0x25,%edi
 5cd:	e9 66 ff ff ff       	jmp    538 <printf+0x48>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 5d8:	83 ec 0c             	sub    $0xc,%esp
 5db:	b9 10 00 00 00       	mov    $0x10,%ecx
 5e0:	6a 00                	push   $0x0
 5e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5e5:	8b 45 08             	mov    0x8(%ebp),%eax
 5e8:	8b 17                	mov    (%edi),%edx
 5ea:	e8 61 fe ff ff       	call   450 <printint>
        ap++;
 5ef:	89 f8                	mov    %edi,%eax
 5f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f4:	31 ff                	xor    %edi,%edi
        ap++;
 5f6:	83 c0 04             	add    $0x4,%eax
 5f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5fc:	e9 37 ff ff ff       	jmp    538 <printf+0x48>
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 608:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 60b:	8b 08                	mov    (%eax),%ecx
        ap++;
 60d:	83 c0 04             	add    $0x4,%eax
 610:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 613:	85 c9                	test   %ecx,%ecx
 615:	0f 84 8e 00 00 00    	je     6a9 <printf+0x1b9>
        while(*s != 0){
 61b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 61e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 620:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 622:	84 c0                	test   %al,%al
 624:	0f 84 0e ff ff ff    	je     538 <printf+0x48>
 62a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 62d:	89 de                	mov    %ebx,%esi
 62f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 632:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 635:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 638:	83 ec 04             	sub    $0x4,%esp
          s++;
 63b:	83 c6 01             	add    $0x1,%esi
 63e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 641:	6a 01                	push   $0x1
 643:	57                   	push   %edi
 644:	53                   	push   %ebx
 645:	e8 38 fd ff ff       	call   382 <write>
        while(*s != 0){
 64a:	0f b6 06             	movzbl (%esi),%eax
 64d:	83 c4 10             	add    $0x10,%esp
 650:	84 c0                	test   %al,%al
 652:	75 e4                	jne    638 <printf+0x148>
 654:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 657:	31 ff                	xor    %edi,%edi
 659:	e9 da fe ff ff       	jmp    538 <printf+0x48>
 65e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 0a 00 00 00       	mov    $0xa,%ecx
 668:	6a 01                	push   $0x1
 66a:	e9 73 ff ff ff       	jmp    5e2 <printf+0xf2>
 66f:	90                   	nop
  write(fd, &c, 1);
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 676:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 679:	6a 01                	push   $0x1
 67b:	e9 21 ff ff ff       	jmp    5a1 <printf+0xb1>
        putc(fd, *ap);
 680:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 686:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 688:	6a 01                	push   $0x1
        ap++;
 68a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 68d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 690:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 693:	50                   	push   %eax
 694:	ff 75 08             	pushl  0x8(%ebp)
 697:	e8 e6 fc ff ff       	call   382 <write>
        ap++;
 69c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 69f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6a2:	31 ff                	xor    %edi,%edi
 6a4:	e9 8f fe ff ff       	jmp    538 <printf+0x48>
          s = "(null)";
 6a9:	bb 90 0d 00 00       	mov    $0xd90,%ebx
        while(*s != 0){
 6ae:	b8 28 00 00 00       	mov    $0x28,%eax
 6b3:	e9 72 ff ff ff       	jmp    62a <printf+0x13a>
 6b8:	66 90                	xchg   %ax,%ax
 6ba:	66 90                	xchg   %ax,%ax
 6bc:	66 90                	xchg   %ax,%ax
 6be:	66 90                	xchg   %ax,%ax

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 c0 11 00 00       	mov    0x11c0,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d8:	39 c8                	cmp    %ecx,%eax
 6da:	8b 10                	mov    (%eax),%edx
 6dc:	73 32                	jae    710 <free+0x50>
 6de:	39 d1                	cmp    %edx,%ecx
 6e0:	72 04                	jb     6e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	39 d0                	cmp    %edx,%eax
 6e4:	72 32                	jb     718 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ec:	39 fa                	cmp    %edi,%edx
 6ee:	74 30                	je     720 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6f3:	8b 50 04             	mov    0x4(%eax),%edx
 6f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f9:	39 f1                	cmp    %esi,%ecx
 6fb:	74 3a                	je     737 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6fd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6ff:	a3 c0 11 00 00       	mov    %eax,0x11c0
}
 704:	5b                   	pop    %ebx
 705:	5e                   	pop    %esi
 706:	5f                   	pop    %edi
 707:	5d                   	pop    %ebp
 708:	c3                   	ret    
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 710:	39 d0                	cmp    %edx,%eax
 712:	72 04                	jb     718 <free+0x58>
 714:	39 d1                	cmp    %edx,%ecx
 716:	72 ce                	jb     6e6 <free+0x26>
{
 718:	89 d0                	mov    %edx,%eax
 71a:	eb bc                	jmp    6d8 <free+0x18>
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 720:	03 72 04             	add    0x4(%edx),%esi
 723:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 726:	8b 10                	mov    (%eax),%edx
 728:	8b 12                	mov    (%edx),%edx
 72a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72d:	8b 50 04             	mov    0x4(%eax),%edx
 730:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 733:	39 f1                	cmp    %esi,%ecx
 735:	75 c6                	jne    6fd <free+0x3d>
    p->s.size += bp->s.size;
 737:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 73a:	a3 c0 11 00 00       	mov    %eax,0x11c0
    p->s.size += bp->s.size;
 73f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 742:	8b 53 f8             	mov    -0x8(%ebx),%edx
 745:	89 10                	mov    %edx,(%eax)
}
 747:	5b                   	pop    %ebx
 748:	5e                   	pop    %esi
 749:	5f                   	pop    %edi
 74a:	5d                   	pop    %ebp
 74b:	c3                   	ret    
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 75c:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	8d 78 07             	lea    0x7(%eax),%edi
 765:	c1 ef 03             	shr    $0x3,%edi
 768:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 76b:	85 d2                	test   %edx,%edx
 76d:	0f 84 9d 00 00 00    	je     810 <malloc+0xc0>
 773:	8b 02                	mov    (%edx),%eax
 775:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 778:	39 cf                	cmp    %ecx,%edi
 77a:	76 6c                	jbe    7e8 <malloc+0x98>
 77c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 782:	bb 00 10 00 00       	mov    $0x1000,%ebx
 787:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 78a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 791:	eb 0e                	jmp    7a1 <malloc+0x51>
 793:	90                   	nop
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 798:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 79a:	8b 48 04             	mov    0x4(%eax),%ecx
 79d:	39 f9                	cmp    %edi,%ecx
 79f:	73 47                	jae    7e8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a1:	39 05 c0 11 00 00    	cmp    %eax,0x11c0
 7a7:	89 c2                	mov    %eax,%edx
 7a9:	75 ed                	jne    798 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7ab:	83 ec 0c             	sub    $0xc,%esp
 7ae:	56                   	push   %esi
 7af:	e8 36 fc ff ff       	call   3ea <sbrk>
  if(p == (char*)-1)
 7b4:	83 c4 10             	add    $0x10,%esp
 7b7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ba:	74 1c                	je     7d8 <malloc+0x88>
  hp->s.size = nu;
 7bc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7bf:	83 ec 0c             	sub    $0xc,%esp
 7c2:	83 c0 08             	add    $0x8,%eax
 7c5:	50                   	push   %eax
 7c6:	e8 f5 fe ff ff       	call   6c0 <free>
  return freep;
 7cb:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
      if((p = morecore(nunits)) == 0)
 7d1:	83 c4 10             	add    $0x10,%esp
 7d4:	85 d2                	test   %edx,%edx
 7d6:	75 c0                	jne    798 <malloc+0x48>
        return 0;
  }
}
 7d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7db:	31 c0                	xor    %eax,%eax
}
 7dd:	5b                   	pop    %ebx
 7de:	5e                   	pop    %esi
 7df:	5f                   	pop    %edi
 7e0:	5d                   	pop    %ebp
 7e1:	c3                   	ret    
 7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7e8:	39 cf                	cmp    %ecx,%edi
 7ea:	74 54                	je     840 <malloc+0xf0>
        p->s.size -= nunits;
 7ec:	29 f9                	sub    %edi,%ecx
 7ee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7f4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7f7:	89 15 c0 11 00 00    	mov    %edx,0x11c0
}
 7fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 800:	83 c0 08             	add    $0x8,%eax
}
 803:	5b                   	pop    %ebx
 804:	5e                   	pop    %esi
 805:	5f                   	pop    %edi
 806:	5d                   	pop    %ebp
 807:	c3                   	ret    
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 810:	c7 05 c0 11 00 00 c4 	movl   $0x11c4,0x11c0
 817:	11 00 00 
 81a:	c7 05 c4 11 00 00 c4 	movl   $0x11c4,0x11c4
 821:	11 00 00 
    base.s.size = 0;
 824:	b8 c4 11 00 00       	mov    $0x11c4,%eax
 829:	c7 05 c8 11 00 00 00 	movl   $0x0,0x11c8
 830:	00 00 00 
 833:	e9 44 ff ff ff       	jmp    77c <malloc+0x2c>
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 840:	8b 08                	mov    (%eax),%ecx
 842:	89 0a                	mov    %ecx,(%edx)
 844:	eb b1                	jmp    7f7 <malloc+0xa7>
 846:	66 90                	xchg   %ax,%ax
 848:	66 90                	xchg   %ax,%ax
 84a:	66 90                	xchg   %ax,%ax
 84c:	66 90                	xchg   %ax,%ax
 84e:	66 90                	xchg   %ax,%ax

00000850 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
 850:	55                   	push   %ebp
    int init = 2;
    int output = 1;
 851:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
 856:	89 e5                	mov    %esp,%ebp
 858:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
 85b:	85 d2                	test   %edx,%edx
 85d:	74 08                	je     867 <powordepth+0x17>
 85f:	90                   	nop
        output *= init;
 860:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 862:	83 ea 01             	sub    $0x1,%edx
 865:	75 f9                	jne    860 <powordepth+0x10>
        exp--;
    }
    return output;
}
 867:	5d                   	pop    %ebp
 868:	c3                   	ret    
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000870 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
 879:	6a 10                	push   $0x10
 87b:	e8 d0 fe ff ff       	call   750 <malloc>
 880:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
 882:	8b 45 08             	mov    0x8(%ebp),%eax
 885:	83 c4 10             	add    $0x10,%esp
 888:	83 e8 01             	sub    $0x1,%eax
 88b:	83 f8 05             	cmp    $0x5,%eax
 88e:	0f 87 f6 00 00 00    	ja     98a <trnmnt_tree_alloc+0x11a>
 894:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
 897:	bf 01 00 00 00       	mov    $0x1,%edi
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 8a0:	01 ff                	add    %edi,%edi
    while (exp != 0) {
 8a2:	83 e8 01             	sub    $0x1,%eax
 8a5:	75 f9                	jne    8a0 <trnmnt_tree_alloc+0x30>
 8a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
 8aa:	8d 47 ff             	lea    -0x1(%edi),%eax
 8ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
 8b0:	8b 45 08             	mov    0x8(%ebp),%eax
 8b3:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
 8b6:	e8 67 fb ff ff       	call   422 <kthread_mutex_alloc>
 8bb:	83 f8 ff             	cmp    $0xffffffff,%eax
 8be:	89 06                	mov    %eax,(%esi)
 8c0:	0f 84 34 01 00 00    	je     9fa <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
 8c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c9:	83 ec 0c             	sub    $0xc,%esp
 8cc:	c1 e0 02             	shl    $0x2,%eax
 8cf:	50                   	push   %eax
 8d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
 8d3:	e8 78 fe ff ff       	call   750 <malloc>
 8d8:	83 c4 10             	add    $0x10,%esp
 8db:	85 c0                	test   %eax,%eax
 8dd:	89 46 04             	mov    %eax,0x4(%esi)
 8e0:	0f 84 14 01 00 00    	je     9fa <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
 8e6:	31 db                	xor    %ebx,%ebx
 8e8:	eb 09                	jmp    8f3 <trnmnt_tree_alloc+0x83>
 8ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8f0:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
 8f3:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
 8f6:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 8f9:	e8 24 fb ff ff       	call   422 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
 8fe:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 901:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
 903:	75 eb                	jne    8f0 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
 905:	8b 4e 04             	mov    0x4(%esi),%ecx
 908:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
 90b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
 910:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 913:	89 c8                	mov    %ecx,%eax
 915:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
 917:	31 c9                	xor    %ecx,%ecx
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
 920:	83 38 ff             	cmpl   $0xffffffff,(%eax)
 923:	0f 44 cf             	cmove  %edi,%ecx
 926:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
 929:	39 d0                	cmp    %edx,%eax
 92b:	75 f3                	jne    920 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
 92d:	85 c9                	test   %ecx,%ecx
 92f:	8b 7d 08             	mov    0x8(%ebp),%edi
 932:	b8 01 00 00 00       	mov    $0x1,%eax
 937:	0f 85 9b 00 00 00    	jne    9d8 <trnmnt_tree_alloc+0x168>
 93d:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
 940:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 942:	83 ef 01             	sub    $0x1,%edi
 945:	75 f9                	jne    940 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
 947:	83 ec 0c             	sub    $0xc,%esp
 94a:	c1 e0 02             	shl    $0x2,%eax
 94d:	50                   	push   %eax
 94e:	e8 fd fd ff ff       	call   750 <malloc>
 953:	83 c4 10             	add    $0x10,%esp
 956:	85 c0                	test   %eax,%eax
 958:	89 46 08             	mov    %eax,0x8(%esi)
 95b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 95e:	74 36                	je     996 <trnmnt_tree_alloc+0x126>
 960:	89 c8                	mov    %ecx,%eax
    int output = 1;
 962:	ba 01 00 00 00       	mov    $0x1,%edx
 967:	89 f6                	mov    %esi,%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 970:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 972:	83 e8 01             	sub    $0x1,%eax
 975:	75 f9                	jne    970 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
 977:	39 d7                	cmp    %edx,%edi
 979:	7d 11                	jge    98c <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
 97b:	8b 46 08             	mov    0x8(%esi),%eax
 97e:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
 985:	83 c7 01             	add    $0x1,%edi
 988:	eb d6                	jmp    960 <trnmnt_tree_alloc+0xf0>
        return 0;
 98a:	31 f6                	xor    %esi,%esi

    return output;
}
 98c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 98f:	89 f0                	mov    %esi,%eax
 991:	5b                   	pop    %ebx
 992:	5e                   	pop    %esi
 993:	5f                   	pop    %edi
 994:	5d                   	pop    %ebp
 995:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
 996:	8b 46 04             	mov    0x4(%esi),%eax
 999:	83 ec 0c             	sub    $0xc,%esp
 99c:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 99f:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 9a2:	e8 83 fa ff ff       	call   42a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 9a7:	83 c4 10             	add    $0x10,%esp
 9aa:	39 df                	cmp    %ebx,%edi
 9ac:	75 e8                	jne    996 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
 9ae:	83 ec 0c             	sub    $0xc,%esp
 9b1:	ff 36                	pushl  (%esi)
 9b3:	e8 72 fa ff ff       	call   42a <kthread_mutex_dealloc>
        free(output->mutextree);
 9b8:	58                   	pop    %eax
 9b9:	ff 76 04             	pushl  0x4(%esi)
 9bc:	e8 ff fc ff ff       	call   6c0 <free>
        free(output);
 9c1:	89 34 24             	mov    %esi,(%esp)
        return 0;
 9c4:	31 f6                	xor    %esi,%esi
        free(output);
 9c6:	e8 f5 fc ff ff       	call   6c0 <free>
        return 0;
 9cb:	83 c4 10             	add    $0x10,%esp
}
 9ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9d1:	89 f0                	mov    %esi,%eax
 9d3:	5b                   	pop    %ebx
 9d4:	5e                   	pop    %esi
 9d5:	5f                   	pop    %edi
 9d6:	5d                   	pop    %ebp
 9d7:	c3                   	ret    
 9d8:	8b 7d dc             	mov    -0x24(%ebp),%edi
 9db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9de:	eb 03                	jmp    9e3 <trnmnt_tree_alloc+0x173>
 9e0:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
 9e3:	83 ec 0c             	sub    $0xc,%esp
 9e6:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 9e9:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 9ec:	e8 39 fa ff ff       	call   42a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 9f1:	83 c4 10             	add    $0x10,%esp
 9f4:	39 df                	cmp    %ebx,%edi
 9f6:	75 e8                	jne    9e0 <trnmnt_tree_alloc+0x170>
 9f8:	eb b4                	jmp    9ae <trnmnt_tree_alloc+0x13e>
        free(output);
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	56                   	push   %esi
        return 0;
 9fe:	31 f6                	xor    %esi,%esi
        free(output);
 a00:	e8 bb fc ff ff       	call   6c0 <free>
        return 0;
 a05:	83 c4 10             	add    $0x10,%esp
 a08:	eb 82                	jmp    98c <trnmnt_tree_alloc+0x11c>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a10 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 28             	sub    $0x28,%esp
 a19:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
 a1c:	ff 36                	pushl  (%esi)
 a1e:	e8 0f fa ff ff       	call   432 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
 a23:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
 a26:	83 c4 10             	add    $0x10,%esp
 a29:	85 ff                	test   %edi,%edi
 a2b:	0f 84 0b 01 00 00    	je     b3c <trnmnt_tree_dealloc+0x12c>
 a31:	89 f8                	mov    %edi,%eax
    int output = 1;
 a33:	bb 01 00 00 00       	mov    $0x1,%ebx
 a38:	90                   	nop
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 a40:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
 a42:	83 e8 01             	sub    $0x1,%eax
 a45:	75 f9                	jne    a40 <trnmnt_tree_dealloc+0x30>
 a47:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
 a4a:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
 a4c:	85 ff                	test   %edi,%edi
 a4e:	74 2f                	je     a7f <trnmnt_tree_dealloc+0x6f>
 a50:	89 f8                	mov    %edi,%eax
    int output = 1;
 a52:	ba 01 00 00 00       	mov    $0x1,%edx
 a57:	89 f6                	mov    %esi,%esi
 a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 a60:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 a62:	83 e8 01             	sub    $0x1,%eax
 a65:	75 f9                	jne    a60 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
 a67:	39 d1                	cmp    %edx,%ecx
 a69:	7d 25                	jge    a90 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
 a6b:	8b 46 08             	mov    0x8(%esi),%eax
 a6e:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
 a72:	0f 85 a8 00 00 00    	jne    b20 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
 a78:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
 a7b:	85 ff                	test   %edi,%edi
 a7d:	75 d1                	jne    a50 <trnmnt_tree_dealloc+0x40>
    int output = 1;
 a7f:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
 a84:	39 d1                	cmp    %edx,%ecx
 a86:	7c e3                	jl     a6b <trnmnt_tree_dealloc+0x5b>
 a88:	90                   	nop
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
 a90:	85 db                	test   %ebx,%ebx
 a92:	74 46                	je     ada <trnmnt_tree_dealloc+0xca>
 a94:	31 ff                	xor    %edi,%edi
 a96:	eb 0f                	jmp    aa7 <trnmnt_tree_dealloc+0x97>
 a98:	90                   	nop
 a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 aa0:	83 c7 01             	add    $0x1,%edi
 aa3:	39 fb                	cmp    %edi,%ebx
 aa5:	74 33                	je     ada <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
 aa7:	8b 46 04             	mov    0x4(%esi),%eax
 aaa:	83 ec 0c             	sub    $0xc,%esp
 aad:	ff 34 b8             	pushl  (%eax,%edi,4)
 ab0:	e8 75 f9 ff ff       	call   42a <kthread_mutex_dealloc>
 ab5:	83 c4 10             	add    $0x10,%esp
 ab8:	83 f8 ff             	cmp    $0xffffffff,%eax
 abb:	75 e3                	jne    aa0 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
 abd:	83 ec 0c             	sub    $0xc,%esp
 ac0:	ff 36                	pushl  (%esi)
 ac2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ac5:	e8 70 f9 ff ff       	call   43a <kthread_mutex_unlock>
            return -1;
 aca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 acd:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
 ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ad3:	5b                   	pop    %ebx
 ad4:	89 d0                	mov    %edx,%eax
 ad6:	5e                   	pop    %esi
 ad7:	5f                   	pop    %edi
 ad8:	5d                   	pop    %ebp
 ad9:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
 ada:	83 ec 0c             	sub    $0xc,%esp
 add:	ff 36                	pushl  (%esi)
 adf:	e8 56 f9 ff ff       	call   43a <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
 ae4:	58                   	pop    %eax
 ae5:	ff 36                	pushl  (%esi)
 ae7:	e8 3e f9 ff ff       	call   42a <kthread_mutex_dealloc>
    free(tree->threadMap);
 aec:	5a                   	pop    %edx
 aed:	ff 76 08             	pushl  0x8(%esi)
 af0:	e8 cb fb ff ff       	call   6c0 <free>
    free(tree->mutextree);
 af5:	59                   	pop    %ecx
 af6:	ff 76 04             	pushl  0x4(%esi)
 af9:	e8 c2 fb ff ff       	call   6c0 <free>
    free(tree);
 afe:	89 34 24             	mov    %esi,(%esp)
 b01:	e8 ba fb ff ff       	call   6c0 <free>
    tree->depth = 0;
 b06:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
 b0d:	83 c4 10             	add    $0x10,%esp
}
 b10:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 b13:	31 d2                	xor    %edx,%edx
}
 b15:	5b                   	pop    %ebx
 b16:	89 d0                	mov    %edx,%eax
 b18:	5e                   	pop    %esi
 b19:	5f                   	pop    %edi
 b1a:	5d                   	pop    %ebp
 b1b:	c3                   	ret    
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
 b20:	83 ec 0c             	sub    $0xc,%esp
 b23:	ff 36                	pushl  (%esi)
 b25:	e8 10 f9 ff ff       	call   43a <kthread_mutex_unlock>
            return -1;
 b2a:	83 c4 10             	add    $0x10,%esp
}
 b2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
 b30:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
 b35:	89 d0                	mov    %edx,%eax
 b37:	5b                   	pop    %ebx
 b38:	5e                   	pop    %esi
 b39:	5f                   	pop    %edi
 b3a:	5d                   	pop    %ebp
 b3b:	c3                   	ret    
    while (exp != 0) {
 b3c:	31 db                	xor    %ebx,%ebx
 b3e:	e9 07 ff ff ff       	jmp    a4a <trnmnt_tree_dealloc+0x3a>
 b43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
 b50:	55                   	push   %ebp
 b51:	89 e5                	mov    %esp,%ebp
 b53:	57                   	push   %edi
 b54:	56                   	push   %esi
 b55:	53                   	push   %ebx
 b56:	83 ec 0c             	sub    $0xc,%esp
 b59:	8b 7d 0c             	mov    0xc(%ebp),%edi
 b5c:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 b5f:	85 ff                	test   %edi,%edi
 b61:	0f 88 d1 00 00 00    	js     c38 <trnmnt_tree_acquire+0xe8>
 b67:	85 f6                	test   %esi,%esi
 b69:	0f 84 c9 00 00 00    	je     c38 <trnmnt_tree_acquire+0xe8>
 b6f:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
 b72:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
 b77:	85 c0                	test   %eax,%eax
 b79:	74 0c                	je     b87 <trnmnt_tree_acquire+0x37>
 b7b:	90                   	nop
 b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 b80:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 b82:	83 e8 01             	sub    $0x1,%eax
 b85:	75 f9                	jne    b80 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 b87:	39 d7                	cmp    %edx,%edi
 b89:	0f 8d a9 00 00 00    	jge    c38 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
 b8f:	83 ec 0c             	sub    $0xc,%esp
 b92:	ff 36                	pushl  (%esi)
 b94:	e8 99 f8 ff ff       	call   432 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
 b99:	8b 46 08             	mov    0x8(%esi),%eax
 b9c:	83 c4 10             	add    $0x10,%esp
 b9f:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
 ba2:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 ba5:	0f 85 94 00 00 00    	jne    c3f <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
 bab:	e8 5a f8 ff ff       	call   40a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
 bb0:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
 bb3:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
 bb5:	ff 36                	pushl  (%esi)
 bb7:	e8 7e f8 ff ff       	call   43a <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
 bbc:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
 bbf:	83 c4 10             	add    $0x10,%esp
 bc2:	85 c0                	test   %eax,%eax
 bc4:	74 5a                	je     c20 <trnmnt_tree_acquire+0xd0>
    int output = 1;
 bc6:	ba 01 00 00 00       	mov    $0x1,%edx
 bcb:	90                   	nop
 bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 bd0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 bd2:	83 e8 01             	sub    $0x1,%eax
 bd5:	75 f9                	jne    bd0 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
 bd7:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
 bdb:	89 c3                	mov    %eax,%ebx
 bdd:	c1 eb 1f             	shr    $0x1f,%ebx
 be0:	01 c3                	add    %eax,%ebx
 be2:	d1 fb                	sar    %ebx
 be4:	eb 0c                	jmp    bf2 <trnmnt_tree_acquire+0xa2>
 be6:	8d 76 00             	lea    0x0(%esi),%esi
 be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
 bf0:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
 bf2:	8b 46 04             	mov    0x4(%esi),%eax
 bf5:	83 ec 0c             	sub    $0xc,%esp
 bf8:	ff 34 98             	pushl  (%eax,%ebx,4)
 bfb:	e8 32 f8 ff ff       	call   432 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
 c00:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
 c03:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
 c06:	89 d0                	mov    %edx,%eax
 c08:	c1 e8 1f             	shr    $0x1f,%eax
 c0b:	01 d0                	add    %edx,%eax
 c0d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
 c0f:	85 db                	test   %ebx,%ebx
 c11:	75 dd                	jne    bf0 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
 c13:	31 c0                	xor    %eax,%eax
}
 c15:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c18:	5b                   	pop    %ebx
 c19:	5e                   	pop    %esi
 c1a:	5f                   	pop    %edi
 c1b:	5d                   	pop    %ebp
 c1c:	c3                   	ret    
 c1d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
 c20:	8d 47 ff             	lea    -0x1(%edi),%eax
 c23:	89 c3                	mov    %eax,%ebx
 c25:	c1 eb 1f             	shr    $0x1f,%ebx
 c28:	01 c3                	add    %eax,%ebx
 c2a:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
 c2c:	85 ff                	test   %edi,%edi
 c2e:	74 e3                	je     c13 <trnmnt_tree_acquire+0xc3>
 c30:	eb c0                	jmp    bf2 <trnmnt_tree_acquire+0xa2>
 c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c3d:	eb d6                	jmp    c15 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
 c3f:	83 ec 0c             	sub    $0xc,%esp
 c42:	ff 36                	pushl  (%esi)
 c44:	e8 f1 f7 ff ff       	call   43a <kthread_mutex_unlock>
        return -1;
 c49:	83 c4 10             	add    $0x10,%esp
 c4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c51:	eb c2                	jmp    c15 <trnmnt_tree_acquire+0xc5>
 c53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c60 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 c60:	55                   	push   %ebp
 c61:	89 e5                	mov    %esp,%ebp
 c63:	56                   	push   %esi
 c64:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
 c65:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 c68:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
 c6b:	8d 50 ff             	lea    -0x1(%eax),%edx
 c6e:	89 d0                	mov    %edx,%eax
 c70:	c1 e8 1f             	shr    $0x1f,%eax
 c73:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
 c75:	d1 f8                	sar    %eax
 c77:	89 c3                	mov    %eax,%ebx
 c79:	75 15                	jne    c90 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 c7b:	8b 46 04             	mov    0x4(%esi),%eax
 c7e:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 c81:	89 45 08             	mov    %eax,0x8(%ebp)
}
 c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
 c87:	5b                   	pop    %ebx
 c88:	5e                   	pop    %esi
 c89:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 c8a:	e9 ab f7 ff ff       	jmp    43a <kthread_mutex_unlock>
 c8f:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
 c90:	83 ec 08             	sub    $0x8,%esp
 c93:	50                   	push   %eax
 c94:	56                   	push   %esi
 c95:	e8 c6 ff ff ff       	call   c60 <trnmnt_tree_release_rec>
 c9a:	83 c4 10             	add    $0x10,%esp
 c9d:	83 f8 ff             	cmp    $0xffffffff,%eax
 ca0:	75 d9                	jne    c7b <trnmnt_tree_release_rec+0x1b>
}
 ca2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ca5:	5b                   	pop    %ebx
 ca6:	5e                   	pop    %esi
 ca7:	5d                   	pop    %ebp
 ca8:	c3                   	ret    
 ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
 cb0:	55                   	push   %ebp
 cb1:	89 e5                	mov    %esp,%ebp
 cb3:	57                   	push   %edi
 cb4:	56                   	push   %esi
 cb5:	53                   	push   %ebx
 cb6:	83 ec 28             	sub    $0x28,%esp
 cb9:	8b 7d 08             	mov    0x8(%ebp),%edi
 cbc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
 cbf:	ff 37                	pushl  (%edi)
 cc1:	e8 6c f7 ff ff       	call   432 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
 cc6:	8b 47 08             	mov    0x8(%edi),%eax
 cc9:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 ccc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ccf:	e8 36 f7 ff ff       	call   40a <kthread_id>
 cd4:	83 c4 10             	add    $0x10,%esp
 cd7:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
 cda:	75 56                	jne    d32 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 cdc:	8b 47 0c             	mov    0xc(%edi),%eax
 cdf:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
 ce6:	85 c0                	test   %eax,%eax
 ce8:	74 11                	je     cfb <trnmnt_tree_release+0x4b>
    int output = 1;
 cea:	b9 01 00 00 00       	mov    $0x1,%ecx
 cef:	90                   	nop
        output *= init;
 cf0:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
 cf2:	83 e8 01             	sub    $0x1,%eax
 cf5:	75 f9                	jne    cf0 <trnmnt_tree_release+0x40>
 cf7:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 cfb:	83 ec 08             	sub    $0x8,%esp
 cfe:	53                   	push   %ebx
 cff:	57                   	push   %edi
 d00:	e8 5b ff ff ff       	call   c60 <trnmnt_tree_release_rec>
 d05:	83 c4 10             	add    $0x10,%esp
 d08:	83 f8 ff             	cmp    $0xffffffff,%eax
 d0b:	89 c3                	mov    %eax,%ebx
 d0d:	74 37                	je     d46 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
 d0f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
 d12:	83 ec 0c             	sub    $0xc,%esp
    return 0;
 d15:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
 d17:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
 d1e:	ff 37                	pushl  (%edi)
 d20:	e8 15 f7 ff ff       	call   43a <kthread_mutex_unlock>
    return 0;
 d25:	83 c4 10             	add    $0x10,%esp
}
 d28:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d2b:	89 d8                	mov    %ebx,%eax
 d2d:	5b                   	pop    %ebx
 d2e:	5e                   	pop    %esi
 d2f:	5f                   	pop    %edi
 d30:	5d                   	pop    %ebp
 d31:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
 d32:	83 ec 0c             	sub    $0xc,%esp
 d35:	ff 37                	pushl  (%edi)
        return -1;
 d37:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
 d3c:	e8 f9 f6 ff ff       	call   43a <kthread_mutex_unlock>
        return -1;
 d41:	83 c4 10             	add    $0x10,%esp
 d44:	eb e2                	jmp    d28 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
 d46:	83 ec 0c             	sub    $0xc,%esp
 d49:	ff 37                	pushl  (%edi)
 d4b:	e8 ea f6 ff ff       	call   43a <kthread_mutex_unlock>
        return -1;
 d50:	83 c4 10             	add    $0x10,%esp
 d53:	eb d3                	jmp    d28 <trnmnt_tree_release+0x78>
