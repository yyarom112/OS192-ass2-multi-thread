
_grep:     file format elf32-i386


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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 39                	mov    (%ecx),%edi
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  19:	83 ff 01             	cmp    $0x1,%edi
  1c:	7e 7c                	jle    9a <main+0x9a>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1e:	8b 43 04             	mov    0x4(%ebx),%eax
  21:	83 c3 08             	add    $0x8,%ebx

  if(argc <= 2){
  24:	83 ff 02             	cmp    $0x2,%edi
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  27:	be 02 00 00 00       	mov    $0x2,%esi
  pattern = argv[1];
  2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  2f:	74 46                	je     77 <main+0x77>
  31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((fd = open(argv[i], 0)) < 0){
  38:	83 ec 08             	sub    $0x8,%esp
  3b:	6a 00                	push   $0x0
  3d:	ff 33                	pushl  (%ebx)
  3f:	e8 7e 05 00 00       	call   5c2 <open>
  44:	83 c4 10             	add    $0x10,%esp
  47:	85 c0                	test   %eax,%eax
  49:	78 3b                	js     86 <main+0x86>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 2; i < argc; i++){
  51:	83 c6 01             	add    $0x1,%esi
    grep(pattern, fd);
  54:	50                   	push   %eax
  55:	ff 75 e0             	pushl  -0x20(%ebp)
  58:	83 c3 04             	add    $0x4,%ebx
  5b:	e8 d0 01 00 00       	call   230 <grep>
    close(fd);
  60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  63:	89 04 24             	mov    %eax,(%esp)
  66:	e8 3f 05 00 00       	call   5aa <close>
  for(i = 2; i < argc; i++){
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	39 f7                	cmp    %esi,%edi
  70:	7f c6                	jg     38 <main+0x38>
  }
  exit();
  72:	e8 0b 05 00 00       	call   582 <exit>
    grep(pattern, 0);
  77:	52                   	push   %edx
  78:	52                   	push   %edx
  79:	6a 00                	push   $0x0
  7b:	50                   	push   %eax
  7c:	e8 af 01 00 00       	call   230 <grep>
    exit();
  81:	e8 fc 04 00 00       	call   582 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  86:	50                   	push   %eax
  87:	ff 33                	pushl  (%ebx)
  89:	68 98 0f 00 00       	push   $0xf98
  8e:	6a 01                	push   $0x1
  90:	e8 7b 06 00 00       	call   710 <printf>
      exit();
  95:	e8 e8 04 00 00       	call   582 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  9a:	51                   	push   %ecx
  9b:	51                   	push   %ecx
  9c:	68 78 0f 00 00       	push   $0xf78
  a1:	6a 02                	push   $0x2
  a3:	e8 68 06 00 00       	call   710 <printf>
    exit();
  a8:	e8 d5 04 00 00       	call   582 <exit>
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	56                   	push   %esi
  b5:	53                   	push   %ebx
  b6:	83 ec 0c             	sub    $0xc,%esp
  b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  c8:	83 ec 08             	sub    $0x8,%esp
  cb:	57                   	push   %edi
  cc:	56                   	push   %esi
  cd:	e8 3e 00 00 00       	call   110 <matchhere>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	85 c0                	test   %eax,%eax
  d7:	75 1f                	jne    f8 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  d9:	0f be 17             	movsbl (%edi),%edx
  dc:	84 d2                	test   %dl,%dl
  de:	74 0c                	je     ec <matchstar+0x3c>
  e0:	83 c7 01             	add    $0x1,%edi
  e3:	39 da                	cmp    %ebx,%edx
  e5:	74 e1                	je     c8 <matchstar+0x18>
  e7:	83 fb 2e             	cmp    $0x2e,%ebx
  ea:	74 dc                	je     c8 <matchstar+0x18>
  return 0;
}
  ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ef:	5b                   	pop    %ebx
  f0:	5e                   	pop    %esi
  f1:	5f                   	pop    %edi
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret    
  f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 1;
  fb:	b8 01 00 00 00       	mov    $0x1,%eax
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <matchhere>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	83 ec 0c             	sub    $0xc,%esp
  if(re[0] == '\0')
 119:	8b 45 08             	mov    0x8(%ebp),%eax
{
 11c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(re[0] == '\0')
 11f:	0f b6 08             	movzbl (%eax),%ecx
 122:	84 c9                	test   %cl,%cl
 124:	74 67                	je     18d <matchhere+0x7d>
  if(re[1] == '*')
 126:	0f be 40 01          	movsbl 0x1(%eax),%eax
 12a:	3c 2a                	cmp    $0x2a,%al
 12c:	74 6c                	je     19a <matchhere+0x8a>
  if(re[0] == '$' && re[1] == '\0')
 12e:	80 f9 24             	cmp    $0x24,%cl
 131:	0f b6 1f             	movzbl (%edi),%ebx
 134:	75 08                	jne    13e <matchhere+0x2e>
 136:	84 c0                	test   %al,%al
 138:	0f 84 81 00 00 00    	je     1bf <matchhere+0xaf>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 13e:	84 db                	test   %bl,%bl
 140:	74 09                	je     14b <matchhere+0x3b>
 142:	38 d9                	cmp    %bl,%cl
 144:	74 3c                	je     182 <matchhere+0x72>
 146:	80 f9 2e             	cmp    $0x2e,%cl
 149:	74 37                	je     182 <matchhere+0x72>
}
 14b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	5e                   	pop    %esi
 152:	5f                   	pop    %edi
 153:	5d                   	pop    %ebp
 154:	c3                   	ret    
 155:	8d 76 00             	lea    0x0(%esi),%esi
  if(re[1] == '*')
 158:	8b 75 08             	mov    0x8(%ebp),%esi
 15b:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
 15f:	80 f9 2a             	cmp    $0x2a,%cl
 162:	74 3b                	je     19f <matchhere+0x8f>
  if(re[0] == '$' && re[1] == '\0')
 164:	3c 24                	cmp    $0x24,%al
 166:	75 04                	jne    16c <matchhere+0x5c>
 168:	84 c9                	test   %cl,%cl
 16a:	74 4f                	je     1bb <matchhere+0xab>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 16c:	0f b6 33             	movzbl (%ebx),%esi
 16f:	89 f2                	mov    %esi,%edx
 171:	84 d2                	test   %dl,%dl
 173:	74 d6                	je     14b <matchhere+0x3b>
 175:	3c 2e                	cmp    $0x2e,%al
 177:	89 df                	mov    %ebx,%edi
 179:	74 04                	je     17f <matchhere+0x6f>
 17b:	38 c2                	cmp    %al,%dl
 17d:	75 cc                	jne    14b <matchhere+0x3b>
 17f:	0f be c1             	movsbl %cl,%eax
    return matchhere(re+1, text+1);
 182:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  if(re[0] == '\0')
 186:	84 c0                	test   %al,%al
    return matchhere(re+1, text+1);
 188:	8d 5f 01             	lea    0x1(%edi),%ebx
  if(re[0] == '\0')
 18b:	75 cb                	jne    158 <matchhere+0x48>
    return 1;
 18d:	b8 01 00 00 00       	mov    $0x1,%eax
}
 192:	8d 65 f4             	lea    -0xc(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5f                   	pop    %edi
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
  if(re[1] == '*')
 19a:	89 fb                	mov    %edi,%ebx
 19c:	0f be c1             	movsbl %cl,%eax
    return matchstar(re[0], re+2, text);
 19f:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a2:	83 ec 04             	sub    $0x4,%esp
 1a5:	53                   	push   %ebx
 1a6:	8d 57 02             	lea    0x2(%edi),%edx
 1a9:	52                   	push   %edx
 1aa:	50                   	push   %eax
 1ab:	e8 00 ff ff ff       	call   b0 <matchstar>
 1b0:	83 c4 10             	add    $0x10,%esp
}
 1b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b6:	5b                   	pop    %ebx
 1b7:	5e                   	pop    %esi
 1b8:	5f                   	pop    %edi
 1b9:	5d                   	pop    %ebp
 1ba:	c3                   	ret    
 1bb:	0f b6 5f 01          	movzbl 0x1(%edi),%ebx
    return *text == '\0';
 1bf:	31 c0                	xor    %eax,%eax
 1c1:	84 db                	test   %bl,%bl
 1c3:	0f 94 c0             	sete   %al
 1c6:	eb ca                	jmp    192 <matchhere+0x82>
 1c8:	90                   	nop
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <match>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	53                   	push   %ebx
 1d5:	8b 75 08             	mov    0x8(%ebp),%esi
 1d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1db:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1de:	75 11                	jne    1f1 <match+0x21>
 1e0:	eb 2e                	jmp    210 <match+0x40>
 1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1e8:	83 c3 01             	add    $0x1,%ebx
 1eb:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1ef:	74 16                	je     207 <match+0x37>
    if(matchhere(re, text))
 1f1:	83 ec 08             	sub    $0x8,%esp
 1f4:	53                   	push   %ebx
 1f5:	56                   	push   %esi
 1f6:	e8 15 ff ff ff       	call   110 <matchhere>
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	85 c0                	test   %eax,%eax
 200:	74 e6                	je     1e8 <match+0x18>
      return 1;
 202:	b8 01 00 00 00       	mov    $0x1,%eax
}
 207:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20a:	5b                   	pop    %ebx
 20b:	5e                   	pop    %esi
 20c:	5d                   	pop    %ebp
 20d:	c3                   	ret    
 20e:	66 90                	xchg   %ax,%ax
    return matchhere(re+1, text);
 210:	83 c6 01             	add    $0x1,%esi
 213:	89 75 08             	mov    %esi,0x8(%ebp)
}
 216:	8d 65 f8             	lea    -0x8(%ebp),%esp
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 21c:	e9 ef fe ff ff       	jmp    110 <matchhere>
 221:	eb 0d                	jmp    230 <grep>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <grep>:
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
 235:	53                   	push   %ebx
  m = 0;
 236:	31 f6                	xor    %esi,%esi
{
 238:	83 ec 1c             	sub    $0x1c,%esp
 23b:	90                   	nop
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 240:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 245:	83 ec 04             	sub    $0x4,%esp
 248:	29 f0                	sub    %esi,%eax
 24a:	50                   	push   %eax
 24b:	8d 86 c0 14 00 00    	lea    0x14c0(%esi),%eax
 251:	50                   	push   %eax
 252:	ff 75 0c             	pushl  0xc(%ebp)
 255:	e8 40 03 00 00       	call   59a <read>
 25a:	83 c4 10             	add    $0x10,%esp
 25d:	85 c0                	test   %eax,%eax
 25f:	0f 8e bb 00 00 00    	jle    320 <grep+0xf0>
    m += n;
 265:	01 c6                	add    %eax,%esi
    p = buf;
 267:	bb c0 14 00 00       	mov    $0x14c0,%ebx
    buf[m] = '\0';
 26c:	c6 86 c0 14 00 00 00 	movb   $0x0,0x14c0(%esi)
 273:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 276:	8d 76 00             	lea    0x0(%esi),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while((q = strchr(p, '\n')) != 0){
 280:	83 ec 08             	sub    $0x8,%esp
 283:	6a 0a                	push   $0xa
 285:	53                   	push   %ebx
 286:	e8 75 01 00 00       	call   400 <strchr>
 28b:	83 c4 10             	add    $0x10,%esp
 28e:	85 c0                	test   %eax,%eax
 290:	89 c6                	mov    %eax,%esi
 292:	74 44                	je     2d8 <grep+0xa8>
      if(match(pattern, p)){
 294:	83 ec 08             	sub    $0x8,%esp
      *q = 0;
 297:	c6 06 00             	movb   $0x0,(%esi)
 29a:	8d 7e 01             	lea    0x1(%esi),%edi
      if(match(pattern, p)){
 29d:	53                   	push   %ebx
 29e:	ff 75 08             	pushl  0x8(%ebp)
 2a1:	e8 2a ff ff ff       	call   1d0 <match>
 2a6:	83 c4 10             	add    $0x10,%esp
 2a9:	85 c0                	test   %eax,%eax
 2ab:	75 0b                	jne    2b8 <grep+0x88>
      p = q+1;
 2ad:	89 fb                	mov    %edi,%ebx
 2af:	eb cf                	jmp    280 <grep+0x50>
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
 2b8:	89 f8                	mov    %edi,%eax
 2ba:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2bd:	c6 06 0a             	movb   $0xa,(%esi)
        write(1, p, q+1 - p);
 2c0:	29 d8                	sub    %ebx,%eax
 2c2:	50                   	push   %eax
 2c3:	53                   	push   %ebx
      p = q+1;
 2c4:	89 fb                	mov    %edi,%ebx
        write(1, p, q+1 - p);
 2c6:	6a 01                	push   $0x1
 2c8:	e8 d5 02 00 00       	call   5a2 <write>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	eb ae                	jmp    280 <grep+0x50>
 2d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p == buf)
 2d8:	81 fb c0 14 00 00    	cmp    $0x14c0,%ebx
 2de:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 2e1:	74 2d                	je     310 <grep+0xe0>
    if(m > 0){
 2e3:	85 f6                	test   %esi,%esi
 2e5:	0f 8e 55 ff ff ff    	jle    240 <grep+0x10>
      m -= p - buf;
 2eb:	89 d8                	mov    %ebx,%eax
      memmove(buf, p, m);
 2ed:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 2f0:	2d c0 14 00 00       	sub    $0x14c0,%eax
 2f5:	29 c6                	sub    %eax,%esi
      memmove(buf, p, m);
 2f7:	56                   	push   %esi
 2f8:	53                   	push   %ebx
 2f9:	68 c0 14 00 00       	push   $0x14c0
 2fe:	e8 4d 02 00 00       	call   550 <memmove>
 303:	83 c4 10             	add    $0x10,%esp
 306:	e9 35 ff ff ff       	jmp    240 <grep+0x10>
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 0;
 310:	31 f6                	xor    %esi,%esi
 312:	e9 29 ff ff ff       	jmp    240 <grep+0x10>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
 320:	8d 65 f4             	lea    -0xc(%ebp),%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	83 c1 01             	add    $0x1,%ecx
 343:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 347:	83 c2 01             	add    $0x1,%edx
 34a:	84 db                	test   %bl,%bl
 34c:	88 5a ff             	mov    %bl,-0x1(%edx)
 34f:	75 ef                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 351:	5b                   	pop    %ebx
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 35a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 55 08             	mov    0x8(%ebp),%edx
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 36a:	0f b6 02             	movzbl (%edx),%eax
 36d:	0f b6 19             	movzbl (%ecx),%ebx
 370:	84 c0                	test   %al,%al
 372:	75 1c                	jne    390 <strcmp+0x30>
 374:	eb 2a                	jmp    3a0 <strcmp+0x40>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 380:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 383:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 386:	83 c1 01             	add    $0x1,%ecx
 389:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 38c:	84 c0                	test   %al,%al
 38e:	74 10                	je     3a0 <strcmp+0x40>
 390:	38 d8                	cmp    %bl,%al
 392:	74 ec                	je     380 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 394:	29 d8                	sub    %ebx,%eax
}
 396:	5b                   	pop    %ebx
 397:	5d                   	pop    %ebp
 398:	c3                   	ret    
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3a2:	29 d8                	sub    %ebx,%eax
}
 3a4:	5b                   	pop    %ebx
 3a5:	5d                   	pop    %ebp
 3a6:	c3                   	ret    
 3a7:	89 f6                	mov    %esi,%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strlen>:

uint
strlen(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3b6:	80 39 00             	cmpb   $0x0,(%ecx)
 3b9:	74 15                	je     3d0 <strlen+0x20>
 3bb:	31 d2                	xor    %edx,%edx
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3c7:	89 d0                	mov    %edx,%eax
 3c9:	75 f5                	jne    3c0 <strlen+0x10>
    ;
  return n;
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 3d0:	31 c0                	xor    %eax,%eax
}
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 d7                	mov    %edx,%edi
 3ef:	fc                   	cld    
 3f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	5f                   	pop    %edi
 3f5:	5d                   	pop    %ebp
 3f6:	c3                   	ret    
 3f7:	89 f6                	mov    %esi,%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <strchr>:

char*
strchr(const char *s, char c)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	53                   	push   %ebx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 40a:	0f b6 10             	movzbl (%eax),%edx
 40d:	84 d2                	test   %dl,%dl
 40f:	74 1d                	je     42e <strchr+0x2e>
    if(*s == c)
 411:	38 d3                	cmp    %dl,%bl
 413:	89 d9                	mov    %ebx,%ecx
 415:	75 0d                	jne    424 <strchr+0x24>
 417:	eb 17                	jmp    430 <strchr+0x30>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	38 ca                	cmp    %cl,%dl
 422:	74 0c                	je     430 <strchr+0x30>
  for(; *s; s++)
 424:	83 c0 01             	add    $0x1,%eax
 427:	0f b6 10             	movzbl (%eax),%edx
 42a:	84 d2                	test   %dl,%dl
 42c:	75 f2                	jne    420 <strchr+0x20>
      return (char*)s;
  return 0;
 42e:	31 c0                	xor    %eax,%eax
}
 430:	5b                   	pop    %ebx
 431:	5d                   	pop    %ebp
 432:	c3                   	ret    
 433:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <gets>:

char*
gets(char *buf, int max)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 446:	31 f6                	xor    %esi,%esi
 448:	89 f3                	mov    %esi,%ebx
{
 44a:	83 ec 1c             	sub    $0x1c,%esp
 44d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 450:	eb 2f                	jmp    481 <gets+0x41>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 458:	8d 45 e7             	lea    -0x19(%ebp),%eax
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	6a 01                	push   $0x1
 460:	50                   	push   %eax
 461:	6a 00                	push   $0x0
 463:	e8 32 01 00 00       	call   59a <read>
    if(cc < 1)
 468:	83 c4 10             	add    $0x10,%esp
 46b:	85 c0                	test   %eax,%eax
 46d:	7e 1c                	jle    48b <gets+0x4b>
      break;
    buf[i++] = c;
 46f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 473:	83 c7 01             	add    $0x1,%edi
 476:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 23                	je     4a0 <gets+0x60>
 47d:	3c 0d                	cmp    $0xd,%al
 47f:	74 1f                	je     4a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 481:	83 c3 01             	add    $0x1,%ebx
 484:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 487:	89 fe                	mov    %edi,%esi
 489:	7c cd                	jl     458 <gets+0x18>
 48b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 48d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 490:	c6 03 00             	movb   $0x0,(%ebx)
}
 493:	8d 65 f4             	lea    -0xc(%ebp),%esp
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5f                   	pop    %edi
 499:	5d                   	pop    %ebp
 49a:	c3                   	ret    
 49b:	90                   	nop
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a0:	8b 75 08             	mov    0x8(%ebp),%esi
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 de                	add    %ebx,%esi
 4a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 4aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 4ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b0:	5b                   	pop    %ebx
 4b1:	5e                   	pop    %esi
 4b2:	5f                   	pop    %edi
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	56                   	push   %esi
 4c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c5:	83 ec 08             	sub    $0x8,%esp
 4c8:	6a 00                	push   $0x0
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 f0 00 00 00       	call   5c2 <open>
  if(fd < 0)
 4d2:	83 c4 10             	add    $0x10,%esp
 4d5:	85 c0                	test   %eax,%eax
 4d7:	78 27                	js     500 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 4d9:	83 ec 08             	sub    $0x8,%esp
 4dc:	ff 75 0c             	pushl  0xc(%ebp)
 4df:	89 c3                	mov    %eax,%ebx
 4e1:	50                   	push   %eax
 4e2:	e8 f3 00 00 00       	call   5da <fstat>
  close(fd);
 4e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 4ea:	89 c6                	mov    %eax,%esi
  close(fd);
 4ec:	e8 b9 00 00 00       	call   5aa <close>
  return r;
 4f1:	83 c4 10             	add    $0x10,%esp
}
 4f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4f7:	89 f0                	mov    %esi,%eax
 4f9:	5b                   	pop    %ebx
 4fa:	5e                   	pop    %esi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 500:	be ff ff ff ff       	mov    $0xffffffff,%esi
 505:	eb ed                	jmp    4f4 <stat+0x34>
 507:	89 f6                	mov    %esi,%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <atoi>:

