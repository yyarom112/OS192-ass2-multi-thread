
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	pushl  -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  16:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi

  for(i = 0; i < 4; i++)
  1c:	31 db                	xor    %ebx,%ebx
{
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  2b:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  32:	74 72 65 
  printf(1, "stressfs starting\n");
  35:	68 88 0d 00 00       	push   $0xd88
  3a:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
  46:	e8 d5 04 00 00       	call   520 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 95 01 00 00       	call   1f0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 27 03 00 00       	call   38a <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx
  7c:	68 9b 0d 00 00       	push   $0xd9b

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  81:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  86:	6a 01                	push   $0x1
  88:	e8 93 04 00 00       	call   520 <printf>
  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  8f:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	5f                   	pop    %edi
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 2a 03 00 00       	call   3d2 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 f3 02 00 00       	call   3b2 <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 ea 02 00 00       	call   3ba <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 a5 0d 00 00       	push   $0xda5
  d7:	6a 01                	push   $0x1
  d9:	e8 42 04 00 00       	call   520 <printf>

  fd = open(path, O_RDONLY);
  de:	59                   	pop    %ecx
  df:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	50                   	push   %eax
  e9:	bb 14 00 00 00       	mov    $0x14,%ebx
  ee:	e8 df 02 00 00       	call   3d2 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 9b 02 00 00       	call   3aa <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 9a 02 00 00       	call   3ba <close>

  wait();
 120:	e8 75 02 00 00       	call   39a <wait>

  exit();
 125:	e8 68 02 00 00       	call   392 <exit>
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	84 c0                	test   %al,%al
 182:	75 1c                	jne    1a0 <strcmp+0x30>
 184:	eb 2a                	jmp    1b0 <strcmp+0x40>
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 190:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 193:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 196:	83 c1 01             	add    $0x1,%ecx
 199:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x40>
 1a0:	38 d8                	cmp    %bl,%al
 1a2:	74 ec                	je     190 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1a4:	29 d8                	sub    %ebx,%eax
}
 1a6:	5b                   	pop    %ebx
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1b2:	29 d8                	sub    %ebx,%eax
}
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1e0:	31 c0                	xor    %eax,%eax
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
    if(*s == c)
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	31 f6                	xor    %esi,%esi
 258:	89 f3                	mov    %esi,%ebx
{
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 268:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26b:	83 ec 04             	sub    $0x4,%esp
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 32 01 00 00       	call   3aa <read>
    if(cc < 1)
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
      break;
    buf[i++] = c;
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 291:	83 c3 01             	add    $0x1,%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	89 fe                	mov    %edi,%esi
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	8b 75 08             	mov    0x8(%ebp),%esi
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 de                	add    %ebx,%esi
 2b8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
}
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 f0 00 00 00       	call   3d2 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 f3 00 00 00       	call   3ea <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 b9 00 00 00       	call   3ba <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
  n = 0;
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 382:	39 d3                	cmp    %edx,%ebx
 384:	75 f2                	jne    378 <memmove+0x18>
  return vdst;
}
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    

0000038a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38a:	b8 01 00 00 00       	mov    $0x1,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <exit>:
SYSCALL(exit)
 392:	b8 02 00 00 00       	mov    $0x2,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <wait>:
SYSCALL(wait)
 39a:	b8 03 00 00 00       	mov    $0x3,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <pipe>:
SYSCALL(pipe)
 3a2:	b8 04 00 00 00       	mov    $0x4,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <read>:
SYSCALL(read)
 3aa:	b8 05 00 00 00       	mov    $0x5,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <write>:
SYSCALL(write)
 3b2:	b8 10 00 00 00       	mov    $0x10,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <close>:
SYSCALL(close)
 3ba:	b8 15 00 00 00       	mov    $0x15,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <kill>:
SYSCALL(kill)
 3c2:	b8 06 00 00 00       	mov    $0x6,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <exec>:
SYSCALL(exec)
 3ca:	b8 07 00 00 00       	mov    $0x7,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <open>:
SYSCALL(open)
 3d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mknod>:
SYSCALL(mknod)
 3da:	b8 11 00 00 00       	mov    $0x11,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <unlink>:
SYSCALL(unlink)
 3e2:	b8 12 00 00 00       	mov    $0x12,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <fstat>:
SYSCALL(fstat)
 3ea:	b8 08 00 00 00       	mov    $0x8,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <link>:
SYSCALL(link)
 3f2:	b8 13 00 00 00       	mov    $0x13,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mkdir>:
SYSCALL(mkdir)
 3fa:	b8 14 00 00 00       	mov    $0x14,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <chdir>:
SYSCALL(chdir)
 402:	b8 09 00 00 00       	mov    $0x9,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <dup>:
SYSCALL(dup)
 40a:	b8 0a 00 00 00       	mov    $0xa,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getpid>:
SYSCALL(getpid)
 412:	b8 0b 00 00 00       	mov    $0xb,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <sbrk>:
SYSCALL(sbrk)
 41a:	b8 0c 00 00 00       	mov    $0xc,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sleep>:
SYSCALL(sleep)
 422:	b8 0d 00 00 00       	mov    $0xd,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <uptime>:
SYSCALL(uptime)
 42a:	b8 0e 00 00 00       	mov    $0xe,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kthread_create>:
SYSCALL(kthread_create)
 432:	b8 16 00 00 00       	mov    $0x16,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <kthread_id>:
SYSCALL(kthread_id)
 43a:	b8 17 00 00 00       	mov    $0x17,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <kthread_exit>:
SYSCALL(kthread_exit)
 442:	b8 18 00 00 00       	mov    $0x18,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <kthread_join>:
SYSCALL(kthread_join)
 44a:	b8 19 00 00 00       	mov    $0x19,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 452:	b8 1a 00 00 00       	mov    $0x1a,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 45a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 462:	b8 1c 00 00 00       	mov    $0x1c,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 46a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    
 472:	66 90                	xchg   %ax,%ax
 474:	66 90                	xchg   %ax,%ax
 476:	66 90                	xchg   %ax,%ax
 478:	66 90                	xchg   %ax,%ax
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 489:	85 d2                	test   %edx,%edx
{
 48b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 48e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 490:	79 76                	jns    508 <printint+0x88>
 492:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 496:	74 70                	je     508 <printint+0x88>
    x = -xx;
 498:	f7 d8                	neg    %eax
    neg = 1;
 49a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4a1:	31 f6                	xor    %esi,%esi
 4a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4a6:	eb 0a                	jmp    4b2 <printint+0x32>
 4a8:	90                   	nop
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 4b0:	89 fe                	mov    %edi,%esi
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	8d 7e 01             	lea    0x1(%esi),%edi
 4b7:	f7 f1                	div    %ecx
 4b9:	0f b6 92 b4 0d 00 00 	movzbl 0xdb4(%edx),%edx
  }while((x /= base) != 0);
 4c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 4c5:	75 e9                	jne    4b0 <printint+0x30>
  if(neg)
 4c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4ca:	85 c0                	test   %eax,%eax
 4cc:	74 08                	je     4d6 <printint+0x56>
    buf[i++] = '-';
 4ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 4d3:	8d 7e 02             	lea    0x2(%esi),%edi
 4d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 4da:	8b 7d c0             	mov    -0x40(%ebp),%edi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
 4e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4e3:	83 ec 04             	sub    $0x4,%esp
 4e6:	83 ee 01             	sub    $0x1,%esi
 4e9:	6a 01                	push   $0x1
 4eb:	53                   	push   %ebx
 4ec:	57                   	push   %edi
 4ed:	88 45 d7             	mov    %al,-0x29(%ebp)
 4f0:	e8 bd fe ff ff       	call   3b2 <write>

  while(--i >= 0)
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	39 de                	cmp    %ebx,%esi
 4fa:	75 e4                	jne    4e0 <printint+0x60>
    putc(fd, buf[i]);
}
 4fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ff:	5b                   	pop    %ebx
 500:	5e                   	pop    %esi
 501:	5f                   	pop    %edi
 502:	5d                   	pop    %ebp
 503:	c3                   	ret    
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 508:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 50f:	eb 90                	jmp    4a1 <printint+0x21>
 511:	eb 0d                	jmp    520 <printf>
 513:	90                   	nop
 514:	90                   	nop
 515:	90                   	nop
 516:	90                   	nop
 517:	90                   	nop
 518:	90                   	nop
 519:	90                   	nop
 51a:	90                   	nop
 51b:	90                   	nop
 51c:	90                   	nop
 51d:	90                   	nop
 51e:	90                   	nop
 51f:	90                   	nop

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 75 0c             	mov    0xc(%ebp),%esi
 52c:	0f b6 1e             	movzbl (%esi),%ebx
 52f:	84 db                	test   %bl,%bl
 531:	0f 84 b3 00 00 00    	je     5ea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 537:	8d 45 10             	lea    0x10(%ebp),%eax
 53a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 53d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 53f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 542:	eb 2f                	jmp    573 <printf+0x53>
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 548:	83 f8 25             	cmp    $0x25,%eax
 54b:	0f 84 a7 00 00 00    	je     5f8 <printf+0xd8>
  write(fd, &c, 1);
 551:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 554:	83 ec 04             	sub    $0x4,%esp
 557:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 55a:	6a 01                	push   $0x1
 55c:	50                   	push   %eax
 55d:	ff 75 08             	pushl  0x8(%ebp)
 560:	e8 4d fe ff ff       	call   3b2 <write>
 565:	83 c4 10             	add    $0x10,%esp
 568:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 56b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 56f:	84 db                	test   %bl,%bl
 571:	74 77                	je     5ea <printf+0xca>
    if(state == 0){
 573:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 575:	0f be cb             	movsbl %bl,%ecx
 578:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 57b:	74 cb                	je     548 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 57d:	83 ff 25             	cmp    $0x25,%edi
 580:	75 e6                	jne    568 <printf+0x48>
      if(c == 'd'){
 582:	83 f8 64             	cmp    $0x64,%eax
 585:	0f 84 05 01 00 00    	je     690 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 58b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 591:	83 f9 70             	cmp    $0x70,%ecx
 594:	74 72                	je     608 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 596:	83 f8 73             	cmp    $0x73,%eax
 599:	0f 84 99 00 00 00    	je     638 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 59f:	83 f8 63             	cmp    $0x63,%eax
 5a2:	0f 84 08 01 00 00    	je     6b0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a8:	83 f8 25             	cmp    $0x25,%eax
 5ab:	0f 84 ef 00 00 00    	je     6a0 <printf+0x180>
  write(fd, &c, 1);
 5b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5b4:	83 ec 04             	sub    $0x4,%esp
 5b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5bb:	6a 01                	push   $0x1
 5bd:	50                   	push   %eax
 5be:	ff 75 08             	pushl  0x8(%ebp)
 5c1:	e8 ec fd ff ff       	call   3b2 <write>
 5c6:	83 c4 0c             	add    $0xc,%esp
 5c9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5cc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 5cf:	6a 01                	push   $0x1
 5d1:	50                   	push   %eax
 5d2:	ff 75 08             	pushl  0x8(%ebp)
 5d5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5d8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5da:	e8 d3 fd ff ff       	call   3b2 <write>
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 5e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5e6:	84 db                	test   %bl,%bl
 5e8:	75 89                	jne    573 <printf+0x53>
    }
  }
}
 5ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ed:	5b                   	pop    %ebx
 5ee:	5e                   	pop    %esi
 5ef:	5f                   	pop    %edi
 5f0:	5d                   	pop    %ebp
 5f1:	c3                   	ret    
 5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 5f8:	bf 25 00 00 00       	mov    $0x25,%edi
 5fd:	e9 66 ff ff ff       	jmp    568 <printf+0x48>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 608:	83 ec 0c             	sub    $0xc,%esp
 60b:	b9 10 00 00 00       	mov    $0x10,%ecx
 610:	6a 00                	push   $0x0
 612:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 615:	8b 45 08             	mov    0x8(%ebp),%eax
 618:	8b 17                	mov    (%edi),%edx
 61a:	e8 61 fe ff ff       	call   480 <printint>
        ap++;
 61f:	89 f8                	mov    %edi,%eax
 621:	83 c4 10             	add    $0x10,%esp
      state = 0;
 624:	31 ff                	xor    %edi,%edi
        ap++;
 626:	83 c0 04             	add    $0x4,%eax
 629:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 62c:	e9 37 ff ff ff       	jmp    568 <printf+0x48>
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 638:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 63b:	8b 08                	mov    (%eax),%ecx
        ap++;
 63d:	83 c0 04             	add    $0x4,%eax
 640:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 643:	85 c9                	test   %ecx,%ecx
 645:	0f 84 8e 00 00 00    	je     6d9 <printf+0x1b9>
        while(*s != 0){
 64b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 64e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 650:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 652:	84 c0                	test   %al,%al
 654:	0f 84 0e ff ff ff    	je     568 <printf+0x48>
 65a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 65d:	89 de                	mov    %ebx,%esi
 65f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 662:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 665:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 668:	83 ec 04             	sub    $0x4,%esp
          s++;
 66b:	83 c6 01             	add    $0x1,%esi
 66e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 671:	6a 01                	push   $0x1
 673:	57                   	push   %edi
 674:	53                   	push   %ebx
 675:	e8 38 fd ff ff       	call   3b2 <write>
        while(*s != 0){
 67a:	0f b6 06             	movzbl (%esi),%eax
 67d:	83 c4 10             	add    $0x10,%esp
 680:	84 c0                	test   %al,%al
 682:	75 e4                	jne    668 <printf+0x148>
 684:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 687:	31 ff                	xor    %edi,%edi
 689:	e9 da fe ff ff       	jmp    568 <printf+0x48>
 68e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	e9 73 ff ff ff       	jmp    612 <printf+0xf2>
 69f:	90                   	nop
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 6a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 6a9:	6a 01                	push   $0x1
 6ab:	e9 21 ff ff ff       	jmp    5d1 <printf+0xb1>
        putc(fd, *ap);
 6b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 6b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 6b6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 6b8:	6a 01                	push   $0x1
        ap++;
 6ba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 6bd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6c3:	50                   	push   %eax
 6c4:	ff 75 08             	pushl  0x8(%ebp)
 6c7:	e8 e6 fc ff ff       	call   3b2 <write>
        ap++;
 6cc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6cf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6d2:	31 ff                	xor    %edi,%edi
 6d4:	e9 8f fe ff ff       	jmp    568 <printf+0x48>
          s = "(null)";
 6d9:	bb ab 0d 00 00       	mov    $0xdab,%ebx
        while(*s != 0){
 6de:	b8 28 00 00 00       	mov    $0x28,%eax
 6e3:	e9 72 ff ff ff       	jmp    65a <printf+0x13a>
 6e8:	66 90                	xchg   %ax,%ax
 6ea:	66 90                	xchg   %ax,%ax
 6ec:	66 90                	xchg   %ax,%ax
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 c0 11 00 00       	mov    0x11c0,%eax
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 708:	39 c8                	cmp    %ecx,%eax
 70a:	8b 10                	mov    (%eax),%edx
 70c:	73 32                	jae    740 <free+0x50>
 70e:	39 d1                	cmp    %edx,%ecx
 710:	72 04                	jb     716 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 712:	39 d0                	cmp    %edx,%eax
 714:	72 32                	jb     748 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 716:	8b 73 fc             	mov    -0x4(%ebx),%esi
 719:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71c:	39 fa                	cmp    %edi,%edx
 71e:	74 30                	je     750 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 720:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 723:	8b 50 04             	mov    0x4(%eax),%edx
 726:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 729:	39 f1                	cmp    %esi,%ecx
 72b:	74 3a                	je     767 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 72d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 72f:	a3 c0 11 00 00       	mov    %eax,0x11c0
}
 734:	5b                   	pop    %ebx
 735:	5e                   	pop    %esi
 736:	5f                   	pop    %edi
 737:	5d                   	pop    %ebp
 738:	c3                   	ret    
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	39 d0                	cmp    %edx,%eax
 742:	72 04                	jb     748 <free+0x58>
 744:	39 d1                	cmp    %edx,%ecx
 746:	72 ce                	jb     716 <free+0x26>
{
 748:	89 d0                	mov    %edx,%eax
 74a:	eb bc                	jmp    708 <free+0x18>
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 750:	03 72 04             	add    0x4(%edx),%esi
 753:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 756:	8b 10                	mov    (%eax),%edx
 758:	8b 12                	mov    (%edx),%edx
 75a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 75d:	8b 50 04             	mov    0x4(%eax),%edx
 760:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 763:	39 f1                	cmp    %esi,%ecx
 765:	75 c6                	jne    72d <free+0x3d>
    p->s.size += bp->s.size;
 767:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 76a:	a3 c0 11 00 00       	mov    %eax,0x11c0
    p->s.size += bp->s.size;
 76f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 772:	8b 53 f8             	mov    -0x8(%ebx),%edx
 775:	89 10                	mov    %edx,(%eax)
}
 777:	5b                   	pop    %ebx
 778:	5e                   	pop    %esi
 779:	5f                   	pop    %edi
 77a:	5d                   	pop    %ebp
 77b:	c3                   	ret    
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 78c:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	8d 78 07             	lea    0x7(%eax),%edi
 795:	c1 ef 03             	shr    $0x3,%edi
 798:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 79b:	85 d2                	test   %edx,%edx
 79d:	0f 84 9d 00 00 00    	je     840 <malloc+0xc0>
 7a3:	8b 02                	mov    (%edx),%eax
 7a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	76 6c                	jbe    818 <malloc+0x98>
 7ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 7b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7b7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7c1:	eb 0e                	jmp    7d1 <malloc+0x51>
 7c3:	90                   	nop
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7ca:	8b 48 04             	mov    0x4(%eax),%ecx
 7cd:	39 f9                	cmp    %edi,%ecx
 7cf:	73 47                	jae    818 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d1:	39 05 c0 11 00 00    	cmp    %eax,0x11c0
 7d7:	89 c2                	mov    %eax,%edx
 7d9:	75 ed                	jne    7c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 7db:	83 ec 0c             	sub    $0xc,%esp
 7de:	56                   	push   %esi
 7df:	e8 36 fc ff ff       	call   41a <sbrk>
  if(p == (char*)-1)
 7e4:	83 c4 10             	add    $0x10,%esp
 7e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ea:	74 1c                	je     808 <malloc+0x88>
  hp->s.size = nu;
 7ec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7ef:	83 ec 0c             	sub    $0xc,%esp
 7f2:	83 c0 08             	add    $0x8,%eax
 7f5:	50                   	push   %eax
 7f6:	e8 f5 fe ff ff       	call   6f0 <free>
  return freep;
 7fb:	8b 15 c0 11 00 00    	mov    0x11c0,%edx
      if((p = morecore(nunits)) == 0)
 801:	83 c4 10             	add    $0x10,%esp
 804:	85 d2                	test   %edx,%edx
 806:	75 c0                	jne    7c8 <malloc+0x48>
        return 0;
  }
}
 808:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 80b:	31 c0                	xor    %eax,%eax
}
 80d:	5b                   	pop    %ebx
 80e:	5e                   	pop    %esi
 80f:	5f                   	pop    %edi
 810:	5d                   	pop    %ebp
 811:	c3                   	ret    
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 818:	39 cf                	cmp    %ecx,%edi
 81a:	74 54                	je     870 <malloc+0xf0>
        p->s.size -= nunits;
 81c:	29 f9                	sub    %edi,%ecx
 81e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 821:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 824:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 827:	89 15 c0 11 00 00    	mov    %edx,0x11c0
}
 82d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 830:	83 c0 08             	add    $0x8,%eax
}
 833:	5b                   	pop    %ebx
 834:	5e                   	pop    %esi
 835:	5f                   	pop    %edi
 836:	5d                   	pop    %ebp
 837:	c3                   	ret    
 838:	90                   	nop
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 c0 11 00 00 c4 	movl   $0x11c4,0x11c0
 847:	11 00 00 
 84a:	c7 05 c4 11 00 00 c4 	movl   $0x11c4,0x11c4
 851:	11 00 00 
    base.s.size = 0;
 854:	b8 c4 11 00 00       	mov    $0x11c4,%eax
 859:	c7 05 c8 11 00 00 00 	movl   $0x0,0x11c8
 860:	00 00 00 
 863:	e9 44 ff ff ff       	jmp    7ac <malloc+0x2c>
 868:	90                   	nop
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb b1                	jmp    827 <malloc+0xa7>
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
 880:	55                   	push   %ebp
    int init = 2;
    int output = 1;
 881:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
 886:	89 e5                	mov    %esp,%ebp
 888:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
 88b:	85 d2                	test   %edx,%edx
 88d:	74 08                	je     897 <powordepth+0x17>
 88f:	90                   	nop
        output *= init;
 890:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 892:	83 ea 01             	sub    $0x1,%edx
 895:	75 f9                	jne    890 <powordepth+0x10>
        exp--;
    }
    return output;
}
 897:	5d                   	pop    %ebp
 898:	c3                   	ret    
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008a0 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
 8a9:	6a 10                	push   $0x10
 8ab:	e8 d0 fe ff ff       	call   780 <malloc>
 8b0:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
 8b2:	8b 45 08             	mov    0x8(%ebp),%eax
 8b5:	83 c4 10             	add    $0x10,%esp
 8b8:	83 e8 01             	sub    $0x1,%eax
 8bb:	83 f8 05             	cmp    $0x5,%eax
 8be:	0f 87 f6 00 00 00    	ja     9ba <trnmnt_tree_alloc+0x11a>
 8c4:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
 8c7:	bf 01 00 00 00       	mov    $0x1,%edi
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 8d0:	01 ff                	add    %edi,%edi
    while (exp != 0) {
 8d2:	83 e8 01             	sub    $0x1,%eax
 8d5:	75 f9                	jne    8d0 <trnmnt_tree_alloc+0x30>
 8d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
 8da:	8d 47 ff             	lea    -0x1(%edi),%eax
 8dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
 8e0:	8b 45 08             	mov    0x8(%ebp),%eax
 8e3:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
 8e6:	e8 67 fb ff ff       	call   452 <kthread_mutex_alloc>
 8eb:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ee:	89 06                	mov    %eax,(%esi)
 8f0:	0f 84 34 01 00 00    	je     a2a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
 8f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8f9:	83 ec 0c             	sub    $0xc,%esp
 8fc:	c1 e0 02             	shl    $0x2,%eax
 8ff:	50                   	push   %eax
 900:	89 45 e0             	mov    %eax,-0x20(%ebp)
 903:	e8 78 fe ff ff       	call   780 <malloc>
 908:	83 c4 10             	add    $0x10,%esp
 90b:	85 c0                	test   %eax,%eax
 90d:	89 46 04             	mov    %eax,0x4(%esi)
 910:	0f 84 14 01 00 00    	je     a2a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
 916:	31 db                	xor    %ebx,%ebx
 918:	eb 09                	jmp    923 <trnmnt_tree_alloc+0x83>
 91a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 920:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
 923:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
 926:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 929:	e8 24 fb ff ff       	call   452 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
 92e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 931:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
 933:	75 eb                	jne    920 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
 935:	8b 4e 04             	mov    0x4(%esi),%ecx
 938:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
 93b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
 940:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 943:	89 c8                	mov    %ecx,%eax
 945:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
 947:	31 c9                	xor    %ecx,%ecx
 949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
 950:	83 38 ff             	cmpl   $0xffffffff,(%eax)
 953:	0f 44 cf             	cmove  %edi,%ecx
 956:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
 959:	39 d0                	cmp    %edx,%eax
 95b:	75 f3                	jne    950 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
 95d:	85 c9                	test   %ecx,%ecx
 95f:	8b 7d 08             	mov    0x8(%ebp),%edi
 962:	b8 01 00 00 00       	mov    $0x1,%eax
 967:	0f 85 9b 00 00 00    	jne    a08 <trnmnt_tree_alloc+0x168>
 96d:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
 970:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 972:	83 ef 01             	sub    $0x1,%edi
 975:	75 f9                	jne    970 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
 977:	83 ec 0c             	sub    $0xc,%esp
 97a:	c1 e0 02             	shl    $0x2,%eax
 97d:	50                   	push   %eax
 97e:	e8 fd fd ff ff       	call   780 <malloc>
 983:	83 c4 10             	add    $0x10,%esp
 986:	85 c0                	test   %eax,%eax
 988:	89 46 08             	mov    %eax,0x8(%esi)
 98b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 98e:	74 36                	je     9c6 <trnmnt_tree_alloc+0x126>
 990:	89 c8                	mov    %ecx,%eax
    int output = 1;
 992:	ba 01 00 00 00       	mov    $0x1,%edx
 997:	89 f6                	mov    %esi,%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 9a0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 9a2:	83 e8 01             	sub    $0x1,%eax
 9a5:	75 f9                	jne    9a0 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
 9a7:	39 d7                	cmp    %edx,%edi
 9a9:	7d 11                	jge    9bc <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
 9ab:	8b 46 08             	mov    0x8(%esi),%eax
 9ae:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
 9b5:	83 c7 01             	add    $0x1,%edi
 9b8:	eb d6                	jmp    990 <trnmnt_tree_alloc+0xf0>
        return 0;
 9ba:	31 f6                	xor    %esi,%esi

    return output;
}
 9bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9bf:	89 f0                	mov    %esi,%eax
 9c1:	5b                   	pop    %ebx
 9c2:	5e                   	pop    %esi
 9c3:	5f                   	pop    %edi
 9c4:	5d                   	pop    %ebp
 9c5:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
 9c6:	8b 46 04             	mov    0x4(%esi),%eax
 9c9:	83 ec 0c             	sub    $0xc,%esp
 9cc:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 9cf:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 9d2:	e8 83 fa ff ff       	call   45a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 9d7:	83 c4 10             	add    $0x10,%esp
 9da:	39 df                	cmp    %ebx,%edi
 9dc:	75 e8                	jne    9c6 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
 9de:	83 ec 0c             	sub    $0xc,%esp
 9e1:	ff 36                	pushl  (%esi)
 9e3:	e8 72 fa ff ff       	call   45a <kthread_mutex_dealloc>
        free(output->mutextree);
 9e8:	58                   	pop    %eax
 9e9:	ff 76 04             	pushl  0x4(%esi)
 9ec:	e8 ff fc ff ff       	call   6f0 <free>
        free(output);
 9f1:	89 34 24             	mov    %esi,(%esp)
        return 0;
 9f4:	31 f6                	xor    %esi,%esi
        free(output);
 9f6:	e8 f5 fc ff ff       	call   6f0 <free>
        return 0;
 9fb:	83 c4 10             	add    $0x10,%esp
}
 9fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a01:	89 f0                	mov    %esi,%eax
 a03:	5b                   	pop    %ebx
 a04:	5e                   	pop    %esi
 a05:	5f                   	pop    %edi
 a06:	5d                   	pop    %ebp
 a07:	c3                   	ret    
 a08:	8b 7d dc             	mov    -0x24(%ebp),%edi
 a0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a0e:	eb 03                	jmp    a13 <trnmnt_tree_alloc+0x173>
 a10:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
 a13:	83 ec 0c             	sub    $0xc,%esp
 a16:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 a19:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 a1c:	e8 39 fa ff ff       	call   45a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 a21:	83 c4 10             	add    $0x10,%esp
 a24:	39 df                	cmp    %ebx,%edi
 a26:	75 e8                	jne    a10 <trnmnt_tree_alloc+0x170>
 a28:	eb b4                	jmp    9de <trnmnt_tree_alloc+0x13e>
        free(output);
 a2a:	83 ec 0c             	sub    $0xc,%esp
 a2d:	56                   	push   %esi
        return 0;
 a2e:	31 f6                	xor    %esi,%esi
        free(output);
 a30:	e8 bb fc ff ff       	call   6f0 <free>
        return 0;
 a35:	83 c4 10             	add    $0x10,%esp
 a38:	eb 82                	jmp    9bc <trnmnt_tree_alloc+0x11c>
 a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a40 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	57                   	push   %edi
 a44:	56                   	push   %esi
 a45:	53                   	push   %ebx
 a46:	83 ec 28             	sub    $0x28,%esp
 a49:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
 a4c:	ff 36                	pushl  (%esi)
 a4e:	e8 0f fa ff ff       	call   462 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
 a53:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
 a56:	83 c4 10             	add    $0x10,%esp
 a59:	85 ff                	test   %edi,%edi
 a5b:	0f 84 0b 01 00 00    	je     b6c <trnmnt_tree_dealloc+0x12c>
 a61:	89 f8                	mov    %edi,%eax
    int output = 1;
 a63:	bb 01 00 00 00       	mov    $0x1,%ebx
 a68:	90                   	nop
 a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 a70:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
 a72:	83 e8 01             	sub    $0x1,%eax
 a75:	75 f9                	jne    a70 <trnmnt_tree_dealloc+0x30>
 a77:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
 a7a:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
 a7c:	85 ff                	test   %edi,%edi
 a7e:	74 2f                	je     aaf <trnmnt_tree_dealloc+0x6f>
 a80:	89 f8                	mov    %edi,%eax
    int output = 1;
 a82:	ba 01 00 00 00       	mov    $0x1,%edx
 a87:	89 f6                	mov    %esi,%esi
 a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 a90:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 a92:	83 e8 01             	sub    $0x1,%eax
 a95:	75 f9                	jne    a90 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
 a97:	39 d1                	cmp    %edx,%ecx
 a99:	7d 25                	jge    ac0 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
 a9b:	8b 46 08             	mov    0x8(%esi),%eax
 a9e:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
 aa2:	0f 85 a8 00 00 00    	jne    b50 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
 aa8:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
 aab:	85 ff                	test   %edi,%edi
 aad:	75 d1                	jne    a80 <trnmnt_tree_dealloc+0x40>
    int output = 1;
 aaf:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
 ab4:	39 d1                	cmp    %edx,%ecx
 ab6:	7c e3                	jl     a9b <trnmnt_tree_dealloc+0x5b>
 ab8:	90                   	nop
 ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
 ac0:	85 db                	test   %ebx,%ebx
 ac2:	74 46                	je     b0a <trnmnt_tree_dealloc+0xca>
 ac4:	31 ff                	xor    %edi,%edi
 ac6:	eb 0f                	jmp    ad7 <trnmnt_tree_dealloc+0x97>
 ac8:	90                   	nop
 ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 ad0:	83 c7 01             	add    $0x1,%edi
 ad3:	39 fb                	cmp    %edi,%ebx
 ad5:	74 33                	je     b0a <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
 ad7:	8b 46 04             	mov    0x4(%esi),%eax
 ada:	83 ec 0c             	sub    $0xc,%esp
 add:	ff 34 b8             	pushl  (%eax,%edi,4)
 ae0:	e8 75 f9 ff ff       	call   45a <kthread_mutex_dealloc>
 ae5:	83 c4 10             	add    $0x10,%esp
 ae8:	83 f8 ff             	cmp    $0xffffffff,%eax
 aeb:	75 e3                	jne    ad0 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
 aed:	83 ec 0c             	sub    $0xc,%esp
 af0:	ff 36                	pushl  (%esi)
 af2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 af5:	e8 70 f9 ff ff       	call   46a <kthread_mutex_unlock>
            return -1;
 afa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 afd:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
 b00:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b03:	5b                   	pop    %ebx
 b04:	89 d0                	mov    %edx,%eax
 b06:	5e                   	pop    %esi
 b07:	5f                   	pop    %edi
 b08:	5d                   	pop    %ebp
 b09:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
 b0a:	83 ec 0c             	sub    $0xc,%esp
 b0d:	ff 36                	pushl  (%esi)
 b0f:	e8 56 f9 ff ff       	call   46a <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
 b14:	58                   	pop    %eax
 b15:	ff 36                	pushl  (%esi)
 b17:	e8 3e f9 ff ff       	call   45a <kthread_mutex_dealloc>
    free(tree->threadMap);
 b1c:	5a                   	pop    %edx
 b1d:	ff 76 08             	pushl  0x8(%esi)
 b20:	e8 cb fb ff ff       	call   6f0 <free>
    free(tree->mutextree);
 b25:	59                   	pop    %ecx
 b26:	ff 76 04             	pushl  0x4(%esi)
 b29:	e8 c2 fb ff ff       	call   6f0 <free>
    free(tree);
 b2e:	89 34 24             	mov    %esi,(%esp)
 b31:	e8 ba fb ff ff       	call   6f0 <free>
    tree->depth = 0;
 b36:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
 b3d:	83 c4 10             	add    $0x10,%esp
}
 b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 b43:	31 d2                	xor    %edx,%edx
}
 b45:	5b                   	pop    %ebx
 b46:	89 d0                	mov    %edx,%eax
 b48:	5e                   	pop    %esi
 b49:	5f                   	pop    %edi
 b4a:	5d                   	pop    %ebp
 b4b:	c3                   	ret    
 b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
 b50:	83 ec 0c             	sub    $0xc,%esp
 b53:	ff 36                	pushl  (%esi)
 b55:	e8 10 f9 ff ff       	call   46a <kthread_mutex_unlock>
            return -1;
 b5a:	83 c4 10             	add    $0x10,%esp
}
 b5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
 b60:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
 b65:	89 d0                	mov    %edx,%eax
 b67:	5b                   	pop    %ebx
 b68:	5e                   	pop    %esi
 b69:	5f                   	pop    %edi
 b6a:	5d                   	pop    %ebp
 b6b:	c3                   	ret    
    while (exp != 0) {
 b6c:	31 db                	xor    %ebx,%ebx
 b6e:	e9 07 ff ff ff       	jmp    a7a <trnmnt_tree_dealloc+0x3a>
 b73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b80 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 0c             	sub    $0xc,%esp
 b89:	8b 7d 0c             	mov    0xc(%ebp),%edi
 b8c:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 b8f:	85 ff                	test   %edi,%edi
 b91:	0f 88 d1 00 00 00    	js     c68 <trnmnt_tree_acquire+0xe8>
 b97:	85 f6                	test   %esi,%esi
 b99:	0f 84 c9 00 00 00    	je     c68 <trnmnt_tree_acquire+0xe8>
 b9f:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
 ba2:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
 ba7:	85 c0                	test   %eax,%eax
 ba9:	74 0c                	je     bb7 <trnmnt_tree_acquire+0x37>
 bab:	90                   	nop
 bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 bb0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 bb2:	83 e8 01             	sub    $0x1,%eax
 bb5:	75 f9                	jne    bb0 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 bb7:	39 d7                	cmp    %edx,%edi
 bb9:	0f 8d a9 00 00 00    	jge    c68 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
 bbf:	83 ec 0c             	sub    $0xc,%esp
 bc2:	ff 36                	pushl  (%esi)
 bc4:	e8 99 f8 ff ff       	call   462 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
 bc9:	8b 46 08             	mov    0x8(%esi),%eax
 bcc:	83 c4 10             	add    $0x10,%esp
 bcf:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
 bd2:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 bd5:	0f 85 94 00 00 00    	jne    c6f <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
 bdb:	e8 5a f8 ff ff       	call   43a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
 be0:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
 be3:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
 be5:	ff 36                	pushl  (%esi)
 be7:	e8 7e f8 ff ff       	call   46a <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
 bec:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
 bef:	83 c4 10             	add    $0x10,%esp
 bf2:	85 c0                	test   %eax,%eax
 bf4:	74 5a                	je     c50 <trnmnt_tree_acquire+0xd0>
    int output = 1;
 bf6:	ba 01 00 00 00       	mov    $0x1,%edx
 bfb:	90                   	nop
 bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 c00:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 c02:	83 e8 01             	sub    $0x1,%eax
 c05:	75 f9                	jne    c00 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
 c07:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
 c0b:	89 c3                	mov    %eax,%ebx
 c0d:	c1 eb 1f             	shr    $0x1f,%ebx
 c10:	01 c3                	add    %eax,%ebx
 c12:	d1 fb                	sar    %ebx
 c14:	eb 0c                	jmp    c22 <trnmnt_tree_acquire+0xa2>
 c16:	8d 76 00             	lea    0x0(%esi),%esi
 c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
 c20:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
 c22:	8b 46 04             	mov    0x4(%esi),%eax
 c25:	83 ec 0c             	sub    $0xc,%esp
 c28:	ff 34 98             	pushl  (%eax,%ebx,4)
 c2b:	e8 32 f8 ff ff       	call   462 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
 c30:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
 c33:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
 c36:	89 d0                	mov    %edx,%eax
 c38:	c1 e8 1f             	shr    $0x1f,%eax
 c3b:	01 d0                	add    %edx,%eax
 c3d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
 c3f:	85 db                	test   %ebx,%ebx
 c41:	75 dd                	jne    c20 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
 c43:	31 c0                	xor    %eax,%eax
}
 c45:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c48:	5b                   	pop    %ebx
 c49:	5e                   	pop    %esi
 c4a:	5f                   	pop    %edi
 c4b:	5d                   	pop    %ebp
 c4c:	c3                   	ret    
 c4d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
 c50:	8d 47 ff             	lea    -0x1(%edi),%eax
 c53:	89 c3                	mov    %eax,%ebx
 c55:	c1 eb 1f             	shr    $0x1f,%ebx
 c58:	01 c3                	add    %eax,%ebx
 c5a:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
 c5c:	85 ff                	test   %edi,%edi
 c5e:	74 e3                	je     c43 <trnmnt_tree_acquire+0xc3>
 c60:	eb c0                	jmp    c22 <trnmnt_tree_acquire+0xa2>
 c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 c68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c6d:	eb d6                	jmp    c45 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
 c6f:	83 ec 0c             	sub    $0xc,%esp
 c72:	ff 36                	pushl  (%esi)
 c74:	e8 f1 f7 ff ff       	call   46a <kthread_mutex_unlock>
        return -1;
 c79:	83 c4 10             	add    $0x10,%esp
 c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 c81:	eb c2                	jmp    c45 <trnmnt_tree_acquire+0xc5>
 c83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c90 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 c90:	55                   	push   %ebp
 c91:	89 e5                	mov    %esp,%ebp
 c93:	56                   	push   %esi
 c94:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
 c95:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 c98:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
 c9b:	8d 50 ff             	lea    -0x1(%eax),%edx
 c9e:	89 d0                	mov    %edx,%eax
 ca0:	c1 e8 1f             	shr    $0x1f,%eax
 ca3:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
 ca5:	d1 f8                	sar    %eax
 ca7:	89 c3                	mov    %eax,%ebx
 ca9:	75 15                	jne    cc0 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 cab:	8b 46 04             	mov    0x4(%esi),%eax
 cae:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 cb1:	89 45 08             	mov    %eax,0x8(%ebp)
}
 cb4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 cb7:	5b                   	pop    %ebx
 cb8:	5e                   	pop    %esi
 cb9:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 cba:	e9 ab f7 ff ff       	jmp    46a <kthread_mutex_unlock>
 cbf:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
 cc0:	83 ec 08             	sub    $0x8,%esp
 cc3:	50                   	push   %eax
 cc4:	56                   	push   %esi
 cc5:	e8 c6 ff ff ff       	call   c90 <trnmnt_tree_release_rec>
 cca:	83 c4 10             	add    $0x10,%esp
 ccd:	83 f8 ff             	cmp    $0xffffffff,%eax
 cd0:	75 d9                	jne    cab <trnmnt_tree_release_rec+0x1b>
}
 cd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 cd5:	5b                   	pop    %ebx
 cd6:	5e                   	pop    %esi
 cd7:	5d                   	pop    %ebp
 cd8:	c3                   	ret    
 cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
 ce0:	55                   	push   %ebp
 ce1:	89 e5                	mov    %esp,%ebp
 ce3:	57                   	push   %edi
 ce4:	56                   	push   %esi
 ce5:	53                   	push   %ebx
 ce6:	83 ec 28             	sub    $0x28,%esp
 ce9:	8b 7d 08             	mov    0x8(%ebp),%edi
 cec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
 cef:	ff 37                	pushl  (%edi)
 cf1:	e8 6c f7 ff ff       	call   462 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
 cf6:	8b 47 08             	mov    0x8(%edi),%eax
 cf9:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 cfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 cff:	e8 36 f7 ff ff       	call   43a <kthread_id>
 d04:	83 c4 10             	add    $0x10,%esp
 d07:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
 d0a:	75 56                	jne    d62 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 d0c:	8b 47 0c             	mov    0xc(%edi),%eax
 d0f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
 d16:	85 c0                	test   %eax,%eax
 d18:	74 11                	je     d2b <trnmnt_tree_release+0x4b>
    int output = 1;
 d1a:	b9 01 00 00 00       	mov    $0x1,%ecx
 d1f:	90                   	nop
        output *= init;
 d20:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
 d22:	83 e8 01             	sub    $0x1,%eax
 d25:	75 f9                	jne    d20 <trnmnt_tree_release+0x40>
 d27:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 d2b:	83 ec 08             	sub    $0x8,%esp
 d2e:	53                   	push   %ebx
 d2f:	57                   	push   %edi
 d30:	e8 5b ff ff ff       	call   c90 <trnmnt_tree_release_rec>
 d35:	83 c4 10             	add    $0x10,%esp
 d38:	83 f8 ff             	cmp    $0xffffffff,%eax
 d3b:	89 c3                	mov    %eax,%ebx
 d3d:	74 37                	je     d76 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
 d3f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
 d42:	83 ec 0c             	sub    $0xc,%esp
    return 0;
 d45:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
 d47:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
 d4e:	ff 37                	pushl  (%edi)
 d50:	e8 15 f7 ff ff       	call   46a <kthread_mutex_unlock>
    return 0;
 d55:	83 c4 10             	add    $0x10,%esp
}
 d58:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d5b:	89 d8                	mov    %ebx,%eax
 d5d:	5b                   	pop    %ebx
 d5e:	5e                   	pop    %esi
 d5f:	5f                   	pop    %edi
 d60:	5d                   	pop    %ebp
 d61:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
 d62:	83 ec 0c             	sub    $0xc,%esp
 d65:	ff 37                	pushl  (%edi)
        return -1;
 d67:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
 d6c:	e8 f9 f6 ff ff       	call   46a <kthread_mutex_unlock>
        return -1;
 d71:	83 c4 10             	add    $0x10,%esp
 d74:	eb e2                	jmp    d58 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
 d76:	83 ec 0c             	sub    $0xc,%esp
 d79:	ff 37                	pushl  (%edi)
 d7b:	e8 ea f6 ff ff       	call   46a <kthread_mutex_unlock>
        return -1;
 d80:	83 c4 10             	add    $0x10,%esp
 d83:	eb d3                	jmp    d58 <trnmnt_tree_release+0x78>