int
atoi(const char *s)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	53                   	push   %ebx
 514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 517:	0f be 11             	movsbl (%ecx),%edx
 51a:	8d 42 d0             	lea    -0x30(%edx),%eax
 51d:	3c 09                	cmp    $0x9,%al
  n = 0;
 51f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 524:	77 1f                	ja     545 <atoi+0x35>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 530:	8d 04 80             	lea    (%eax,%eax,4),%eax
 533:	83 c1 01             	add    $0x1,%ecx
 536:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 53a:	0f be 11             	movsbl (%ecx),%edx
 53d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 540:	80 fb 09             	cmp    $0x9,%bl
 543:	76 eb                	jbe    530 <atoi+0x20>
  return n;
}
 545:	5b                   	pop    %ebx
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    
 548:	90                   	nop
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000550 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	56                   	push   %esi
 554:	53                   	push   %ebx
 555:	8b 5d 10             	mov    0x10(%ebp),%ebx
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 55e:	85 db                	test   %ebx,%ebx
 560:	7e 14                	jle    576 <memmove+0x26>
 562:	31 d2                	xor    %edx,%edx
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 568:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 56c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 56f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 572:	39 d3                	cmp    %edx,%ebx
 574:	75 f2                	jne    568 <memmove+0x18>
  return vdst;
}
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5d                   	pop    %ebp
 579:	c3                   	ret    

0000057a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 57a:	b8 01 00 00 00       	mov    $0x1,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <exit>:
SYSCALL(exit)
 582:	b8 02 00 00 00       	mov    $0x2,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <wait>:
SYSCALL(wait)
 58a:	b8 03 00 00 00       	mov    $0x3,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <pipe>:
SYSCALL(pipe)
 592:	b8 04 00 00 00       	mov    $0x4,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <read>:
SYSCALL(read)
 59a:	b8 05 00 00 00       	mov    $0x5,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <write>:
SYSCALL(write)
 5a2:	b8 10 00 00 00       	mov    $0x10,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <close>:
SYSCALL(close)
 5aa:	b8 15 00 00 00       	mov    $0x15,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <kill>:
SYSCALL(kill)
 5b2:	b8 06 00 00 00       	mov    $0x6,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <exec>:
SYSCALL(exec)
 5ba:	b8 07 00 00 00       	mov    $0x7,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <open>:
SYSCALL(open)
 5c2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mknod>:
SYSCALL(mknod)
 5ca:	b8 11 00 00 00       	mov    $0x11,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <unlink>:
SYSCALL(unlink)
 5d2:	b8 12 00 00 00       	mov    $0x12,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <fstat>:
SYSCALL(fstat)
 5da:	b8 08 00 00 00       	mov    $0x8,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <link>:
SYSCALL(link)
 5e2:	b8 13 00 00 00       	mov    $0x13,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <mkdir>:
SYSCALL(mkdir)
 5ea:	b8 14 00 00 00       	mov    $0x14,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <chdir>:
SYSCALL(chdir)
 5f2:	b8 09 00 00 00       	mov    $0x9,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <dup>:
SYSCALL(dup)
 5fa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <getpid>:
SYSCALL(getpid)
 602:	b8 0b 00 00 00       	mov    $0xb,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <sbrk>:
SYSCALL(sbrk)
 60a:	b8 0c 00 00 00       	mov    $0xc,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <sleep>:
SYSCALL(sleep)
 612:	b8 0d 00 00 00       	mov    $0xd,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <uptime>:
SYSCALL(uptime)
 61a:	b8 0e 00 00 00       	mov    $0xe,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <kthread_create>:
SYSCALL(kthread_create)
 622:	b8 16 00 00 00       	mov    $0x16,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <kthread_id>:
SYSCALL(kthread_id)
 62a:	b8 17 00 00 00       	mov    $0x17,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <kthread_exit>:
SYSCALL(kthread_exit)
 632:	b8 18 00 00 00       	mov    $0x18,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <kthread_join>:
SYSCALL(kthread_join)
 63a:	b8 19 00 00 00       	mov    $0x19,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 642:	b8 1a 00 00 00       	mov    $0x1a,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 64a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 652:	b8 1c 00 00 00       	mov    $0x1c,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 65a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    
 662:	66 90                	xchg   %ax,%ax
 664:	66 90                	xchg   %ax,%ax
 666:	66 90                	xchg   %ax,%ax
 668:	66 90                	xchg   %ax,%ax
 66a:	66 90                	xchg   %ax,%ax
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	53                   	push   %ebx
 676:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 679:	85 d2                	test   %edx,%edx
{
 67b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 67e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 680:	79 76                	jns    6f8 <printint+0x88>
 682:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 686:	74 70                	je     6f8 <printint+0x88>
    x = -xx;
 688:	f7 d8                	neg    %eax
    neg = 1;
 68a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 691:	31 f6                	xor    %esi,%esi
 693:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 696:	eb 0a                	jmp    6a2 <printint+0x32>
 698:	90                   	nop
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 6a0:	89 fe                	mov    %edi,%esi
 6a2:	31 d2                	xor    %edx,%edx
 6a4:	8d 7e 01             	lea    0x1(%esi),%edi
 6a7:	f7 f1                	div    %ecx
 6a9:	0f b6 92 b8 0f 00 00 	movzbl 0xfb8(%edx),%edx
  }while((x /= base) != 0);
 6b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 6b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 6b5:	75 e9                	jne    6a0 <printint+0x30>
  if(neg)
 6b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 6ba:	85 c0                	test   %eax,%eax
 6bc:	74 08                	je     6c6 <printint+0x56>
    buf[i++] = '-';
 6be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 6c3:	8d 7e 02             	lea    0x2(%esi),%edi
 6c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 6ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 6d3:	83 ec 04             	sub    $0x4,%esp
 6d6:	83 ee 01             	sub    $0x1,%esi
 6d9:	6a 01                	push   $0x1
 6db:	53                   	push   %ebx
 6dc:	57                   	push   %edi
 6dd:	88 45 d7             	mov    %al,-0x29(%ebp)
 6e0:	e8 bd fe ff ff       	call   5a2 <write>

  while(--i >= 0)
 6e5:	83 c4 10             	add    $0x10,%esp
 6e8:	39 de                	cmp    %ebx,%esi
 6ea:	75 e4                	jne    6d0 <printint+0x60>
    putc(fd, buf[i]);
}
 6ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6ef:	5b                   	pop    %ebx
 6f0:	5e                   	pop    %esi
 6f1:	5f                   	pop    %edi
 6f2:	5d                   	pop    %ebp
 6f3:	c3                   	ret    
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 6f8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 6ff:	eb 90                	jmp    691 <printint+0x21>
 701:	eb 0d                	jmp    710 <printf>
 703:	90                   	nop
 704:	90                   	nop
 705:	90                   	nop
 706:	90                   	nop
 707:	90                   	nop
 708:	90                   	nop
 709:	90                   	nop
 70a:	90                   	nop
 70b:	90                   	nop
 70c:	90                   	nop
 70d:	90                   	nop
 70e:	90                   	nop
 70f:	90                   	nop

00000710 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 719:	8b 75 0c             	mov    0xc(%ebp),%esi
 71c:	0f b6 1e             	movzbl (%esi),%ebx
 71f:	84 db                	test   %bl,%bl
 721:	0f 84 b3 00 00 00    	je     7da <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 727:	8d 45 10             	lea    0x10(%ebp),%eax
 72a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 72d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 72f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 732:	eb 2f                	jmp    763 <printf+0x53>
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 738:	83 f8 25             	cmp    $0x25,%eax
 73b:	0f 84 a7 00 00 00    	je     7e8 <printf+0xd8>
  write(fd, &c, 1);
 741:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 744:	83 ec 04             	sub    $0x4,%esp
 747:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 74a:	6a 01                	push   $0x1
 74c:	50                   	push   %eax
 74d:	ff 75 08             	pushl  0x8(%ebp)
 750:	e8 4d fe ff ff       	call   5a2 <write>
 755:	83 c4 10             	add    $0x10,%esp
 758:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 75b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 75f:	84 db                	test   %bl,%bl
 761:	74 77                	je     7da <printf+0xca>
    if(state == 0){
 763:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 765:	0f be cb             	movsbl %bl,%ecx
 768:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 76b:	74 cb                	je     738 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 76d:	83 ff 25             	cmp    $0x25,%edi
 770:	75 e6                	jne    758 <printf+0x48>
      if(c == 'd'){
 772:	83 f8 64             	cmp    $0x64,%eax
 775:	0f 84 05 01 00 00    	je     880 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 77b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 781:	83 f9 70             	cmp    $0x70,%ecx
 784:	74 72                	je     7f8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 786:	83 f8 73             	cmp    $0x73,%eax
 789:	0f 84 99 00 00 00    	je     828 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 78f:	83 f8 63             	cmp    $0x63,%eax
 792:	0f 84 08 01 00 00    	je     8a0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 798:	83 f8 25             	cmp    $0x25,%eax
 79b:	0f 84 ef 00 00 00    	je     890 <printf+0x180>
  write(fd, &c, 1);
 7a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7a4:	83 ec 04             	sub    $0x4,%esp
 7a7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7ab:	6a 01                	push   $0x1
 7ad:	50                   	push   %eax
 7ae:	ff 75 08             	pushl  0x8(%ebp)
 7b1:	e8 ec fd ff ff       	call   5a2 <write>
 7b6:	83 c4 0c             	add    $0xc,%esp
 7b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 7bc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 7bf:	6a 01                	push   $0x1
 7c1:	50                   	push   %eax
 7c2:	ff 75 08             	pushl  0x8(%ebp)
 7c5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7c8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 7ca:	e8 d3 fd ff ff       	call   5a2 <write>
  for(i = 0; fmt[i]; i++){
 7cf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 7d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 7d6:	84 db                	test   %bl,%bl
 7d8:	75 89                	jne    763 <printf+0x53>
    }
  }
}
 7da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7dd:	5b                   	pop    %ebx
 7de:	5e                   	pop    %esi
 7df:	5f                   	pop    %edi
 7e0:	5d                   	pop    %ebp
 7e1:	c3                   	ret    
 7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 7e8:	bf 25 00 00 00       	mov    $0x25,%edi
 7ed:	e9 66 ff ff ff       	jmp    758 <printf+0x48>
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 7f8:	83 ec 0c             	sub    $0xc,%esp
 7fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 800:	6a 00                	push   $0x0
 802:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	8b 17                	mov    (%edi),%edx
 80a:	e8 61 fe ff ff       	call   670 <printint>
        ap++;
 80f:	89 f8                	mov    %edi,%eax
 811:	83 c4 10             	add    $0x10,%esp
      state = 0;
 814:	31 ff                	xor    %edi,%edi
        ap++;
 816:	83 c0 04             	add    $0x4,%eax
 819:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 81c:	e9 37 ff ff ff       	jmp    758 <printf+0x48>
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 828:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 82b:	8b 08                	mov    (%eax),%ecx
        ap++;
 82d:	83 c0 04             	add    $0x4,%eax
 830:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 833:	85 c9                	test   %ecx,%ecx
 835:	0f 84 8e 00 00 00    	je     8c9 <printf+0x1b9>
        while(*s != 0){
 83b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 83e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 840:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 842:	84 c0                	test   %al,%al
 844:	0f 84 0e ff ff ff    	je     758 <printf+0x48>
 84a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 84d:	89 de                	mov    %ebx,%esi
 84f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 852:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 855:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 858:	83 ec 04             	sub    $0x4,%esp
          s++;
 85b:	83 c6 01             	add    $0x1,%esi
 85e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 861:	6a 01                	push   $0x1
 863:	57                   	push   %edi
 864:	53                   	push   %ebx
 865:	e8 38 fd ff ff       	call   5a2 <write>
        while(*s != 0){
 86a:	0f b6 06             	movzbl (%esi),%eax
 86d:	83 c4 10             	add    $0x10,%esp
 870:	84 c0                	test   %al,%al
 872:	75 e4                	jne    858 <printf+0x148>
 874:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 877:	31 ff                	xor    %edi,%edi
 879:	e9 da fe ff ff       	jmp    758 <printf+0x48>
 87e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 880:	83 ec 0c             	sub    $0xc,%esp
 883:	b9 0a 00 00 00       	mov    $0xa,%ecx
 888:	6a 01                	push   $0x1
 88a:	e9 73 ff ff ff       	jmp    802 <printf+0xf2>
 88f:	90                   	nop
  write(fd, &c, 1);
 890:	83 ec 04             	sub    $0x4,%esp
 893:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 896:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 899:	6a 01                	push   $0x1
 89b:	e9 21 ff ff ff       	jmp    7c1 <printf+0xb1>
        putc(fd, *ap);
 8a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 8a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 8a6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 8a8:	6a 01                	push   $0x1
        ap++;
 8aa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 8ad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 8b0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8b3:	50                   	push   %eax
 8b4:	ff 75 08             	pushl  0x8(%ebp)
 8b7:	e8 e6 fc ff ff       	call   5a2 <write>
        ap++;
 8bc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 8bf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8c2:	31 ff                	xor    %edi,%edi
 8c4:	e9 8f fe ff ff       	jmp    758 <printf+0x48>
          s = "(null)";
 8c9:	bb ae 0f 00 00       	mov    $0xfae,%ebx
        while(*s != 0){
 8ce:	b8 28 00 00 00       	mov    $0x28,%eax
 8d3:	e9 72 ff ff ff       	jmp    84a <printf+0x13a>
 8d8:	66 90                	xchg   %ax,%ax
 8da:	66 90                	xchg   %ax,%ax
 8dc:	66 90                	xchg   %ax,%ax
 8de:	66 90                	xchg   %ax,%ax

000008e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e1:	a1 a0 14 00 00       	mov    0x14a0,%eax
{
 8e6:	89 e5                	mov    %esp,%ebp
 8e8:	57                   	push   %edi
 8e9:	56                   	push   %esi
 8ea:	53                   	push   %ebx
 8eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 8ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 8f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f8:	39 c8                	cmp    %ecx,%eax
 8fa:	8b 10                	mov    (%eax),%edx
 8fc:	73 32                	jae    930 <free+0x50>
 8fe:	39 d1                	cmp    %edx,%ecx
 900:	72 04                	jb     906 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 902:	39 d0                	cmp    %edx,%eax
 904:	72 32                	jb     938 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 906:	8b 73 fc             	mov    -0x4(%ebx),%esi
 909:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 90c:	39 fa                	cmp    %edi,%edx
 90e:	74 30                	je     940 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 910:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 913:	8b 50 04             	mov    0x4(%eax),%edx
 916:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 919:	39 f1                	cmp    %esi,%ecx
 91b:	74 3a                	je     957 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 91d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 91f:	a3 a0 14 00 00       	mov    %eax,0x14a0
}
 924:	5b                   	pop    %ebx
 925:	5e                   	pop    %esi
 926:	5f                   	pop    %edi
 927:	5d                   	pop    %ebp
 928:	c3                   	ret    
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 930:	39 d0                	cmp    %edx,%eax
 932:	72 04                	jb     938 <free+0x58>
 934:	39 d1                	cmp    %edx,%ecx
 936:	72 ce                	jb     906 <free+0x26>
{
 938:	89 d0                	mov    %edx,%eax
 93a:	eb bc                	jmp    8f8 <free+0x18>
 93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 940:	03 72 04             	add    0x4(%edx),%esi
 943:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 946:	8b 10                	mov    (%eax),%edx
 948:	8b 12                	mov    (%edx),%edx
 94a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 94d:	8b 50 04             	mov    0x4(%eax),%edx
 950:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 953:	39 f1                	cmp    %esi,%ecx
 955:	75 c6                	jne    91d <free+0x3d>
    p->s.size += bp->s.size;
 957:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 95a:	a3 a0 14 00 00       	mov    %eax,0x14a0
    p->s.size += bp->s.size;
 95f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 962:	8b 53 f8             	mov    -0x8(%ebx),%edx
 965:	89 10                	mov    %edx,(%eax)
}
 967:	5b                   	pop    %ebx
 968:	5e                   	pop    %esi
 969:	5f                   	pop    %edi
 96a:	5d                   	pop    %ebp
 96b:	c3                   	ret    
 96c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000970 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
 975:	53                   	push   %ebx
 976:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 979:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 97c:	8b 15 a0 14 00 00    	mov    0x14a0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 982:	8d 78 07             	lea    0x7(%eax),%edi
 985:	c1 ef 03             	shr    $0x3,%edi
 988:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 98b:	85 d2                	test   %edx,%edx
 98d:	0f 84 9d 00 00 00    	je     a30 <malloc+0xc0>
 993:	8b 02                	mov    (%edx),%eax
 995:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 998:	39 cf                	cmp    %ecx,%edi
 99a:	76 6c                	jbe    a08 <malloc+0x98>
 99c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9a2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9a7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9aa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9b1:	eb 0e                	jmp    9c1 <malloc+0x51>
 9b3:	90                   	nop
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9ba:	8b 48 04             	mov    0x4(%eax),%ecx
 9bd:	39 f9                	cmp    %edi,%ecx
 9bf:	73 47                	jae    a08 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9c1:	39 05 a0 14 00 00    	cmp    %eax,0x14a0
 9c7:	89 c2                	mov    %eax,%edx
 9c9:	75 ed                	jne    9b8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 9cb:	83 ec 0c             	sub    $0xc,%esp
 9ce:	56                   	push   %esi
 9cf:	e8 36 fc ff ff       	call   60a <sbrk>
  if(p == (char*)-1)
 9d4:	83 c4 10             	add    $0x10,%esp
 9d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 9da:	74 1c                	je     9f8 <malloc+0x88>
  hp->s.size = nu;
 9dc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 9df:	83 ec 0c             	sub    $0xc,%esp
 9e2:	83 c0 08             	add    $0x8,%eax
 9e5:	50                   	push   %eax
 9e6:	e8 f5 fe ff ff       	call   8e0 <free>
  return freep;
 9eb:	8b 15 a0 14 00 00    	mov    0x14a0,%edx
      if((p = morecore(nunits)) == 0)
 9f1:	83 c4 10             	add    $0x10,%esp
 9f4:	85 d2                	test   %edx,%edx
 9f6:	75 c0                	jne    9b8 <malloc+0x48>
        return 0;
  }
}
 9f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 9fb:	31 c0                	xor    %eax,%eax
}
 9fd:	5b                   	pop    %ebx
 9fe:	5e                   	pop    %esi
 9ff:	5f                   	pop    %edi
 a00:	5d                   	pop    %ebp
 a01:	c3                   	ret    
 a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a08:	39 cf                	cmp    %ecx,%edi
 a0a:	74 54                	je     a60 <malloc+0xf0>
        p->s.size -= nunits;
 a0c:	29 f9                	sub    %edi,%ecx
 a0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 a17:	89 15 a0 14 00 00    	mov    %edx,0x14a0
}
 a1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a20:	83 c0 08             	add    $0x8,%eax
}
 a23:	5b                   	pop    %ebx
 a24:	5e                   	pop    %esi
 a25:	5f                   	pop    %edi
 a26:	5d                   	pop    %ebp
 a27:	c3                   	ret    
 a28:	90                   	nop
 a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 a30:	c7 05 a0 14 00 00 a4 	movl   $0x14a4,0x14a0
 a37:	14 00 00 
 a3a:	c7 05 a4 14 00 00 a4 	movl   $0x14a4,0x14a4
 a41:	14 00 00 
    base.s.size = 0;
 a44:	b8 a4 14 00 00       	mov    $0x14a4,%eax
 a49:	c7 05 a8 14 00 00 00 	movl   $0x0,0x14a8
 a50:	00 00 00 
 a53:	e9 44 ff ff ff       	jmp    99c <malloc+0x2c>
 a58:	90                   	nop
 a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 a60:	8b 08                	mov    (%eax),%ecx
 a62:	89 0a                	mov    %ecx,(%edx)
 a64:	eb b1                	jmp    a17 <malloc+0xa7>
 a66:	66 90                	xchg   %ax,%ax
 a68:	66 90                	xchg   %ax,%ax
 a6a:	66 90                	xchg   %ax,%ax
 a6c:	66 90                	xchg   %ax,%ax
 a6e:	66 90                	xchg   %ax,%ax

00000a70 <powordepth>:
#include "user.h"
#include "kthread.h"
#include "tournament_tree.h"


int powordepth(int exp) {
 a70:	55                   	push   %ebp
    int init = 2;
    int output = 1;
 a71:	b8 01 00 00 00       	mov    $0x1,%eax
int powordepth(int exp) {
 a76:	89 e5                	mov    %esp,%ebp
 a78:	8b 55 08             	mov    0x8(%ebp),%edx
    while (exp != 0) {
 a7b:	85 d2                	test   %edx,%edx
 a7d:	74 08                	je     a87 <powordepth+0x17>
 a7f:	90                   	nop
        output *= init;
 a80:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 a82:	83 ea 01             	sub    $0x1,%edx
 a85:	75 f9                	jne    a80 <powordepth+0x10>
        exp--;
    }
    return output;
}
 a87:	5d                   	pop    %ebp
 a88:	c3                   	ret    
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <trnmnt_tree_alloc>:

struct trnmnt_tree *trnmnt_tree_alloc(int depth) {
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 28             	sub    $0x28,%esp
    struct trnmnt_tree *output = malloc(sizeof(trnmnt_tree));
 a99:	6a 10                	push   $0x10
 a9b:	e8 d0 fe ff ff       	call   970 <malloc>
 aa0:	89 c6                	mov    %eax,%esi
    int i;
    if (depth <= 0 || depth > 6)
 aa2:	8b 45 08             	mov    0x8(%ebp),%eax
 aa5:	83 c4 10             	add    $0x10,%esp
 aa8:	83 e8 01             	sub    $0x1,%eax
 aab:	83 f8 05             	cmp    $0x5,%eax
 aae:	0f 87 f6 00 00 00    	ja     baa <trnmnt_tree_alloc+0x11a>
 ab4:	8b 45 08             	mov    0x8(%ebp),%eax
    int output = 1;
 ab7:	bf 01 00 00 00       	mov    $0x1,%edi
 abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 ac0:	01 ff                	add    %edi,%edi
    while (exp != 0) {
 ac2:	83 e8 01             	sub    $0x1,%eax
 ac5:	75 f9                	jne    ac0 <trnmnt_tree_alloc+0x30>
 ac7:	89 45 dc             	mov    %eax,-0x24(%ebp)
        return 0;
    int treeSize = powordepth(depth) - 1;
 aca:	8d 47 ff             	lea    -0x1(%edi),%eax
 acd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    //depth field
    output->depth = depth;
 ad0:	8b 45 08             	mov    0x8(%ebp),%eax
 ad3:	89 46 0c             	mov    %eax,0xc(%esi)

    //init lock field
    if ((output->Lock = kthread_mutex_alloc()) == -1) {
 ad6:	e8 67 fb ff ff       	call   642 <kthread_mutex_alloc>
 adb:	83 f8 ff             	cmp    $0xffffffff,%eax
 ade:	89 06                	mov    %eax,(%esi)
 ae0:	0f 84 34 01 00 00    	je     c1a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }

    //init mutextree field
    if ((output->mutextree = malloc((treeSize * sizeof(int)))) == 0) {
 ae6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ae9:	83 ec 0c             	sub    $0xc,%esp
 aec:	c1 e0 02             	shl    $0x2,%eax
 aef:	50                   	push   %eax
 af0:	89 45 e0             	mov    %eax,-0x20(%ebp)
 af3:	e8 78 fe ff ff       	call   970 <malloc>
 af8:	83 c4 10             	add    $0x10,%esp
 afb:	85 c0                	test   %eax,%eax
 afd:	89 46 04             	mov    %eax,0x4(%esi)
 b00:	0f 84 14 01 00 00    	je     c1a <trnmnt_tree_alloc+0x18a>
        free(output);
        return 0;
    }
    for (i = 0; i < treeSize; i++){
 b06:	31 db                	xor    %ebx,%ebx
 b08:	eb 09                	jmp    b13 <trnmnt_tree_alloc+0x83>
 b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 b10:	8b 46 04             	mov    0x4(%esi),%eax
        output->mutextree[i] = kthread_mutex_alloc();
 b13:	8d 3c 98             	lea    (%eax,%ebx,4),%edi
    for (i = 0; i < treeSize; i++){
 b16:	83 c3 01             	add    $0x1,%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 b19:	e8 24 fb ff ff       	call   642 <kthread_mutex_alloc>
    for (i = 0; i < treeSize; i++){
 b1e:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
        output->mutextree[i] = kthread_mutex_alloc();
 b21:	89 07                	mov    %eax,(%edi)
    for (i = 0; i < treeSize; i++){
 b23:	75 eb                	jne    b10 <trnmnt_tree_alloc+0x80>

    }

    int initCheck = 0;
    for (int i = 0; i < treeSize; i++) {
        if (output->mutextree[i] == -1)
 b25:	8b 4e 04             	mov    0x4(%esi),%ecx
 b28:	8b 55 e0             	mov    -0x20(%ebp),%edx
            initCheck = 1;
 b2b:	bf 01 00 00 00       	mov    $0x1,%edi
        if (output->mutextree[i] == -1)
 b30:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 b33:	89 c8                	mov    %ecx,%eax
 b35:	01 ca                	add    %ecx,%edx
    int initCheck = 0;
 b37:	31 c9                	xor    %ecx,%ecx
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            initCheck = 1;
 b40:	83 38 ff             	cmpl   $0xffffffff,(%eax)
 b43:	0f 44 cf             	cmove  %edi,%ecx
 b46:	83 c0 04             	add    $0x4,%eax
    for (int i = 0; i < treeSize; i++) {
 b49:	39 d0                	cmp    %edx,%eax
 b4b:	75 f3                	jne    b40 <trnmnt_tree_alloc+0xb0>
    }
    if (initCheck) {
 b4d:	85 c9                	test   %ecx,%ecx
 b4f:	8b 7d 08             	mov    0x8(%ebp),%edi
 b52:	b8 01 00 00 00       	mov    $0x1,%eax
 b57:	0f 85 9b 00 00 00    	jne    bf8 <trnmnt_tree_alloc+0x168>
 b5d:	8d 76 00             	lea    0x0(%esi),%esi
        output *= init;
 b60:	01 c0                	add    %eax,%eax
    while (exp != 0) {
 b62:	83 ef 01             	sub    $0x1,%edi
 b65:	75 f9                	jne    b60 <trnmnt_tree_alloc+0xd0>
    }



    //init threadMap field
    if ((output->threadMap = malloc(powordepth(depth) * sizeof(int))) == 0) {
 b67:	83 ec 0c             	sub    $0xc,%esp
 b6a:	c1 e0 02             	shl    $0x2,%eax
 b6d:	50                   	push   %eax
 b6e:	e8 fd fd ff ff       	call   970 <malloc>
 b73:	83 c4 10             	add    $0x10,%esp
 b76:	85 c0                	test   %eax,%eax
 b78:	89 46 08             	mov    %eax,0x8(%esi)
 b7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 b7e:	74 36                	je     bb6 <trnmnt_tree_alloc+0x126>
 b80:	89 c8                	mov    %ecx,%eax
    int output = 1;
 b82:	ba 01 00 00 00       	mov    $0x1,%edx
 b87:	89 f6                	mov    %esi,%esi
 b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 b90:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 b92:	83 e8 01             	sub    $0x1,%eax
 b95:	75 f9                	jne    b90 <trnmnt_tree_alloc+0x100>
        kthread_mutex_dealloc(output->Lock);
        free(output->mutextree);
        free(output);
        return 0;
    }
    for (i = 0; i < powordepth(depth); i++)
 b97:	39 d7                	cmp    %edx,%edi
 b99:	7d 11                	jge    bac <trnmnt_tree_alloc+0x11c>
        output->threadMap[i] = -1;
 b9b:	8b 46 08             	mov    0x8(%esi),%eax
 b9e:	c7 04 b8 ff ff ff ff 	movl   $0xffffffff,(%eax,%edi,4)
    for (i = 0; i < powordepth(depth); i++)
 ba5:	83 c7 01             	add    $0x1,%edi
 ba8:	eb d6                	jmp    b80 <trnmnt_tree_alloc+0xf0>
        return 0;
 baa:	31 f6                	xor    %esi,%esi

    return output;
}
 bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 baf:	89 f0                	mov    %esi,%eax
 bb1:	5b                   	pop    %ebx
 bb2:	5e                   	pop    %esi
 bb3:	5f                   	pop    %edi
 bb4:	5d                   	pop    %ebp
 bb5:	c3                   	ret    
            kthread_mutex_dealloc(output->mutextree[i]);
 bb6:	8b 46 04             	mov    0x4(%esi),%eax
 bb9:	83 ec 0c             	sub    $0xc,%esp
 bbc:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 bbf:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 bc2:	e8 83 fa ff ff       	call   64a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 bc7:	83 c4 10             	add    $0x10,%esp
 bca:	39 df                	cmp    %ebx,%edi
 bcc:	75 e8                	jne    bb6 <trnmnt_tree_alloc+0x126>
        kthread_mutex_dealloc(output->Lock);
 bce:	83 ec 0c             	sub    $0xc,%esp
 bd1:	ff 36                	pushl  (%esi)
 bd3:	e8 72 fa ff ff       	call   64a <kthread_mutex_dealloc>
        free(output->mutextree);
 bd8:	58                   	pop    %eax
 bd9:	ff 76 04             	pushl  0x4(%esi)
 bdc:	e8 ff fc ff ff       	call   8e0 <free>
        free(output);
 be1:	89 34 24             	mov    %esi,(%esp)
        return 0;
 be4:	31 f6                	xor    %esi,%esi
        free(output);
 be6:	e8 f5 fc ff ff       	call   8e0 <free>
        return 0;
 beb:	83 c4 10             	add    $0x10,%esp
}
 bee:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bf1:	89 f0                	mov    %esi,%eax
 bf3:	5b                   	pop    %ebx
 bf4:	5e                   	pop    %esi
 bf5:	5f                   	pop    %edi
 bf6:	5d                   	pop    %ebp
 bf7:	c3                   	ret    
 bf8:	8b 7d dc             	mov    -0x24(%ebp),%edi
 bfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 bfe:	eb 03                	jmp    c03 <trnmnt_tree_alloc+0x173>
 c00:	8b 46 04             	mov    0x4(%esi),%eax
            kthread_mutex_dealloc(output->mutextree[i]);
 c03:	83 ec 0c             	sub    $0xc,%esp
 c06:	ff 34 b8             	pushl  (%eax,%edi,4)
        for (int i = 0; i < treeSize; i++) {
 c09:	83 c7 01             	add    $0x1,%edi
            kthread_mutex_dealloc(output->mutextree[i]);
 c0c:	e8 39 fa ff ff       	call   64a <kthread_mutex_dealloc>
        for (int i = 0; i < treeSize; i++) {
 c11:	83 c4 10             	add    $0x10,%esp
 c14:	39 df                	cmp    %ebx,%edi
 c16:	75 e8                	jne    c00 <trnmnt_tree_alloc+0x170>
 c18:	eb b4                	jmp    bce <trnmnt_tree_alloc+0x13e>
        free(output);
 c1a:	83 ec 0c             	sub    $0xc,%esp
 c1d:	56                   	push   %esi
        return 0;
 c1e:	31 f6                	xor    %esi,%esi
        free(output);
 c20:	e8 bb fc ff ff       	call   8e0 <free>
        return 0;
 c25:	83 c4 10             	add    $0x10,%esp
 c28:	eb 82                	jmp    bac <trnmnt_tree_alloc+0x11c>
 c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c30 <trnmnt_tree_dealloc>:

int trnmnt_tree_dealloc(struct trnmnt_tree *tree) {
 c30:	55                   	push   %ebp
 c31:	89 e5                	mov    %esp,%ebp
 c33:	57                   	push   %edi
 c34:	56                   	push   %esi
 c35:	53                   	push   %ebx
 c36:	83 ec 28             	sub    $0x28,%esp
 c39:	8b 75 08             	mov    0x8(%ebp),%esi
    int i;
    kthread_mutex_lock(tree->Lock);
 c3c:	ff 36                	pushl  (%esi)
 c3e:	e8 0f fa ff ff       	call   652 <kthread_mutex_lock>
    int treeSize = powordepth(tree->depth) - 1;
 c43:	8b 7e 0c             	mov    0xc(%esi),%edi
    while (exp != 0) {
 c46:	83 c4 10             	add    $0x10,%esp
 c49:	85 ff                	test   %edi,%edi
 c4b:	0f 84 0b 01 00 00    	je     d5c <trnmnt_tree_dealloc+0x12c>
 c51:	89 f8                	mov    %edi,%eax
    int output = 1;
 c53:	bb 01 00 00 00       	mov    $0x1,%ebx
 c58:	90                   	nop
 c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 c60:	01 db                	add    %ebx,%ebx
    while (exp != 0) {
 c62:	83 e8 01             	sub    $0x1,%eax
 c65:	75 f9                	jne    c60 <trnmnt_tree_dealloc+0x30>
 c67:	83 eb 01             	sub    $0x1,%ebx
    for (i = 0; i < powordepth(tree->depth); i++) {
 c6a:	31 c9                	xor    %ecx,%ecx
    while (exp != 0) {
 c6c:	85 ff                	test   %edi,%edi
 c6e:	74 2f                	je     c9f <trnmnt_tree_dealloc+0x6f>
 c70:	89 f8                	mov    %edi,%eax
    int output = 1;
 c72:	ba 01 00 00 00       	mov    $0x1,%edx
 c77:	89 f6                	mov    %esi,%esi
 c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        output *= init;
 c80:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 c82:	83 e8 01             	sub    $0x1,%eax
 c85:	75 f9                	jne    c80 <trnmnt_tree_dealloc+0x50>
    for (i = 0; i < powordepth(tree->depth); i++) {
 c87:	39 d1                	cmp    %edx,%ecx
 c89:	7d 25                	jge    cb0 <trnmnt_tree_dealloc+0x80>
        if (tree->threadMap[i] != -1){
 c8b:	8b 46 08             	mov    0x8(%esi),%eax
 c8e:	83 3c 88 ff          	cmpl   $0xffffffff,(%eax,%ecx,4)
 c92:	0f 85 a8 00 00 00    	jne    d40 <trnmnt_tree_dealloc+0x110>
    for (i = 0; i < powordepth(tree->depth); i++) {
 c98:	83 c1 01             	add    $0x1,%ecx
    while (exp != 0) {
 c9b:	85 ff                	test   %edi,%edi
 c9d:	75 d1                	jne    c70 <trnmnt_tree_dealloc+0x40>
    int output = 1;
 c9f:	ba 01 00 00 00       	mov    $0x1,%edx
    for (i = 0; i < powordepth(tree->depth); i++) {
 ca4:	39 d1                	cmp    %edx,%ecx
 ca6:	7c e3                	jl     c8b <trnmnt_tree_dealloc+0x5b>
 ca8:	90                   	nop
 ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
            return -1;
        }
    }
    for (int i = 0; i < treeSize; i++) {
 cb0:	85 db                	test   %ebx,%ebx
 cb2:	74 46                	je     cfa <trnmnt_tree_dealloc+0xca>
 cb4:	31 ff                	xor    %edi,%edi
 cb6:	eb 0f                	jmp    cc7 <trnmnt_tree_dealloc+0x97>
 cb8:	90                   	nop
 cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 cc0:	83 c7 01             	add    $0x1,%edi
 cc3:	39 fb                	cmp    %edi,%ebx
 cc5:	74 33                	je     cfa <trnmnt_tree_dealloc+0xca>
        if (kthread_mutex_dealloc(tree->mutextree[i]) == -1){
 cc7:	8b 46 04             	mov    0x4(%esi),%eax
 cca:	83 ec 0c             	sub    $0xc,%esp
 ccd:	ff 34 b8             	pushl  (%eax,%edi,4)
 cd0:	e8 75 f9 ff ff       	call   64a <kthread_mutex_dealloc>
 cd5:	83 c4 10             	add    $0x10,%esp
 cd8:	83 f8 ff             	cmp    $0xffffffff,%eax
 cdb:	75 e3                	jne    cc0 <trnmnt_tree_dealloc+0x90>
            kthread_mutex_unlock(tree->Lock);
 cdd:	83 ec 0c             	sub    $0xc,%esp
 ce0:	ff 36                	pushl  (%esi)
 ce2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 ce5:	e8 70 f9 ff ff       	call   65a <kthread_mutex_unlock>
            return -1;
 cea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 ced:	83 c4 10             	add    $0x10,%esp
    free(tree->threadMap);
    free(tree->mutextree);
    free(tree);
    tree->depth = 0;
    return 0;
}
 cf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 cf3:	5b                   	pop    %ebx
 cf4:	89 d0                	mov    %edx,%eax
 cf6:	5e                   	pop    %esi
 cf7:	5f                   	pop    %edi
 cf8:	5d                   	pop    %ebp
 cf9:	c3                   	ret    
    kthread_mutex_unlock(tree->Lock);
 cfa:	83 ec 0c             	sub    $0xc,%esp
 cfd:	ff 36                	pushl  (%esi)
 cff:	e8 56 f9 ff ff       	call   65a <kthread_mutex_unlock>
    kthread_mutex_dealloc(tree->Lock);
 d04:	58                   	pop    %eax
 d05:	ff 36                	pushl  (%esi)
 d07:	e8 3e f9 ff ff       	call   64a <kthread_mutex_dealloc>
    free(tree->threadMap);
 d0c:	5a                   	pop    %edx
 d0d:	ff 76 08             	pushl  0x8(%esi)
 d10:	e8 cb fb ff ff       	call   8e0 <free>
    free(tree->mutextree);
 d15:	59                   	pop    %ecx
 d16:	ff 76 04             	pushl  0x4(%esi)
 d19:	e8 c2 fb ff ff       	call   8e0 <free>
    free(tree);
 d1e:	89 34 24             	mov    %esi,(%esp)
 d21:	e8 ba fb ff ff       	call   8e0 <free>
    tree->depth = 0;
 d26:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return 0;
 d2d:	83 c4 10             	add    $0x10,%esp
}
 d30:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 d33:	31 d2                	xor    %edx,%edx
}
 d35:	5b                   	pop    %ebx
 d36:	89 d0                	mov    %edx,%eax
 d38:	5e                   	pop    %esi
 d39:	5f                   	pop    %edi
 d3a:	5d                   	pop    %ebp
 d3b:	c3                   	ret    
 d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kthread_mutex_unlock(tree->Lock);
 d40:	83 ec 0c             	sub    $0xc,%esp
 d43:	ff 36                	pushl  (%esi)
 d45:	e8 10 f9 ff ff       	call   65a <kthread_mutex_unlock>
            return -1;
 d4a:	83 c4 10             	add    $0x10,%esp
}
 d4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
 d50:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
 d55:	89 d0                	mov    %edx,%eax
 d57:	5b                   	pop    %ebx
 d58:	5e                   	pop    %esi
 d59:	5f                   	pop    %edi
 d5a:	5d                   	pop    %ebp
 d5b:	c3                   	ret    
    while (exp != 0) {
 d5c:	31 db                	xor    %ebx,%ebx
 d5e:	e9 07 ff ff ff       	jmp    c6a <trnmnt_tree_dealloc+0x3a>
 d63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d70 <trnmnt_tree_acquire>:


int trnmnt_tree_acquire(trnmnt_tree *tree, int ID) {
 d70:	55                   	push   %ebp
 d71:	89 e5                	mov    %esp,%ebp
 d73:	57                   	push   %edi
 d74:	56                   	push   %esi
 d75:	53                   	push   %ebx
 d76:	83 ec 0c             	sub    $0xc,%esp
 d79:	8b 7d 0c             	mov    0xc(%ebp),%edi
 d7c:	8b 75 08             	mov    0x8(%ebp),%esi
    int treePosition, fatherPosition = -1;
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 d7f:	85 ff                	test   %edi,%edi
 d81:	0f 88 d1 00 00 00    	js     e58 <trnmnt_tree_acquire+0xe8>
 d87:	85 f6                	test   %esi,%esi
 d89:	0f 84 c9 00 00 00    	je     e58 <trnmnt_tree_acquire+0xe8>
 d8f:	8b 46 0c             	mov    0xc(%esi),%eax
    int output = 1;
 d92:	ba 01 00 00 00       	mov    $0x1,%edx
    while (exp != 0) {
 d97:	85 c0                	test   %eax,%eax
 d99:	74 0c                	je     da7 <trnmnt_tree_acquire+0x37>
 d9b:	90                   	nop
 d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 da0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 da2:	83 e8 01             	sub    $0x1,%eax
 da5:	75 f9                	jne    da0 <trnmnt_tree_acquire+0x30>
    if (ID < 0 || tree == 0 || ID > (powordepth(tree->depth) - 1)) {
 da7:	39 d7                	cmp    %edx,%edi
 da9:	0f 8d a9 00 00 00    	jge    e58 <trnmnt_tree_acquire+0xe8>
        return -1;
    }
    kthread_mutex_lock(tree->Lock);
 daf:	83 ec 0c             	sub    $0xc,%esp
 db2:	ff 36                	pushl  (%esi)
 db4:	e8 99 f8 ff ff       	call   652 <kthread_mutex_lock>

    if (tree->threadMap[ID] != -1) {
 db9:	8b 46 08             	mov    0x8(%esi),%eax
 dbc:	83 c4 10             	add    $0x10,%esp
 dbf:	8d 1c b8             	lea    (%eax,%edi,4),%ebx
 dc2:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
 dc5:	0f 85 94 00 00 00    	jne    e5f <trnmnt_tree_acquire+0xef>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = kthread_id();
 dcb:	e8 5a f8 ff ff       	call   62a <kthread_id>
    kthread_mutex_unlock(tree->Lock);
 dd0:	83 ec 0c             	sub    $0xc,%esp
    tree->threadMap[ID] = kthread_id();
 dd3:	89 03                	mov    %eax,(%ebx)
    kthread_mutex_unlock(tree->Lock);
 dd5:	ff 36                	pushl  (%esi)
 dd7:	e8 7e f8 ff ff       	call   65a <kthread_mutex_unlock>
    treePosition = (powordepth(tree->depth) - 1) + ID;
 ddc:	8b 46 0c             	mov    0xc(%esi),%eax
    while (exp != 0) {
 ddf:	83 c4 10             	add    $0x10,%esp
 de2:	85 c0                	test   %eax,%eax
 de4:	74 5a                	je     e40 <trnmnt_tree_acquire+0xd0>
    int output = 1;
 de6:	ba 01 00 00 00       	mov    $0x1,%edx
 deb:	90                   	nop
 dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        output *= init;
 df0:	01 d2                	add    %edx,%edx
    while (exp != 0) {
 df2:	83 e8 01             	sub    $0x1,%eax
 df5:	75 f9                	jne    df0 <trnmnt_tree_acquire+0x80>
    fatherPosition = (treePosition - 1) / 2;
 df7:	8d 44 3a fe          	lea    -0x2(%edx,%edi,1),%eax
 dfb:	89 c3                	mov    %eax,%ebx
 dfd:	c1 eb 1f             	shr    $0x1f,%ebx
 e00:	01 c3                	add    %eax,%ebx
 e02:	d1 fb                	sar    %ebx
 e04:	eb 0c                	jmp    e12 <trnmnt_tree_acquire+0xa2>
 e06:	8d 76 00             	lea    0x0(%esi),%esi
 e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (treePosition != 0) {
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
        treePosition = fatherPosition;
        fatherPosition = (treePosition - 1) / 2;
 e10:	89 c3                	mov    %eax,%ebx
        kthread_mutex_lock(tree->mutextree[fatherPosition]);
 e12:	8b 46 04             	mov    0x4(%esi),%eax
 e15:	83 ec 0c             	sub    $0xc,%esp
 e18:	ff 34 98             	pushl  (%eax,%ebx,4)
 e1b:	e8 32 f8 ff ff       	call   652 <kthread_mutex_lock>
        fatherPosition = (treePosition - 1) / 2;
 e20:	8d 53 ff             	lea    -0x1(%ebx),%edx
    while (treePosition != 0) {
 e23:	83 c4 10             	add    $0x10,%esp
        fatherPosition = (treePosition - 1) / 2;
 e26:	89 d0                	mov    %edx,%eax
 e28:	c1 e8 1f             	shr    $0x1f,%eax
 e2b:	01 d0                	add    %edx,%eax
 e2d:	d1 f8                	sar    %eax
    while (treePosition != 0) {
 e2f:	85 db                	test   %ebx,%ebx
 e31:	75 dd                	jne    e10 <trnmnt_tree_acquire+0xa0>
    }
    return 0;
 e33:	31 c0                	xor    %eax,%eax
}
 e35:	8d 65 f4             	lea    -0xc(%ebp),%esp
 e38:	5b                   	pop    %ebx
 e39:	5e                   	pop    %esi
 e3a:	5f                   	pop    %edi
 e3b:	5d                   	pop    %ebp
 e3c:	c3                   	ret    
 e3d:	8d 76 00             	lea    0x0(%esi),%esi
    fatherPosition = (treePosition - 1) / 2;
 e40:	8d 47 ff             	lea    -0x1(%edi),%eax
 e43:	89 c3                	mov    %eax,%ebx
 e45:	c1 eb 1f             	shr    $0x1f,%ebx
 e48:	01 c3                	add    %eax,%ebx
 e4a:	d1 fb                	sar    %ebx
    while (treePosition != 0) {
 e4c:	85 ff                	test   %edi,%edi
 e4e:	74 e3                	je     e33 <trnmnt_tree_acquire+0xc3>
 e50:	eb c0                	jmp    e12 <trnmnt_tree_acquire+0xa2>
 e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 e58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e5d:	eb d6                	jmp    e35 <trnmnt_tree_acquire+0xc5>
        kthread_mutex_unlock(tree->Lock);
 e5f:	83 ec 0c             	sub    $0xc,%esp
 e62:	ff 36                	pushl  (%esi)
 e64:	e8 f1 f7 ff ff       	call   65a <kthread_mutex_unlock>
        return -1;
 e69:	83 c4 10             	add    $0x10,%esp
 e6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e71:	eb c2                	jmp    e35 <trnmnt_tree_acquire+0xc5>
 e73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e80 <trnmnt_tree_release_rec>:

int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 e80:	55                   	push   %ebp
 e81:	89 e5                	mov    %esp,%ebp
 e83:	56                   	push   %esi
 e84:	53                   	push   %ebx
    int fatherPosition = (position - 1) / 2;
 e85:	8b 45 0c             	mov    0xc(%ebp),%eax
int trnmnt_tree_release_rec(struct trnmnt_tree *tree, int position) {
 e88:	8b 75 08             	mov    0x8(%ebp),%esi
    int fatherPosition = (position - 1) / 2;
 e8b:	8d 50 ff             	lea    -0x1(%eax),%edx
 e8e:	89 d0                	mov    %edx,%eax
 e90:	c1 e8 1f             	shr    $0x1f,%eax
 e93:	01 d0                	add    %edx,%eax
    if (fatherPosition != 0){
 e95:	d1 f8                	sar    %eax
 e97:	89 c3                	mov    %eax,%ebx
 e99:	75 15                	jne    eb0 <trnmnt_tree_release_rec+0x30>
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
            //printf(1,"position id=%d, fatherPosition=%d\n",position, fatherPosition);
            return -1;
        }
    }
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 e9b:	8b 46 04             	mov    0x4(%esi),%eax
 e9e:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 ea1:	89 45 08             	mov    %eax,0x8(%ebp)
}
 ea4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ea7:	5b                   	pop    %ebx
 ea8:	5e                   	pop    %esi
 ea9:	5d                   	pop    %ebp
    return kthread_mutex_unlock(tree->mutextree[fatherPosition]);
 eaa:	e9 ab f7 ff ff       	jmp    65a <kthread_mutex_unlock>
 eaf:	90                   	nop
        if (trnmnt_tree_release_rec(tree, fatherPosition) == -1){
 eb0:	83 ec 08             	sub    $0x8,%esp
 eb3:	50                   	push   %eax
 eb4:	56                   	push   %esi
 eb5:	e8 c6 ff ff ff       	call   e80 <trnmnt_tree_release_rec>
 eba:	83 c4 10             	add    $0x10,%esp
 ebd:	83 f8 ff             	cmp    $0xffffffff,%eax
 ec0:	75 d9                	jne    e9b <trnmnt_tree_release_rec+0x1b>
}
 ec2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ec5:	5b                   	pop    %ebx
 ec6:	5e                   	pop    %esi
 ec7:	5d                   	pop    %ebp
 ec8:	c3                   	ret    
 ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <trnmnt_tree_release>:


int trnmnt_tree_release(struct trnmnt_tree *tree, int ID) {
 ed0:	55                   	push   %ebp
 ed1:	89 e5                	mov    %esp,%ebp
 ed3:	57                   	push   %edi
 ed4:	56                   	push   %esi
 ed5:	53                   	push   %ebx
 ed6:	83 ec 28             	sub    $0x28,%esp
 ed9:	8b 7d 08             	mov    0x8(%ebp),%edi
 edc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    kthread_mutex_lock(tree->Lock);
 edf:	ff 37                	pushl  (%edi)
 ee1:	e8 6c f7 ff ff       	call   652 <kthread_mutex_lock>
    if (tree->threadMap[ID] != kthread_id()) {
 ee6:	8b 47 08             	mov    0x8(%edi),%eax
 ee9:	8b 04 98             	mov    (%eax,%ebx,4),%eax
 eec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 eef:	e8 36 f7 ff ff       	call   62a <kthread_id>
 ef4:	83 c4 10             	add    $0x10,%esp
 ef7:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
 efa:	75 56                	jne    f52 <trnmnt_tree_release+0x82>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 efc:	8b 47 0c             	mov    0xc(%edi),%eax
 eff:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
    while (exp != 0) {
 f06:	85 c0                	test   %eax,%eax
 f08:	74 11                	je     f1b <trnmnt_tree_release+0x4b>
    int output = 1;
 f0a:	b9 01 00 00 00       	mov    $0x1,%ecx
 f0f:	90                   	nop
        output *= init;
 f10:	01 c9                	add    %ecx,%ecx
    while (exp != 0) {
 f12:	83 e8 01             	sub    $0x1,%eax
 f15:	75 f9                	jne    f10 <trnmnt_tree_release+0x40>
 f17:	8d 5c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ebx
    if(trnmnt_tree_release_rec(tree, (powordepth(tree->depth) - 1) + ID)==-1){
 f1b:	83 ec 08             	sub    $0x8,%esp
 f1e:	53                   	push   %ebx
 f1f:	57                   	push   %edi
 f20:	e8 5b ff ff ff       	call   e80 <trnmnt_tree_release_rec>
 f25:	83 c4 10             	add    $0x10,%esp
 f28:	83 f8 ff             	cmp    $0xffffffff,%eax
 f2b:	89 c3                	mov    %eax,%ebx
 f2d:	74 37                	je     f66 <trnmnt_tree_release+0x96>
        kthread_mutex_unlock(tree->Lock);
        return -1;
    }
    tree->threadMap[ID] = -1;
 f2f:	8b 47 08             	mov    0x8(%edi),%eax
    kthread_mutex_unlock(tree->Lock);
 f32:	83 ec 0c             	sub    $0xc,%esp
    return 0;
 f35:	31 db                	xor    %ebx,%ebx
    tree->threadMap[ID] = -1;
 f37:	c7 04 30 ff ff ff ff 	movl   $0xffffffff,(%eax,%esi,1)
    kthread_mutex_unlock(tree->Lock);
 f3e:	ff 37                	pushl  (%edi)
 f40:	e8 15 f7 ff ff       	call   65a <kthread_mutex_unlock>
    return 0;
 f45:	83 c4 10             	add    $0x10,%esp
}
 f48:	8d 65 f4             	lea    -0xc(%ebp),%esp
 f4b:	89 d8                	mov    %ebx,%eax
 f4d:	5b                   	pop    %ebx
 f4e:	5e                   	pop    %esi
 f4f:	5f                   	pop    %edi
 f50:	5d                   	pop    %ebp
 f51:	c3                   	ret    
        kthread_mutex_unlock(tree->Lock);
 f52:	83 ec 0c             	sub    $0xc,%esp
 f55:	ff 37                	pushl  (%edi)
        return -1;
 f57:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
        kthread_mutex_unlock(tree->Lock);
 f5c:	e8 f9 f6 ff ff       	call   65a <kthread_mutex_unlock>
        return -1;
 f61:	83 c4 10             	add    $0x10,%esp
 f64:	eb e2                	jmp    f48 <trnmnt_tree_release+0x78>
        kthread_mutex_unlock(tree->Lock);
 f66:	83 ec 0c             	sub    $0xc,%esp
 f69:	ff 37                	pushl  (%edi)
 f6b:	e8 ea f6 ff ff       	call   65a <kthread_mutex_unlock>
        return -1;
 f70:	83 c4 10             	add    $0x10,%esp
 f73:	eb d3                	jmp    f48 <trnmnt_tree_release+0x78>
