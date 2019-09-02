
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 30 10 80       	mov    $0x80103010,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 20 81 10 80       	push   $0x80108120
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 a5 51 00 00       	call   80105200 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 81 10 80       	push   $0x80108127
80100097:	50                   	push   %eax
80100098:	e8 33 50 00 00       	call   801050d0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 57 52 00 00       	call   80105340 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 99 52 00 00       	call   80105400 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 9e 4f 00 00       	call   80105110 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 0d 21 00 00       	call   80102290 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 2e 81 10 80       	push   $0x8010812e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 fd 4f 00 00       	call   801051b0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 c7 20 00 00       	jmp    80102290 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 3f 81 10 80       	push   $0x8010813f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 bc 4f 00 00       	call   801051b0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 6c 4f 00 00       	call   80105170 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 30 51 00 00       	call   80105340 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 9f 51 00 00       	jmp    80105400 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 81 10 80       	push   $0x80108146
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 4b 16 00 00       	call   801018d0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 af 50 00 00       	call   80105340 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002a7:	39 15 a4 0f 11 80    	cmp    %edx,0x80110fa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 a0 0f 11 80       	push   $0x80110fa0
801002c5:	e8 d6 47 00 00       	call   80104aa0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 d0 38 00 00       	call   80103bb0 <myproc>
801002e0:	8b 40 14             	mov    0x14(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 0c 51 00 00       	call   80105400 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 f4 14 00 00       	call   801017f0 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 0f 11 80 	movsbl -0x7feef0e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 ae 50 00 00       	call   80105400 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 96 14 00 00       	call   801017f0 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 f2 24 00 00       	call   801028a0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 4d 81 10 80       	push   $0x8010814d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 8c 8d 10 80 	movl   $0x80108d8c,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 43 4e 00 00       	call   80105220 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 61 81 10 80       	push   $0x80108161
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 c1 68 00 00       	call   80106d00 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 0f 68 00 00       	call   80106d00 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 03 68 00 00       	call   80106d00 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 f7 67 00 00       	call   80106d00 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 d7 4f 00 00       	call   80105500 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 0a 4f 00 00       	call   80105450 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 65 81 10 80       	push   $0x80108165
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 90 81 10 80 	movzbl -0x7fef7e70(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 bc 12 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 20 4d 00 00       	call   80105340 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 b4 4d 00 00       	call   80105400 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 9b 11 00 00       	call   801017f0 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 dc 4c 00 00       	call   80105400 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 78 81 10 80       	mov    $0x80108178,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 4b 4b 00 00       	call   80105340 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 7f 81 10 80       	push   $0x8010817f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 18 4b 00 00       	call   80105340 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100856:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 73 4b 00 00       	call   80105400 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
80100911:	68 a0 0f 11 80       	push   $0x80110fa0
80100916:	e8 75 39 00 00       	call   80104290 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010093d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100964:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 04 3a 00 00       	jmp    801043a0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 88 81 10 80       	push   $0x80108188
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 2b 48 00 00       	call   80105200 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 42 1a 00 00       	call   80102440 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv) {
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 1c 01 00 00    	sub    $0x11c,%esp
    uint argc, sz, sp, ustack[3 + MAXARG + 1];
    struct elfhdr elf;
    struct inode *ip;
    struct proghdr ph;
    pde_t *pgdir, *oldpgdir;
    struct proc *curproc = myproc();
80100a1c:	e8 8f 31 00 00       	call   80103bb0 <myproc>
80100a21:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
    struct thread *curthread = mythread();
80100a27:	e8 b4 31 00 00       	call   80103be0 <mythread>
80100a2c:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
    struct thread *t;

    if(mythread()->shouldDie){
80100a32:	e8 a9 31 00 00       	call   80103be0 <mythread>
80100a37:	8b 58 1c             	mov    0x1c(%eax),%ebx
80100a3a:	85 db                	test   %ebx,%ebx
80100a3c:	0f 85 57 02 00 00    	jne    80100c99 <exec+0x289>
        kthread_exit();
    }

    acquire(mySpinlock());
80100a42:	e8 b9 30 00 00       	call   80103b00 <mySpinlock>
80100a47:	83 ec 0c             	sub    $0xc,%esp
80100a4a:	50                   	push   %eax
80100a4b:	e8 f0 48 00 00       	call   80105340 <acquire>
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80100a50:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100a56:	8b 95 e8 fe ff ff    	mov    -0x118(%ebp),%edx
80100a5c:	83 c4 10             	add    $0x10,%esp
80100a5f:	8d 88 dc 03 00 00    	lea    0x3dc(%eax),%ecx
80100a65:	8d 58 5c             	lea    0x5c(%eax),%ebx
80100a68:	89 8d e4 fe ff ff    	mov    %ecx,-0x11c(%ebp)
80100a6e:	89 d8                	mov    %ebx,%eax
        if (t->tid != curthread->tid)
80100a70:	8b 7a 0c             	mov    0xc(%edx),%edi
80100a73:	39 78 0c             	cmp    %edi,0xc(%eax)
80100a76:	74 07                	je     80100a7f <exec+0x6f>
            t->shouldDie = 1;
80100a78:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
        if (t->state == T_SLEEPING)
80100a7f:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80100a83:	75 07                	jne    80100a8c <exec+0x7c>
            t->state = T_RUNNABLE;
80100a85:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80100a8c:	83 c0 38             	add    $0x38,%eax
80100a8f:	39 c8                	cmp    %ecx,%eax
80100a91:	72 dd                	jb     80100a70 <exec+0x60>
    }
    release(mySpinlock());
80100a93:	e8 68 30 00 00       	call   80103b00 <mySpinlock>
80100a98:	83 ec 0c             	sub    $0xc,%esp
    int numthread=1000;
    while(numthread>1){
        numthread=0;
        for(t=curproc->ttable;t<&(curproc->ttable[NTHREAD]);t++){
80100a9b:	89 de                	mov    %ebx,%esi
        numthread=0;
80100a9d:	31 ff                	xor    %edi,%edi
    release(mySpinlock());
80100a9f:	50                   	push   %eax
80100aa0:	e8 5b 49 00 00       	call   80105400 <release>
80100aa5:	89 9d f4 fe ff ff    	mov    %ebx,-0x10c(%ebp)
80100aab:	83 c4 10             	add    $0x10,%esp
80100aae:	8b 9d e4 fe ff ff    	mov    -0x11c(%ebp),%ebx
80100ab4:	eb 16                	jmp    80100acc <exec+0xbc>
80100ab6:	8d 76 00             	lea    0x0(%esi),%esi
80100ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            if (t->state == T_SLEEPING){
                t->state = T_RUNNABLE;
            }
            if(t->state==T_ZOMBIE){
80100ac0:	83 f8 05             	cmp    $0x5,%eax
80100ac3:	74 23                	je     80100ae8 <exec+0xd8>
                t->tid = 0;
                t->state = T_UNUSED;
                curproc->numOfthread--;
            }
            else{
                if(t->state!=T_UNUSED){
80100ac5:	85 c0                	test   %eax,%eax
80100ac7:	75 16                	jne    80100adf <exec+0xcf>
        for(t=curproc->ttable;t<&(curproc->ttable[NTHREAD]);t++){
80100ac9:	83 c6 38             	add    $0x38,%esi
80100acc:	39 de                	cmp    %ebx,%esi
80100ace:	73 50                	jae    80100b20 <exec+0x110>
            if (t->state == T_SLEEPING){
80100ad0:	8b 46 04             	mov    0x4(%esi),%eax
80100ad3:	83 f8 02             	cmp    $0x2,%eax
80100ad6:	75 e8                	jne    80100ac0 <exec+0xb0>
                t->state = T_RUNNABLE;
80100ad8:	c7 46 04 03 00 00 00 	movl   $0x3,0x4(%esi)
                    numthread++;
80100adf:	83 c7 01             	add    $0x1,%edi
80100ae2:	eb e5                	jmp    80100ac9 <exec+0xb9>
80100ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                kfree(t->kstack);
80100ae8:	83 ec 0c             	sub    $0xc,%esp
80100aeb:	ff 36                	pushl  (%esi)
80100aed:	e8 8e 19 00 00       	call   80102480 <kfree>
                curproc->numOfthread--;
80100af2:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
                t->kstack = 0;
80100af8:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80100afe:	83 c4 10             	add    $0x10,%esp
                t->tid = 0;
80100b01:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
                t->state = T_UNUSED;
80100b08:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
                curproc->numOfthread--;
80100b0f:	83 a8 ec 03 00 00 01 	subl   $0x1,0x3ec(%eax)
80100b16:	eb b1                	jmp    80100ac9 <exec+0xb9>
80100b18:	90                   	nop
80100b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(numthread>1){
80100b20:	83 ff 01             	cmp    $0x1,%edi
80100b23:	7e 0a                	jle    80100b2f <exec+0x11f>
        for(t=curproc->ttable;t<&(curproc->ttable[NTHREAD]);t++){
80100b25:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
        numthread=0;
80100b2b:	31 ff                	xor    %edi,%edi
80100b2d:	eb a1                	jmp    80100ad0 <exec+0xc0>
                }
            }
        }
    }

    begin_op();
80100b2f:	e8 dc 21 00 00       	call   80102d10 <begin_op>

    if ((ip = namei(path)) == 0) {
80100b34:	83 ec 0c             	sub    $0xc,%esp
80100b37:	ff 75 08             	pushl  0x8(%ebp)
80100b3a:	e8 11 15 00 00       	call   80102050 <namei>
80100b3f:	83 c4 10             	add    $0x10,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	89 c6                	mov    %eax,%esi
80100b46:	0f 84 4e 03 00 00    	je     80100e9a <exec+0x48a>
        end_op();
        cprintf("exec: fail\n");
        return -1;
    }
    ilock(ip);
80100b4c:	83 ec 0c             	sub    $0xc,%esp
80100b4f:	50                   	push   %eax
80100b50:	e8 9b 0c 00 00       	call   801017f0 <ilock>
    pgdir = 0;

    // Check ELF header
    if (readi(ip, (char *) &elf, 0, sizeof(elf)) != sizeof(elf))
80100b55:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b5b:	6a 34                	push   $0x34
80100b5d:	6a 00                	push   $0x0
80100b5f:	50                   	push   %eax
80100b60:	56                   	push   %esi
80100b61:	e8 6a 0f 00 00       	call   80101ad0 <readi>
80100b66:	83 c4 20             	add    $0x20,%esp
80100b69:	83 f8 34             	cmp    $0x34,%eax
80100b6c:	0f 85 f8 00 00 00    	jne    80100c6a <exec+0x25a>
        goto bad;
    if (elf.magic != ELF_MAGIC)
80100b72:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b79:	45 4c 46 
80100b7c:	0f 85 e8 00 00 00    	jne    80100c6a <exec+0x25a>
        goto bad;

    if ((pgdir = setupkvm()) == 0)
80100b82:	e8 e9 72 00 00       	call   80107e70 <setupkvm>
80100b87:	85 c0                	test   %eax,%eax
80100b89:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b8f:	0f 84 d5 00 00 00    	je     80100c6a <exec+0x25a>
        goto bad;

    // Load program into memory.
    sz = 0;
80100b95:	31 ff                	xor    %edi,%edi
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
80100b97:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b9e:	00 
80100b9f:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ba5:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bab:	0f 84 bb 02 00 00    	je     80100e6c <exec+0x45c>
80100bb1:	31 db                	xor    %ebx,%ebx
80100bb3:	eb 7d                	jmp    80100c32 <exec+0x222>
80100bb5:	8d 76 00             	lea    0x0(%esi),%esi
        if (readi(ip, (char *) &ph, off, sizeof(ph)) != sizeof(ph))
            goto bad;
        if (ph.type != ELF_PROG_LOAD)
80100bb8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100bbf:	75 63                	jne    80100c24 <exec+0x214>
            continue;
        if (ph.memsz < ph.filesz)
80100bc1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100bc7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100bcd:	0f 82 86 00 00 00    	jb     80100c59 <exec+0x249>
80100bd3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100bd9:	72 7e                	jb     80100c59 <exec+0x249>
            goto bad;
        if (ph.vaddr + ph.memsz < ph.vaddr)
            goto bad;
        if ((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bdb:	83 ec 04             	sub    $0x4,%esp
80100bde:	50                   	push   %eax
80100bdf:	57                   	push   %edi
80100be0:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100be6:	e8 a5 70 00 00       	call   80107c90 <allocuvm>
80100beb:	83 c4 10             	add    $0x10,%esp
80100bee:	85 c0                	test   %eax,%eax
80100bf0:	89 c7                	mov    %eax,%edi
80100bf2:	74 65                	je     80100c59 <exec+0x249>
            goto bad;
        if (ph.vaddr % PGSIZE != 0)
80100bf4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bfa:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bff:	75 58                	jne    80100c59 <exec+0x249>
            goto bad;
        if (loaduvm(pgdir, (char *) ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c01:	83 ec 0c             	sub    $0xc,%esp
80100c04:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100c0a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100c10:	56                   	push   %esi
80100c11:	50                   	push   %eax
80100c12:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c18:	e8 b3 6f 00 00       	call   80107bd0 <loaduvm>
80100c1d:	83 c4 20             	add    $0x20,%esp
80100c20:	85 c0                	test   %eax,%eax
80100c22:	78 35                	js     80100c59 <exec+0x249>
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
80100c24:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c2b:	83 c3 01             	add    $0x1,%ebx
80100c2e:	39 d8                	cmp    %ebx,%eax
80100c30:	7e 71                	jle    80100ca3 <exec+0x293>
        if (readi(ip, (char *) &ph, off, sizeof(ph)) != sizeof(ph))
80100c32:	89 d8                	mov    %ebx,%eax
80100c34:	6a 20                	push   $0x20
80100c36:	c1 e0 05             	shl    $0x5,%eax
80100c39:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100c3f:	50                   	push   %eax
80100c40:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c46:	50                   	push   %eax
80100c47:	56                   	push   %esi
80100c48:	e8 83 0e 00 00       	call   80101ad0 <readi>
80100c4d:	83 c4 10             	add    $0x10,%esp
80100c50:	83 f8 20             	cmp    $0x20,%eax
80100c53:	0f 84 5f ff ff ff    	je     80100bb8 <exec+0x1a8>
    freevm(oldpgdir);
    return 0;

    bad:
    if (pgdir)
        freevm(pgdir);
80100c59:	83 ec 0c             	sub    $0xc,%esp
80100c5c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c62:	e8 89 71 00 00       	call   80107df0 <freevm>
80100c67:	83 c4 10             	add    $0x10,%esp
    if (ip) {
        iunlockput(ip);
80100c6a:	83 ec 0c             	sub    $0xc,%esp
80100c6d:	56                   	push   %esi
80100c6e:	e8 0d 0e 00 00       	call   80101a80 <iunlockput>
        end_op();
80100c73:	e8 08 21 00 00       	call   80102d80 <end_op>
80100c78:	83 c4 10             	add    $0x10,%esp
    }
    release(mySpinlock());
80100c7b:	e8 80 2e 00 00       	call   80103b00 <mySpinlock>
80100c80:	83 ec 0c             	sub    $0xc,%esp
80100c83:	50                   	push   %eax
80100c84:	e8 77 47 00 00       	call   80105400 <release>
    return -1;
80100c89:	83 c4 10             	add    $0x10,%esp
80100c8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c94:	5b                   	pop    %ebx
80100c95:	5e                   	pop    %esi
80100c96:	5f                   	pop    %edi
80100c97:	5d                   	pop    %ebp
80100c98:	c3                   	ret    
        kthread_exit();
80100c99:	e8 92 3d 00 00       	call   80104a30 <kthread_exit>
80100c9e:	e9 9f fd ff ff       	jmp    80100a42 <exec+0x32>
80100ca3:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100ca9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100caf:	8d 9f 00 20 00 00    	lea    0x2000(%edi),%ebx
    iunlockput(ip);
80100cb5:	83 ec 0c             	sub    $0xc,%esp
80100cb8:	56                   	push   %esi
80100cb9:	e8 c2 0d 00 00       	call   80101a80 <iunlockput>
    end_op();
80100cbe:	e8 bd 20 00 00       	call   80102d80 <end_op>
    acquire(mySpinlock());
80100cc3:	e8 38 2e 00 00       	call   80103b00 <mySpinlock>
80100cc8:	89 04 24             	mov    %eax,(%esp)
80100ccb:	e8 70 46 00 00       	call   80105340 <acquire>
    if ((sz = allocuvm(pgdir, sz, sz + 2 * PGSIZE)) == 0)
80100cd0:	83 c4 0c             	add    $0xc,%esp
80100cd3:	53                   	push   %ebx
80100cd4:	8b 9d f4 fe ff ff    	mov    -0x10c(%ebp),%ebx
80100cda:	57                   	push   %edi
80100cdb:	53                   	push   %ebx
80100cdc:	e8 af 6f 00 00       	call   80107c90 <allocuvm>
80100ce1:	83 c4 10             	add    $0x10,%esp
80100ce4:	85 c0                	test   %eax,%eax
80100ce6:	89 c7                	mov    %eax,%edi
80100ce8:	0f 84 83 00 00 00    	je     80100d71 <exec+0x361>
    clearpteu(pgdir, (char *) (sz - 2 * PGSIZE));
80100cee:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100cf4:	83 ec 08             	sub    $0x8,%esp
    for (argc = 0; argv[argc]; argc++) {
80100cf7:	31 f6                	xor    %esi,%esi
    clearpteu(pgdir, (char *) (sz - 2 * PGSIZE));
80100cf9:	50                   	push   %eax
80100cfa:	53                   	push   %ebx
    for (argc = 0; argv[argc]; argc++) {
80100cfb:	89 fb                	mov    %edi,%ebx
    clearpteu(pgdir, (char *) (sz - 2 * PGSIZE));
80100cfd:	e8 0e 72 00 00       	call   80107f10 <clearpteu>
    for (argc = 0; argv[argc]; argc++) {
80100d02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d05:	83 c4 10             	add    $0x10,%esp
80100d08:	8b 08                	mov    (%eax),%ecx
80100d0a:	85 c9                	test   %ecx,%ecx
80100d0c:	0f 84 64 01 00 00    	je     80100e76 <exec+0x466>
80100d12:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100d18:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100d1b:	eb 21                	jmp    80100d3e <exec+0x32e>
80100d1d:	8d 76 00             	lea    0x0(%esi),%esi
80100d20:	8d 46 01             	lea    0x1(%esi),%eax
        ustack[3 + argc] = sp;
80100d23:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100d29:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
    for (argc = 0; argv[argc]; argc++) {
80100d30:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80100d33:	85 c9                	test   %ecx,%ecx
80100d35:	74 50                	je     80100d87 <exec+0x377>
        if (argc >= MAXARG)
80100d37:	83 f8 20             	cmp    $0x20,%eax
80100d3a:	74 35                	je     80100d71 <exec+0x361>
80100d3c:	89 c6                	mov    %eax,%esi
        sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d3e:	83 ec 0c             	sub    $0xc,%esp
80100d41:	51                   	push   %ecx
80100d42:	e8 29 49 00 00       	call   80105670 <strlen>
        if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d47:	59                   	pop    %ecx
        sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d48:	f7 d0                	not    %eax
        if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d4a:	ff 34 b7             	pushl  (%edi,%esi,4)
        sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d4d:	01 c3                	add    %eax,%ebx
80100d4f:	83 e3 fc             	and    $0xfffffffc,%ebx
        if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d52:	e8 19 49 00 00       	call   80105670 <strlen>
80100d57:	83 c0 01             	add    $0x1,%eax
80100d5a:	50                   	push   %eax
80100d5b:	ff 34 b7             	pushl  (%edi,%esi,4)
80100d5e:	53                   	push   %ebx
80100d5f:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d65:	e8 06 73 00 00       	call   80108070 <copyout>
80100d6a:	83 c4 20             	add    $0x20,%esp
80100d6d:	85 c0                	test   %eax,%eax
80100d6f:	79 af                	jns    80100d20 <exec+0x310>
        freevm(pgdir);
80100d71:	83 ec 0c             	sub    $0xc,%esp
80100d74:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d7a:	e8 71 70 00 00       	call   80107df0 <freevm>
80100d7f:	83 c4 10             	add    $0x10,%esp
80100d82:	e9 f4 fe ff ff       	jmp    80100c7b <exec+0x26b>
80100d87:	8d 0c b5 08 00 00 00 	lea    0x8(,%esi,4),%ecx
80100d8e:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d94:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d9a:	8d 46 04             	lea    0x4(%esi),%eax
80100d9d:	8d 71 0c             	lea    0xc(%ecx),%esi
    ustack[3 + argc] = 0;
80100da0:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100da7:	00 00 00 00 
    ustack[1] = argc;
80100dab:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
    if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
80100db1:	56                   	push   %esi
80100db2:	52                   	push   %edx
    ustack[0] = 0xffffffff;  // fake return PC
80100db3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100dba:	ff ff ff 
    ustack[1] = argc;
80100dbd:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
    ustack[2] = sp - (argc + 1) * 4;  // argv pointer
80100dc3:	89 d8                	mov    %ebx,%eax
    sp -= (3 + argc + 1) * 4;
80100dc5:	29 f3                	sub    %esi,%ebx
    if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
80100dc7:	53                   	push   %ebx
80100dc8:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
    ustack[2] = sp - (argc + 1) * 4;  // argv pointer
80100dce:	29 c8                	sub    %ecx,%eax
80100dd0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    if (copyout(pgdir, sp, ustack, (3 + argc + 1) * 4) < 0)
80100dd6:	e8 95 72 00 00       	call   80108070 <copyout>
80100ddb:	83 c4 10             	add    $0x10,%esp
80100dde:	85 c0                	test   %eax,%eax
80100de0:	78 8f                	js     80100d71 <exec+0x361>
    for (last = s = path; *s; s++)
80100de2:	8b 45 08             	mov    0x8(%ebp),%eax
80100de5:	8b 55 08             	mov    0x8(%ebp),%edx
80100de8:	0f b6 00             	movzbl (%eax),%eax
80100deb:	84 c0                	test   %al,%al
80100ded:	74 18                	je     80100e07 <exec+0x3f7>
80100def:	89 d1                	mov    %edx,%ecx
80100df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100df8:	83 c1 01             	add    $0x1,%ecx
80100dfb:	3c 2f                	cmp    $0x2f,%al
80100dfd:	0f b6 01             	movzbl (%ecx),%eax
80100e00:	0f 44 d1             	cmove  %ecx,%edx
80100e03:	84 c0                	test   %al,%al
80100e05:	75 f1                	jne    80100df8 <exec+0x3e8>
    safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e07:	83 ec 04             	sub    $0x4,%esp
80100e0a:	6a 10                	push   $0x10
80100e0c:	52                   	push   %edx
80100e0d:	ff b5 e4 fe ff ff    	pushl  -0x11c(%ebp)
80100e13:	e8 18 48 00 00       	call   80105630 <safestrcpy>
    oldpgdir = curproc->pgdir;
80100e18:	8b 8d ec fe ff ff    	mov    -0x114(%ebp),%ecx
    curproc->pgdir = pgdir;
80100e1e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
    curproc->sz = sz;
80100e24:	89 39                	mov    %edi,(%ecx)
    curthread->tf->eip = elf.entry;  // main
80100e26:	8b bd e8 fe ff ff    	mov    -0x118(%ebp),%edi
    oldpgdir = curproc->pgdir;
80100e2c:	8b 71 04             	mov    0x4(%ecx),%esi
    curproc->pgdir = pgdir;
80100e2f:	89 41 04             	mov    %eax,0x4(%ecx)
    curthread->tf->eip = elf.entry;  // main
80100e32:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e38:	8b 47 08             	mov    0x8(%edi),%eax
80100e3b:	89 50 38             	mov    %edx,0x38(%eax)
    curthread->tf->esp = sp;
80100e3e:	8b 47 08             	mov    0x8(%edi),%eax
80100e41:	89 58 44             	mov    %ebx,0x44(%eax)
    switchuvm(curthread,curproc);
80100e44:	58                   	pop    %eax
80100e45:	5a                   	pop    %edx
80100e46:	51                   	push   %ecx
80100e47:	57                   	push   %edi
80100e48:	e8 d3 6b 00 00       	call   80107a20 <switchuvm>
    release(mySpinlock());
80100e4d:	e8 ae 2c 00 00       	call   80103b00 <mySpinlock>
80100e52:	89 04 24             	mov    %eax,(%esp)
80100e55:	e8 a6 45 00 00       	call   80105400 <release>
    freevm(oldpgdir);
80100e5a:	89 34 24             	mov    %esi,(%esp)
80100e5d:	e8 8e 6f 00 00       	call   80107df0 <freevm>
    return 0;
80100e62:	83 c4 10             	add    $0x10,%esp
80100e65:	31 c0                	xor    %eax,%eax
80100e67:	e9 25 fe ff ff       	jmp    80100c91 <exec+0x281>
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
80100e6c:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e71:	e9 3f fe ff ff       	jmp    80100cb5 <exec+0x2a5>
    for (argc = 0; argv[argc]; argc++) {
80100e76:	be 10 00 00 00       	mov    $0x10,%esi
80100e7b:	b9 04 00 00 00       	mov    $0x4,%ecx
80100e80:	b8 03 00 00 00       	mov    $0x3,%eax
80100e85:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e8c:	00 00 00 
80100e8f:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100e95:	e9 06 ff ff ff       	jmp    80100da0 <exec+0x390>
        end_op();
80100e9a:	e8 e1 1e 00 00       	call   80102d80 <end_op>
        cprintf("exec: fail\n");
80100e9f:	83 ec 0c             	sub    $0xc,%esp
80100ea2:	68 a1 81 10 80       	push   $0x801081a1
80100ea7:	e8 b4 f7 ff ff       	call   80100660 <cprintf>
        return -1;
80100eac:	83 c4 10             	add    $0x10,%esp
80100eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100eb4:	e9 d8 fd ff ff       	jmp    80100c91 <exec+0x281>
80100eb9:	66 90                	xchg   %ax,%ax
80100ebb:	66 90                	xchg   %ax,%ax
80100ebd:	66 90                	xchg   %ax,%ax
80100ebf:	90                   	nop

80100ec0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ec6:	68 ad 81 10 80       	push   $0x801081ad
80100ecb:	68 c0 0f 11 80       	push   $0x80110fc0
80100ed0:	e8 2b 43 00 00       	call   80105200 <initlock>
}
80100ed5:	83 c4 10             	add    $0x10,%esp
80100ed8:	c9                   	leave  
80100ed9:	c3                   	ret    
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ee0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ee4:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
{
80100ee9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100eec:	68 c0 0f 11 80       	push   $0x80110fc0
80100ef1:	e8 4a 44 00 00       	call   80105340 <acquire>
80100ef6:	83 c4 10             	add    $0x10,%esp
80100ef9:	eb 10                	jmp    80100f0b <filealloc+0x2b>
80100efb:	90                   	nop
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f00:	83 c3 18             	add    $0x18,%ebx
80100f03:	81 fb 54 19 11 80    	cmp    $0x80111954,%ebx
80100f09:	73 25                	jae    80100f30 <filealloc+0x50>
    if(f->ref == 0){
80100f0b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f0e:	85 c0                	test   %eax,%eax
80100f10:	75 ee                	jne    80100f00 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f12:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f15:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f1c:	68 c0 0f 11 80       	push   $0x80110fc0
80100f21:	e8 da 44 00 00       	call   80105400 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f26:	89 d8                	mov    %ebx,%eax
      return f;
80100f28:	83 c4 10             	add    $0x10,%esp
}
80100f2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f2e:	c9                   	leave  
80100f2f:	c3                   	ret    
  release(&ftable.lock);
80100f30:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f33:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f35:	68 c0 0f 11 80       	push   $0x80110fc0
80100f3a:	e8 c1 44 00 00       	call   80105400 <release>
}
80100f3f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f41:	83 c4 10             	add    $0x10,%esp
}
80100f44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f47:	c9                   	leave  
80100f48:	c3                   	ret    
80100f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 10             	sub    $0x10,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f5a:	68 c0 0f 11 80       	push   $0x80110fc0
80100f5f:	e8 dc 43 00 00       	call   80105340 <acquire>
  if(f->ref < 1)
80100f64:	8b 43 04             	mov    0x4(%ebx),%eax
80100f67:	83 c4 10             	add    $0x10,%esp
80100f6a:	85 c0                	test   %eax,%eax
80100f6c:	7e 1a                	jle    80100f88 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f6e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f71:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f74:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f77:	68 c0 0f 11 80       	push   $0x80110fc0
80100f7c:	e8 7f 44 00 00       	call   80105400 <release>
  return f;
}
80100f81:	89 d8                	mov    %ebx,%eax
80100f83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f86:	c9                   	leave  
80100f87:	c3                   	ret    
    panic("filedup");
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	68 b4 81 10 80       	push   $0x801081b4
80100f90:	e8 fb f3 ff ff       	call   80100390 <panic>
80100f95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fa0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 28             	sub    $0x28,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100fac:	68 c0 0f 11 80       	push   $0x80110fc0
80100fb1:	e8 8a 43 00 00       	call   80105340 <acquire>
  if(f->ref < 1)
80100fb6:	8b 43 04             	mov    0x4(%ebx),%eax
80100fb9:	83 c4 10             	add    $0x10,%esp
80100fbc:	85 c0                	test   %eax,%eax
80100fbe:	0f 8e 9b 00 00 00    	jle    8010105f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100fc4:	83 e8 01             	sub    $0x1,%eax
80100fc7:	85 c0                	test   %eax,%eax
80100fc9:	89 43 04             	mov    %eax,0x4(%ebx)
80100fcc:	74 1a                	je     80100fe8 <fileclose+0x48>
    release(&ftable.lock);
80100fce:	c7 45 08 c0 0f 11 80 	movl   $0x80110fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd8:	5b                   	pop    %ebx
80100fd9:	5e                   	pop    %esi
80100fda:	5f                   	pop    %edi
80100fdb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fdc:	e9 1f 44 00 00       	jmp    80105400 <release>
80100fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100fe8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100fec:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100fee:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ff1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ff4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100ffa:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ffd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101000:	68 c0 0f 11 80       	push   $0x80110fc0
  ff = *f;
80101005:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101008:	e8 f3 43 00 00       	call   80105400 <release>
  if(ff.type == FD_PIPE)
8010100d:	83 c4 10             	add    $0x10,%esp
80101010:	83 ff 01             	cmp    $0x1,%edi
80101013:	74 13                	je     80101028 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80101015:	83 ff 02             	cmp    $0x2,%edi
80101018:	74 26                	je     80101040 <fileclose+0xa0>
}
8010101a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010101d:	5b                   	pop    %ebx
8010101e:	5e                   	pop    %esi
8010101f:	5f                   	pop    %edi
80101020:	5d                   	pop    %ebp
80101021:	c3                   	ret    
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101028:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010102c:	83 ec 08             	sub    $0x8,%esp
8010102f:	53                   	push   %ebx
80101030:	56                   	push   %esi
80101031:	e8 8a 24 00 00       	call   801034c0 <pipeclose>
80101036:	83 c4 10             	add    $0x10,%esp
80101039:	eb df                	jmp    8010101a <fileclose+0x7a>
8010103b:	90                   	nop
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80101040:	e8 cb 1c 00 00       	call   80102d10 <begin_op>
    iput(ff.ip);
80101045:	83 ec 0c             	sub    $0xc,%esp
80101048:	ff 75 e0             	pushl  -0x20(%ebp)
8010104b:	e8 d0 08 00 00       	call   80101920 <iput>
    end_op();
80101050:	83 c4 10             	add    $0x10,%esp
}
80101053:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101056:	5b                   	pop    %ebx
80101057:	5e                   	pop    %esi
80101058:	5f                   	pop    %edi
80101059:	5d                   	pop    %ebp
    end_op();
8010105a:	e9 21 1d 00 00       	jmp    80102d80 <end_op>
    panic("fileclose");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 bc 81 10 80       	push   $0x801081bc
80101067:	e8 24 f3 ff ff       	call   80100390 <panic>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101070 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	53                   	push   %ebx
80101074:	83 ec 04             	sub    $0x4,%esp
80101077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010107a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010107d:	75 31                	jne    801010b0 <filestat+0x40>
    ilock(f->ip);
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	ff 73 10             	pushl  0x10(%ebx)
80101085:	e8 66 07 00 00       	call   801017f0 <ilock>
    stati(f->ip, st);
8010108a:	58                   	pop    %eax
8010108b:	5a                   	pop    %edx
8010108c:	ff 75 0c             	pushl  0xc(%ebp)
8010108f:	ff 73 10             	pushl  0x10(%ebx)
80101092:	e8 09 0a 00 00       	call   80101aa0 <stati>
    iunlock(f->ip);
80101097:	59                   	pop    %ecx
80101098:	ff 73 10             	pushl  0x10(%ebx)
8010109b:	e8 30 08 00 00       	call   801018d0 <iunlock>
    return 0;
801010a0:	83 c4 10             	add    $0x10,%esp
801010a3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
801010a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010a8:	c9                   	leave  
801010a9:	c3                   	ret    
801010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
801010b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010b5:	eb ee                	jmp    801010a5 <filestat+0x35>
801010b7:	89 f6                	mov    %esi,%esi
801010b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801010c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	57                   	push   %edi
801010c4:	56                   	push   %esi
801010c5:	53                   	push   %ebx
801010c6:	83 ec 0c             	sub    $0xc,%esp
801010c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801010cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010d6:	74 60                	je     80101138 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010d8:	8b 03                	mov    (%ebx),%eax
801010da:	83 f8 01             	cmp    $0x1,%eax
801010dd:	74 41                	je     80101120 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010df:	83 f8 02             	cmp    $0x2,%eax
801010e2:	75 5b                	jne    8010113f <fileread+0x7f>
    ilock(f->ip);
801010e4:	83 ec 0c             	sub    $0xc,%esp
801010e7:	ff 73 10             	pushl  0x10(%ebx)
801010ea:	e8 01 07 00 00       	call   801017f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010ef:	57                   	push   %edi
801010f0:	ff 73 14             	pushl  0x14(%ebx)
801010f3:	56                   	push   %esi
801010f4:	ff 73 10             	pushl  0x10(%ebx)
801010f7:	e8 d4 09 00 00       	call   80101ad0 <readi>
801010fc:	83 c4 20             	add    $0x20,%esp
801010ff:	85 c0                	test   %eax,%eax
80101101:	89 c6                	mov    %eax,%esi
80101103:	7e 03                	jle    80101108 <fileread+0x48>
      f->off += r;
80101105:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101108:	83 ec 0c             	sub    $0xc,%esp
8010110b:	ff 73 10             	pushl  0x10(%ebx)
8010110e:	e8 bd 07 00 00       	call   801018d0 <iunlock>
    return r;
80101113:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	89 f0                	mov    %esi,%eax
8010111b:	5b                   	pop    %ebx
8010111c:	5e                   	pop    %esi
8010111d:	5f                   	pop    %edi
8010111e:	5d                   	pop    %ebp
8010111f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101120:	8b 43 0c             	mov    0xc(%ebx),%eax
80101123:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	5b                   	pop    %ebx
8010112a:	5e                   	pop    %esi
8010112b:	5f                   	pop    %edi
8010112c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010112d:	e9 3e 25 00 00       	jmp    80103670 <piperead>
80101132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101138:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010113d:	eb d7                	jmp    80101116 <fileread+0x56>
  panic("fileread");
8010113f:	83 ec 0c             	sub    $0xc,%esp
80101142:	68 c6 81 10 80       	push   $0x801081c6
80101147:	e8 44 f2 ff ff       	call   80100390 <panic>
8010114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101150 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 1c             	sub    $0x1c,%esp
80101159:	8b 75 08             	mov    0x8(%ebp),%esi
8010115c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010115f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101163:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101166:	8b 45 10             	mov    0x10(%ebp),%eax
80101169:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010116c:	0f 84 aa 00 00 00    	je     8010121c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101172:	8b 06                	mov    (%esi),%eax
80101174:	83 f8 01             	cmp    $0x1,%eax
80101177:	0f 84 c3 00 00 00    	je     80101240 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010117d:	83 f8 02             	cmp    $0x2,%eax
80101180:	0f 85 d9 00 00 00    	jne    8010125f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101186:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101189:	31 ff                	xor    %edi,%edi
    while(i < n){
8010118b:	85 c0                	test   %eax,%eax
8010118d:	7f 34                	jg     801011c3 <filewrite+0x73>
8010118f:	e9 9c 00 00 00       	jmp    80101230 <filewrite+0xe0>
80101194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101198:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010119b:	83 ec 0c             	sub    $0xc,%esp
8010119e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801011a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011a4:	e8 27 07 00 00       	call   801018d0 <iunlock>
      end_op();
801011a9:	e8 d2 1b 00 00       	call   80102d80 <end_op>
801011ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011b1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801011b4:	39 c3                	cmp    %eax,%ebx
801011b6:	0f 85 96 00 00 00    	jne    80101252 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801011bc:	01 df                	add    %ebx,%edi
    while(i < n){
801011be:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011c1:	7e 6d                	jle    80101230 <filewrite+0xe0>
      int n1 = n - i;
801011c3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011c6:	b8 00 06 00 00       	mov    $0x600,%eax
801011cb:	29 fb                	sub    %edi,%ebx
801011cd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801011d3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011d6:	e8 35 1b 00 00       	call   80102d10 <begin_op>
      ilock(f->ip);
801011db:	83 ec 0c             	sub    $0xc,%esp
801011de:	ff 76 10             	pushl  0x10(%esi)
801011e1:	e8 0a 06 00 00       	call   801017f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e9:	53                   	push   %ebx
801011ea:	ff 76 14             	pushl  0x14(%esi)
801011ed:	01 f8                	add    %edi,%eax
801011ef:	50                   	push   %eax
801011f0:	ff 76 10             	pushl  0x10(%esi)
801011f3:	e8 d8 09 00 00       	call   80101bd0 <writei>
801011f8:	83 c4 20             	add    $0x20,%esp
801011fb:	85 c0                	test   %eax,%eax
801011fd:	7f 99                	jg     80101198 <filewrite+0x48>
      iunlock(f->ip);
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	ff 76 10             	pushl  0x10(%esi)
80101205:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101208:	e8 c3 06 00 00       	call   801018d0 <iunlock>
      end_op();
8010120d:	e8 6e 1b 00 00       	call   80102d80 <end_op>
      if(r < 0)
80101212:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101215:	83 c4 10             	add    $0x10,%esp
80101218:	85 c0                	test   %eax,%eax
8010121a:	74 98                	je     801011b4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010121c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010121f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101224:	89 f8                	mov    %edi,%eax
80101226:	5b                   	pop    %ebx
80101227:	5e                   	pop    %esi
80101228:	5f                   	pop    %edi
80101229:	5d                   	pop    %ebp
8010122a:	c3                   	ret    
8010122b:	90                   	nop
8010122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101230:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101233:	75 e7                	jne    8010121c <filewrite+0xcc>
}
80101235:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101238:	89 f8                	mov    %edi,%eax
8010123a:	5b                   	pop    %ebx
8010123b:	5e                   	pop    %esi
8010123c:	5f                   	pop    %edi
8010123d:	5d                   	pop    %ebp
8010123e:	c3                   	ret    
8010123f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101240:	8b 46 0c             	mov    0xc(%esi),%eax
80101243:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101246:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101249:	5b                   	pop    %ebx
8010124a:	5e                   	pop    %esi
8010124b:	5f                   	pop    %edi
8010124c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010124d:	e9 0e 23 00 00       	jmp    80103560 <pipewrite>
        panic("short filewrite");
80101252:	83 ec 0c             	sub    $0xc,%esp
80101255:	68 cf 81 10 80       	push   $0x801081cf
8010125a:	e8 31 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010125f:	83 ec 0c             	sub    $0xc,%esp
80101262:	68 d5 81 10 80       	push   $0x801081d5
80101267:	e8 24 f1 ff ff       	call   80100390 <panic>
8010126c:	66 90                	xchg   %ax,%ax
8010126e:	66 90                	xchg   %ax,%ax

80101270 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	57                   	push   %edi
80101274:	56                   	push   %esi
80101275:	53                   	push   %ebx
80101276:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101279:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
{
8010127f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101282:	85 c9                	test   %ecx,%ecx
80101284:	0f 84 87 00 00 00    	je     80101311 <balloc+0xa1>
8010128a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101291:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101294:	83 ec 08             	sub    $0x8,%esp
80101297:	89 f0                	mov    %esi,%eax
80101299:	c1 f8 0c             	sar    $0xc,%eax
8010129c:	03 05 d8 19 11 80    	add    0x801119d8,%eax
801012a2:	50                   	push   %eax
801012a3:	ff 75 d8             	pushl  -0x28(%ebp)
801012a6:	e8 25 ee ff ff       	call   801000d0 <bread>
801012ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ae:	a1 c0 19 11 80       	mov    0x801119c0,%eax
801012b3:	83 c4 10             	add    $0x10,%esp
801012b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012b9:	31 c0                	xor    %eax,%eax
801012bb:	eb 2f                	jmp    801012ec <balloc+0x7c>
801012bd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012c0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801012c5:	bb 01 00 00 00       	mov    $0x1,%ebx
801012ca:	83 e1 07             	and    $0x7,%ecx
801012cd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012cf:	89 c1                	mov    %eax,%ecx
801012d1:	c1 f9 03             	sar    $0x3,%ecx
801012d4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012d9:	85 df                	test   %ebx,%edi
801012db:	89 fa                	mov    %edi,%edx
801012dd:	74 41                	je     80101320 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012df:	83 c0 01             	add    $0x1,%eax
801012e2:	83 c6 01             	add    $0x1,%esi
801012e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ea:	74 05                	je     801012f1 <balloc+0x81>
801012ec:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012ef:	77 cf                	ja     801012c0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801012f1:	83 ec 0c             	sub    $0xc,%esp
801012f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801012f7:	e8 e4 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012fc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101303:	83 c4 10             	add    $0x10,%esp
80101306:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101309:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010130f:	77 80                	ja     80101291 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101311:	83 ec 0c             	sub    $0xc,%esp
80101314:	68 df 81 10 80       	push   $0x801081df
80101319:	e8 72 f0 ff ff       	call   80100390 <panic>
8010131e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101320:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101323:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101326:	09 da                	or     %ebx,%edx
80101328:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010132c:	57                   	push   %edi
8010132d:	e8 ae 1b 00 00       	call   80102ee0 <log_write>
        brelse(bp);
80101332:	89 3c 24             	mov    %edi,(%esp)
80101335:	e8 a6 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010133a:	58                   	pop    %eax
8010133b:	5a                   	pop    %edx
8010133c:	56                   	push   %esi
8010133d:	ff 75 d8             	pushl  -0x28(%ebp)
80101340:	e8 8b ed ff ff       	call   801000d0 <bread>
80101345:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101347:	8d 40 5c             	lea    0x5c(%eax),%eax
8010134a:	83 c4 0c             	add    $0xc,%esp
8010134d:	68 00 02 00 00       	push   $0x200
80101352:	6a 00                	push   $0x0
80101354:	50                   	push   %eax
80101355:	e8 f6 40 00 00       	call   80105450 <memset>
  log_write(bp);
8010135a:	89 1c 24             	mov    %ebx,(%esp)
8010135d:	e8 7e 1b 00 00       	call   80102ee0 <log_write>
  brelse(bp);
80101362:	89 1c 24             	mov    %ebx,(%esp)
80101365:	e8 76 ee ff ff       	call   801001e0 <brelse>
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	89 f0                	mov    %esi,%eax
8010136f:	5b                   	pop    %ebx
80101370:	5e                   	pop    %esi
80101371:	5f                   	pop    %edi
80101372:	5d                   	pop    %ebp
80101373:	c3                   	ret    
80101374:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010137a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101380 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101380:	55                   	push   %ebp
80101381:	89 e5                	mov    %esp,%ebp
80101383:	57                   	push   %edi
80101384:	56                   	push   %esi
80101385:	53                   	push   %ebx
80101386:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101388:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010138a:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
{
8010138f:	83 ec 28             	sub    $0x28,%esp
80101392:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101395:	68 e0 19 11 80       	push   $0x801119e0
8010139a:	e8 a1 3f 00 00       	call   80105340 <acquire>
8010139f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013a5:	eb 17                	jmp    801013be <iget+0x3e>
801013a7:	89 f6                	mov    %esi,%esi
801013a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801013b0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013b6:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
801013bc:	73 22                	jae    801013e0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013be:	8b 4b 08             	mov    0x8(%ebx),%ecx
801013c1:	85 c9                	test   %ecx,%ecx
801013c3:	7e 04                	jle    801013c9 <iget+0x49>
801013c5:	39 3b                	cmp    %edi,(%ebx)
801013c7:	74 4f                	je     80101418 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013c9:	85 f6                	test   %esi,%esi
801013cb:	75 e3                	jne    801013b0 <iget+0x30>
801013cd:	85 c9                	test   %ecx,%ecx
801013cf:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013d2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013d8:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
801013de:	72 de                	jb     801013be <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013e0:	85 f6                	test   %esi,%esi
801013e2:	74 5b                	je     8010143f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013e4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013e7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013e9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013ec:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013f3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013fa:	68 e0 19 11 80       	push   $0x801119e0
801013ff:	e8 fc 3f 00 00       	call   80105400 <release>

  return ip;
80101404:	83 c4 10             	add    $0x10,%esp
}
80101407:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010140a:	89 f0                	mov    %esi,%eax
8010140c:	5b                   	pop    %ebx
8010140d:	5e                   	pop    %esi
8010140e:	5f                   	pop    %edi
8010140f:	5d                   	pop    %ebp
80101410:	c3                   	ret    
80101411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101418:	39 53 04             	cmp    %edx,0x4(%ebx)
8010141b:	75 ac                	jne    801013c9 <iget+0x49>
      release(&icache.lock);
8010141d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101420:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101423:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101425:	68 e0 19 11 80       	push   $0x801119e0
      ip->ref++;
8010142a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010142d:	e8 ce 3f 00 00       	call   80105400 <release>
      return ip;
80101432:	83 c4 10             	add    $0x10,%esp
}
80101435:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101438:	89 f0                	mov    %esi,%eax
8010143a:	5b                   	pop    %ebx
8010143b:	5e                   	pop    %esi
8010143c:	5f                   	pop    %edi
8010143d:	5d                   	pop    %ebp
8010143e:	c3                   	ret    
    panic("iget: no inodes");
8010143f:	83 ec 0c             	sub    $0xc,%esp
80101442:	68 f5 81 10 80       	push   $0x801081f5
80101447:	e8 44 ef ff ff       	call   80100390 <panic>
8010144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	53                   	push   %ebx
80101456:	89 c6                	mov    %eax,%esi
80101458:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	77 18                	ja     80101478 <bmap+0x28>
80101460:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101463:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101466:	85 db                	test   %ebx,%ebx
80101468:	74 76                	je     801014e0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010146a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010146d:	89 d8                	mov    %ebx,%eax
8010146f:	5b                   	pop    %ebx
80101470:	5e                   	pop    %esi
80101471:	5f                   	pop    %edi
80101472:	5d                   	pop    %ebp
80101473:	c3                   	ret    
80101474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101478:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010147b:	83 fb 7f             	cmp    $0x7f,%ebx
8010147e:	0f 87 90 00 00 00    	ja     80101514 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101484:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010148a:	8b 00                	mov    (%eax),%eax
8010148c:	85 d2                	test   %edx,%edx
8010148e:	74 70                	je     80101500 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	52                   	push   %edx
80101494:	50                   	push   %eax
80101495:	e8 36 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010149a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010149e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801014a1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801014a3:	8b 1a                	mov    (%edx),%ebx
801014a5:	85 db                	test   %ebx,%ebx
801014a7:	75 1d                	jne    801014c6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801014a9:	8b 06                	mov    (%esi),%eax
801014ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014ae:	e8 bd fd ff ff       	call   80101270 <balloc>
801014b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801014b6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014b9:	89 c3                	mov    %eax,%ebx
801014bb:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801014bd:	57                   	push   %edi
801014be:	e8 1d 1a 00 00       	call   80102ee0 <log_write>
801014c3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801014c6:	83 ec 0c             	sub    $0xc,%esp
801014c9:	57                   	push   %edi
801014ca:	e8 11 ed ff ff       	call   801001e0 <brelse>
801014cf:	83 c4 10             	add    $0x10,%esp
}
801014d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014d5:	89 d8                	mov    %ebx,%eax
801014d7:	5b                   	pop    %ebx
801014d8:	5e                   	pop    %esi
801014d9:	5f                   	pop    %edi
801014da:	5d                   	pop    %ebp
801014db:	c3                   	ret    
801014dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801014e0:	8b 00                	mov    (%eax),%eax
801014e2:	e8 89 fd ff ff       	call   80101270 <balloc>
801014e7:	89 47 5c             	mov    %eax,0x5c(%edi)
}
801014ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801014ed:	89 c3                	mov    %eax,%ebx
}
801014ef:	89 d8                	mov    %ebx,%eax
801014f1:	5b                   	pop    %ebx
801014f2:	5e                   	pop    %esi
801014f3:	5f                   	pop    %edi
801014f4:	5d                   	pop    %ebp
801014f5:	c3                   	ret    
801014f6:	8d 76 00             	lea    0x0(%esi),%esi
801014f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101500:	e8 6b fd ff ff       	call   80101270 <balloc>
80101505:	89 c2                	mov    %eax,%edx
80101507:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010150d:	8b 06                	mov    (%esi),%eax
8010150f:	e9 7c ff ff ff       	jmp    80101490 <bmap+0x40>
  panic("bmap: out of range");
80101514:	83 ec 0c             	sub    $0xc,%esp
80101517:	68 05 82 10 80       	push   $0x80108205
8010151c:	e8 6f ee ff ff       	call   80100390 <panic>
80101521:	eb 0d                	jmp    80101530 <readsb>
80101523:	90                   	nop
80101524:	90                   	nop
80101525:	90                   	nop
80101526:	90                   	nop
80101527:	90                   	nop
80101528:	90                   	nop
80101529:	90                   	nop
8010152a:	90                   	nop
8010152b:	90                   	nop
8010152c:	90                   	nop
8010152d:	90                   	nop
8010152e:	90                   	nop
8010152f:	90                   	nop

80101530 <readsb>:
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	56                   	push   %esi
80101534:	53                   	push   %ebx
80101535:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101538:	83 ec 08             	sub    $0x8,%esp
8010153b:	6a 01                	push   $0x1
8010153d:	ff 75 08             	pushl  0x8(%ebp)
80101540:	e8 8b eb ff ff       	call   801000d0 <bread>
80101545:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101547:	8d 40 5c             	lea    0x5c(%eax),%eax
8010154a:	83 c4 0c             	add    $0xc,%esp
8010154d:	6a 1c                	push   $0x1c
8010154f:	50                   	push   %eax
80101550:	56                   	push   %esi
80101551:	e8 aa 3f 00 00       	call   80105500 <memmove>
  brelse(bp);
80101556:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101559:	83 c4 10             	add    $0x10,%esp
}
8010155c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010155f:	5b                   	pop    %ebx
80101560:	5e                   	pop    %esi
80101561:	5d                   	pop    %ebp
  brelse(bp);
80101562:	e9 79 ec ff ff       	jmp    801001e0 <brelse>
80101567:	89 f6                	mov    %esi,%esi
80101569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101570 <bfree>:
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	56                   	push   %esi
80101574:	53                   	push   %ebx
80101575:	89 d3                	mov    %edx,%ebx
80101577:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101579:	83 ec 08             	sub    $0x8,%esp
8010157c:	68 c0 19 11 80       	push   $0x801119c0
80101581:	50                   	push   %eax
80101582:	e8 a9 ff ff ff       	call   80101530 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101587:	58                   	pop    %eax
80101588:	5a                   	pop    %edx
80101589:	89 da                	mov    %ebx,%edx
8010158b:	c1 ea 0c             	shr    $0xc,%edx
8010158e:	03 15 d8 19 11 80    	add    0x801119d8,%edx
80101594:	52                   	push   %edx
80101595:	56                   	push   %esi
80101596:	e8 35 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010159b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010159d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801015a0:	ba 01 00 00 00       	mov    $0x1,%edx
801015a5:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801015a8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801015ae:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801015b1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801015b3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801015b8:	85 d1                	test   %edx,%ecx
801015ba:	74 25                	je     801015e1 <bfree+0x71>
  bp->data[bi/8] &= ~m;
801015bc:	f7 d2                	not    %edx
801015be:	89 c6                	mov    %eax,%esi
  log_write(bp);
801015c0:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801015c3:	21 ca                	and    %ecx,%edx
801015c5:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801015c9:	56                   	push   %esi
801015ca:	e8 11 19 00 00       	call   80102ee0 <log_write>
  brelse(bp);
801015cf:	89 34 24             	mov    %esi,(%esp)
801015d2:	e8 09 ec ff ff       	call   801001e0 <brelse>
}
801015d7:	83 c4 10             	add    $0x10,%esp
801015da:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015dd:	5b                   	pop    %ebx
801015de:	5e                   	pop    %esi
801015df:	5d                   	pop    %ebp
801015e0:	c3                   	ret    
    panic("freeing free block");
801015e1:	83 ec 0c             	sub    $0xc,%esp
801015e4:	68 18 82 10 80       	push   $0x80108218
801015e9:	e8 a2 ed ff ff       	call   80100390 <panic>
801015ee:	66 90                	xchg   %ax,%ax

801015f0 <iinit>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	53                   	push   %ebx
801015f4:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
801015f9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015fc:	68 2b 82 10 80       	push   $0x8010822b
80101601:	68 e0 19 11 80       	push   $0x801119e0
80101606:	e8 f5 3b 00 00       	call   80105200 <initlock>
8010160b:	83 c4 10             	add    $0x10,%esp
8010160e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101610:	83 ec 08             	sub    $0x8,%esp
80101613:	68 32 82 10 80       	push   $0x80108232
80101618:	53                   	push   %ebx
80101619:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010161f:	e8 ac 3a 00 00       	call   801050d0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101624:	83 c4 10             	add    $0x10,%esp
80101627:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
8010162d:	75 e1                	jne    80101610 <iinit+0x20>
  readsb(dev, &sb);
8010162f:	83 ec 08             	sub    $0x8,%esp
80101632:	68 c0 19 11 80       	push   $0x801119c0
80101637:	ff 75 08             	pushl  0x8(%ebp)
8010163a:	e8 f1 fe ff ff       	call   80101530 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010163f:	ff 35 d8 19 11 80    	pushl  0x801119d8
80101645:	ff 35 d4 19 11 80    	pushl  0x801119d4
8010164b:	ff 35 d0 19 11 80    	pushl  0x801119d0
80101651:	ff 35 cc 19 11 80    	pushl  0x801119cc
80101657:	ff 35 c8 19 11 80    	pushl  0x801119c8
8010165d:	ff 35 c4 19 11 80    	pushl  0x801119c4
80101663:	ff 35 c0 19 11 80    	pushl  0x801119c0
80101669:	68 98 82 10 80       	push   $0x80108298
8010166e:	e8 ed ef ff ff       	call   80100660 <cprintf>
}
80101673:	83 c4 30             	add    $0x30,%esp
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ialloc>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101689:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
{
80101690:	8b 45 0c             	mov    0xc(%ebp),%eax
80101693:	8b 75 08             	mov    0x8(%ebp),%esi
80101696:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101699:	0f 86 91 00 00 00    	jbe    80101730 <ialloc+0xb0>
8010169f:	bb 01 00 00 00       	mov    $0x1,%ebx
801016a4:	eb 21                	jmp    801016c7 <ialloc+0x47>
801016a6:	8d 76 00             	lea    0x0(%esi),%esi
801016a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801016b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016b3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801016b6:	57                   	push   %edi
801016b7:	e8 24 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016bc:	83 c4 10             	add    $0x10,%esp
801016bf:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
801016c5:	76 69                	jbe    80101730 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016c7:	89 d8                	mov    %ebx,%eax
801016c9:	83 ec 08             	sub    $0x8,%esp
801016cc:	c1 e8 03             	shr    $0x3,%eax
801016cf:	03 05 d4 19 11 80    	add    0x801119d4,%eax
801016d5:	50                   	push   %eax
801016d6:	56                   	push   %esi
801016d7:	e8 f4 e9 ff ff       	call   801000d0 <bread>
801016dc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801016de:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801016e0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801016e3:	83 e0 07             	and    $0x7,%eax
801016e6:	c1 e0 06             	shl    $0x6,%eax
801016e9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016f1:	75 bd                	jne    801016b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016f3:	83 ec 04             	sub    $0x4,%esp
801016f6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016f9:	6a 40                	push   $0x40
801016fb:	6a 00                	push   $0x0
801016fd:	51                   	push   %ecx
801016fe:	e8 4d 3d 00 00       	call   80105450 <memset>
      dip->type = type;
80101703:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101707:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010170a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010170d:	89 3c 24             	mov    %edi,(%esp)
80101710:	e8 cb 17 00 00       	call   80102ee0 <log_write>
      brelse(bp);
80101715:	89 3c 24             	mov    %edi,(%esp)
80101718:	e8 c3 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010171d:	83 c4 10             	add    $0x10,%esp
}
80101720:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101723:	89 da                	mov    %ebx,%edx
80101725:	89 f0                	mov    %esi,%eax
}
80101727:	5b                   	pop    %ebx
80101728:	5e                   	pop    %esi
80101729:	5f                   	pop    %edi
8010172a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010172b:	e9 50 fc ff ff       	jmp    80101380 <iget>
  panic("ialloc: no inodes");
80101730:	83 ec 0c             	sub    $0xc,%esp
80101733:	68 38 82 10 80       	push   $0x80108238
80101738:	e8 53 ec ff ff       	call   80100390 <panic>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi

80101740 <iupdate>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101748:	83 ec 08             	sub    $0x8,%esp
8010174b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010174e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101751:	c1 e8 03             	shr    $0x3,%eax
80101754:	03 05 d4 19 11 80    	add    0x801119d4,%eax
8010175a:	50                   	push   %eax
8010175b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010175e:	e8 6d e9 ff ff       	call   801000d0 <bread>
80101763:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101765:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101768:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010176c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010176f:	83 e0 07             	and    $0x7,%eax
80101772:	c1 e0 06             	shl    $0x6,%eax
80101775:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101779:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010177c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101780:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101783:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101787:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010178b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010178f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101793:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101797:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010179a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179d:	6a 34                	push   $0x34
8010179f:	53                   	push   %ebx
801017a0:	50                   	push   %eax
801017a1:	e8 5a 3d 00 00       	call   80105500 <memmove>
  log_write(bp);
801017a6:	89 34 24             	mov    %esi,(%esp)
801017a9:	e8 32 17 00 00       	call   80102ee0 <log_write>
  brelse(bp);
801017ae:	89 75 08             	mov    %esi,0x8(%ebp)
801017b1:	83 c4 10             	add    $0x10,%esp
}
801017b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b7:	5b                   	pop    %ebx
801017b8:	5e                   	pop    %esi
801017b9:	5d                   	pop    %ebp
  brelse(bp);
801017ba:	e9 21 ea ff ff       	jmp    801001e0 <brelse>
801017bf:	90                   	nop

801017c0 <idup>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	53                   	push   %ebx
801017c4:	83 ec 10             	sub    $0x10,%esp
801017c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017ca:	68 e0 19 11 80       	push   $0x801119e0
801017cf:	e8 6c 3b 00 00       	call   80105340 <acquire>
  ip->ref++;
801017d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017d8:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801017df:	e8 1c 3c 00 00       	call   80105400 <release>
}
801017e4:	89 d8                	mov    %ebx,%eax
801017e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017e9:	c9                   	leave  
801017ea:	c3                   	ret    
801017eb:	90                   	nop
801017ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017f0 <ilock>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017f8:	85 db                	test   %ebx,%ebx
801017fa:	0f 84 b7 00 00 00    	je     801018b7 <ilock+0xc7>
80101800:	8b 53 08             	mov    0x8(%ebx),%edx
80101803:	85 d2                	test   %edx,%edx
80101805:	0f 8e ac 00 00 00    	jle    801018b7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010180b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010180e:	83 ec 0c             	sub    $0xc,%esp
80101811:	50                   	push   %eax
80101812:	e8 f9 38 00 00       	call   80105110 <acquiresleep>
  if(ip->valid == 0){
80101817:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010181a:	83 c4 10             	add    $0x10,%esp
8010181d:	85 c0                	test   %eax,%eax
8010181f:	74 0f                	je     80101830 <ilock+0x40>
}
80101821:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101824:	5b                   	pop    %ebx
80101825:	5e                   	pop    %esi
80101826:	5d                   	pop    %ebp
80101827:	c3                   	ret    
80101828:	90                   	nop
80101829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101830:	8b 43 04             	mov    0x4(%ebx),%eax
80101833:	83 ec 08             	sub    $0x8,%esp
80101836:	c1 e8 03             	shr    $0x3,%eax
80101839:	03 05 d4 19 11 80    	add    0x801119d4,%eax
8010183f:	50                   	push   %eax
80101840:	ff 33                	pushl  (%ebx)
80101842:	e8 89 e8 ff ff       	call   801000d0 <bread>
80101847:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101849:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010184c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010184f:	83 e0 07             	and    $0x7,%eax
80101852:	c1 e0 06             	shl    $0x6,%eax
80101855:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101859:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010185c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010185f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101863:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101867:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010186b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010186f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101873:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101877:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010187b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010187e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101881:	6a 34                	push   $0x34
80101883:	50                   	push   %eax
80101884:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101887:	50                   	push   %eax
80101888:	e8 73 3c 00 00       	call   80105500 <memmove>
    brelse(bp);
8010188d:	89 34 24             	mov    %esi,(%esp)
80101890:	e8 4b e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101895:	83 c4 10             	add    $0x10,%esp
80101898:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010189d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018a4:	0f 85 77 ff ff ff    	jne    80101821 <ilock+0x31>
      panic("ilock: no type");
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	68 50 82 10 80       	push   $0x80108250
801018b2:	e8 d9 ea ff ff       	call   80100390 <panic>
    panic("ilock");
801018b7:	83 ec 0c             	sub    $0xc,%esp
801018ba:	68 4a 82 10 80       	push   $0x8010824a
801018bf:	e8 cc ea ff ff       	call   80100390 <panic>
801018c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801018ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801018d0 <iunlock>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	74 28                	je     80101904 <iunlock+0x34>
801018dc:	8d 73 0c             	lea    0xc(%ebx),%esi
801018df:	83 ec 0c             	sub    $0xc,%esp
801018e2:	56                   	push   %esi
801018e3:	e8 c8 38 00 00       	call   801051b0 <holdingsleep>
801018e8:	83 c4 10             	add    $0x10,%esp
801018eb:	85 c0                	test   %eax,%eax
801018ed:	74 15                	je     80101904 <iunlock+0x34>
801018ef:	8b 43 08             	mov    0x8(%ebx),%eax
801018f2:	85 c0                	test   %eax,%eax
801018f4:	7e 0e                	jle    80101904 <iunlock+0x34>
  releasesleep(&ip->lock);
801018f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018ff:	e9 6c 38 00 00       	jmp    80105170 <releasesleep>
    panic("iunlock");
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 5f 82 10 80       	push   $0x8010825f
8010190c:	e8 7f ea ff ff       	call   80100390 <panic>
80101911:	eb 0d                	jmp    80101920 <iput>
80101913:	90                   	nop
80101914:	90                   	nop
80101915:	90                   	nop
80101916:	90                   	nop
80101917:	90                   	nop
80101918:	90                   	nop
80101919:	90                   	nop
8010191a:	90                   	nop
8010191b:	90                   	nop
8010191c:	90                   	nop
8010191d:	90                   	nop
8010191e:	90                   	nop
8010191f:	90                   	nop

80101920 <iput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 28             	sub    $0x28,%esp
80101929:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010192c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010192f:	57                   	push   %edi
80101930:	e8 db 37 00 00       	call   80105110 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101935:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101938:	83 c4 10             	add    $0x10,%esp
8010193b:	85 d2                	test   %edx,%edx
8010193d:	74 07                	je     80101946 <iput+0x26>
8010193f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101944:	74 32                	je     80101978 <iput+0x58>
  releasesleep(&ip->lock);
80101946:	83 ec 0c             	sub    $0xc,%esp
80101949:	57                   	push   %edi
8010194a:	e8 21 38 00 00       	call   80105170 <releasesleep>
  acquire(&icache.lock);
8010194f:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101956:	e8 e5 39 00 00       	call   80105340 <acquire>
  ip->ref--;
8010195b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010195f:	83 c4 10             	add    $0x10,%esp
80101962:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
}
80101969:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5f                   	pop    %edi
8010196f:	5d                   	pop    %ebp
  release(&icache.lock);
80101970:	e9 8b 3a 00 00       	jmp    80105400 <release>
80101975:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101978:	83 ec 0c             	sub    $0xc,%esp
8010197b:	68 e0 19 11 80       	push   $0x801119e0
80101980:	e8 bb 39 00 00       	call   80105340 <acquire>
    int r = ip->ref;
80101985:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101988:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010198f:	e8 6c 3a 00 00       	call   80105400 <release>
    if(r == 1){
80101994:	83 c4 10             	add    $0x10,%esp
80101997:	83 fe 01             	cmp    $0x1,%esi
8010199a:	75 aa                	jne    80101946 <iput+0x26>
8010199c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019a2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019a8:	89 cf                	mov    %ecx,%edi
801019aa:	eb 0b                	jmp    801019b7 <iput+0x97>
801019ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019b0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019b3:	39 fe                	cmp    %edi,%esi
801019b5:	74 19                	je     801019d0 <iput+0xb0>
    if(ip->addrs[i]){
801019b7:	8b 16                	mov    (%esi),%edx
801019b9:	85 d2                	test   %edx,%edx
801019bb:	74 f3                	je     801019b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019bd:	8b 03                	mov    (%ebx),%eax
801019bf:	e8 ac fb ff ff       	call   80101570 <bfree>
      ip->addrs[i] = 0;
801019c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019ca:	eb e4                	jmp    801019b0 <iput+0x90>
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019d0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019d6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019d9:	85 c0                	test   %eax,%eax
801019db:	75 33                	jne    80101a10 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019dd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019e0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019e7:	53                   	push   %ebx
801019e8:	e8 53 fd ff ff       	call   80101740 <iupdate>
      ip->type = 0;
801019ed:	31 c0                	xor    %eax,%eax
801019ef:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019f3:	89 1c 24             	mov    %ebx,(%esp)
801019f6:	e8 45 fd ff ff       	call   80101740 <iupdate>
      ip->valid = 0;
801019fb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a02:	83 c4 10             	add    $0x10,%esp
80101a05:	e9 3c ff ff ff       	jmp    80101946 <iput+0x26>
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a10:	83 ec 08             	sub    $0x8,%esp
80101a13:	50                   	push   %eax
80101a14:	ff 33                	pushl  (%ebx)
80101a16:	e8 b5 e6 ff ff       	call   801000d0 <bread>
80101a1b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a21:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101a27:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	89 cf                	mov    %ecx,%edi
80101a2f:	eb 0e                	jmp    80101a3f <iput+0x11f>
80101a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a38:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101a3b:	39 fe                	cmp    %edi,%esi
80101a3d:	74 0f                	je     80101a4e <iput+0x12e>
      if(a[j])
80101a3f:	8b 16                	mov    (%esi),%edx
80101a41:	85 d2                	test   %edx,%edx
80101a43:	74 f3                	je     80101a38 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a45:	8b 03                	mov    (%ebx),%eax
80101a47:	e8 24 fb ff ff       	call   80101570 <bfree>
80101a4c:	eb ea                	jmp    80101a38 <iput+0x118>
    brelse(bp);
80101a4e:	83 ec 0c             	sub    $0xc,%esp
80101a51:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a54:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a57:	e8 84 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a5c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a62:	8b 03                	mov    (%ebx),%eax
80101a64:	e8 07 fb ff ff       	call   80101570 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a69:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a70:	00 00 00 
80101a73:	83 c4 10             	add    $0x10,%esp
80101a76:	e9 62 ff ff ff       	jmp    801019dd <iput+0xbd>
80101a7b:	90                   	nop
80101a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a80 <iunlockput>:
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	53                   	push   %ebx
80101a84:	83 ec 10             	sub    $0x10,%esp
80101a87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a8a:	53                   	push   %ebx
80101a8b:	e8 40 fe ff ff       	call   801018d0 <iunlock>
  iput(ip);
80101a90:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a93:	83 c4 10             	add    $0x10,%esp
}
80101a96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a99:	c9                   	leave  
  iput(ip);
80101a9a:	e9 81 fe ff ff       	jmp    80101920 <iput>
80101a9f:	90                   	nop

80101aa0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	8b 55 08             	mov    0x8(%ebp),%edx
80101aa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101aa9:	8b 0a                	mov    (%edx),%ecx
80101aab:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101aae:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ab1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ab4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ab8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101abb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101abf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ac3:	8b 52 58             	mov    0x58(%edx),%edx
80101ac6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ac9:	5d                   	pop    %ebp
80101aca:	c3                   	ret    
80101acb:	90                   	nop
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 1c             	sub    $0x1c,%esp
80101ad9:	8b 45 08             	mov    0x8(%ebp),%eax
80101adc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101adf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ae2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ae7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101aea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aed:	8b 75 10             	mov    0x10(%ebp),%esi
80101af0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101af3:	0f 84 a7 00 00 00    	je     80101ba0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101af9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101afc:	8b 40 58             	mov    0x58(%eax),%eax
80101aff:	39 c6                	cmp    %eax,%esi
80101b01:	0f 87 ba 00 00 00    	ja     80101bc1 <readi+0xf1>
80101b07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b0a:	89 f9                	mov    %edi,%ecx
80101b0c:	01 f1                	add    %esi,%ecx
80101b0e:	0f 82 ad 00 00 00    	jb     80101bc1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b14:	89 c2                	mov    %eax,%edx
80101b16:	29 f2                	sub    %esi,%edx
80101b18:	39 c8                	cmp    %ecx,%eax
80101b1a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b1d:	31 ff                	xor    %edi,%edi
80101b1f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101b21:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b24:	74 6c                	je     80101b92 <readi+0xc2>
80101b26:	8d 76 00             	lea    0x0(%esi),%esi
80101b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b30:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b33:	89 f2                	mov    %esi,%edx
80101b35:	c1 ea 09             	shr    $0x9,%edx
80101b38:	89 d8                	mov    %ebx,%eax
80101b3a:	e8 11 f9 ff ff       	call   80101450 <bmap>
80101b3f:	83 ec 08             	sub    $0x8,%esp
80101b42:	50                   	push   %eax
80101b43:	ff 33                	pushl  (%ebx)
80101b45:	e8 86 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b4d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b4f:	89 f0                	mov    %esi,%eax
80101b51:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b56:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b5b:	83 c4 0c             	add    $0xc,%esp
80101b5e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b60:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b64:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b67:	29 fb                	sub    %edi,%ebx
80101b69:	39 d9                	cmp    %ebx,%ecx
80101b6b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b6e:	53                   	push   %ebx
80101b6f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b70:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b72:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b75:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b77:	e8 84 39 00 00       	call   80105500 <memmove>
    brelse(bp);
80101b7c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b7f:	89 14 24             	mov    %edx,(%esp)
80101b82:	e8 59 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b87:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b8a:	83 c4 10             	add    $0x10,%esp
80101b8d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b90:	77 9e                	ja     80101b30 <readi+0x60>
  }
  return n;
80101b92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b98:	5b                   	pop    %ebx
80101b99:	5e                   	pop    %esi
80101b9a:	5f                   	pop    %edi
80101b9b:	5d                   	pop    %ebp
80101b9c:	c3                   	ret    
80101b9d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ba0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ba4:	66 83 f8 09          	cmp    $0x9,%ax
80101ba8:	77 17                	ja     80101bc1 <readi+0xf1>
80101baa:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
80101bb1:	85 c0                	test   %eax,%eax
80101bb3:	74 0c                	je     80101bc1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101bb5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bbb:	5b                   	pop    %ebx
80101bbc:	5e                   	pop    %esi
80101bbd:	5f                   	pop    %edi
80101bbe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101bbf:	ff e0                	jmp    *%eax
      return -1;
80101bc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc6:	eb cd                	jmp    80101b95 <readi+0xc5>
80101bc8:	90                   	nop
80101bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bd0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 1c             	sub    $0x1c,%esp
80101bd9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bdf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101be2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101be7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bea:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bed:	8b 75 10             	mov    0x10(%ebp),%esi
80101bf0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bf3:	0f 84 b7 00 00 00    	je     80101cb0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bf9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bfc:	39 70 58             	cmp    %esi,0x58(%eax)
80101bff:	0f 82 eb 00 00 00    	jb     80101cf0 <writei+0x120>
80101c05:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101c08:	31 d2                	xor    %edx,%edx
80101c0a:	89 f8                	mov    %edi,%eax
80101c0c:	01 f0                	add    %esi,%eax
80101c0e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c11:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c16:	0f 87 d4 00 00 00    	ja     80101cf0 <writei+0x120>
80101c1c:	85 d2                	test   %edx,%edx
80101c1e:	0f 85 cc 00 00 00    	jne    80101cf0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c24:	85 ff                	test   %edi,%edi
80101c26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c2d:	74 72                	je     80101ca1 <writei+0xd1>
80101c2f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c30:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c33:	89 f2                	mov    %esi,%edx
80101c35:	c1 ea 09             	shr    $0x9,%edx
80101c38:	89 f8                	mov    %edi,%eax
80101c3a:	e8 11 f8 ff ff       	call   80101450 <bmap>
80101c3f:	83 ec 08             	sub    $0x8,%esp
80101c42:	50                   	push   %eax
80101c43:	ff 37                	pushl  (%edi)
80101c45:	e8 86 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c4a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c4d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c50:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c52:	89 f0                	mov    %esi,%eax
80101c54:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c59:	83 c4 0c             	add    $0xc,%esp
80101c5c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c61:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c63:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c67:	39 d9                	cmp    %ebx,%ecx
80101c69:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c6c:	53                   	push   %ebx
80101c6d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c70:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c72:	50                   	push   %eax
80101c73:	e8 88 38 00 00       	call   80105500 <memmove>
    log_write(bp);
80101c78:	89 3c 24             	mov    %edi,(%esp)
80101c7b:	e8 60 12 00 00       	call   80102ee0 <log_write>
    brelse(bp);
80101c80:	89 3c 24             	mov    %edi,(%esp)
80101c83:	e8 58 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c88:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c8b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c8e:	83 c4 10             	add    $0x10,%esp
80101c91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c94:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c97:	77 97                	ja     80101c30 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c9f:	77 37                	ja     80101cd8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ca1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ca4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ca7:	5b                   	pop    %ebx
80101ca8:	5e                   	pop    %esi
80101ca9:	5f                   	pop    %edi
80101caa:	5d                   	pop    %ebp
80101cab:	c3                   	ret    
80101cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cb0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cb4:	66 83 f8 09          	cmp    $0x9,%ax
80101cb8:	77 36                	ja     80101cf0 <writei+0x120>
80101cba:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
80101cc1:	85 c0                	test   %eax,%eax
80101cc3:	74 2b                	je     80101cf0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101cc5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101cc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ccb:	5b                   	pop    %ebx
80101ccc:	5e                   	pop    %esi
80101ccd:	5f                   	pop    %edi
80101cce:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101ccf:	ff e0                	jmp    *%eax
80101cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101cd8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cdb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cde:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ce1:	50                   	push   %eax
80101ce2:	e8 59 fa ff ff       	call   80101740 <iupdate>
80101ce7:	83 c4 10             	add    $0x10,%esp
80101cea:	eb b5                	jmp    80101ca1 <writei+0xd1>
80101cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cf5:	eb ad                	jmp    80101ca4 <writei+0xd4>
80101cf7:	89 f6                	mov    %esi,%esi
80101cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d00 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d06:	6a 0e                	push   $0xe
80101d08:	ff 75 0c             	pushl  0xc(%ebp)
80101d0b:	ff 75 08             	pushl  0x8(%ebp)
80101d0e:	e8 5d 38 00 00       	call   80105570 <strncmp>
}
80101d13:	c9                   	leave  
80101d14:	c3                   	ret    
80101d15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d20 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	83 ec 1c             	sub    $0x1c,%esp
80101d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d2c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d31:	0f 85 85 00 00 00    	jne    80101dbc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d37:	8b 53 58             	mov    0x58(%ebx),%edx
80101d3a:	31 ff                	xor    %edi,%edi
80101d3c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d3f:	85 d2                	test   %edx,%edx
80101d41:	74 3e                	je     80101d81 <dirlookup+0x61>
80101d43:	90                   	nop
80101d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d48:	6a 10                	push   $0x10
80101d4a:	57                   	push   %edi
80101d4b:	56                   	push   %esi
80101d4c:	53                   	push   %ebx
80101d4d:	e8 7e fd ff ff       	call   80101ad0 <readi>
80101d52:	83 c4 10             	add    $0x10,%esp
80101d55:	83 f8 10             	cmp    $0x10,%eax
80101d58:	75 55                	jne    80101daf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d5f:	74 18                	je     80101d79 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d61:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d64:	83 ec 04             	sub    $0x4,%esp
80101d67:	6a 0e                	push   $0xe
80101d69:	50                   	push   %eax
80101d6a:	ff 75 0c             	pushl  0xc(%ebp)
80101d6d:	e8 fe 37 00 00       	call   80105570 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d72:	83 c4 10             	add    $0x10,%esp
80101d75:	85 c0                	test   %eax,%eax
80101d77:	74 17                	je     80101d90 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d79:	83 c7 10             	add    $0x10,%edi
80101d7c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d7f:	72 c7                	jb     80101d48 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d81:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d84:	31 c0                	xor    %eax,%eax
}
80101d86:	5b                   	pop    %ebx
80101d87:	5e                   	pop    %esi
80101d88:	5f                   	pop    %edi
80101d89:	5d                   	pop    %ebp
80101d8a:	c3                   	ret    
80101d8b:	90                   	nop
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d90:	8b 45 10             	mov    0x10(%ebp),%eax
80101d93:	85 c0                	test   %eax,%eax
80101d95:	74 05                	je     80101d9c <dirlookup+0x7c>
        *poff = off;
80101d97:	8b 45 10             	mov    0x10(%ebp),%eax
80101d9a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d9c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101da0:	8b 03                	mov    (%ebx),%eax
80101da2:	e8 d9 f5 ff ff       	call   80101380 <iget>
}
80101da7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101daa:	5b                   	pop    %ebx
80101dab:	5e                   	pop    %esi
80101dac:	5f                   	pop    %edi
80101dad:	5d                   	pop    %ebp
80101dae:	c3                   	ret    
      panic("dirlookup read");
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	68 79 82 10 80       	push   $0x80108279
80101db7:	e8 d4 e5 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101dbc:	83 ec 0c             	sub    $0xc,%esp
80101dbf:	68 67 82 10 80       	push   $0x80108267
80101dc4:	e8 c7 e5 ff ff       	call   80100390 <panic>
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	89 cf                	mov    %ecx,%edi
80101dd8:	89 c3                	mov    %eax,%ebx
80101dda:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ddd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101de0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101de3:	0f 84 67 01 00 00    	je     80101f50 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101de9:	e8 c2 1d 00 00       	call   80103bb0 <myproc>
  acquire(&icache.lock);
80101dee:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101df1:	8b 70 58             	mov    0x58(%eax),%esi
  acquire(&icache.lock);
80101df4:	68 e0 19 11 80       	push   $0x801119e0
80101df9:	e8 42 35 00 00       	call   80105340 <acquire>
  ip->ref++;
80101dfe:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e02:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101e09:	e8 f2 35 00 00       	call   80105400 <release>
80101e0e:	83 c4 10             	add    $0x10,%esp
80101e11:	eb 08                	jmp    80101e1b <namex+0x4b>
80101e13:	90                   	nop
80101e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e1b:	0f b6 03             	movzbl (%ebx),%eax
80101e1e:	3c 2f                	cmp    $0x2f,%al
80101e20:	74 f6                	je     80101e18 <namex+0x48>
  if(*path == 0)
80101e22:	84 c0                	test   %al,%al
80101e24:	0f 84 ee 00 00 00    	je     80101f18 <namex+0x148>
  while(*path != '/' && *path != 0)
80101e2a:	0f b6 03             	movzbl (%ebx),%eax
80101e2d:	3c 2f                	cmp    $0x2f,%al
80101e2f:	0f 84 b3 00 00 00    	je     80101ee8 <namex+0x118>
80101e35:	84 c0                	test   %al,%al
80101e37:	89 da                	mov    %ebx,%edx
80101e39:	75 09                	jne    80101e44 <namex+0x74>
80101e3b:	e9 a8 00 00 00       	jmp    80101ee8 <namex+0x118>
80101e40:	84 c0                	test   %al,%al
80101e42:	74 0a                	je     80101e4e <namex+0x7e>
    path++;
80101e44:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e47:	0f b6 02             	movzbl (%edx),%eax
80101e4a:	3c 2f                	cmp    $0x2f,%al
80101e4c:	75 f2                	jne    80101e40 <namex+0x70>
80101e4e:	89 d1                	mov    %edx,%ecx
80101e50:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e52:	83 f9 0d             	cmp    $0xd,%ecx
80101e55:	0f 8e 91 00 00 00    	jle    80101eec <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e5b:	83 ec 04             	sub    $0x4,%esp
80101e5e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e61:	6a 0e                	push   $0xe
80101e63:	53                   	push   %ebx
80101e64:	57                   	push   %edi
80101e65:	e8 96 36 00 00       	call   80105500 <memmove>
    path++;
80101e6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e6d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e70:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e72:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e75:	75 11                	jne    80101e88 <namex+0xb8>
80101e77:	89 f6                	mov    %esi,%esi
80101e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e80:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e83:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e86:	74 f8                	je     80101e80 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e88:	83 ec 0c             	sub    $0xc,%esp
80101e8b:	56                   	push   %esi
80101e8c:	e8 5f f9 ff ff       	call   801017f0 <ilock>
    if(ip->type != T_DIR){
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e99:	0f 85 91 00 00 00    	jne    80101f30 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e9f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ea2:	85 d2                	test   %edx,%edx
80101ea4:	74 09                	je     80101eaf <namex+0xdf>
80101ea6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ea9:	0f 84 b7 00 00 00    	je     80101f66 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101eaf:	83 ec 04             	sub    $0x4,%esp
80101eb2:	6a 00                	push   $0x0
80101eb4:	57                   	push   %edi
80101eb5:	56                   	push   %esi
80101eb6:	e8 65 fe ff ff       	call   80101d20 <dirlookup>
80101ebb:	83 c4 10             	add    $0x10,%esp
80101ebe:	85 c0                	test   %eax,%eax
80101ec0:	74 6e                	je     80101f30 <namex+0x160>
  iunlock(ip);
80101ec2:	83 ec 0c             	sub    $0xc,%esp
80101ec5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ec8:	56                   	push   %esi
80101ec9:	e8 02 fa ff ff       	call   801018d0 <iunlock>
  iput(ip);
80101ece:	89 34 24             	mov    %esi,(%esp)
80101ed1:	e8 4a fa ff ff       	call   80101920 <iput>
80101ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ed9:	83 c4 10             	add    $0x10,%esp
80101edc:	89 c6                	mov    %eax,%esi
80101ede:	e9 38 ff ff ff       	jmp    80101e1b <namex+0x4b>
80101ee3:	90                   	nop
80101ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ee8:	89 da                	mov    %ebx,%edx
80101eea:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101eec:	83 ec 04             	sub    $0x4,%esp
80101eef:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ef2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ef5:	51                   	push   %ecx
80101ef6:	53                   	push   %ebx
80101ef7:	57                   	push   %edi
80101ef8:	e8 03 36 00 00       	call   80105500 <memmove>
    name[len] = 0;
80101efd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f00:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101f0a:	89 d3                	mov    %edx,%ebx
80101f0c:	e9 61 ff ff ff       	jmp    80101e72 <namex+0xa2>
80101f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f18:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f1b:	85 c0                	test   %eax,%eax
80101f1d:	75 5d                	jne    80101f7c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f22:	89 f0                	mov    %esi,%eax
80101f24:	5b                   	pop    %ebx
80101f25:	5e                   	pop    %esi
80101f26:	5f                   	pop    %edi
80101f27:	5d                   	pop    %ebp
80101f28:	c3                   	ret    
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f30:	83 ec 0c             	sub    $0xc,%esp
80101f33:	56                   	push   %esi
80101f34:	e8 97 f9 ff ff       	call   801018d0 <iunlock>
  iput(ip);
80101f39:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f3c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f3e:	e8 dd f9 ff ff       	call   80101920 <iput>
      return 0;
80101f43:	83 c4 10             	add    $0x10,%esp
}
80101f46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f49:	89 f0                	mov    %esi,%eax
80101f4b:	5b                   	pop    %ebx
80101f4c:	5e                   	pop    %esi
80101f4d:	5f                   	pop    %edi
80101f4e:	5d                   	pop    %ebp
80101f4f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f50:	ba 01 00 00 00       	mov    $0x1,%edx
80101f55:	b8 01 00 00 00       	mov    $0x1,%eax
80101f5a:	e8 21 f4 ff ff       	call   80101380 <iget>
80101f5f:	89 c6                	mov    %eax,%esi
80101f61:	e9 b5 fe ff ff       	jmp    80101e1b <namex+0x4b>
      iunlock(ip);
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	56                   	push   %esi
80101f6a:	e8 61 f9 ff ff       	call   801018d0 <iunlock>
      return ip;
80101f6f:	83 c4 10             	add    $0x10,%esp
}
80101f72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f75:	89 f0                	mov    %esi,%eax
80101f77:	5b                   	pop    %ebx
80101f78:	5e                   	pop    %esi
80101f79:	5f                   	pop    %edi
80101f7a:	5d                   	pop    %ebp
80101f7b:	c3                   	ret    
    iput(ip);
80101f7c:	83 ec 0c             	sub    $0xc,%esp
80101f7f:	56                   	push   %esi
    return 0;
80101f80:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f82:	e8 99 f9 ff ff       	call   80101920 <iput>
    return 0;
80101f87:	83 c4 10             	add    $0x10,%esp
80101f8a:	eb 93                	jmp    80101f1f <namex+0x14f>
80101f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f90 <dirlink>:
{
80101f90:	55                   	push   %ebp
80101f91:	89 e5                	mov    %esp,%ebp
80101f93:	57                   	push   %edi
80101f94:	56                   	push   %esi
80101f95:	53                   	push   %ebx
80101f96:	83 ec 20             	sub    $0x20,%esp
80101f99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f9c:	6a 00                	push   $0x0
80101f9e:	ff 75 0c             	pushl  0xc(%ebp)
80101fa1:	53                   	push   %ebx
80101fa2:	e8 79 fd ff ff       	call   80101d20 <dirlookup>
80101fa7:	83 c4 10             	add    $0x10,%esp
80101faa:	85 c0                	test   %eax,%eax
80101fac:	75 67                	jne    80102015 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fae:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fb1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fb4:	85 ff                	test   %edi,%edi
80101fb6:	74 29                	je     80101fe1 <dirlink+0x51>
80101fb8:	31 ff                	xor    %edi,%edi
80101fba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fbd:	eb 09                	jmp    80101fc8 <dirlink+0x38>
80101fbf:	90                   	nop
80101fc0:	83 c7 10             	add    $0x10,%edi
80101fc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fc6:	73 19                	jae    80101fe1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fc8:	6a 10                	push   $0x10
80101fca:	57                   	push   %edi
80101fcb:	56                   	push   %esi
80101fcc:	53                   	push   %ebx
80101fcd:	e8 fe fa ff ff       	call   80101ad0 <readi>
80101fd2:	83 c4 10             	add    $0x10,%esp
80101fd5:	83 f8 10             	cmp    $0x10,%eax
80101fd8:	75 4e                	jne    80102028 <dirlink+0x98>
    if(de.inum == 0)
80101fda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fdf:	75 df                	jne    80101fc0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101fe1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fe4:	83 ec 04             	sub    $0x4,%esp
80101fe7:	6a 0e                	push   $0xe
80101fe9:	ff 75 0c             	pushl  0xc(%ebp)
80101fec:	50                   	push   %eax
80101fed:	e8 de 35 00 00       	call   801055d0 <strncpy>
  de.inum = inum;
80101ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ff5:	6a 10                	push   $0x10
80101ff7:	57                   	push   %edi
80101ff8:	56                   	push   %esi
80101ff9:	53                   	push   %ebx
  de.inum = inum;
80101ffa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ffe:	e8 cd fb ff ff       	call   80101bd0 <writei>
80102003:	83 c4 20             	add    $0x20,%esp
80102006:	83 f8 10             	cmp    $0x10,%eax
80102009:	75 2a                	jne    80102035 <dirlink+0xa5>
  return 0;
8010200b:	31 c0                	xor    %eax,%eax
}
8010200d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102010:	5b                   	pop    %ebx
80102011:	5e                   	pop    %esi
80102012:	5f                   	pop    %edi
80102013:	5d                   	pop    %ebp
80102014:	c3                   	ret    
    iput(ip);
80102015:	83 ec 0c             	sub    $0xc,%esp
80102018:	50                   	push   %eax
80102019:	e8 02 f9 ff ff       	call   80101920 <iput>
    return -1;
8010201e:	83 c4 10             	add    $0x10,%esp
80102021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102026:	eb e5                	jmp    8010200d <dirlink+0x7d>
      panic("dirlink read");
80102028:	83 ec 0c             	sub    $0xc,%esp
8010202b:	68 88 82 10 80       	push   $0x80108288
80102030:	e8 5b e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102035:	83 ec 0c             	sub    $0xc,%esp
80102038:	68 5e 8b 10 80       	push   $0x80108b5e
8010203d:	e8 4e e3 ff ff       	call   80100390 <panic>
80102042:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102050 <namei>:

struct inode*
namei(char *path)
{
80102050:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102051:	31 d2                	xor    %edx,%edx
{
80102053:	89 e5                	mov    %esp,%ebp
80102055:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102058:	8b 45 08             	mov    0x8(%ebp),%eax
8010205b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010205e:	e8 6d fd ff ff       	call   80101dd0 <namex>
}
80102063:	c9                   	leave  
80102064:	c3                   	ret    
80102065:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102070 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102070:	55                   	push   %ebp
  return namex(path, 1, name);
80102071:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102076:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102078:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010207b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010207e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010207f:	e9 4c fd ff ff       	jmp    80101dd0 <namex>
80102084:	66 90                	xchg   %ax,%ax
80102086:	66 90                	xchg   %ax,%ax
80102088:	66 90                	xchg   %ax,%ax
8010208a:	66 90                	xchg   %ax,%ax
8010208c:	66 90                	xchg   %ax,%ax
8010208e:	66 90                	xchg   %ax,%ax

80102090 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102099:	85 c0                	test   %eax,%eax
8010209b:	0f 84 b4 00 00 00    	je     80102155 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020a1:	8b 58 08             	mov    0x8(%eax),%ebx
801020a4:	89 c6                	mov    %eax,%esi
801020a6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801020ac:	0f 87 96 00 00 00    	ja     80102148 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020b7:	89 f6                	mov    %esi,%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020c0:	89 ca                	mov    %ecx,%edx
801020c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020c3:	83 e0 c0             	and    $0xffffffc0,%eax
801020c6:	3c 40                	cmp    $0x40,%al
801020c8:	75 f6                	jne    801020c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ca:	31 ff                	xor    %edi,%edi
801020cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020d1:	89 f8                	mov    %edi,%eax
801020d3:	ee                   	out    %al,(%dx)
801020d4:	b8 01 00 00 00       	mov    $0x1,%eax
801020d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020de:	ee                   	out    %al,(%dx)
801020df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801020e4:	89 d8                	mov    %ebx,%eax
801020e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020e7:	89 d8                	mov    %ebx,%eax
801020e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801020ee:	c1 f8 08             	sar    $0x8,%eax
801020f1:	ee                   	out    %al,(%dx)
801020f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801020f7:	89 f8                	mov    %edi,%eax
801020f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020fa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
801020fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102103:	c1 e0 04             	shl    $0x4,%eax
80102106:	83 e0 10             	and    $0x10,%eax
80102109:	83 c8 e0             	or     $0xffffffe0,%eax
8010210c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010210d:	f6 06 04             	testb  $0x4,(%esi)
80102110:	75 16                	jne    80102128 <idestart+0x98>
80102112:	b8 20 00 00 00       	mov    $0x20,%eax
80102117:	89 ca                	mov    %ecx,%edx
80102119:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010211a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010211d:	5b                   	pop    %ebx
8010211e:	5e                   	pop    %esi
8010211f:	5f                   	pop    %edi
80102120:	5d                   	pop    %ebp
80102121:	c3                   	ret    
80102122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102128:	b8 30 00 00 00       	mov    $0x30,%eax
8010212d:	89 ca                	mov    %ecx,%edx
8010212f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102130:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102135:	83 c6 5c             	add    $0x5c,%esi
80102138:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010213d:	fc                   	cld    
8010213e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102140:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102143:	5b                   	pop    %ebx
80102144:	5e                   	pop    %esi
80102145:	5f                   	pop    %edi
80102146:	5d                   	pop    %ebp
80102147:	c3                   	ret    
    panic("incorrect blockno");
80102148:	83 ec 0c             	sub    $0xc,%esp
8010214b:	68 f4 82 10 80       	push   $0x801082f4
80102150:	e8 3b e2 ff ff       	call   80100390 <panic>
    panic("idestart");
80102155:	83 ec 0c             	sub    $0xc,%esp
80102158:	68 eb 82 10 80       	push   $0x801082eb
8010215d:	e8 2e e2 ff ff       	call   80100390 <panic>
80102162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102170 <ideinit>:
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102176:	68 06 83 10 80       	push   $0x80108306
8010217b:	68 80 b5 10 80       	push   $0x8010b580
80102180:	e8 7b 30 00 00       	call   80105200 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102185:	58                   	pop    %eax
80102186:	a1 20 3d 11 80       	mov    0x80113d20,%eax
8010218b:	5a                   	pop    %edx
8010218c:	83 e8 01             	sub    $0x1,%eax
8010218f:	50                   	push   %eax
80102190:	6a 0e                	push   $0xe
80102192:	e8 a9 02 00 00       	call   80102440 <ioapicenable>
80102197:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010219a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010219f:	90                   	nop
801021a0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021a1:	83 e0 c0             	and    $0xffffffc0,%eax
801021a4:	3c 40                	cmp    $0x40,%al
801021a6:	75 f8                	jne    801021a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021a8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021ad:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021b2:	ee                   	out    %al,(%dx)
801021b3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021b8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021bd:	eb 06                	jmp    801021c5 <ideinit+0x55>
801021bf:	90                   	nop
  for(i=0; i<1000; i++){
801021c0:	83 e9 01             	sub    $0x1,%ecx
801021c3:	74 0f                	je     801021d4 <ideinit+0x64>
801021c5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021c6:	84 c0                	test   %al,%al
801021c8:	74 f6                	je     801021c0 <ideinit+0x50>
      havedisk1 = 1;
801021ca:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801021d1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021d4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021d9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021de:	ee                   	out    %al,(%dx)
}
801021df:	c9                   	leave  
801021e0:	c3                   	ret    
801021e1:	eb 0d                	jmp    801021f0 <ideintr>
801021e3:	90                   	nop
801021e4:	90                   	nop
801021e5:	90                   	nop
801021e6:	90                   	nop
801021e7:	90                   	nop
801021e8:	90                   	nop
801021e9:	90                   	nop
801021ea:	90                   	nop
801021eb:	90                   	nop
801021ec:	90                   	nop
801021ed:	90                   	nop
801021ee:	90                   	nop
801021ef:	90                   	nop

801021f0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801021f0:	55                   	push   %ebp
801021f1:	89 e5                	mov    %esp,%ebp
801021f3:	57                   	push   %edi
801021f4:	56                   	push   %esi
801021f5:	53                   	push   %ebx
801021f6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021f9:	68 80 b5 10 80       	push   $0x8010b580
801021fe:	e8 3d 31 00 00       	call   80105340 <acquire>

  if((b = idequeue) == 0){
80102203:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102209:	83 c4 10             	add    $0x10,%esp
8010220c:	85 db                	test   %ebx,%ebx
8010220e:	74 67                	je     80102277 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102210:	8b 43 58             	mov    0x58(%ebx),%eax
80102213:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102218:	8b 3b                	mov    (%ebx),%edi
8010221a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102220:	75 31                	jne    80102253 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102222:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102227:	89 f6                	mov    %esi,%esi
80102229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102230:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102231:	89 c6                	mov    %eax,%esi
80102233:	83 e6 c0             	and    $0xffffffc0,%esi
80102236:	89 f1                	mov    %esi,%ecx
80102238:	80 f9 40             	cmp    $0x40,%cl
8010223b:	75 f3                	jne    80102230 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010223d:	a8 21                	test   $0x21,%al
8010223f:	75 12                	jne    80102253 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102241:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102244:	b9 80 00 00 00       	mov    $0x80,%ecx
80102249:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010224e:	fc                   	cld    
8010224f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102251:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102253:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102256:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102259:	89 f9                	mov    %edi,%ecx
8010225b:	83 c9 02             	or     $0x2,%ecx
8010225e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102260:	53                   	push   %ebx
80102261:	e8 2a 20 00 00       	call   80104290 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102266:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010226b:	83 c4 10             	add    $0x10,%esp
8010226e:	85 c0                	test   %eax,%eax
80102270:	74 05                	je     80102277 <ideintr+0x87>
    idestart(idequeue);
80102272:	e8 19 fe ff ff       	call   80102090 <idestart>
    release(&idelock);
80102277:	83 ec 0c             	sub    $0xc,%esp
8010227a:	68 80 b5 10 80       	push   $0x8010b580
8010227f:	e8 7c 31 00 00       	call   80105400 <release>

  release(&idelock);
}
80102284:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102287:	5b                   	pop    %ebx
80102288:	5e                   	pop    %esi
80102289:	5f                   	pop    %edi
8010228a:	5d                   	pop    %ebp
8010228b:	c3                   	ret    
8010228c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102290 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102290:	55                   	push   %ebp
80102291:	89 e5                	mov    %esp,%ebp
80102293:	53                   	push   %ebx
80102294:	83 ec 10             	sub    $0x10,%esp
80102297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010229a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010229d:	50                   	push   %eax
8010229e:	e8 0d 2f 00 00       	call   801051b0 <holdingsleep>
801022a3:	83 c4 10             	add    $0x10,%esp
801022a6:	85 c0                	test   %eax,%eax
801022a8:	0f 84 c6 00 00 00    	je     80102374 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022ae:	8b 03                	mov    (%ebx),%eax
801022b0:	83 e0 06             	and    $0x6,%eax
801022b3:	83 f8 02             	cmp    $0x2,%eax
801022b6:	0f 84 ab 00 00 00    	je     80102367 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801022bc:	8b 53 04             	mov    0x4(%ebx),%edx
801022bf:	85 d2                	test   %edx,%edx
801022c1:	74 0d                	je     801022d0 <iderw+0x40>
801022c3:	a1 60 b5 10 80       	mov    0x8010b560,%eax
801022c8:	85 c0                	test   %eax,%eax
801022ca:	0f 84 b1 00 00 00    	je     80102381 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801022d0:	83 ec 0c             	sub    $0xc,%esp
801022d3:	68 80 b5 10 80       	push   $0x8010b580
801022d8:	e8 63 30 00 00       	call   80105340 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022dd:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
801022e3:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801022e6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022ed:	85 d2                	test   %edx,%edx
801022ef:	75 09                	jne    801022fa <iderw+0x6a>
801022f1:	eb 6d                	jmp    80102360 <iderw+0xd0>
801022f3:	90                   	nop
801022f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022f8:	89 c2                	mov    %eax,%edx
801022fa:	8b 42 58             	mov    0x58(%edx),%eax
801022fd:	85 c0                	test   %eax,%eax
801022ff:	75 f7                	jne    801022f8 <iderw+0x68>
80102301:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102304:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102306:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
8010230c:	74 42                	je     80102350 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010230e:	8b 03                	mov    (%ebx),%eax
80102310:	83 e0 06             	and    $0x6,%eax
80102313:	83 f8 02             	cmp    $0x2,%eax
80102316:	74 23                	je     8010233b <iderw+0xab>
80102318:	90                   	nop
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102320:	83 ec 08             	sub    $0x8,%esp
80102323:	68 80 b5 10 80       	push   $0x8010b580
80102328:	53                   	push   %ebx
80102329:	e8 72 27 00 00       	call   80104aa0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010232e:	8b 03                	mov    (%ebx),%eax
80102330:	83 c4 10             	add    $0x10,%esp
80102333:	83 e0 06             	and    $0x6,%eax
80102336:	83 f8 02             	cmp    $0x2,%eax
80102339:	75 e5                	jne    80102320 <iderw+0x90>
  }


  release(&idelock);
8010233b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102342:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102345:	c9                   	leave  
  release(&idelock);
80102346:	e9 b5 30 00 00       	jmp    80105400 <release>
8010234b:	90                   	nop
8010234c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102350:	89 d8                	mov    %ebx,%eax
80102352:	e8 39 fd ff ff       	call   80102090 <idestart>
80102357:	eb b5                	jmp    8010230e <iderw+0x7e>
80102359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102360:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102365:	eb 9d                	jmp    80102304 <iderw+0x74>
    panic("iderw: nothing to do");
80102367:	83 ec 0c             	sub    $0xc,%esp
8010236a:	68 20 83 10 80       	push   $0x80108320
8010236f:	e8 1c e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102374:	83 ec 0c             	sub    $0xc,%esp
80102377:	68 0a 83 10 80       	push   $0x8010830a
8010237c:	e8 0f e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102381:	83 ec 0c             	sub    $0xc,%esp
80102384:	68 35 83 10 80       	push   $0x80108335
80102389:	e8 02 e0 ff ff       	call   80100390 <panic>
8010238e:	66 90                	xchg   %ax,%ax

80102390 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102390:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102391:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
80102398:	00 c0 fe 
{
8010239b:	89 e5                	mov    %esp,%ebp
8010239d:	56                   	push   %esi
8010239e:	53                   	push   %ebx
  ioapic->reg = reg;
8010239f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023a6:	00 00 00 
  return ioapic->data;
801023a9:	a1 34 36 11 80       	mov    0x80113634,%eax
801023ae:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801023b1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801023b7:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023bd:	0f b6 15 60 37 11 80 	movzbl 0x80113760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023c4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801023c7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801023ca:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801023cd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801023d0:	39 c2                	cmp    %eax,%edx
801023d2:	74 16                	je     801023ea <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801023d4:	83 ec 0c             	sub    $0xc,%esp
801023d7:	68 54 83 10 80       	push   $0x80108354
801023dc:	e8 7f e2 ff ff       	call   80100660 <cprintf>
801023e1:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
801023e7:	83 c4 10             	add    $0x10,%esp
801023ea:	83 c3 21             	add    $0x21,%ebx
{
801023ed:	ba 10 00 00 00       	mov    $0x10,%edx
801023f2:	b8 20 00 00 00       	mov    $0x20,%eax
801023f7:	89 f6                	mov    %esi,%esi
801023f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102400:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102402:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102408:	89 c6                	mov    %eax,%esi
8010240a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102410:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102413:	89 71 10             	mov    %esi,0x10(%ecx)
80102416:	8d 72 01             	lea    0x1(%edx),%esi
80102419:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010241c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010241e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102420:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
80102426:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010242d:	75 d1                	jne    80102400 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010242f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102432:	5b                   	pop    %ebx
80102433:	5e                   	pop    %esi
80102434:	5d                   	pop    %ebp
80102435:	c3                   	ret    
80102436:	8d 76 00             	lea    0x0(%esi),%esi
80102439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102440 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102440:	55                   	push   %ebp
  ioapic->reg = reg;
80102441:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
{
80102447:	89 e5                	mov    %esp,%ebp
80102449:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010244c:	8d 50 20             	lea    0x20(%eax),%edx
8010244f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102453:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102455:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010245b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010245e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102461:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102464:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102466:	a1 34 36 11 80       	mov    0x80113634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010246b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010246e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	66 90                	xchg   %ax,%ax
80102475:	66 90                	xchg   %ax,%ax
80102477:	66 90                	xchg   %ax,%ax
80102479:	66 90                	xchg   %ax,%ax
8010247b:	66 90                	xchg   %ax,%ax
8010247d:	66 90                	xchg   %ax,%ax
8010247f:	90                   	nop

80102480 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
80102487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010248a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102490:	75 70                	jne    80102502 <kfree+0x82>
80102492:	81 fb 68 55 12 80    	cmp    $0x80125568,%ebx
80102498:	72 68                	jb     80102502 <kfree+0x82>
8010249a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024a5:	77 5b                	ja     80102502 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024a7:	83 ec 04             	sub    $0x4,%esp
801024aa:	68 00 10 00 00       	push   $0x1000
801024af:	6a 01                	push   $0x1
801024b1:	53                   	push   %ebx
801024b2:	e8 99 2f 00 00       	call   80105450 <memset>

  if(kmem.use_lock)
801024b7:	8b 15 74 36 11 80    	mov    0x80113674,%edx
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	85 d2                	test   %edx,%edx
801024c2:	75 2c                	jne    801024f0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024c4:	a1 78 36 11 80       	mov    0x80113678,%eax
801024c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024cb:	a1 74 36 11 80       	mov    0x80113674,%eax
  kmem.freelist = r;
801024d0:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
  if(kmem.use_lock)
801024d6:	85 c0                	test   %eax,%eax
801024d8:	75 06                	jne    801024e0 <kfree+0x60>
    release(&kmem.lock);
}
801024da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024dd:	c9                   	leave  
801024de:	c3                   	ret    
801024df:	90                   	nop
    release(&kmem.lock);
801024e0:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
801024e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024ea:	c9                   	leave  
    release(&kmem.lock);
801024eb:	e9 10 2f 00 00       	jmp    80105400 <release>
    acquire(&kmem.lock);
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 40 36 11 80       	push   $0x80113640
801024f8:	e8 43 2e 00 00       	call   80105340 <acquire>
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	eb c2                	jmp    801024c4 <kfree+0x44>
    panic("kfree");
80102502:	83 ec 0c             	sub    $0xc,%esp
80102505:	68 86 83 10 80       	push   $0x80108386
8010250a:	e8 81 de ff ff       	call   80100390 <panic>
8010250f:	90                   	nop

80102510 <freerange>:
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	56                   	push   %esi
80102514:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102515:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102518:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010251b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102521:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102527:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010252d:	39 de                	cmp    %ebx,%esi
8010252f:	72 23                	jb     80102554 <freerange+0x44>
80102531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102538:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010253e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102541:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102547:	50                   	push   %eax
80102548:	e8 33 ff ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010254d:	83 c4 10             	add    $0x10,%esp
80102550:	39 f3                	cmp    %esi,%ebx
80102552:	76 e4                	jbe    80102538 <freerange+0x28>
}
80102554:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102557:	5b                   	pop    %ebx
80102558:	5e                   	pop    %esi
80102559:	5d                   	pop    %ebp
8010255a:	c3                   	ret    
8010255b:	90                   	nop
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <kinit1>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	53                   	push   %ebx
80102565:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102568:	83 ec 08             	sub    $0x8,%esp
8010256b:	68 8c 83 10 80       	push   $0x8010838c
80102570:	68 40 36 11 80       	push   $0x80113640
80102575:	e8 86 2c 00 00       	call   80105200 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010257a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010257d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102580:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102587:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010258a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102590:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102596:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010259c:	39 de                	cmp    %ebx,%esi
8010259e:	72 1c                	jb     801025bc <kinit1+0x5c>
    kfree(p);
801025a0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025a6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025af:	50                   	push   %eax
801025b0:	e8 cb fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b5:	83 c4 10             	add    $0x10,%esp
801025b8:	39 de                	cmp    %ebx,%esi
801025ba:	73 e4                	jae    801025a0 <kinit1+0x40>
}
801025bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025bf:	5b                   	pop    %ebx
801025c0:	5e                   	pop    %esi
801025c1:	5d                   	pop    %ebp
801025c2:	c3                   	ret    
801025c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025d0 <kinit2>:
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	56                   	push   %esi
801025d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025ed:	39 de                	cmp    %ebx,%esi
801025ef:	72 23                	jb     80102614 <kinit2+0x44>
801025f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801025fe:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102601:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102607:	50                   	push   %eax
80102608:	e8 73 fe ff ff       	call   80102480 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010260d:	83 c4 10             	add    $0x10,%esp
80102610:	39 de                	cmp    %ebx,%esi
80102612:	73 e4                	jae    801025f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102614:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
8010261b:	00 00 00 
}
8010261e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102621:	5b                   	pop    %ebx
80102622:	5e                   	pop    %esi
80102623:	5d                   	pop    %ebp
80102624:	c3                   	ret    
80102625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102630:	a1 74 36 11 80       	mov    0x80113674,%eax
80102635:	85 c0                	test   %eax,%eax
80102637:	75 1f                	jne    80102658 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102639:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
8010263e:	85 c0                	test   %eax,%eax
80102640:	74 0e                	je     80102650 <kalloc+0x20>
    kmem.freelist = r->next;
80102642:	8b 10                	mov    (%eax),%edx
80102644:	89 15 78 36 11 80    	mov    %edx,0x80113678
8010264a:	c3                   	ret    
8010264b:	90                   	nop
8010264c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102650:	f3 c3                	repz ret 
80102652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102658:	55                   	push   %ebp
80102659:	89 e5                	mov    %esp,%ebp
8010265b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010265e:	68 40 36 11 80       	push   $0x80113640
80102663:	e8 d8 2c 00 00       	call   80105340 <acquire>
  r = kmem.freelist;
80102668:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102676:	85 c0                	test   %eax,%eax
80102678:	74 08                	je     80102682 <kalloc+0x52>
    kmem.freelist = r->next;
8010267a:	8b 08                	mov    (%eax),%ecx
8010267c:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
  if(kmem.use_lock)
80102682:	85 d2                	test   %edx,%edx
80102684:	74 16                	je     8010269c <kalloc+0x6c>
    release(&kmem.lock);
80102686:	83 ec 0c             	sub    $0xc,%esp
80102689:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010268c:	68 40 36 11 80       	push   $0x80113640
80102691:	e8 6a 2d 00 00       	call   80105400 <release>
  return (char*)r;
80102696:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102699:	83 c4 10             	add    $0x10,%esp
}
8010269c:	c9                   	leave  
8010269d:	c3                   	ret    
8010269e:	66 90                	xchg   %ax,%ax

801026a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026a0:	ba 64 00 00 00       	mov    $0x64,%edx
801026a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026a6:	a8 01                	test   $0x1,%al
801026a8:	0f 84 c2 00 00 00    	je     80102770 <kbdgetc+0xd0>
801026ae:	ba 60 00 00 00       	mov    $0x60,%edx
801026b3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801026b4:	0f b6 d0             	movzbl %al,%edx
801026b7:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
801026bd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801026c3:	0f 84 7f 00 00 00    	je     80102748 <kbdgetc+0xa8>
{
801026c9:	55                   	push   %ebp
801026ca:	89 e5                	mov    %esp,%ebp
801026cc:	53                   	push   %ebx
801026cd:	89 cb                	mov    %ecx,%ebx
801026cf:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801026d2:	84 c0                	test   %al,%al
801026d4:	78 4a                	js     80102720 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801026d6:	85 db                	test   %ebx,%ebx
801026d8:	74 09                	je     801026e3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801026da:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801026dd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801026e0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801026e3:	0f b6 82 c0 84 10 80 	movzbl -0x7fef7b40(%edx),%eax
801026ea:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801026ec:	0f b6 82 c0 83 10 80 	movzbl -0x7fef7c40(%edx),%eax
801026f3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801026f5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801026f7:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801026fd:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102700:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102703:	8b 04 85 a0 83 10 80 	mov    -0x7fef7c60(,%eax,4),%eax
8010270a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010270e:	74 31                	je     80102741 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102710:	8d 50 9f             	lea    -0x61(%eax),%edx
80102713:	83 fa 19             	cmp    $0x19,%edx
80102716:	77 40                	ja     80102758 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102718:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010271b:	5b                   	pop    %ebx
8010271c:	5d                   	pop    %ebp
8010271d:	c3                   	ret    
8010271e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102720:	83 e0 7f             	and    $0x7f,%eax
80102723:	85 db                	test   %ebx,%ebx
80102725:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102728:	0f b6 82 c0 84 10 80 	movzbl -0x7fef7b40(%edx),%eax
8010272f:	83 c8 40             	or     $0x40,%eax
80102732:	0f b6 c0             	movzbl %al,%eax
80102735:	f7 d0                	not    %eax
80102737:	21 c1                	and    %eax,%ecx
    return 0;
80102739:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010273b:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102741:	5b                   	pop    %ebx
80102742:	5d                   	pop    %ebp
80102743:	c3                   	ret    
80102744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102748:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010274b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010274d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
80102753:	c3                   	ret    
80102754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102758:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010275b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010275e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010275f:	83 f9 1a             	cmp    $0x1a,%ecx
80102762:	0f 42 c2             	cmovb  %edx,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102775:	c3                   	ret    
80102776:	8d 76 00             	lea    0x0(%esi),%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102780 <kbdintr>:

void
kbdintr(void)
{
80102780:	55                   	push   %ebp
80102781:	89 e5                	mov    %esp,%ebp
80102783:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102786:	68 a0 26 10 80       	push   $0x801026a0
8010278b:	e8 80 e0 ff ff       	call   80100810 <consoleintr>
}
80102790:	83 c4 10             	add    $0x10,%esp
80102793:	c9                   	leave  
80102794:	c3                   	ret    
80102795:	66 90                	xchg   %ax,%ax
80102797:	66 90                	xchg   %ax,%ax
80102799:	66 90                	xchg   %ax,%ax
8010279b:	66 90                	xchg   %ax,%ax
8010279d:	66 90                	xchg   %ax,%ax
8010279f:	90                   	nop

801027a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027a0:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
801027a5:	55                   	push   %ebp
801027a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801027a8:	85 c0                	test   %eax,%eax
801027aa:	0f 84 c8 00 00 00    	je     80102878 <lapicinit+0xd8>
  lapic[index] = value;
801027b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801027f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801027fe:	8b 50 30             	mov    0x30(%eax),%edx
80102801:	c1 ea 10             	shr    $0x10,%edx
80102804:	80 fa 03             	cmp    $0x3,%dl
80102807:	77 77                	ja     80102880 <lapicinit+0xe0>
  lapic[index] = value;
80102809:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102810:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102813:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102816:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010281d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102820:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102823:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010282d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102830:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102837:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102844:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102847:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010284a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102851:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102854:	8b 50 20             	mov    0x20(%eax),%edx
80102857:	89 f6                	mov    %esi,%esi
80102859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102860:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102866:	80 e6 10             	and    $0x10,%dh
80102869:	75 f5                	jne    80102860 <lapicinit+0xc0>
  lapic[index] = value;
8010286b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102872:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102875:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102878:	5d                   	pop    %ebp
80102879:	c3                   	ret    
8010287a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102880:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102887:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
8010288d:	e9 77 ff ff ff       	jmp    80102809 <lapicinit+0x69>
80102892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028a0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028a0:	8b 15 7c 36 11 80    	mov    0x8011367c,%edx
{
801028a6:	55                   	push   %ebp
801028a7:	31 c0                	xor    %eax,%eax
801028a9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801028ab:	85 d2                	test   %edx,%edx
801028ad:	74 06                	je     801028b5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
801028af:	8b 42 20             	mov    0x20(%edx),%eax
801028b2:	c1 e8 18             	shr    $0x18,%eax
}
801028b5:	5d                   	pop    %ebp
801028b6:	c3                   	ret    
801028b7:	89 f6                	mov    %esi,%esi
801028b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028c0:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
801028c5:	55                   	push   %ebp
801028c6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801028c8:	85 c0                	test   %eax,%eax
801028ca:	74 0d                	je     801028d9 <lapiceoi+0x19>
  lapic[index] = value;
801028cc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028d3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028d9:	5d                   	pop    %ebp
801028da:	c3                   	ret    
801028db:	90                   	nop
801028dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028e0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801028e0:	55                   	push   %ebp
801028e1:	89 e5                	mov    %esp,%ebp
}
801028e3:	5d                   	pop    %ebp
801028e4:	c3                   	ret    
801028e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028f0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801028f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801028f6:	ba 70 00 00 00       	mov    $0x70,%edx
801028fb:	89 e5                	mov    %esp,%ebp
801028fd:	53                   	push   %ebx
801028fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102901:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102904:	ee                   	out    %al,(%dx)
80102905:	b8 0a 00 00 00       	mov    $0xa,%eax
8010290a:	ba 71 00 00 00       	mov    $0x71,%edx
8010290f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102910:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102912:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102915:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010291b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010291d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102920:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102923:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102925:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102928:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010292e:	a1 7c 36 11 80       	mov    0x8011367c,%eax
80102933:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102939:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010293c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102943:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102946:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102949:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102950:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102953:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102956:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010295c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010295f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102965:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102968:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010296e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102971:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102977:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010297a:	5b                   	pop    %ebx
8010297b:	5d                   	pop    %ebp
8010297c:	c3                   	ret    
8010297d:	8d 76 00             	lea    0x0(%esi),%esi

80102980 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102980:	55                   	push   %ebp
80102981:	b8 0b 00 00 00       	mov    $0xb,%eax
80102986:	ba 70 00 00 00       	mov    $0x70,%edx
8010298b:	89 e5                	mov    %esp,%ebp
8010298d:	57                   	push   %edi
8010298e:	56                   	push   %esi
8010298f:	53                   	push   %ebx
80102990:	83 ec 4c             	sub    $0x4c,%esp
80102993:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102994:	ba 71 00 00 00       	mov    $0x71,%edx
80102999:	ec                   	in     (%dx),%al
8010299a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010299d:	bb 70 00 00 00       	mov    $0x70,%ebx
801029a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029a5:	8d 76 00             	lea    0x0(%esi),%esi
801029a8:	31 c0                	xor    %eax,%eax
801029aa:	89 da                	mov    %ebx,%edx
801029ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801029b2:	89 ca                	mov    %ecx,%edx
801029b4:	ec                   	in     (%dx),%al
801029b5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b8:	89 da                	mov    %ebx,%edx
801029ba:	b8 02 00 00 00       	mov    $0x2,%eax
801029bf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c0:	89 ca                	mov    %ecx,%edx
801029c2:	ec                   	in     (%dx),%al
801029c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c6:	89 da                	mov    %ebx,%edx
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
801029d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d4:	89 da                	mov    %ebx,%edx
801029d6:	b8 07 00 00 00       	mov    $0x7,%eax
801029db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029dc:	89 ca                	mov    %ecx,%edx
801029de:	ec                   	in     (%dx),%al
801029df:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e2:	89 da                	mov    %ebx,%edx
801029e4:	b8 08 00 00 00       	mov    $0x8,%eax
801029e9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ea:	89 ca                	mov    %ecx,%edx
801029ec:	ec                   	in     (%dx),%al
801029ed:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ef:	89 da                	mov    %ebx,%edx
801029f1:	b8 09 00 00 00       	mov    $0x9,%eax
801029f6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f7:	89 ca                	mov    %ecx,%edx
801029f9:	ec                   	in     (%dx),%al
801029fa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029fc:	89 da                	mov    %ebx,%edx
801029fe:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a03:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a04:	89 ca                	mov    %ecx,%edx
80102a06:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a07:	84 c0                	test   %al,%al
80102a09:	78 9d                	js     801029a8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a0b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a0f:	89 fa                	mov    %edi,%edx
80102a11:	0f b6 fa             	movzbl %dl,%edi
80102a14:	89 f2                	mov    %esi,%edx
80102a16:	0f b6 f2             	movzbl %dl,%esi
80102a19:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a1c:	89 da                	mov    %ebx,%edx
80102a1e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a21:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a24:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a28:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a2b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a2f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a32:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a36:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a39:	31 c0                	xor    %eax,%eax
80102a3b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3c:	89 ca                	mov    %ecx,%edx
80102a3e:	ec                   	in     (%dx),%al
80102a3f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a42:	89 da                	mov    %ebx,%edx
80102a44:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a47:	b8 02 00 00 00       	mov    $0x2,%eax
80102a4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a4d:	89 ca                	mov    %ecx,%edx
80102a4f:	ec                   	in     (%dx),%al
80102a50:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a53:	89 da                	mov    %ebx,%edx
80102a55:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a58:	b8 04 00 00 00       	mov    $0x4,%eax
80102a5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a5e:	89 ca                	mov    %ecx,%edx
80102a60:	ec                   	in     (%dx),%al
80102a61:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a64:	89 da                	mov    %ebx,%edx
80102a66:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a69:	b8 07 00 00 00       	mov    $0x7,%eax
80102a6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6f:	89 ca                	mov    %ecx,%edx
80102a71:	ec                   	in     (%dx),%al
80102a72:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a75:	89 da                	mov    %ebx,%edx
80102a77:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a7a:	b8 08 00 00 00       	mov    $0x8,%eax
80102a7f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a80:	89 ca                	mov    %ecx,%edx
80102a82:	ec                   	in     (%dx),%al
80102a83:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a86:	89 da                	mov    %ebx,%edx
80102a88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a8b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a90:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a91:	89 ca                	mov    %ecx,%edx
80102a93:	ec                   	in     (%dx),%al
80102a94:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a97:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a9d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102aa0:	6a 18                	push   $0x18
80102aa2:	50                   	push   %eax
80102aa3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102aa6:	50                   	push   %eax
80102aa7:	e8 f4 29 00 00       	call   801054a0 <memcmp>
80102aac:	83 c4 10             	add    $0x10,%esp
80102aaf:	85 c0                	test   %eax,%eax
80102ab1:	0f 85 f1 fe ff ff    	jne    801029a8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ab7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102abb:	75 78                	jne    80102b35 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102abd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ac0:	89 c2                	mov    %eax,%edx
80102ac2:	83 e0 0f             	and    $0xf,%eax
80102ac5:	c1 ea 04             	shr    $0x4,%edx
80102ac8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102acb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ace:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ad1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ad4:	89 c2                	mov    %eax,%edx
80102ad6:	83 e0 0f             	and    $0xf,%eax
80102ad9:	c1 ea 04             	shr    $0x4,%edx
80102adc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102adf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ae2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102ae5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ae8:	89 c2                	mov    %eax,%edx
80102aea:	83 e0 0f             	and    $0xf,%eax
80102aed:	c1 ea 04             	shr    $0x4,%edx
80102af0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102af9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102afc:	89 c2                	mov    %eax,%edx
80102afe:	83 e0 0f             	and    $0xf,%eax
80102b01:	c1 ea 04             	shr    $0x4,%edx
80102b04:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b07:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b0a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b0d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b21:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b35:	8b 75 08             	mov    0x8(%ebp),%esi
80102b38:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b3b:	89 06                	mov    %eax,(%esi)
80102b3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b40:	89 46 04             	mov    %eax,0x4(%esi)
80102b43:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b46:	89 46 08             	mov    %eax,0x8(%esi)
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b52:	89 46 10             	mov    %eax,0x10(%esi)
80102b55:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b58:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102b5b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102b62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b65:	5b                   	pop    %ebx
80102b66:	5e                   	pop    %esi
80102b67:	5f                   	pop    %edi
80102b68:	5d                   	pop    %ebp
80102b69:	c3                   	ret    
80102b6a:	66 90                	xchg   %ax,%ax
80102b6c:	66 90                	xchg   %ax,%ax
80102b6e:	66 90                	xchg   %ax,%ax

80102b70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b70:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102b76:	85 c9                	test   %ecx,%ecx
80102b78:	0f 8e 8a 00 00 00    	jle    80102c08 <install_trans+0x98>
{
80102b7e:	55                   	push   %ebp
80102b7f:	89 e5                	mov    %esp,%ebp
80102b81:	57                   	push   %edi
80102b82:	56                   	push   %esi
80102b83:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b84:	31 db                	xor    %ebx,%ebx
{
80102b86:	83 ec 0c             	sub    $0xc,%esp
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b90:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b95:	83 ec 08             	sub    $0x8,%esp
80102b98:	01 d8                	add    %ebx,%eax
80102b9a:	83 c0 01             	add    $0x1,%eax
80102b9d:	50                   	push   %eax
80102b9e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102ba4:	e8 27 d5 ff ff       	call   801000d0 <bread>
80102ba9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bab:	58                   	pop    %eax
80102bac:	5a                   	pop    %edx
80102bad:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102bb4:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bba:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbd:	e8 0e d5 ff ff       	call   801000d0 <bread>
80102bc2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bc4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102bc7:	83 c4 0c             	add    $0xc,%esp
80102bca:	68 00 02 00 00       	push   $0x200
80102bcf:	50                   	push   %eax
80102bd0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bd3:	50                   	push   %eax
80102bd4:	e8 27 29 00 00       	call   80105500 <memmove>
    bwrite(dbuf);  // write dst to disk
80102bd9:	89 34 24             	mov    %esi,(%esp)
80102bdc:	e8 bf d5 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102be1:	89 3c 24             	mov    %edi,(%esp)
80102be4:	e8 f7 d5 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102be9:	89 34 24             	mov    %esi,(%esp)
80102bec:	e8 ef d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102bf1:	83 c4 10             	add    $0x10,%esp
80102bf4:	39 1d c8 36 11 80    	cmp    %ebx,0x801136c8
80102bfa:	7f 94                	jg     80102b90 <install_trans+0x20>
  }
}
80102bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bff:	5b                   	pop    %ebx
80102c00:	5e                   	pop    %esi
80102c01:	5f                   	pop    %edi
80102c02:	5d                   	pop    %ebp
80102c03:	c3                   	ret    
80102c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c08:	f3 c3                	repz ret 
80102c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c10:	55                   	push   %ebp
80102c11:	89 e5                	mov    %esp,%ebp
80102c13:	56                   	push   %esi
80102c14:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102c15:	83 ec 08             	sub    $0x8,%esp
80102c18:	ff 35 b4 36 11 80    	pushl  0x801136b4
80102c1e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102c24:	e8 a7 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102c29:	8b 1d c8 36 11 80    	mov    0x801136c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c2f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c32:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102c34:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102c36:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102c39:	7e 16                	jle    80102c51 <write_head+0x41>
80102c3b:	c1 e3 02             	shl    $0x2,%ebx
80102c3e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102c40:	8b 8a cc 36 11 80    	mov    -0x7feec934(%edx),%ecx
80102c46:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102c4a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 da                	cmp    %ebx,%edx
80102c4f:	75 ef                	jne    80102c40 <write_head+0x30>
  }
  bwrite(buf);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	56                   	push   %esi
80102c55:	e8 46 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102c5a:	89 34 24             	mov    %esi,(%esp)
80102c5d:	e8 7e d5 ff ff       	call   801001e0 <brelse>
}
80102c62:	83 c4 10             	add    $0x10,%esp
80102c65:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c68:	5b                   	pop    %ebx
80102c69:	5e                   	pop    %esi
80102c6a:	5d                   	pop    %ebp
80102c6b:	c3                   	ret    
80102c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c70 <initlog>:
{
80102c70:	55                   	push   %ebp
80102c71:	89 e5                	mov    %esp,%ebp
80102c73:	53                   	push   %ebx
80102c74:	83 ec 2c             	sub    $0x2c,%esp
80102c77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c7a:	68 c0 85 10 80       	push   $0x801085c0
80102c7f:	68 80 36 11 80       	push   $0x80113680
80102c84:	e8 77 25 00 00       	call   80105200 <initlock>
  readsb(dev, &sb);
80102c89:	58                   	pop    %eax
80102c8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c8d:	5a                   	pop    %edx
80102c8e:	50                   	push   %eax
80102c8f:	53                   	push   %ebx
80102c90:	e8 9b e8 ff ff       	call   80101530 <readsb>
  log.size = sb.nlog;
80102c95:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c98:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c9b:	59                   	pop    %ecx
  log.dev = dev;
80102c9c:	89 1d c4 36 11 80    	mov    %ebx,0x801136c4
  log.size = sb.nlog;
80102ca2:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
  log.start = sb.logstart;
80102ca8:	a3 b4 36 11 80       	mov    %eax,0x801136b4
  struct buf *buf = bread(log.dev, log.start);
80102cad:	5a                   	pop    %edx
80102cae:	50                   	push   %eax
80102caf:	53                   	push   %ebx
80102cb0:	e8 1b d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102cb5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102cb8:	83 c4 10             	add    $0x10,%esp
80102cbb:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102cbd:	89 1d c8 36 11 80    	mov    %ebx,0x801136c8
  for (i = 0; i < log.lh.n; i++) {
80102cc3:	7e 1c                	jle    80102ce1 <initlog+0x71>
80102cc5:	c1 e3 02             	shl    $0x2,%ebx
80102cc8:	31 d2                	xor    %edx,%edx
80102cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102cd0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102cd4:	83 c2 04             	add    $0x4,%edx
80102cd7:	89 8a c8 36 11 80    	mov    %ecx,-0x7feec938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102cdd:	39 d3                	cmp    %edx,%ebx
80102cdf:	75 ef                	jne    80102cd0 <initlog+0x60>
  brelse(buf);
80102ce1:	83 ec 0c             	sub    $0xc,%esp
80102ce4:	50                   	push   %eax
80102ce5:	e8 f6 d4 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cea:	e8 81 fe ff ff       	call   80102b70 <install_trans>
  log.lh.n = 0;
80102cef:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102cf6:	00 00 00 
  write_head(); // clear the log
80102cf9:	e8 12 ff ff ff       	call   80102c10 <write_head>
}
80102cfe:	83 c4 10             	add    $0x10,%esp
80102d01:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d04:	c9                   	leave  
80102d05:	c3                   	ret    
80102d06:	8d 76 00             	lea    0x0(%esi),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d16:	68 80 36 11 80       	push   $0x80113680
80102d1b:	e8 20 26 00 00       	call   80105340 <acquire>
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	eb 18                	jmp    80102d3d <begin_op+0x2d>
80102d25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d28:	83 ec 08             	sub    $0x8,%esp
80102d2b:	68 80 36 11 80       	push   $0x80113680
80102d30:	68 80 36 11 80       	push   $0x80113680
80102d35:	e8 66 1d 00 00       	call   80104aa0 <sleep>
80102d3a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d3d:	a1 c0 36 11 80       	mov    0x801136c0,%eax
80102d42:	85 c0                	test   %eax,%eax
80102d44:	75 e2                	jne    80102d28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d46:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102d4b:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
80102d51:	83 c0 01             	add    $0x1,%eax
80102d54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d5a:	83 fa 1e             	cmp    $0x1e,%edx
80102d5d:	7f c9                	jg     80102d28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d5f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d62:	a3 bc 36 11 80       	mov    %eax,0x801136bc
      release(&log.lock);
80102d67:	68 80 36 11 80       	push   $0x80113680
80102d6c:	e8 8f 26 00 00       	call   80105400 <release>
      break;
    }
  }
}
80102d71:	83 c4 10             	add    $0x10,%esp
80102d74:	c9                   	leave  
80102d75:	c3                   	ret    
80102d76:	8d 76 00             	lea    0x0(%esi),%esi
80102d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	57                   	push   %edi
80102d84:	56                   	push   %esi
80102d85:	53                   	push   %ebx
80102d86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d89:	68 80 36 11 80       	push   $0x80113680
80102d8e:	e8 ad 25 00 00       	call   80105340 <acquire>
  log.outstanding -= 1;
80102d93:	a1 bc 36 11 80       	mov    0x801136bc,%eax
  if(log.committing)
80102d98:	8b 35 c0 36 11 80    	mov    0x801136c0,%esi
80102d9e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102da1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102da4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102da6:	89 1d bc 36 11 80    	mov    %ebx,0x801136bc
  if(log.committing)
80102dac:	0f 85 1a 01 00 00    	jne    80102ecc <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102db2:	85 db                	test   %ebx,%ebx
80102db4:	0f 85 ee 00 00 00    	jne    80102ea8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dba:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102dbd:	c7 05 c0 36 11 80 01 	movl   $0x1,0x801136c0
80102dc4:	00 00 00 
  release(&log.lock);
80102dc7:	68 80 36 11 80       	push   $0x80113680
80102dcc:	e8 2f 26 00 00       	call   80105400 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102dd1:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102dd7:	83 c4 10             	add    $0x10,%esp
80102dda:	85 c9                	test   %ecx,%ecx
80102ddc:	0f 8e 85 00 00 00    	jle    80102e67 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102de2:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102de7:	83 ec 08             	sub    $0x8,%esp
80102dea:	01 d8                	add    %ebx,%eax
80102dec:	83 c0 01             	add    $0x1,%eax
80102def:	50                   	push   %eax
80102df0:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102df6:	e8 d5 d2 ff ff       	call   801000d0 <bread>
80102dfb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102dfd:	58                   	pop    %eax
80102dfe:	5a                   	pop    %edx
80102dff:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102e06:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e0c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e0f:	e8 bc d2 ff ff       	call   801000d0 <bread>
80102e14:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e16:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e19:	83 c4 0c             	add    $0xc,%esp
80102e1c:	68 00 02 00 00       	push   $0x200
80102e21:	50                   	push   %eax
80102e22:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e25:	50                   	push   %eax
80102e26:	e8 d5 26 00 00       	call   80105500 <memmove>
    bwrite(to);  // write the log
80102e2b:	89 34 24             	mov    %esi,(%esp)
80102e2e:	e8 6d d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102e33:	89 3c 24             	mov    %edi,(%esp)
80102e36:	e8 a5 d3 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102e3b:	89 34 24             	mov    %esi,(%esp)
80102e3e:	e8 9d d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e43:	83 c4 10             	add    $0x10,%esp
80102e46:	3b 1d c8 36 11 80    	cmp    0x801136c8,%ebx
80102e4c:	7c 94                	jl     80102de2 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e4e:	e8 bd fd ff ff       	call   80102c10 <write_head>
    install_trans(); // Now install writes to home locations
80102e53:	e8 18 fd ff ff       	call   80102b70 <install_trans>
    log.lh.n = 0;
80102e58:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102e5f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102e62:	e8 a9 fd ff ff       	call   80102c10 <write_head>
    acquire(&log.lock);
80102e67:	83 ec 0c             	sub    $0xc,%esp
80102e6a:	68 80 36 11 80       	push   $0x80113680
80102e6f:	e8 cc 24 00 00       	call   80105340 <acquire>
    wakeup(&log);
80102e74:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
    log.committing = 0;
80102e7b:	c7 05 c0 36 11 80 00 	movl   $0x0,0x801136c0
80102e82:	00 00 00 
    wakeup(&log);
80102e85:	e8 06 14 00 00       	call   80104290 <wakeup>
    release(&log.lock);
80102e8a:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102e91:	e8 6a 25 00 00       	call   80105400 <release>
80102e96:	83 c4 10             	add    $0x10,%esp
}
80102e99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e9c:	5b                   	pop    %ebx
80102e9d:	5e                   	pop    %esi
80102e9e:	5f                   	pop    %edi
80102e9f:	5d                   	pop    %ebp
80102ea0:	c3                   	ret    
80102ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102ea8:	83 ec 0c             	sub    $0xc,%esp
80102eab:	68 80 36 11 80       	push   $0x80113680
80102eb0:	e8 db 13 00 00       	call   80104290 <wakeup>
  release(&log.lock);
80102eb5:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80102ebc:	e8 3f 25 00 00       	call   80105400 <release>
80102ec1:	83 c4 10             	add    $0x10,%esp
}
80102ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ec7:	5b                   	pop    %ebx
80102ec8:	5e                   	pop    %esi
80102ec9:	5f                   	pop    %edi
80102eca:	5d                   	pop    %ebp
80102ecb:	c3                   	ret    
    panic("log.committing");
80102ecc:	83 ec 0c             	sub    $0xc,%esp
80102ecf:	68 c4 85 10 80       	push   $0x801085c4
80102ed4:	e8 b7 d4 ff ff       	call   80100390 <panic>
80102ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ee0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ee7:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
{
80102eed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ef0:	83 fa 1d             	cmp    $0x1d,%edx
80102ef3:	0f 8f 9d 00 00 00    	jg     80102f96 <log_write+0xb6>
80102ef9:	a1 b8 36 11 80       	mov    0x801136b8,%eax
80102efe:	83 e8 01             	sub    $0x1,%eax
80102f01:	39 c2                	cmp    %eax,%edx
80102f03:	0f 8d 8d 00 00 00    	jge    80102f96 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f09:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102f0e:	85 c0                	test   %eax,%eax
80102f10:	0f 8e 8d 00 00 00    	jle    80102fa3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f16:	83 ec 0c             	sub    $0xc,%esp
80102f19:	68 80 36 11 80       	push   $0x80113680
80102f1e:	e8 1d 24 00 00       	call   80105340 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f23:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102f29:	83 c4 10             	add    $0x10,%esp
80102f2c:	83 f9 00             	cmp    $0x0,%ecx
80102f2f:	7e 57                	jle    80102f88 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f31:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102f34:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f36:	3b 15 cc 36 11 80    	cmp    0x801136cc,%edx
80102f3c:	75 0b                	jne    80102f49 <log_write+0x69>
80102f3e:	eb 38                	jmp    80102f78 <log_write+0x98>
80102f40:	39 14 85 cc 36 11 80 	cmp    %edx,-0x7feec934(,%eax,4)
80102f47:	74 2f                	je     80102f78 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102f49:	83 c0 01             	add    $0x1,%eax
80102f4c:	39 c1                	cmp    %eax,%ecx
80102f4e:	75 f0                	jne    80102f40 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f50:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102f57:	83 c0 01             	add    $0x1,%eax
80102f5a:	a3 c8 36 11 80       	mov    %eax,0x801136c8
  b->flags |= B_DIRTY; // prevent eviction
80102f5f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102f62:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
80102f69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f6c:	c9                   	leave  
  release(&log.lock);
80102f6d:	e9 8e 24 00 00       	jmp    80105400 <release>
80102f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102f78:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
80102f7f:	eb de                	jmp    80102f5f <log_write+0x7f>
80102f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f88:	8b 43 08             	mov    0x8(%ebx),%eax
80102f8b:	a3 cc 36 11 80       	mov    %eax,0x801136cc
  if (i == log.lh.n)
80102f90:	75 cd                	jne    80102f5f <log_write+0x7f>
80102f92:	31 c0                	xor    %eax,%eax
80102f94:	eb c1                	jmp    80102f57 <log_write+0x77>
    panic("too big a transaction");
80102f96:	83 ec 0c             	sub    $0xc,%esp
80102f99:	68 d3 85 10 80       	push   $0x801085d3
80102f9e:	e8 ed d3 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102fa3:	83 ec 0c             	sub    $0xc,%esp
80102fa6:	68 e9 85 10 80       	push   $0x801085e9
80102fab:	e8 e0 d3 ff ff       	call   80100390 <panic>

80102fb0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fb7:	e8 d4 0b 00 00       	call   80103b90 <cpuid>
80102fbc:	89 c3                	mov    %eax,%ebx
80102fbe:	e8 cd 0b 00 00       	call   80103b90 <cpuid>
80102fc3:	83 ec 04             	sub    $0x4,%esp
80102fc6:	53                   	push   %ebx
80102fc7:	50                   	push   %eax
80102fc8:	68 04 86 10 80       	push   $0x80108604
80102fcd:	e8 8e d6 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102fd2:	e8 79 38 00 00       	call   80106850 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fd7:	e8 34 0b 00 00       	call   80103b10 <mycpu>
80102fdc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fde:	b8 01 00 00 00       	mov    $0x1,%eax
80102fe3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102fea:	e8 71 0f 00 00       	call   80103f60 <scheduler>
80102fef:	90                   	nop

80102ff0 <mpenter>:
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ff6:	e8 05 4a 00 00       	call   80107a00 <switchkvm>
  seginit();
80102ffb:	e8 70 49 00 00       	call   80107970 <seginit>
  lapicinit();
80103000:	e8 9b f7 ff ff       	call   801027a0 <lapicinit>
  mpmain();
80103005:	e8 a6 ff ff ff       	call   80102fb0 <mpmain>
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <main>:
{
80103010:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103014:	83 e4 f0             	and    $0xfffffff0,%esp
80103017:	ff 71 fc             	pushl  -0x4(%ecx)
8010301a:	55                   	push   %ebp
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010301f:	83 ec 08             	sub    $0x8,%esp
80103022:	68 00 00 40 80       	push   $0x80400000
80103027:	68 68 55 12 80       	push   $0x80125568
8010302c:	e8 2f f5 ff ff       	call   80102560 <kinit1>
  kvmalloc();      // kernel page table
80103031:	e8 ba 4e 00 00       	call   80107ef0 <kvmalloc>
  mpinit();        // detect other processors
80103036:	e8 75 01 00 00       	call   801031b0 <mpinit>
  lapicinit();     // interrupt controller
8010303b:	e8 60 f7 ff ff       	call   801027a0 <lapicinit>
  seginit();       // segment descriptors
80103040:	e8 2b 49 00 00       	call   80107970 <seginit>
  picinit();       // disable pic
80103045:	e8 46 03 00 00       	call   80103390 <picinit>
  ioapicinit();    // another interrupt controller
8010304a:	e8 41 f3 ff ff       	call   80102390 <ioapicinit>
  consoleinit();   // console hardware
8010304f:	e8 6c d9 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80103054:	e8 e7 3b 00 00       	call   80106c40 <uartinit>
  pinit();         // process table
80103059:	e8 02 09 00 00       	call   80103960 <pinit>
  tvinit();        // trap vectors
8010305e:	e8 6d 37 00 00       	call   801067d0 <tvinit>
  binit();         // buffer cache
80103063:	e8 d8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103068:	e8 53 de ff ff       	call   80100ec0 <fileinit>
  ideinit();       // disk 
8010306d:	e8 fe f0 ff ff       	call   80102170 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103072:	83 c4 0c             	add    $0xc,%esp
80103075:	68 8a 00 00 00       	push   $0x8a
8010307a:	68 8c b4 10 80       	push   $0x8010b48c
8010307f:	68 00 70 00 80       	push   $0x80007000
80103084:	e8 77 24 00 00       	call   80105500 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103089:	69 05 20 3d 11 80 b4 	imul   $0xb4,0x80113d20,%eax
80103090:	00 00 00 
80103093:	83 c4 10             	add    $0x10,%esp
80103096:	05 80 37 11 80       	add    $0x80113780,%eax
8010309b:	3d 80 37 11 80       	cmp    $0x80113780,%eax
801030a0:	76 71                	jbe    80103113 <main+0x103>
801030a2:	bb 80 37 11 80       	mov    $0x80113780,%ebx
801030a7:	89 f6                	mov    %esi,%esi
801030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
801030b0:	e8 5b 0a 00 00       	call   80103b10 <mycpu>
801030b5:	39 d8                	cmp    %ebx,%eax
801030b7:	74 41                	je     801030fa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030b9:	e8 72 f5 ff ff       	call   80102630 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801030be:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801030c3:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ff0,0x80006ff8
801030ca:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030cd:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801030d4:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030d7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801030dc:	0f b6 03             	movzbl (%ebx),%eax
801030df:	83 ec 08             	sub    $0x8,%esp
801030e2:	68 00 70 00 00       	push   $0x7000
801030e7:	50                   	push   %eax
801030e8:	e8 03 f8 ff ff       	call   801028f0 <lapicstartap>
801030ed:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801030f6:	85 c0                	test   %eax,%eax
801030f8:	74 f6                	je     801030f0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
801030fa:	69 05 20 3d 11 80 b4 	imul   $0xb4,0x80113d20,%eax
80103101:	00 00 00 
80103104:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
8010310a:	05 80 37 11 80       	add    $0x80113780,%eax
8010310f:	39 c3                	cmp    %eax,%ebx
80103111:	72 9d                	jb     801030b0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103113:	83 ec 08             	sub    $0x8,%esp
80103116:	68 00 00 00 8e       	push   $0x8e000000
8010311b:	68 00 00 40 80       	push   $0x80400000
80103120:	e8 ab f4 ff ff       	call   801025d0 <kinit2>
  userinit();      // first user process
80103125:	e8 e6 0a 00 00       	call   80103c10 <userinit>
  mpmain();        // finish this processor's setup
8010312a:	e8 81 fe ff ff       	call   80102fb0 <mpmain>
8010312f:	90                   	nop

80103130 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	57                   	push   %edi
80103134:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103135:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010313b:	53                   	push   %ebx
  e = addr+len;
8010313c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010313f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103142:	39 de                	cmp    %ebx,%esi
80103144:	72 10                	jb     80103156 <mpsearch1+0x26>
80103146:	eb 50                	jmp    80103198 <mpsearch1+0x68>
80103148:	90                   	nop
80103149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103150:	39 fb                	cmp    %edi,%ebx
80103152:	89 fe                	mov    %edi,%esi
80103154:	76 42                	jbe    80103198 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103156:	83 ec 04             	sub    $0x4,%esp
80103159:	8d 7e 10             	lea    0x10(%esi),%edi
8010315c:	6a 04                	push   $0x4
8010315e:	68 18 86 10 80       	push   $0x80108618
80103163:	56                   	push   %esi
80103164:	e8 37 23 00 00       	call   801054a0 <memcmp>
80103169:	83 c4 10             	add    $0x10,%esp
8010316c:	85 c0                	test   %eax,%eax
8010316e:	75 e0                	jne    80103150 <mpsearch1+0x20>
80103170:	89 f1                	mov    %esi,%ecx
80103172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103178:	0f b6 11             	movzbl (%ecx),%edx
8010317b:	83 c1 01             	add    $0x1,%ecx
8010317e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103180:	39 f9                	cmp    %edi,%ecx
80103182:	75 f4                	jne    80103178 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103184:	84 c0                	test   %al,%al
80103186:	75 c8                	jne    80103150 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103188:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010318b:	89 f0                	mov    %esi,%eax
8010318d:	5b                   	pop    %ebx
8010318e:	5e                   	pop    %esi
8010318f:	5f                   	pop    %edi
80103190:	5d                   	pop    %ebp
80103191:	c3                   	ret    
80103192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103198:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010319b:	31 f6                	xor    %esi,%esi
}
8010319d:	89 f0                	mov    %esi,%eax
8010319f:	5b                   	pop    %ebx
801031a0:	5e                   	pop    %esi
801031a1:	5f                   	pop    %edi
801031a2:	5d                   	pop    %ebp
801031a3:	c3                   	ret    
801031a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801031b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	57                   	push   %edi
801031b4:	56                   	push   %esi
801031b5:	53                   	push   %ebx
801031b6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031c7:	c1 e0 08             	shl    $0x8,%eax
801031ca:	09 d0                	or     %edx,%eax
801031cc:	c1 e0 04             	shl    $0x4,%eax
801031cf:	85 c0                	test   %eax,%eax
801031d1:	75 1b                	jne    801031ee <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031d3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031da:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031e1:	c1 e0 08             	shl    $0x8,%eax
801031e4:	09 d0                	or     %edx,%eax
801031e6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031e9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031ee:	ba 00 04 00 00       	mov    $0x400,%edx
801031f3:	e8 38 ff ff ff       	call   80103130 <mpsearch1>
801031f8:	85 c0                	test   %eax,%eax
801031fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031fd:	0f 84 3d 01 00 00    	je     80103340 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103203:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103206:	8b 58 04             	mov    0x4(%eax),%ebx
80103209:	85 db                	test   %ebx,%ebx
8010320b:	0f 84 4f 01 00 00    	je     80103360 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103211:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	6a 04                	push   $0x4
8010321c:	68 35 86 10 80       	push   $0x80108635
80103221:	56                   	push   %esi
80103222:	e8 79 22 00 00       	call   801054a0 <memcmp>
80103227:	83 c4 10             	add    $0x10,%esp
8010322a:	85 c0                	test   %eax,%eax
8010322c:	0f 85 2e 01 00 00    	jne    80103360 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103232:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103239:	3c 01                	cmp    $0x1,%al
8010323b:	0f 95 c2             	setne  %dl
8010323e:	3c 04                	cmp    $0x4,%al
80103240:	0f 95 c0             	setne  %al
80103243:	20 c2                	and    %al,%dl
80103245:	0f 85 15 01 00 00    	jne    80103360 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010324b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103252:	66 85 ff             	test   %di,%di
80103255:	74 1a                	je     80103271 <mpinit+0xc1>
80103257:	89 f0                	mov    %esi,%eax
80103259:	01 f7                	add    %esi,%edi
  sum = 0;
8010325b:	31 d2                	xor    %edx,%edx
8010325d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103260:	0f b6 08             	movzbl (%eax),%ecx
80103263:	83 c0 01             	add    $0x1,%eax
80103266:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103268:	39 c7                	cmp    %eax,%edi
8010326a:	75 f4                	jne    80103260 <mpinit+0xb0>
8010326c:	84 d2                	test   %dl,%dl
8010326e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103271:	85 f6                	test   %esi,%esi
80103273:	0f 84 e7 00 00 00    	je     80103360 <mpinit+0x1b0>
80103279:	84 d2                	test   %dl,%dl
8010327b:	0f 85 df 00 00 00    	jne    80103360 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103281:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103287:	a3 7c 36 11 80       	mov    %eax,0x8011367c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010328c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103293:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103299:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010329e:	01 d6                	add    %edx,%esi
801032a0:	39 c6                	cmp    %eax,%esi
801032a2:	76 23                	jbe    801032c7 <mpinit+0x117>
    switch(*p){
801032a4:	0f b6 10             	movzbl (%eax),%edx
801032a7:	80 fa 04             	cmp    $0x4,%dl
801032aa:	0f 87 ca 00 00 00    	ja     8010337a <mpinit+0x1ca>
801032b0:	ff 24 95 5c 86 10 80 	jmp    *-0x7fef79a4(,%edx,4)
801032b7:	89 f6                	mov    %esi,%esi
801032b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032c0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c3:	39 c6                	cmp    %eax,%esi
801032c5:	77 dd                	ja     801032a4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032c7:	85 db                	test   %ebx,%ebx
801032c9:	0f 84 9e 00 00 00    	je     8010336d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801032d2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801032d6:	74 15                	je     801032ed <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d8:	b8 70 00 00 00       	mov    $0x70,%eax
801032dd:	ba 22 00 00 00       	mov    $0x22,%edx
801032e2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e3:	ba 23 00 00 00       	mov    $0x23,%edx
801032e8:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032e9:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032ec:	ee                   	out    %al,(%dx)
  }
}
801032ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032f0:	5b                   	pop    %ebx
801032f1:	5e                   	pop    %esi
801032f2:	5f                   	pop    %edi
801032f3:	5d                   	pop    %ebp
801032f4:	c3                   	ret    
801032f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801032f8:	8b 0d 20 3d 11 80    	mov    0x80113d20,%ecx
801032fe:	83 f9 07             	cmp    $0x7,%ecx
80103301:	7f 19                	jg     8010331c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103303:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103307:	69 f9 b4 00 00 00    	imul   $0xb4,%ecx,%edi
        ncpu++;
8010330d:	83 c1 01             	add    $0x1,%ecx
80103310:	89 0d 20 3d 11 80    	mov    %ecx,0x80113d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103316:	88 97 80 37 11 80    	mov    %dl,-0x7feec880(%edi)
      p += sizeof(struct mpproc);
8010331c:	83 c0 14             	add    $0x14,%eax
      continue;
8010331f:	e9 7c ff ff ff       	jmp    801032a0 <mpinit+0xf0>
80103324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103328:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010332c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010332f:	88 15 60 37 11 80    	mov    %dl,0x80113760
      continue;
80103335:	e9 66 ff ff ff       	jmp    801032a0 <mpinit+0xf0>
8010333a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103340:	ba 00 00 01 00       	mov    $0x10000,%edx
80103345:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010334a:	e8 e1 fd ff ff       	call   80103130 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010334f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103351:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103354:	0f 85 a9 fe ff ff    	jne    80103203 <mpinit+0x53>
8010335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103360:	83 ec 0c             	sub    $0xc,%esp
80103363:	68 1d 86 10 80       	push   $0x8010861d
80103368:	e8 23 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010336d:	83 ec 0c             	sub    $0xc,%esp
80103370:	68 3c 86 10 80       	push   $0x8010863c
80103375:	e8 16 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
8010337a:	31 db                	xor    %ebx,%ebx
8010337c:	e9 26 ff ff ff       	jmp    801032a7 <mpinit+0xf7>
80103381:	66 90                	xchg   %ax,%ax
80103383:	66 90                	xchg   %ax,%ax
80103385:	66 90                	xchg   %ax,%ax
80103387:	66 90                	xchg   %ax,%ax
80103389:	66 90                	xchg   %ax,%ax
8010338b:	66 90                	xchg   %ax,%ax
8010338d:	66 90                	xchg   %ax,%ax
8010338f:	90                   	nop

80103390 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103390:	55                   	push   %ebp
80103391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103396:	ba 21 00 00 00       	mov    $0x21,%edx
8010339b:	89 e5                	mov    %esp,%ebp
8010339d:	ee                   	out    %al,(%dx)
8010339e:	ba a1 00 00 00       	mov    $0xa1,%edx
801033a3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033a4:	5d                   	pop    %ebp
801033a5:	c3                   	ret    
801033a6:	66 90                	xchg   %ax,%ax
801033a8:	66 90                	xchg   %ax,%ax
801033aa:	66 90                	xchg   %ax,%ax
801033ac:	66 90                	xchg   %ax,%ax
801033ae:	66 90                	xchg   %ax,%ax

801033b0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	57                   	push   %edi
801033b4:	56                   	push   %esi
801033b5:	53                   	push   %ebx
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033bf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801033c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033cb:	e8 10 db ff ff       	call   80100ee0 <filealloc>
801033d0:	85 c0                	test   %eax,%eax
801033d2:	89 03                	mov    %eax,(%ebx)
801033d4:	74 22                	je     801033f8 <pipealloc+0x48>
801033d6:	e8 05 db ff ff       	call   80100ee0 <filealloc>
801033db:	85 c0                	test   %eax,%eax
801033dd:	89 06                	mov    %eax,(%esi)
801033df:	74 3f                	je     80103420 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801033e1:	e8 4a f2 ff ff       	call   80102630 <kalloc>
801033e6:	85 c0                	test   %eax,%eax
801033e8:	89 c7                	mov    %eax,%edi
801033ea:	75 54                	jne    80103440 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033ec:	8b 03                	mov    (%ebx),%eax
801033ee:	85 c0                	test   %eax,%eax
801033f0:	75 34                	jne    80103426 <pipealloc+0x76>
801033f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801033f8:	8b 06                	mov    (%esi),%eax
801033fa:	85 c0                	test   %eax,%eax
801033fc:	74 0c                	je     8010340a <pipealloc+0x5a>
    fileclose(*f1);
801033fe:	83 ec 0c             	sub    $0xc,%esp
80103401:	50                   	push   %eax
80103402:	e8 99 db ff ff       	call   80100fa0 <fileclose>
80103407:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010340a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010340d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103412:	5b                   	pop    %ebx
80103413:	5e                   	pop    %esi
80103414:	5f                   	pop    %edi
80103415:	5d                   	pop    %ebp
80103416:	c3                   	ret    
80103417:	89 f6                	mov    %esi,%esi
80103419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103420:	8b 03                	mov    (%ebx),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 e4                	je     8010340a <pipealloc+0x5a>
    fileclose(*f0);
80103426:	83 ec 0c             	sub    $0xc,%esp
80103429:	50                   	push   %eax
8010342a:	e8 71 db ff ff       	call   80100fa0 <fileclose>
  if(*f1)
8010342f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103431:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103434:	85 c0                	test   %eax,%eax
80103436:	75 c6                	jne    801033fe <pipealloc+0x4e>
80103438:	eb d0                	jmp    8010340a <pipealloc+0x5a>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103440:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103443:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010344a:	00 00 00 
  p->writeopen = 1;
8010344d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103454:	00 00 00 
  p->nwrite = 0;
80103457:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010345e:	00 00 00 
  p->nread = 0;
80103461:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103468:	00 00 00 
  initlock(&p->lock, "pipe");
8010346b:	68 70 86 10 80       	push   $0x80108670
80103470:	50                   	push   %eax
80103471:	e8 8a 1d 00 00       	call   80105200 <initlock>
  (*f0)->type = FD_PIPE;
80103476:	8b 03                	mov    (%ebx),%eax
  return 0;
80103478:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010347b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103481:	8b 03                	mov    (%ebx),%eax
80103483:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103487:	8b 03                	mov    (%ebx),%eax
80103489:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010348d:	8b 03                	mov    (%ebx),%eax
8010348f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103492:	8b 06                	mov    (%esi),%eax
80103494:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010349a:	8b 06                	mov    (%esi),%eax
8010349c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034a0:	8b 06                	mov    (%esi),%eax
801034a2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034a6:	8b 06                	mov    (%esi),%eax
801034a8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801034ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034ae:	31 c0                	xor    %eax,%eax
}
801034b0:	5b                   	pop    %ebx
801034b1:	5e                   	pop    %esi
801034b2:	5f                   	pop    %edi
801034b3:	5d                   	pop    %ebp
801034b4:	c3                   	ret    
801034b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	56                   	push   %esi
801034c4:	53                   	push   %ebx
801034c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034cb:	83 ec 0c             	sub    $0xc,%esp
801034ce:	53                   	push   %ebx
801034cf:	e8 6c 1e 00 00       	call   80105340 <acquire>
  if(writable){
801034d4:	83 c4 10             	add    $0x10,%esp
801034d7:	85 f6                	test   %esi,%esi
801034d9:	74 45                	je     80103520 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034db:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034e1:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
801034e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034eb:	00 00 00 
    wakeup(&p->nread);
801034ee:	50                   	push   %eax
801034ef:	e8 9c 0d 00 00       	call   80104290 <wakeup>
801034f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801034f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801034fd:	85 d2                	test   %edx,%edx
801034ff:	75 0a                	jne    8010350b <pipeclose+0x4b>
80103501:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103507:	85 c0                	test   %eax,%eax
80103509:	74 35                	je     80103540 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010350b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010350e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103511:	5b                   	pop    %ebx
80103512:	5e                   	pop    %esi
80103513:	5d                   	pop    %ebp
    release(&p->lock);
80103514:	e9 e7 1e 00 00       	jmp    80105400 <release>
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103520:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103526:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103529:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103530:	00 00 00 
    wakeup(&p->nwrite);
80103533:	50                   	push   %eax
80103534:	e8 57 0d 00 00       	call   80104290 <wakeup>
80103539:	83 c4 10             	add    $0x10,%esp
8010353c:	eb b9                	jmp    801034f7 <pipeclose+0x37>
8010353e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103540:	83 ec 0c             	sub    $0xc,%esp
80103543:	53                   	push   %ebx
80103544:	e8 b7 1e 00 00       	call   80105400 <release>
    kfree((char*)p);
80103549:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010354c:	83 c4 10             	add    $0x10,%esp
}
8010354f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5d                   	pop    %ebp
    kfree((char*)p);
80103555:	e9 26 ef ff ff       	jmp    80102480 <kfree>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103560 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103560:	55                   	push   %ebp
80103561:	89 e5                	mov    %esp,%ebp
80103563:	57                   	push   %edi
80103564:	56                   	push   %esi
80103565:	53                   	push   %ebx
80103566:	83 ec 28             	sub    $0x28,%esp
80103569:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010356c:	53                   	push   %ebx
8010356d:	e8 ce 1d 00 00       	call   80105340 <acquire>
  for(i = 0; i < n; i++){
80103572:	8b 45 10             	mov    0x10(%ebp),%eax
80103575:	83 c4 10             	add    $0x10,%esp
80103578:	85 c0                	test   %eax,%eax
8010357a:	0f 8e c9 00 00 00    	jle    80103649 <pipewrite+0xe9>
80103580:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103583:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103589:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010358f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103592:	03 4d 10             	add    0x10(%ebp),%ecx
80103595:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103598:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010359e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801035a4:	39 d0                	cmp    %edx,%eax
801035a6:	75 71                	jne    80103619 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801035a8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035ae:	85 c0                	test   %eax,%eax
801035b0:	74 4e                	je     80103600 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035b2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801035b8:	eb 3a                	jmp    801035f4 <pipewrite+0x94>
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	57                   	push   %edi
801035c4:	e8 c7 0c 00 00       	call   80104290 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c9:	5a                   	pop    %edx
801035ca:	59                   	pop    %ecx
801035cb:	53                   	push   %ebx
801035cc:	56                   	push   %esi
801035cd:	e8 ce 14 00 00       	call   80104aa0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035d2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035d8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801035de:	83 c4 10             	add    $0x10,%esp
801035e1:	05 00 02 00 00       	add    $0x200,%eax
801035e6:	39 c2                	cmp    %eax,%edx
801035e8:	75 36                	jne    80103620 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801035ea:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801035f0:	85 c0                	test   %eax,%eax
801035f2:	74 0c                	je     80103600 <pipewrite+0xa0>
801035f4:	e8 b7 05 00 00       	call   80103bb0 <myproc>
801035f9:	8b 40 14             	mov    0x14(%eax),%eax
801035fc:	85 c0                	test   %eax,%eax
801035fe:	74 c0                	je     801035c0 <pipewrite+0x60>
        release(&p->lock);
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	53                   	push   %ebx
80103604:	e8 f7 1d 00 00       	call   80105400 <release>
        return -1;
80103609:	83 c4 10             	add    $0x10,%esp
8010360c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103611:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103614:	5b                   	pop    %ebx
80103615:	5e                   	pop    %esi
80103616:	5f                   	pop    %edi
80103617:	5d                   	pop    %ebp
80103618:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103619:	89 c2                	mov    %eax,%edx
8010361b:	90                   	nop
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103620:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103623:	8d 42 01             	lea    0x1(%edx),%eax
80103626:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010362c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103632:	83 c6 01             	add    $0x1,%esi
80103635:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103639:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010363c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010363f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103643:	0f 85 4f ff ff ff    	jne    80103598 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103649:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010364f:	83 ec 0c             	sub    $0xc,%esp
80103652:	50                   	push   %eax
80103653:	e8 38 0c 00 00       	call   80104290 <wakeup>
  release(&p->lock);
80103658:	89 1c 24             	mov    %ebx,(%esp)
8010365b:	e8 a0 1d 00 00       	call   80105400 <release>
  return n;
80103660:	83 c4 10             	add    $0x10,%esp
80103663:	8b 45 10             	mov    0x10(%ebp),%eax
80103666:	eb a9                	jmp    80103611 <pipewrite+0xb1>
80103668:	90                   	nop
80103669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103670 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 18             	sub    $0x18,%esp
80103679:	8b 75 08             	mov    0x8(%ebp),%esi
8010367c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	56                   	push   %esi
80103680:	e8 bb 1c 00 00       	call   80105340 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010368e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103694:	75 6a                	jne    80103700 <piperead+0x90>
80103696:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010369c:	85 db                	test   %ebx,%ebx
8010369e:	0f 84 c4 00 00 00    	je     80103768 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036a4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036aa:	eb 2d                	jmp    801036d9 <piperead+0x69>
801036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b0:	83 ec 08             	sub    $0x8,%esp
801036b3:	56                   	push   %esi
801036b4:	53                   	push   %ebx
801036b5:	e8 e6 13 00 00       	call   80104aa0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ba:	83 c4 10             	add    $0x10,%esp
801036bd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801036c3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801036c9:	75 35                	jne    80103700 <piperead+0x90>
801036cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801036d1:	85 d2                	test   %edx,%edx
801036d3:	0f 84 8f 00 00 00    	je     80103768 <piperead+0xf8>
    if(myproc()->killed){
801036d9:	e8 d2 04 00 00       	call   80103bb0 <myproc>
801036de:	8b 48 14             	mov    0x14(%eax),%ecx
801036e1:	85 c9                	test   %ecx,%ecx
801036e3:	74 cb                	je     801036b0 <piperead+0x40>
      release(&p->lock);
801036e5:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801036e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801036ed:	56                   	push   %esi
801036ee:	e8 0d 1d 00 00       	call   80105400 <release>
      return -1;
801036f3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036f9:	89 d8                	mov    %ebx,%eax
801036fb:	5b                   	pop    %ebx
801036fc:	5e                   	pop    %esi
801036fd:	5f                   	pop    %edi
801036fe:	5d                   	pop    %ebp
801036ff:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103700:	8b 45 10             	mov    0x10(%ebp),%eax
80103703:	85 c0                	test   %eax,%eax
80103705:	7e 61                	jle    80103768 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103707:	31 db                	xor    %ebx,%ebx
80103709:	eb 13                	jmp    8010371e <piperead+0xae>
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103710:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103716:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010371c:	74 1f                	je     8010373d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010371e:	8d 41 01             	lea    0x1(%ecx),%eax
80103721:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103727:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010372d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103732:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	83 c3 01             	add    $0x1,%ebx
80103738:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010373b:	75 d3                	jne    80103710 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103743:	83 ec 0c             	sub    $0xc,%esp
80103746:	50                   	push   %eax
80103747:	e8 44 0b 00 00       	call   80104290 <wakeup>
  release(&p->lock);
8010374c:	89 34 24             	mov    %esi,(%esp)
8010374f:	e8 ac 1c 00 00       	call   80105400 <release>
  return i;
80103754:	83 c4 10             	add    $0x10,%esp
}
80103757:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010375a:	89 d8                	mov    %ebx,%eax
8010375c:	5b                   	pop    %ebx
8010375d:	5e                   	pop    %esi
8010375e:	5f                   	pop    %edi
8010375f:	5d                   	pop    %ebp
80103760:	c3                   	ret    
80103761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103768:	31 db                	xor    %ebx,%ebx
8010376a:	eb d1                	jmp    8010373d <piperead+0xcd>
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void) {
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp
80103773:	53                   	push   %ebx
    struct proc *p;
    acquire(&ptable.lock);
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103774:	bb 14 51 11 80       	mov    $0x80115114,%ebx
allocproc(void) {
80103779:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);
8010377c:	68 e0 50 11 80       	push   $0x801150e0
80103781:	e8 ba 1b 00 00       	call   80105340 <acquire>
80103786:	83 c4 10             	add    $0x10,%esp
80103789:	eb 13                	jmp    8010379e <allocproc+0x2e>
8010378b:	90                   	nop
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103790:	81 c3 f0 03 00 00    	add    $0x3f0,%ebx
80103796:	81 fb 14 4d 12 80    	cmp    $0x80124d14,%ebx
8010379c:	73 3a                	jae    801037d8 <allocproc+0x68>
        if (p->state == UNUSED)
8010379e:	8b 43 08             	mov    0x8(%ebx),%eax
801037a1:	85 c0                	test   %eax,%eax
801037a3:	75 eb                	jne    80103790 <allocproc+0x20>
    release(&ptable.lock);
    return 0;

    found:
    p->state = USED;
    p->pid = nextpid++;
801037a5:	a1 0c b0 10 80       	mov    0x8010b00c,%eax
    release(&ptable.lock);
801037aa:	83 ec 0c             	sub    $0xc,%esp
    p->state = USED;
801037ad:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
    p->pid = nextpid++;
801037b4:	89 43 0c             	mov    %eax,0xc(%ebx)
801037b7:	8d 50 01             	lea    0x1(%eax),%edx
    release(&ptable.lock);
801037ba:	68 e0 50 11 80       	push   $0x801150e0
    p->pid = nextpid++;
801037bf:	89 15 0c b0 10 80    	mov    %edx,0x8010b00c
    release(&ptable.lock);
801037c5:	e8 36 1c 00 00       	call   80105400 <release>

    return p;
}
801037ca:	89 d8                	mov    %ebx,%eax
    return p;
801037cc:	83 c4 10             	add    $0x10,%esp
}
801037cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037d2:	c9                   	leave  
801037d3:	c3                   	ret    
801037d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
801037d8:	83 ec 0c             	sub    $0xc,%esp
    return 0;
801037db:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
801037dd:	68 e0 50 11 80       	push   $0x801150e0
801037e2:	e8 19 1c 00 00       	call   80105400 <release>
}
801037e7:	89 d8                	mov    %ebx,%eax
    return 0;
801037e9:	83 c4 10             	add    $0x10,%esp
}
801037ec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037ef:	c9                   	leave  
801037f0:	c3                   	ret    
801037f1:	eb 0d                	jmp    80103800 <allocthread>
801037f3:	90                   	nop
801037f4:	90                   	nop
801037f5:	90                   	nop
801037f6:	90                   	nop
801037f7:	90                   	nop
801037f8:	90                   	nop
801037f9:	90                   	nop
801037fa:	90                   	nop
801037fb:	90                   	nop
801037fc:	90                   	nop
801037fd:	90                   	nop
801037fe:	90                   	nop
801037ff:	90                   	nop

80103800 <allocthread>:


static struct thread *
allocthread(struct proc *p) {
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	56                   	push   %esi
80103804:	53                   	push   %ebx
80103805:	89 c6                	mov    %eax,%esi
    struct thread *t;
    char *sp;
    int i;
    acquire(&ptable.lock);
80103807:	83 ec 0c             	sub    $0xc,%esp
    for (i = 1, t = p->ttable; t < &p->ttable[NTHREAD]; t++, i++) {
8010380a:	8d 5e 5c             	lea    0x5c(%esi),%ebx
    acquire(&ptable.lock);
8010380d:	68 e0 50 11 80       	push   $0x801150e0
80103812:	e8 29 1b 00 00       	call   80105340 <acquire>
        if (t->state == T_UNUSED) {
80103817:	8b 4e 60             	mov    0x60(%esi),%ecx
8010381a:	83 c4 10             	add    $0x10,%esp
8010381d:	8d 86 dc 03 00 00    	lea    0x3dc(%esi),%eax
80103823:	85 c9                	test   %ecx,%ecx
80103825:	75 10                	jne    80103837 <allocthread+0x37>
80103827:	eb 37                	jmp    80103860 <allocthread+0x60>
80103829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103830:	8b 53 04             	mov    0x4(%ebx),%edx
80103833:	85 d2                	test   %edx,%edx
80103835:	74 29                	je     80103860 <allocthread+0x60>
    for (i = 1, t = p->ttable; t < &p->ttable[NTHREAD]; t++, i++) {
80103837:	83 c3 38             	add    $0x38,%ebx
8010383a:	39 c3                	cmp    %eax,%ebx
8010383c:	72 f2                	jb     80103830 <allocthread+0x30>
            goto found;
        }
    }
    release(&ptable.lock);
8010383e:	83 ec 0c             	sub    $0xc,%esp
    return 0;
80103841:	31 db                	xor    %ebx,%ebx
    release(&ptable.lock);
80103843:	68 e0 50 11 80       	push   $0x801150e0
80103848:	e8 b3 1b 00 00       	call   80105400 <release>
    return 0;
8010384d:	83 c4 10             	add    $0x10,%esp
    t->context = (struct context *) sp;
    memset(t->context, 0, sizeof *t->context);
    t->context->eip = (uint) forkret;
    p->numOfthread++;
    return t;
}
80103850:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103853:	89 d8                	mov    %ebx,%eax
80103855:	5b                   	pop    %ebx
80103856:	5e                   	pop    %esi
80103857:	5d                   	pop    %ebp
80103858:	c3                   	ret    
80103859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    t->tid = nexttid++;
80103860:	a1 08 b0 10 80       	mov    0x8010b008,%eax
    release(&ptable.lock);
80103865:	83 ec 0c             	sub    $0xc,%esp
    t->state = T_EMBRYO;
80103868:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
    t->parent = p;
8010386f:	89 73 10             	mov    %esi,0x10(%ebx)
    t->next_thread = 0;
80103872:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    t->mutex_flag = 0;
80103879:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
    t->shouldDie = 0;
80103880:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    t->tid = nexttid++;
80103887:	8d 50 01             	lea    0x1(%eax),%edx
8010388a:	89 43 0c             	mov    %eax,0xc(%ebx)
    release(&ptable.lock);
8010388d:	68 e0 50 11 80       	push   $0x801150e0
    t->tid = nexttid++;
80103892:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
    release(&ptable.lock);
80103898:	e8 63 1b 00 00       	call   80105400 <release>
    if ((t->kstack = kalloc()) == 0) {
8010389d:	e8 8e ed ff ff       	call   80102630 <kalloc>
801038a2:	83 c4 10             	add    $0x10,%esp
801038a5:	85 c0                	test   %eax,%eax
801038a7:	89 03                	mov    %eax,(%ebx)
801038a9:	74 42                	je     801038ed <allocthread+0xed>
    sp -= sizeof *t->tf;
801038ab:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
    memset(t->context, 0, sizeof *t->context);
801038b1:	83 ec 04             	sub    $0x4,%esp
    sp -= sizeof *t->context;
801038b4:	05 9c 0f 00 00       	add    $0xf9c,%eax
    sp -= sizeof *t->tf;
801038b9:	89 53 08             	mov    %edx,0x8(%ebx)
    *(uint *) sp = (uint) trapret;
801038bc:	c7 40 14 bf 67 10 80 	movl   $0x801067bf,0x14(%eax)
    t->context = (struct context *) sp;
801038c3:	89 43 14             	mov    %eax,0x14(%ebx)
    memset(t->context, 0, sizeof *t->context);
801038c6:	6a 14                	push   $0x14
801038c8:	6a 00                	push   $0x0
801038ca:	50                   	push   %eax
801038cb:	e8 80 1b 00 00       	call   80105450 <memset>
    t->context->eip = (uint) forkret;
801038d0:	8b 43 14             	mov    0x14(%ebx),%eax
    return t;
801038d3:	83 c4 10             	add    $0x10,%esp
    t->context->eip = (uint) forkret;
801038d6:	c7 40 10 10 39 10 80 	movl   $0x80103910,0x10(%eax)
    p->numOfthread++;
801038dd:	83 86 ec 03 00 00 01 	addl   $0x1,0x3ec(%esi)
}
801038e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801038e7:	89 d8                	mov    %ebx,%eax
801038e9:	5b                   	pop    %ebx
801038ea:	5e                   	pop    %esi
801038eb:	5d                   	pop    %ebp
801038ec:	c3                   	ret    
        p->state = UNUSED;
801038ed:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
        t->state = T_UNUSED;
801038f4:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        return 0;
801038fb:	31 db                	xor    %ebx,%ebx
801038fd:	e9 4e ff ff ff       	jmp    80103850 <allocthread+0x50>
80103902:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103910 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void) {
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 14             	sub    $0x14,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80103916:	68 e0 50 11 80       	push   $0x801150e0
8010391b:	e8 e0 1a 00 00       	call   80105400 <release>

    if (first) {
80103920:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	85 c0                	test   %eax,%eax
8010392a:	75 04                	jne    80103930 <forkret+0x20>
        iinit(ROOTDEV);
        initlog(ROOTDEV);
    }

    // Return to "caller", actually trapret (see allocproc).
}
8010392c:	c9                   	leave  
8010392d:	c3                   	ret    
8010392e:	66 90                	xchg   %ax,%ax
        iinit(ROOTDEV);
80103930:	83 ec 0c             	sub    $0xc,%esp
        first = 0;
80103933:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010393a:	00 00 00 
        iinit(ROOTDEV);
8010393d:	6a 01                	push   $0x1
8010393f:	e8 ac dc ff ff       	call   801015f0 <iinit>
        initlog(ROOTDEV);
80103944:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010394b:	e8 20 f3 ff ff       	call   80102c70 <initlog>
80103950:	83 c4 10             	add    $0x10,%esp
}
80103953:	c9                   	leave  
80103954:	c3                   	ret    
80103955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <pinit>:
pinit(void) {
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	bb 80 3d 11 80       	mov    $0x80113d80,%ebx
80103969:	83 ec 0c             	sub    $0xc,%esp
    initlock(&mtable.lock, "mtable");
8010396c:	68 75 86 10 80       	push   $0x80108675
80103971:	68 40 3d 11 80       	push   $0x80113d40
80103976:	e8 85 18 00 00       	call   80105200 <initlock>
    initlock(&ptable.lock, "ptable");
8010397b:	58                   	pop    %eax
8010397c:	5a                   	pop    %edx
8010397d:	68 7c 86 10 80       	push   $0x8010867c
80103982:	68 e0 50 11 80       	push   $0x801150e0
80103987:	e8 74 18 00 00       	call   80105200 <initlock>
8010398c:	83 c4 10             	add    $0x10,%esp
8010398f:	90                   	nop
        initlock(&mtable.mutex[i].mutexLock, "mutexLock");
80103990:	83 ec 08             	sub    $0x8,%esp
80103993:	68 83 86 10 80       	push   $0x80108683
80103998:	53                   	push   %ebx
80103999:	83 c3 4c             	add    $0x4c,%ebx
8010399c:	e8 5f 18 00 00       	call   80105200 <initlock>
    for (int i = 0; i < MAX_MUTEXES; i++) {
801039a1:	83 c4 10             	add    $0x10,%esp
801039a4:	81 fb 80 50 11 80    	cmp    $0x80115080,%ebx
801039aa:	75 e4                	jne    80103990 <pinit+0x30>
}
801039ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039af:	c9                   	leave  
801039b0:	c3                   	ret    
801039b1:	eb 0d                	jmp    801039c0 <cprintState>
801039b3:	90                   	nop
801039b4:	90                   	nop
801039b5:	90                   	nop
801039b6:	90                   	nop
801039b7:	90                   	nop
801039b8:	90                   	nop
801039b9:	90                   	nop
801039ba:	90                   	nop
801039bb:	90                   	nop
801039bc:	90                   	nop
801039bd:	90                   	nop
801039be:	90                   	nop
801039bf:	90                   	nop

801039c0 <cprintState>:
void cprintState(struct thread *t) {
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	83 ec 08             	sub    $0x8,%esp
801039c6:	8b 45 08             	mov    0x8(%ebp),%eax
    switch (t->state) {
801039c9:	83 78 04 05          	cmpl   $0x5,0x4(%eax)
801039cd:	77 2b                	ja     801039fa <cprintState+0x3a>
801039cf:	8b 50 04             	mov    0x4(%eax),%edx
            cprintf("thread id %d and he killed=%d that is father is %s in state T_ZOMBIE\n", t->tid,t->shouldDie, t->parent->name);
801039d2:	8b 48 10             	mov    0x10(%eax),%ecx
    switch (t->state) {
801039d5:	ff 24 95 1c 8a 10 80 	jmp    *-0x7fef75e4(,%edx,4)
801039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_RUNNING\n", t->tid,t->shouldDie, t->parent->name);
801039e0:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
801039e6:	52                   	push   %edx
801039e7:	ff 70 1c             	pushl  0x1c(%eax)
801039ea:	ff 70 0c             	pushl  0xc(%eax)
801039ed:	68 08 89 10 80       	push   $0x80108908
801039f2:	e8 69 cc ff ff       	call   80100660 <cprintf>
            break;
801039f7:	83 c4 10             	add    $0x10,%esp
}
801039fa:	c9                   	leave  
801039fb:	c3                   	ret    
801039fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_ZOMBIE\n", t->tid,t->shouldDie, t->parent->name);
80103a00:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80103a06:	52                   	push   %edx
80103a07:	ff 70 1c             	pushl  0x1c(%eax)
80103a0a:	ff 70 0c             	pushl  0xc(%eax)
80103a0d:	68 a0 87 10 80       	push   $0x801087a0
80103a12:	e8 49 cc ff ff       	call   80100660 <cprintf>
            break;
80103a17:	83 c4 10             	add    $0x10,%esp
}
80103a1a:	c9                   	leave  
80103a1b:	c3                   	ret    
80103a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_UNUSED\n", t->tid,t->shouldDie, t->parent->name);
80103a20:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80103a26:	52                   	push   %edx
80103a27:	ff 70 1c             	pushl  0x1c(%eax)
80103a2a:	ff 70 0c             	pushl  0xc(%eax)
80103a2d:	68 78 88 10 80       	push   $0x80108878
80103a32:	e8 29 cc ff ff       	call   80100660 <cprintf>
            break;
80103a37:	83 c4 10             	add    $0x10,%esp
}
80103a3a:	c9                   	leave  
80103a3b:	c3                   	ret    
80103a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_EMBRYO\n", t->tid,t->shouldDie, t->parent->name);
80103a40:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80103a46:	52                   	push   %edx
80103a47:	ff 70 1c             	pushl  0x1c(%eax)
80103a4a:	ff 70 0c             	pushl  0xc(%eax)
80103a4d:	68 c0 88 10 80       	push   $0x801088c0
80103a52:	e8 09 cc ff ff       	call   80100660 <cprintf>
            break;
80103a57:	83 c4 10             	add    $0x10,%esp
}
80103a5a:	c9                   	leave  
80103a5b:	c3                   	ret    
80103a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_SLEEPING\n", t->tid,t->shouldDie, t->parent->name);
80103a60:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80103a66:	52                   	push   %edx
80103a67:	ff 70 1c             	pushl  0x1c(%eax)
80103a6a:	ff 70 0c             	pushl  0xc(%eax)
80103a6d:	68 30 88 10 80       	push   $0x80108830
80103a72:	e8 e9 cb ff ff       	call   80100660 <cprintf>
            break;
80103a77:	83 c4 10             	add    $0x10,%esp
}
80103a7a:	c9                   	leave  
80103a7b:	c3                   	ret    
80103a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("thread id %d and he killed=%d that is father is %s in state T_RUNNABLE\n",t->tid,t->shouldDie, t->parent->name);
80103a80:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80103a86:	52                   	push   %edx
80103a87:	ff 70 1c             	pushl  0x1c(%eax)
80103a8a:	ff 70 0c             	pushl  0xc(%eax)
80103a8d:	68 e8 87 10 80       	push   $0x801087e8
80103a92:	e8 c9 cb ff ff       	call   80100660 <cprintf>
            break;
80103a97:	83 c4 10             	add    $0x10,%esp
}
80103a9a:	c9                   	leave  
80103a9b:	c3                   	ret    
80103a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103aa0 <cprintMutexState>:
void cprintMutexState(struct mutex *m) {
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	83 ec 08             	sub    $0x8,%esp
80103aa6:	8b 45 08             	mov    0x8(%ebp),%eax
    switch (m->state) {
80103aa9:	8b 50 40             	mov    0x40(%eax),%edx
80103aac:	83 fa 01             	cmp    $0x1,%edx
80103aaf:	74 37                	je     80103ae8 <cprintMutexState+0x48>
80103ab1:	72 1d                	jb     80103ad0 <cprintMutexState+0x30>
80103ab3:	83 fa 02             	cmp    $0x2,%edx
80103ab6:	75 12                	jne    80103aca <cprintMutexState+0x2a>
            cprintf("mutex id is %d and is state = CLOSE\n", m->mid);
80103ab8:	83 ec 08             	sub    $0x8,%esp
80103abb:	ff 30                	pushl  (%eax)
80103abd:	68 a4 89 10 80       	push   $0x801089a4
80103ac2:	e8 99 cb ff ff       	call   80100660 <cprintf>
            break;
80103ac7:	83 c4 10             	add    $0x10,%esp
}
80103aca:	c9                   	leave  
80103acb:	c3                   	ret    
80103acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("mutex id is %d and is state = UNINITIALIZED\n", m->mid);
80103ad0:	83 ec 08             	sub    $0x8,%esp
80103ad3:	ff 30                	pushl  (%eax)
80103ad5:	68 50 89 10 80       	push   $0x80108950
80103ada:	e8 81 cb ff ff       	call   80100660 <cprintf>
            break;
80103adf:	83 c4 10             	add    $0x10,%esp
}
80103ae2:	c9                   	leave  
80103ae3:	c3                   	ret    
80103ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("mutex id is %d and is state = OPEN\n", m->mid);
80103ae8:	83 ec 08             	sub    $0x8,%esp
80103aeb:	ff 30                	pushl  (%eax)
80103aed:	68 80 89 10 80       	push   $0x80108980
80103af2:	e8 69 cb ff ff       	call   80100660 <cprintf>
            break;
80103af7:	83 c4 10             	add    $0x10,%esp
}
80103afa:	c9                   	leave  
80103afb:	c3                   	ret    
80103afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b00 <mySpinlock>:
mySpinlock() {
80103b00:	55                   	push   %ebp
}
80103b01:	b8 e0 50 11 80       	mov    $0x801150e0,%eax
mySpinlock() {
80103b06:	89 e5                	mov    %esp,%ebp
}
80103b08:	5d                   	pop    %ebp
80103b09:	c3                   	ret    
80103b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b10 <mycpu>:
mycpu(void) {
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	56                   	push   %esi
80103b14:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b15:	9c                   	pushf  
80103b16:	58                   	pop    %eax
    if (readeflags() & FL_IF)
80103b17:	f6 c4 02             	test   $0x2,%ah
80103b1a:	75 5e                	jne    80103b7a <mycpu+0x6a>
    apicid = lapicid();
80103b1c:	e8 7f ed ff ff       	call   801028a0 <lapicid>
    for (i = 0; i < ncpu; ++i) {
80103b21:	8b 35 20 3d 11 80    	mov    0x80113d20,%esi
80103b27:	85 f6                	test   %esi,%esi
80103b29:	7e 42                	jle    80103b6d <mycpu+0x5d>
        if (cpus[i].apicid == apicid)
80103b2b:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
80103b32:	39 d0                	cmp    %edx,%eax
80103b34:	74 30                	je     80103b66 <mycpu+0x56>
80103b36:	b9 34 38 11 80       	mov    $0x80113834,%ecx
    for (i = 0; i < ncpu; ++i) {
80103b3b:	31 d2                	xor    %edx,%edx
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi
80103b40:	83 c2 01             	add    $0x1,%edx
80103b43:	39 f2                	cmp    %esi,%edx
80103b45:	74 26                	je     80103b6d <mycpu+0x5d>
        if (cpus[i].apicid == apicid)
80103b47:	0f b6 19             	movzbl (%ecx),%ebx
80103b4a:	81 c1 b4 00 00 00    	add    $0xb4,%ecx
80103b50:	39 c3                	cmp    %eax,%ebx
80103b52:	75 ec                	jne    80103b40 <mycpu+0x30>
80103b54:	69 c2 b4 00 00 00    	imul   $0xb4,%edx,%eax
80103b5a:	05 80 37 11 80       	add    $0x80113780,%eax
}
80103b5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b62:	5b                   	pop    %ebx
80103b63:	5e                   	pop    %esi
80103b64:	5d                   	pop    %ebp
80103b65:	c3                   	ret    
        if (cpus[i].apicid == apicid)
80103b66:	b8 80 37 11 80       	mov    $0x80113780,%eax
            return &cpus[i];
80103b6b:	eb f2                	jmp    80103b5f <mycpu+0x4f>
    panic("unknown apicid\n");
80103b6d:	83 ec 0c             	sub    $0xc,%esp
80103b70:	68 8d 86 10 80       	push   $0x8010868d
80103b75:	e8 16 c8 ff ff       	call   80100390 <panic>
        panic("mycpu called with interrupts enabled\n");
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 cc 89 10 80       	push   $0x801089cc
80103b82:	e8 09 c8 ff ff       	call   80100390 <panic>
80103b87:	89 f6                	mov    %esi,%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b90 <cpuid>:
cpuid() {
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	83 ec 08             	sub    $0x8,%esp
    return mycpu() - cpus;
80103b96:	e8 75 ff ff ff       	call   80103b10 <mycpu>
80103b9b:	2d 80 37 11 80       	sub    $0x80113780,%eax
}
80103ba0:	c9                   	leave  
    return mycpu() - cpus;
80103ba1:	c1 f8 02             	sar    $0x2,%eax
80103ba4:	69 c0 a5 4f fa a4    	imul   $0xa4fa4fa5,%eax,%eax
}
80103baa:	c3                   	ret    
80103bab:	90                   	nop
80103bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103bb0 <myproc>:
myproc(void) {
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	53                   	push   %ebx
80103bb4:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80103bb7:	e8 b4 16 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103bbc:	e8 4f ff ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80103bc1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103bc7:	e8 e4 16 00 00       	call   801052b0 <popcli>
}
80103bcc:	83 c4 04             	add    $0x4,%esp
80103bcf:	89 d8                	mov    %ebx,%eax
80103bd1:	5b                   	pop    %ebx
80103bd2:	5d                   	pop    %ebp
80103bd3:	c3                   	ret    
80103bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103be0 <mythread>:
mythread(void) {
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	53                   	push   %ebx
80103be4:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80103be7:	e8 84 16 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103bec:	e8 1f ff ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80103bf1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80103bf7:	e8 b4 16 00 00       	call   801052b0 <popcli>
}
80103bfc:	83 c4 04             	add    $0x4,%esp
80103bff:	89 d8                	mov    %ebx,%eax
80103c01:	5b                   	pop    %ebx
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret    
80103c04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c10 <userinit>:
userinit(void) {
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
    p = allocproc();
80103c15:	e8 56 fb ff ff       	call   80103770 <allocproc>
80103c1a:	89 c6                	mov    %eax,%esi
    t = allocthread(p);
80103c1c:	e8 df fb ff ff       	call   80103800 <allocthread>
    initproc = p;
80103c21:	89 35 b8 b5 10 80    	mov    %esi,0x8010b5b8
    t = allocthread(p);
80103c27:	89 c3                	mov    %eax,%ebx
    if ((p->pgdir = setupkvm()) == 0)
80103c29:	e8 42 42 00 00       	call   80107e70 <setupkvm>
80103c2e:	85 c0                	test   %eax,%eax
80103c30:	89 46 04             	mov    %eax,0x4(%esi)
80103c33:	0f 84 dc 00 00 00    	je     80103d15 <userinit+0x105>
    inituvm(p->pgdir, _binary_initcode_start, (int) _binary_initcode_size);
80103c39:	83 ec 04             	sub    $0x4,%esp
80103c3c:	68 2c 00 00 00       	push   $0x2c
80103c41:	68 60 b4 10 80       	push   $0x8010b460
80103c46:	50                   	push   %eax
80103c47:	e8 04 3f 00 00       	call   80107b50 <inituvm>
    memset(t->tf, 0, sizeof(*t->tf));
80103c4c:	83 c4 0c             	add    $0xc,%esp
    p->sz = PGSIZE;
80103c4f:	c7 06 00 10 00 00    	movl   $0x1000,(%esi)
    memset(t->tf, 0, sizeof(*t->tf));
80103c55:	6a 4c                	push   $0x4c
80103c57:	6a 00                	push   $0x0
80103c59:	ff 73 08             	pushl  0x8(%ebx)
80103c5c:	e8 ef 17 00 00       	call   80105450 <memset>
    t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c61:	8b 43 08             	mov    0x8(%ebx),%eax
80103c64:	ba 1b 00 00 00       	mov    $0x1b,%edx
    t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c69:	b9 23 00 00 00       	mov    $0x23,%ecx
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103c6e:	83 c4 0c             	add    $0xc,%esp
    t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c71:	66 89 50 3c          	mov    %dx,0x3c(%eax)
    t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c75:	8b 43 08             	mov    0x8(%ebx),%eax
80103c78:	66 89 48 2c          	mov    %cx,0x2c(%eax)
    t->tf->es = t->tf->ds;
80103c7c:	8b 43 08             	mov    0x8(%ebx),%eax
80103c7f:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c83:	66 89 50 28          	mov    %dx,0x28(%eax)
    t->tf->ss = t->tf->ds;
80103c87:	8b 43 08             	mov    0x8(%ebx),%eax
80103c8a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c8e:	66 89 50 48          	mov    %dx,0x48(%eax)
    t->tf->eflags = FL_IF;
80103c92:	8b 43 08             	mov    0x8(%ebx),%eax
80103c95:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    t->tf->esp = PGSIZE;
80103c9c:	8b 43 08             	mov    0x8(%ebx),%eax
80103c9f:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    t->tf->eip = 0;  // beginning of initcode.S
80103ca6:	8b 43 08             	mov    0x8(%ebx),%eax
80103ca9:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
    safestrcpy(p->name, "initcode", sizeof(p->name));
80103cb0:	8d 86 dc 03 00 00    	lea    0x3dc(%esi),%eax
80103cb6:	6a 10                	push   $0x10
80103cb8:	68 b6 86 10 80       	push   $0x801086b6
80103cbd:	50                   	push   %eax
80103cbe:	e8 6d 19 00 00       	call   80105630 <safestrcpy>
    safestrcpy(t->name, "initcodeThread", sizeof(t->name));
80103cc3:	8d 43 28             	lea    0x28(%ebx),%eax
80103cc6:	83 c4 0c             	add    $0xc,%esp
80103cc9:	6a 10                	push   $0x10
80103ccb:	68 bf 86 10 80       	push   $0x801086bf
80103cd0:	50                   	push   %eax
80103cd1:	e8 5a 19 00 00       	call   80105630 <safestrcpy>
    p->cwd = namei("/");
80103cd6:	c7 04 24 ce 86 10 80 	movl   $0x801086ce,(%esp)
80103cdd:	e8 6e e3 ff ff       	call   80102050 <namei>
80103ce2:	89 46 58             	mov    %eax,0x58(%esi)
    acquire(&ptable.lock);
80103ce5:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80103cec:	e8 4f 16 00 00       	call   80105340 <acquire>
    p->state = USED;
80103cf1:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
    t->state = T_RUNNABLE;
80103cf8:	c7 43 04 03 00 00 00 	movl   $0x3,0x4(%ebx)
    release(&ptable.lock);
80103cff:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80103d06:	e8 f5 16 00 00       	call   80105400 <release>
}
80103d0b:	83 c4 10             	add    $0x10,%esp
80103d0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d11:	5b                   	pop    %ebx
80103d12:	5e                   	pop    %esi
80103d13:	5d                   	pop    %ebp
80103d14:	c3                   	ret    
        panic("userinit: out of memory?");
80103d15:	83 ec 0c             	sub    $0xc,%esp
80103d18:	68 9d 86 10 80       	push   $0x8010869d
80103d1d:	e8 6e c6 ff ff       	call   80100390 <panic>
80103d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d30 <growproc>:
growproc(int n) {
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
80103d35:	53                   	push   %ebx
80103d36:	83 ec 0c             	sub    $0xc,%esp
80103d39:	8b 75 08             	mov    0x8(%ebp),%esi
    pushcli();
80103d3c:	e8 2f 15 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103d41:	e8 ca fd ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80103d46:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103d4c:	e8 5f 15 00 00       	call   801052b0 <popcli>
    pushcli();
80103d51:	e8 1a 15 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103d56:	e8 b5 fd ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80103d5b:	8b b8 b0 00 00 00    	mov    0xb0(%eax),%edi
    popcli();
80103d61:	e8 4a 15 00 00       	call   801052b0 <popcli>
    acquire(&ptable.lock);
80103d66:	83 ec 0c             	sub    $0xc,%esp
80103d69:	68 e0 50 11 80       	push   $0x801150e0
80103d6e:	e8 cd 15 00 00       	call   80105340 <acquire>
    if (n > 0) {
80103d73:	83 c4 10             	add    $0x10,%esp
80103d76:	83 fe 00             	cmp    $0x0,%esi
    sz = curproc->sz;
80103d79:	8b 03                	mov    (%ebx),%eax
    if (n > 0) {
80103d7b:	7f 2b                	jg     80103da8 <growproc+0x78>
    } else if (n < 0) {
80103d7d:	75 59                	jne    80103dd8 <growproc+0xa8>
    release(&ptable.lock);
80103d7f:	83 ec 0c             	sub    $0xc,%esp
    curproc->sz = sz;
80103d82:	89 03                	mov    %eax,(%ebx)
    release(&ptable.lock);
80103d84:	68 e0 50 11 80       	push   $0x801150e0
80103d89:	e8 72 16 00 00       	call   80105400 <release>
    switchuvm(curthread, curproc);
80103d8e:	58                   	pop    %eax
80103d8f:	5a                   	pop    %edx
80103d90:	53                   	push   %ebx
80103d91:	57                   	push   %edi
80103d92:	e8 89 3c 00 00       	call   80107a20 <switchuvm>
    return 0;
80103d97:	83 c4 10             	add    $0x10,%esp
80103d9a:	31 c0                	xor    %eax,%eax
}
80103d9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d9f:	5b                   	pop    %ebx
80103da0:	5e                   	pop    %esi
80103da1:	5f                   	pop    %edi
80103da2:	5d                   	pop    %ebp
80103da3:	c3                   	ret    
80103da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0) {
80103da8:	83 ec 04             	sub    $0x4,%esp
80103dab:	01 c6                	add    %eax,%esi
80103dad:	56                   	push   %esi
80103dae:	50                   	push   %eax
80103daf:	ff 73 04             	pushl  0x4(%ebx)
80103db2:	e8 d9 3e 00 00       	call   80107c90 <allocuvm>
80103db7:	83 c4 10             	add    $0x10,%esp
80103dba:	85 c0                	test   %eax,%eax
80103dbc:	75 c1                	jne    80103d7f <growproc+0x4f>
            release(&ptable.lock);
80103dbe:	83 ec 0c             	sub    $0xc,%esp
80103dc1:	68 e0 50 11 80       	push   $0x801150e0
80103dc6:	e8 35 16 00 00       	call   80105400 <release>
            return -1;
80103dcb:	83 c4 10             	add    $0x10,%esp
80103dce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103dd3:	eb c7                	jmp    80103d9c <growproc+0x6c>
80103dd5:	8d 76 00             	lea    0x0(%esi),%esi
        if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0) {
80103dd8:	83 ec 04             	sub    $0x4,%esp
80103ddb:	01 c6                	add    %eax,%esi
80103ddd:	56                   	push   %esi
80103dde:	50                   	push   %eax
80103ddf:	ff 73 04             	pushl  0x4(%ebx)
80103de2:	e8 d9 3f 00 00       	call   80107dc0 <deallocuvm>
80103de7:	83 c4 10             	add    $0x10,%esp
80103dea:	85 c0                	test   %eax,%eax
80103dec:	75 91                	jne    80103d7f <growproc+0x4f>
80103dee:	eb ce                	jmp    80103dbe <growproc+0x8e>

80103df0 <fork>:
fork(void) {
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	57                   	push   %edi
80103df4:	56                   	push   %esi
80103df5:	53                   	push   %ebx
80103df6:	83 ec 1c             	sub    $0x1c,%esp
    pushcli();
80103df9:	e8 72 14 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103dfe:	e8 0d fd ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80103e03:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103e09:	e8 a2 14 00 00       	call   801052b0 <popcli>
    pushcli();
80103e0e:	e8 5d 14 00 00       	call   80105270 <pushcli>
    c = mycpu();
80103e13:	e8 f8 fc ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80103e18:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80103e1e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    popcli();
80103e21:	e8 8a 14 00 00       	call   801052b0 <popcli>
    if ((np = allocproc()) == 0) {
80103e26:	e8 45 f9 ff ff       	call   80103770 <allocproc>
80103e2b:	85 c0                	test   %eax,%eax
80103e2d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e30:	0f 84 20 01 00 00    	je     80103f56 <fork+0x166>
    if ((nt = allocthread(np)) == 0) {
80103e36:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103e39:	89 f8                	mov    %edi,%eax
80103e3b:	e8 c0 f9 ff ff       	call   80103800 <allocthread>
80103e40:	85 c0                	test   %eax,%eax
80103e42:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103e45:	0f 84 0b 01 00 00    	je     80103f56 <fork+0x166>
    if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0) {
80103e4b:	83 ec 08             	sub    $0x8,%esp
80103e4e:	ff 33                	pushl  (%ebx)
80103e50:	ff 73 04             	pushl  0x4(%ebx)
80103e53:	e8 e8 40 00 00       	call   80107f40 <copyuvm>
80103e58:	83 c4 10             	add    $0x10,%esp
80103e5b:	85 c0                	test   %eax,%eax
80103e5d:	89 47 04             	mov    %eax,0x4(%edi)
80103e60:	0f 84 c9 00 00 00    	je     80103f2f <fork+0x13f>
    np->sz = curproc->sz;
80103e66:	8b 03                	mov    (%ebx),%eax
80103e68:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    *nt->tf = *curthread->tf;
80103e6b:	b9 13 00 00 00       	mov    $0x13,%ecx
    np->sz = curproc->sz;
80103e70:	89 02                	mov    %eax,(%edx)
    *nt->tf = *curthread->tf;
80103e72:	8b 45 dc             	mov    -0x24(%ebp),%eax
    np->parent = curproc;
80103e75:	89 5a 10             	mov    %ebx,0x10(%edx)
    *nt->tf = *curthread->tf;
80103e78:	8b 70 08             	mov    0x8(%eax),%esi
80103e7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e7e:	8b 78 08             	mov    0x8(%eax),%edi
80103e81:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    for (i = 0; i < NOFILE; i++)
80103e83:	31 f6                	xor    %esi,%esi
80103e85:	89 d7                	mov    %edx,%edi
    nt->tf->eax = 0;
80103e87:	8b 40 08             	mov    0x8(%eax),%eax
80103e8a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (curproc->ofile[i])
80103e98:	8b 44 b3 18          	mov    0x18(%ebx,%esi,4),%eax
80103e9c:	85 c0                	test   %eax,%eax
80103e9e:	74 10                	je     80103eb0 <fork+0xc0>
            np->ofile[i] = filedup(curproc->ofile[i]);
80103ea0:	83 ec 0c             	sub    $0xc,%esp
80103ea3:	50                   	push   %eax
80103ea4:	e8 a7 d0 ff ff       	call   80100f50 <filedup>
80103ea9:	83 c4 10             	add    $0x10,%esp
80103eac:	89 44 b7 18          	mov    %eax,0x18(%edi,%esi,4)
    for (i = 0; i < NOFILE; i++)
80103eb0:	83 c6 01             	add    $0x1,%esi
80103eb3:	83 fe 10             	cmp    $0x10,%esi
80103eb6:	75 e0                	jne    80103e98 <fork+0xa8>
    np->cwd = idup(curproc->cwd);
80103eb8:	83 ec 0c             	sub    $0xc,%esp
80103ebb:	ff 73 58             	pushl  0x58(%ebx)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ebe:	81 c3 dc 03 00 00    	add    $0x3dc,%ebx
    np->cwd = idup(curproc->cwd);
80103ec4:	e8 f7 d8 ff ff       	call   801017c0 <idup>
80103ec9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ecc:	83 c4 0c             	add    $0xc,%esp
    np->cwd = idup(curproc->cwd);
80103ecf:	89 47 58             	mov    %eax,0x58(%edi)
    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ed2:	8d 87 dc 03 00 00    	lea    0x3dc(%edi),%eax
80103ed8:	6a 10                	push   $0x10
80103eda:	53                   	push   %ebx
80103edb:	50                   	push   %eax
80103edc:	e8 4f 17 00 00       	call   80105630 <safestrcpy>
    safestrcpy(nt->name, curthread->name, sizeof(curthread->name));
80103ee1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103ee4:	8b 75 e0             	mov    -0x20(%ebp),%esi
80103ee7:	83 c4 0c             	add    $0xc,%esp
80103eea:	6a 10                	push   $0x10
80103eec:	83 c0 28             	add    $0x28,%eax
80103eef:	50                   	push   %eax
80103ef0:	8d 46 28             	lea    0x28(%esi),%eax
80103ef3:	50                   	push   %eax
80103ef4:	e8 37 17 00 00       	call   80105630 <safestrcpy>
    pid = np->pid;
80103ef9:	8b 5f 0c             	mov    0xc(%edi),%ebx
    acquire(&ptable.lock);
80103efc:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80103f03:	e8 38 14 00 00       	call   80105340 <acquire>
    np->state = USED;
80103f08:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
    nt->state = T_RUNNABLE;
80103f0f:	c7 46 04 03 00 00 00 	movl   $0x3,0x4(%esi)
    release(&ptable.lock);
80103f16:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80103f1d:	e8 de 14 00 00       	call   80105400 <release>
    return pid;
80103f22:	83 c4 10             	add    $0x10,%esp
}
80103f25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f28:	89 d8                	mov    %ebx,%eax
80103f2a:	5b                   	pop    %ebx
80103f2b:	5e                   	pop    %esi
80103f2c:	5f                   	pop    %edi
80103f2d:	5d                   	pop    %ebp
80103f2e:	c3                   	ret    
        kfree(nt->kstack);
80103f2f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80103f32:	83 ec 0c             	sub    $0xc,%esp
80103f35:	ff 33                	pushl  (%ebx)
80103f37:	e8 44 e5 ff ff       	call   80102480 <kfree>
        np->state = UNUSED;
80103f3c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
        nt->kstack = 0;
80103f3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
        return -1;
80103f45:	83 c4 10             	add    $0x10,%esp
        np->state = UNUSED;
80103f48:	c7 41 08 00 00 00 00 	movl   $0x0,0x8(%ecx)
        nt->state = T_UNUSED;
80103f4f:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        return -1;
80103f56:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103f5b:	eb c8                	jmp    80103f25 <fork+0x135>
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi

80103f60 <scheduler>:
scheduler(void) {
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	57                   	push   %edi
80103f64:	56                   	push   %esi
80103f65:	53                   	push   %ebx
80103f66:	83 ec 1c             	sub    $0x1c,%esp
    struct cpu *c = mycpu();
80103f69:	e8 a2 fb ff ff       	call   80103b10 <mycpu>
    c->proc = 0;
80103f6e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f75:	00 00 00 
    struct cpu *c = mycpu();
80103f78:	89 c7                	mov    %eax,%edi
80103f7a:	8d 40 04             	lea    0x4(%eax),%eax
80103f7d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("sti");
80103f80:	fb                   	sti    
        acquire(&ptable.lock);
80103f81:	83 ec 0c             	sub    $0xc,%esp
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103f84:	be 14 51 11 80       	mov    $0x80115114,%esi
        acquire(&ptable.lock);
80103f89:	68 e0 50 11 80       	push   $0x801150e0
80103f8e:	e8 ad 13 00 00       	call   80105340 <acquire>
80103f93:	83 c4 10             	add    $0x10,%esp
80103f96:	8d 76 00             	lea    0x0(%esi),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103fa0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80103fa3:	8d 96 dc 03 00 00    	lea    0x3dc(%esi),%edx
80103fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                if (t->state != T_RUNNABLE)
80103fb0:	83 7b 04 03          	cmpl   $0x3,0x4(%ebx)
80103fb4:	75 53                	jne    80104009 <scheduler+0xa9>
                switchuvm(t, p);
80103fb6:	83 ec 08             	sub    $0x8,%esp
                c->proc = p;
80103fb9:	89 b7 ac 00 00 00    	mov    %esi,0xac(%edi)
                c->thread = t;
80103fbf:	89 9f b0 00 00 00    	mov    %ebx,0xb0(%edi)
                switchuvm(t, p);
80103fc5:	56                   	push   %esi
80103fc6:	53                   	push   %ebx
80103fc7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103fca:	e8 51 3a 00 00       	call   80107a20 <switchuvm>
                p->state = USED;
80103fcf:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
                t->state = T_RUNNING;
80103fd6:	c7 43 04 04 00 00 00 	movl   $0x4,0x4(%ebx)
                swtch(&(c->scheduler), t->context);
80103fdd:	58                   	pop    %eax
80103fde:	5a                   	pop    %edx
80103fdf:	ff 73 14             	pushl  0x14(%ebx)
80103fe2:	ff 75 e0             	pushl  -0x20(%ebp)
80103fe5:	e8 a1 16 00 00       	call   8010568b <swtch>
                switchkvm();
80103fea:	e8 11 3a 00 00       	call   80107a00 <switchkvm>
                c->thread = 0;
80103fef:	8b 55 e4             	mov    -0x1c(%ebp),%edx
                c->proc = 0;
80103ff2:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103ff9:	00 00 00 
                c->thread = 0;
80103ffc:	83 c4 10             	add    $0x10,%esp
80103fff:	c7 87 b0 00 00 00 00 	movl   $0x0,0xb0(%edi)
80104006:	00 00 00 
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104009:	83 c3 38             	add    $0x38,%ebx
8010400c:	39 da                	cmp    %ebx,%edx
8010400e:	77 a0                	ja     80103fb0 <scheduler+0x50>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104010:	81 c6 f0 03 00 00    	add    $0x3f0,%esi
80104016:	81 fe 14 4d 12 80    	cmp    $0x80124d14,%esi
8010401c:	72 82                	jb     80103fa0 <scheduler+0x40>
        release(&ptable.lock);
8010401e:	83 ec 0c             	sub    $0xc,%esp
80104021:	68 e0 50 11 80       	push   $0x801150e0
80104026:	e8 d5 13 00 00       	call   80105400 <release>
        sti();
8010402b:	83 c4 10             	add    $0x10,%esp
8010402e:	e9 4d ff ff ff       	jmp    80103f80 <scheduler+0x20>
80104033:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <sched>:
sched(void) {
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	57                   	push   %edi
80104044:	56                   	push   %esi
80104045:	53                   	push   %ebx
80104046:	83 ec 18             	sub    $0x18,%esp
    if (!holding(&ptable.lock))
80104049:	68 e0 50 11 80       	push   $0x801150e0
8010404e:	e8 bd 12 00 00       	call   80105310 <holding>
80104053:	83 c4 10             	add    $0x10,%esp
80104056:	85 c0                	test   %eax,%eax
80104058:	74 7f                	je     801040d9 <sched+0x99>
    if (mycpu()->ncli != 1)
8010405a:	e8 b1 fa ff ff       	call   80103b10 <mycpu>
8010405f:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104066:	0f 85 94 00 00 00    	jne    80104100 <sched+0xc0>
    pushcli();
8010406c:	e8 ff 11 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104071:	e8 9a fa ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104076:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
8010407c:	e8 2f 12 00 00       	call   801052b0 <popcli>
    if (mythread()->state == T_RUNNING)
80104081:	83 7b 04 04          	cmpl   $0x4,0x4(%ebx)
80104085:	74 6c                	je     801040f3 <sched+0xb3>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104087:	9c                   	pushf  
80104088:	58                   	pop    %eax
    if (readeflags() & FL_IF)
80104089:	f6 c4 02             	test   $0x2,%ah
8010408c:	75 58                	jne    801040e6 <sched+0xa6>
    intena = mycpu()->intena;
8010408e:	e8 7d fa ff ff       	call   80103b10 <mycpu>
80104093:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&mythread()->context, mycpu()->scheduler);
80104099:	e8 72 fa ff ff       	call   80103b10 <mycpu>
8010409e:	8b 78 04             	mov    0x4(%eax),%edi
    pushcli();
801040a1:	e8 ca 11 00 00       	call   80105270 <pushcli>
    c = mycpu();
801040a6:	e8 65 fa ff ff       	call   80103b10 <mycpu>
    t = c->thread;
801040ab:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
801040b1:	e8 fa 11 00 00       	call   801052b0 <popcli>
    swtch(&mythread()->context, mycpu()->scheduler);
801040b6:	83 ec 08             	sub    $0x8,%esp
801040b9:	83 c3 14             	add    $0x14,%ebx
801040bc:	57                   	push   %edi
801040bd:	53                   	push   %ebx
801040be:	e8 c8 15 00 00       	call   8010568b <swtch>
    mycpu()->intena = intena;
801040c3:	e8 48 fa ff ff       	call   80103b10 <mycpu>
}
801040c8:	83 c4 10             	add    $0x10,%esp
    mycpu()->intena = intena;
801040cb:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801040d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040d4:	5b                   	pop    %ebx
801040d5:	5e                   	pop    %esi
801040d6:	5f                   	pop    %edi
801040d7:	5d                   	pop    %ebp
801040d8:	c3                   	ret    
        panic("sched ptable.lock");
801040d9:	83 ec 0c             	sub    $0xc,%esp
801040dc:	68 d0 86 10 80       	push   $0x801086d0
801040e1:	e8 aa c2 ff ff       	call   80100390 <panic>
        panic("sched interruptible");
801040e6:	83 ec 0c             	sub    $0xc,%esp
801040e9:	68 06 87 10 80       	push   $0x80108706
801040ee:	e8 9d c2 ff ff       	call   80100390 <panic>
        panic("sched running curthread");
801040f3:	83 ec 0c             	sub    $0xc,%esp
801040f6:	68 ee 86 10 80       	push   $0x801086ee
801040fb:	e8 90 c2 ff ff       	call   80100390 <panic>
        panic("sched locks");
80104100:	83 ec 0c             	sub    $0xc,%esp
80104103:	68 e2 86 10 80       	push   $0x801086e2
80104108:	e8 83 c2 ff ff       	call   80100390 <panic>
8010410d:	8d 76 00             	lea    0x0(%esi),%esi

80104110 <exitThread>:
void exitThread(void) {
80104110:	55                   	push   %ebp
80104111:	89 e5                	mov    %esp,%ebp
80104113:	56                   	push   %esi
80104114:	53                   	push   %ebx
    acquire(&ptable.lock);
80104115:	83 ec 0c             	sub    $0xc,%esp
80104118:	68 e0 50 11 80       	push   $0x801150e0
8010411d:	e8 1e 12 00 00       	call   80105340 <acquire>
    pushcli();
80104122:	e8 49 11 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104127:	e8 e4 f9 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
8010412c:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104132:	e8 79 11 00 00       	call   801052b0 <popcli>
    for (t = myproc()->ttable; t < &(myproc()->ttable[NTHREAD]); t++) {
80104137:	83 c4 10             	add    $0x10,%esp
8010413a:	83 c3 5c             	add    $0x5c,%ebx
    pushcli();
8010413d:	e8 2e 11 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104142:	e8 c9 f9 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104147:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010414d:	e8 5e 11 00 00       	call   801052b0 <popcli>
    for (t = myproc()->ttable; t < &(myproc()->ttable[NTHREAD]); t++) {
80104152:	81 c6 dc 03 00 00    	add    $0x3dc,%esi
80104158:	39 f3                	cmp    %esi,%ebx
8010415a:	73 7a                	jae    801041d6 <exitThread+0xc6>
    pushcli();
8010415c:	e8 0f 11 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104161:	e8 aa f9 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104166:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
    popcli();
8010416c:	e8 3f 11 00 00       	call   801052b0 <popcli>
static void
wakeup1(void *chan) {
    struct proc *p;
    struct thread *t;

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104171:	b9 14 51 11 80       	mov    $0x80115114,%ecx
80104176:	8d 76 00             	lea    0x0(%esi),%esi
80104179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104180:	8d 41 5c             	lea    0x5c(%ecx),%eax
80104183:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
80104189:	eb 0c                	jmp    80104197 <exitThread+0x87>
8010418b:	90                   	nop
8010418c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104190:	83 c0 38             	add    $0x38,%eax
80104193:	39 d0                	cmp    %edx,%eax
80104195:	73 29                	jae    801041c0 <exitThread+0xb0>
            if (t->state == T_SLEEPING && t->chan == chan) {
80104197:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010419b:	75 f3                	jne    80104190 <exitThread+0x80>
8010419d:	39 70 18             	cmp    %esi,0x18(%eax)
801041a0:	75 ee                	jne    80104190 <exitThread+0x80>
                p->state = USED;
801041a2:	c7 41 08 01 00 00 00 	movl   $0x1,0x8(%ecx)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801041a9:	83 c0 38             	add    $0x38,%eax
                t->state = T_RUNNABLE;
801041ac:	c7 40 cc 03 00 00 00 	movl   $0x3,-0x34(%eax)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801041b3:	39 d0                	cmp    %edx,%eax
801041b5:	72 e0                	jb     80104197 <exitThread+0x87>
801041b7:	89 f6                	mov    %esi,%esi
801041b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801041c0:	81 c1 f0 03 00 00    	add    $0x3f0,%ecx
801041c6:	81 f9 14 4d 12 80    	cmp    $0x80124d14,%ecx
801041cc:	72 b2                	jb     80104180 <exitThread+0x70>
    for (t = myproc()->ttable; t < &(myproc()->ttable[NTHREAD]); t++) {
801041ce:	83 c3 38             	add    $0x38,%ebx
801041d1:	e9 67 ff ff ff       	jmp    8010413d <exitThread+0x2d>
    pushcli();
801041d6:	e8 95 10 00 00       	call   80105270 <pushcli>
    c = mycpu();
801041db:	e8 30 f9 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
801041e0:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
801041e6:	e8 c5 10 00 00       	call   801052b0 <popcli>
    mythread()->shouldDie = 0;
801041eb:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
    pushcli();
801041f2:	e8 79 10 00 00       	call   80105270 <pushcli>
    c = mycpu();
801041f7:	e8 14 f9 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
801041fc:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104202:	e8 a9 10 00 00       	call   801052b0 <popcli>
    mythread()->state = T_ZOMBIE;
80104207:	c7 43 04 05 00 00 00 	movl   $0x5,0x4(%ebx)
    sched();
8010420e:	e8 2d fe ff ff       	call   80104040 <sched>
    panic("exitThread exit");
80104213:	83 ec 0c             	sub    $0xc,%esp
80104216:	68 1a 87 10 80       	push   $0x8010871a
8010421b:	e8 70 c1 ff ff       	call   80100390 <panic>

80104220 <yield>:
yield(void) {
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104227:	68 e0 50 11 80       	push   $0x801150e0
8010422c:	e8 0f 11 00 00       	call   80105340 <acquire>
    pushcli();
80104231:	e8 3a 10 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104236:	e8 d5 f8 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
8010423b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104241:	e8 6a 10 00 00       	call   801052b0 <popcli>
    myproc()->state = USED;
80104246:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
    pushcli();
8010424d:	e8 1e 10 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104252:	e8 b9 f8 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104257:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
8010425d:	e8 4e 10 00 00       	call   801052b0 <popcli>
    mythread()->state = T_RUNNABLE;
80104262:	c7 43 04 03 00 00 00 	movl   $0x3,0x4(%ebx)
    sched();
80104269:	e8 d2 fd ff ff       	call   80104040 <sched>
    release(&ptable.lock);
8010426e:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
80104275:	e8 86 11 00 00       	call   80105400 <release>
}
8010427a:	83 c4 10             	add    $0x10,%esp
8010427d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104280:	c9                   	leave  
80104281:	c3                   	ret    
80104282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104290 <wakeup>:

}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan) {
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 10             	sub    $0x10,%esp
80104297:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&ptable.lock);
8010429a:	68 e0 50 11 80       	push   $0x801150e0
8010429f:	e8 9c 10 00 00       	call   80105340 <acquire>
801042a4:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801042a7:	b9 14 51 11 80       	mov    $0x80115114,%ecx
801042ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042b0:	8d 41 5c             	lea    0x5c(%ecx),%eax
801042b3:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
801042b9:	eb 0c                	jmp    801042c7 <wakeup+0x37>
801042bb:	90                   	nop
801042bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801042c0:	83 c0 38             	add    $0x38,%eax
801042c3:	39 d0                	cmp    %edx,%eax
801042c5:	73 29                	jae    801042f0 <wakeup+0x60>
            if (t->state == T_SLEEPING && t->chan == chan) {
801042c7:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801042cb:	75 f3                	jne    801042c0 <wakeup+0x30>
801042cd:	3b 58 18             	cmp    0x18(%eax),%ebx
801042d0:	75 ee                	jne    801042c0 <wakeup+0x30>
                p->state = USED;
801042d2:	c7 41 08 01 00 00 00 	movl   $0x1,0x8(%ecx)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801042d9:	83 c0 38             	add    $0x38,%eax
                t->state = T_RUNNABLE;
801042dc:	c7 40 cc 03 00 00 00 	movl   $0x3,-0x34(%eax)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801042e3:	39 d0                	cmp    %edx,%eax
801042e5:	72 e0                	jb     801042c7 <wakeup+0x37>
801042e7:	89 f6                	mov    %esi,%esi
801042e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801042f0:	81 c1 f0 03 00 00    	add    $0x3f0,%ecx
801042f6:	81 f9 14 4d 12 80    	cmp    $0x80124d14,%ecx
801042fc:	72 b2                	jb     801042b0 <wakeup+0x20>
    wakeup1(chan);
    release(&ptable.lock);
801042fe:	c7 45 08 e0 50 11 80 	movl   $0x801150e0,0x8(%ebp)
}
80104305:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104308:	c9                   	leave  
    release(&ptable.lock);
80104309:	e9 f2 10 00 00       	jmp    80105400 <release>
8010430e:	66 90                	xchg   %ax,%ax

80104310 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid) {
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	53                   	push   %ebx
80104314:	83 ec 10             	sub    $0x10,%esp
80104317:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;
    struct thread *t;

    acquire(&ptable.lock);
8010431a:	68 e0 50 11 80       	push   $0x801150e0
8010431f:	e8 1c 10 00 00       	call   80105340 <acquire>
80104324:	83 c4 10             	add    $0x10,%esp
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104327:	b8 14 51 11 80       	mov    $0x80115114,%eax
8010432c:	eb 0e                	jmp    8010433c <kill+0x2c>
8010432e:	66 90                	xchg   %ax,%ax
80104330:	05 f0 03 00 00       	add    $0x3f0,%eax
80104335:	3d 14 4d 12 80       	cmp    $0x80124d14,%eax
8010433a:	73 44                	jae    80104380 <kill+0x70>
        if (p->pid == pid) {
8010433c:	39 58 0c             	cmp    %ebx,0xc(%eax)
8010433f:	75 ef                	jne    80104330 <kill+0x20>
            p->killed = 1;
80104341:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
            // Wake process from sleep if necessary.
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104348:	8d 50 5c             	lea    0x5c(%eax),%edx
8010434b:	05 dc 03 00 00       	add    $0x3dc,%eax
                if (t->state == T_SLEEPING)
80104350:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
80104354:	75 07                	jne    8010435d <kill+0x4d>
                    t->state = T_RUNNABLE;
80104356:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
8010435d:	83 c2 38             	add    $0x38,%edx
80104360:	39 d0                	cmp    %edx,%eax
80104362:	77 ec                	ja     80104350 <kill+0x40>
            }
            release(&ptable.lock);
80104364:	83 ec 0c             	sub    $0xc,%esp
80104367:	68 e0 50 11 80       	push   $0x801150e0
8010436c:	e8 8f 10 00 00       	call   80105400 <release>
            return 0;
80104371:	83 c4 10             	add    $0x10,%esp
80104374:	31 c0                	xor    %eax,%eax
        }
    }
    release(&ptable.lock);
    return -1;
}
80104376:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104379:	c9                   	leave  
8010437a:	c3                   	ret    
8010437b:	90                   	nop
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104380:	83 ec 0c             	sub    $0xc,%esp
80104383:	68 e0 50 11 80       	push   $0x801150e0
80104388:	e8 73 10 00 00       	call   80105400 <release>
    return -1;
8010438d:	83 c4 10             	add    $0x10,%esp
80104390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104398:	c9                   	leave  
80104399:	c3                   	ret    
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043a0 <procdump>:
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void) {
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	56                   	push   %esi
801043a5:	53                   	push   %ebx
    struct proc *p;
    struct thread *t;
    char *state;
    uint pc[10];

    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801043a6:	bf 14 51 11 80       	mov    $0x80115114,%edi
procdump(void) {
801043ab:	83 ec 4c             	sub    $0x4c,%esp
801043ae:	66 90                	xchg   %ax,%ax
        if (p->state == UNUSED)
801043b0:	8b 47 08             	mov    0x8(%edi),%eax
801043b3:	85 c0                	test   %eax,%eax
801043b5:	74 6d                	je     80104424 <procdump+0x84>
801043b7:	8d 87 dc 03 00 00    	lea    0x3dc(%edi),%eax
801043bd:	8d 77 5c             	lea    0x5c(%edi),%esi
            continue;
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
            if (t->state >= 0 && t->state < NELEM(states) && states[t->state])
                state = states[t->state];
            else
                state = "???";
801043c0:	89 7d b0             	mov    %edi,-0x50(%ebp)
801043c3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801043c6:	89 f7                	mov    %esi,%edi
801043c8:	90                   	nop
801043c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (t->state >= 0 && t->state < NELEM(states) && states[t->state])
801043d0:	8b 4f 04             	mov    0x4(%edi),%ecx
                state = "???";
801043d3:	ba 2a 87 10 80       	mov    $0x8010872a,%edx
            if (t->state >= 0 && t->state < NELEM(states) && states[t->state])
801043d8:	83 f9 05             	cmp    $0x5,%ecx
801043db:	77 11                	ja     801043ee <procdump+0x4e>
801043dd:	8b 14 8d 34 8a 10 80 	mov    -0x7fef75cc(,%ecx,4),%edx
                state = "???";
801043e4:	b8 2a 87 10 80       	mov    $0x8010872a,%eax
801043e9:	85 d2                	test   %edx,%edx
801043eb:	0f 44 d0             	cmove  %eax,%edx
            cprintf("%d %s %s", t->tid, state, t->name);
801043ee:	8d 4f 28             	lea    0x28(%edi),%ecx
801043f1:	51                   	push   %ecx
801043f2:	52                   	push   %edx
801043f3:	ff 77 0c             	pushl  0xc(%edi)
801043f6:	68 2e 87 10 80       	push   $0x8010872e
801043fb:	e8 60 c2 ff ff       	call   80100660 <cprintf>
            if (t->state == T_SLEEPING) {
80104400:	83 c4 10             	add    $0x10,%esp
80104403:	83 7f 04 02          	cmpl   $0x2,0x4(%edi)
80104407:	74 37                	je     80104440 <procdump+0xa0>
                getcallerpcs((uint *) t->context->ebp + 2, pc);
                for (i = 0; i < 10 && pc[i] != 0; i++)
                    cprintf(" %p", pc[i]);
            }
            cprintf("\n");
80104409:	83 ec 0c             	sub    $0xc,%esp
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
8010440c:	83 c7 38             	add    $0x38,%edi
            cprintf("\n");
8010440f:	68 8c 8d 10 80       	push   $0x80108d8c
80104414:	e8 47 c2 ff ff       	call   80100660 <cprintf>
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104419:	83 c4 10             	add    $0x10,%esp
8010441c:	3b 7d b4             	cmp    -0x4c(%ebp),%edi
8010441f:	72 af                	jb     801043d0 <procdump+0x30>
80104421:	8b 7d b0             	mov    -0x50(%ebp),%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104424:	81 c7 f0 03 00 00    	add    $0x3f0,%edi
8010442a:	81 ff 14 4d 12 80    	cmp    $0x80124d14,%edi
80104430:	0f 82 7a ff ff ff    	jb     801043b0 <procdump+0x10>
        }

    }
}
80104436:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104439:	5b                   	pop    %ebx
8010443a:	5e                   	pop    %esi
8010443b:	5f                   	pop    %edi
8010443c:	5d                   	pop    %ebp
8010443d:	c3                   	ret    
8010443e:	66 90                	xchg   %ax,%ax
                getcallerpcs((uint *) t->context->ebp + 2, pc);
80104440:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104443:	83 ec 08             	sub    $0x8,%esp
80104446:	8d 5d c0             	lea    -0x40(%ebp),%ebx
80104449:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010444c:	50                   	push   %eax
8010444d:	8b 57 14             	mov    0x14(%edi),%edx
80104450:	8b 52 0c             	mov    0xc(%edx),%edx
80104453:	83 c2 08             	add    $0x8,%edx
80104456:	52                   	push   %edx
80104457:	e8 c4 0d 00 00       	call   80105220 <getcallerpcs>
8010445c:	83 c4 10             	add    $0x10,%esp
8010445f:	90                   	nop
                for (i = 0; i < 10 && pc[i] != 0; i++)
80104460:	8b 03                	mov    (%ebx),%eax
80104462:	85 c0                	test   %eax,%eax
80104464:	74 a3                	je     80104409 <procdump+0x69>
                    cprintf(" %p", pc[i]);
80104466:	83 ec 08             	sub    $0x8,%esp
80104469:	83 c3 04             	add    $0x4,%ebx
8010446c:	50                   	push   %eax
8010446d:	68 61 81 10 80       	push   $0x80108161
80104472:	e8 e9 c1 ff ff       	call   80100660 <cprintf>
                for (i = 0; i < 10 && pc[i] != 0; i++)
80104477:	83 c4 10             	add    $0x10,%esp
8010447a:	39 f3                	cmp    %esi,%ebx
8010447c:	75 e2                	jne    80104460 <procdump+0xc0>
8010447e:	eb 89                	jmp    80104409 <procdump+0x69>

80104480 <kthread_create>:

int kthread_create(void (*start_func)(), void *stack) {
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	53                   	push   %ebx
80104486:	83 ec 0c             	sub    $0xc,%esp
    pushcli();
80104489:	e8 e2 0d 00 00       	call   80105270 <pushcli>
    c = mycpu();
8010448e:	e8 7d f6 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104493:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
    popcli();
80104499:	e8 12 0e 00 00       	call   801052b0 <popcli>
    struct thread *t;
    struct thread *curthread = mythread();

    if (curthread == 0 || start_func <= 0 || stack <= 0) {
8010449e:	8b 45 08             	mov    0x8(%ebp),%eax
801044a1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801044a4:	85 c0                	test   %eax,%eax
801044a6:	0f 94 c2             	sete   %dl
801044a9:	85 c9                	test   %ecx,%ecx
801044ab:	0f 94 c0             	sete   %al
801044ae:	08 c2                	or     %al,%dl
801044b0:	0f 85 8a 00 00 00    	jne    80104540 <kthread_create+0xc0>
801044b6:	85 f6                	test   %esi,%esi
801044b8:	0f 84 82 00 00 00    	je     80104540 <kthread_create+0xc0>
    pushcli();
801044be:	e8 ad 0d 00 00       	call   80105270 <pushcli>
    c = mycpu();
801044c3:	e8 48 f6 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
801044c8:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801044ce:	e8 dd 0d 00 00       	call   801052b0 <popcli>
        return -1;
    }
    if ((t = allocthread(myproc())) == 0) {
801044d3:	89 d8                	mov    %ebx,%eax
801044d5:	e8 26 f3 ff ff       	call   80103800 <allocthread>
801044da:	85 c0                	test   %eax,%eax
801044dc:	89 c3                	mov    %eax,%ebx
801044de:	74 60                	je     80104540 <kthread_create+0xc0>
        return -1;
    }
    acquire(&ptable.lock);
801044e0:	83 ec 0c             	sub    $0xc,%esp
801044e3:	68 e0 50 11 80       	push   $0x801150e0
801044e8:	e8 53 0e 00 00       	call   80105340 <acquire>

    safestrcpy(t->name, "thread", sizeof("thread"));
801044ed:	8d 43 28             	lea    0x28(%ebx),%eax
801044f0:	83 c4 0c             	add    $0xc,%esp
801044f3:	6a 07                	push   $0x7
801044f5:	68 f2 8c 10 80       	push   $0x80108cf2
801044fa:	50                   	push   %eax
801044fb:	e8 30 11 00 00       	call   80105630 <safestrcpy>
    *t->tf = *curthread->tf;
80104500:	8b 76 08             	mov    0x8(%esi),%esi
80104503:	8b 7b 08             	mov    0x8(%ebx),%edi
80104506:	b9 13 00 00 00       	mov    $0x13,%ecx
8010450b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->esp = (uint) (stack);
8010450d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    t->tf->eip = (uint) start_func;
80104510:	8b 7d 08             	mov    0x8(%ebp),%edi
    t->tf->esp = (uint) (stack);
80104513:	8b 43 08             	mov    0x8(%ebx),%eax
80104516:	89 48 44             	mov    %ecx,0x44(%eax)
    t->tf->eip = (uint) start_func;
80104519:	8b 43 08             	mov    0x8(%ebx),%eax
8010451c:	89 78 38             	mov    %edi,0x38(%eax)

    t->state = T_RUNNABLE;
8010451f:	c7 43 04 03 00 00 00 	movl   $0x3,0x4(%ebx)
    release(&ptable.lock);
80104526:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
8010452d:	e8 ce 0e 00 00       	call   80105400 <release>

    return t->tid;
80104532:	8b 43 0c             	mov    0xc(%ebx),%eax
80104535:	83 c4 10             	add    $0x10,%esp


}
80104538:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010453b:	5b                   	pop    %ebx
8010453c:	5e                   	pop    %esi
8010453d:	5f                   	pop    %edi
8010453e:	5d                   	pop    %ebp
8010453f:	c3                   	ret    
        return -1;
80104540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104545:	eb f1                	jmp    80104538 <kthread_create+0xb8>
80104547:	89 f6                	mov    %esi,%esi
80104549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104550 <kthread_id>:

int kthread_id() {
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 04             	sub    $0x4,%esp
    pushcli();
80104557:	e8 14 0d 00 00       	call   80105270 <pushcli>
    c = mycpu();
8010455c:	e8 af f5 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104561:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104567:	e8 44 0d 00 00       	call   801052b0 <popcli>
    if (mythread() == 0)
8010456c:	85 db                	test   %ebx,%ebx
8010456e:	74 20                	je     80104590 <kthread_id+0x40>
    pushcli();
80104570:	e8 fb 0c 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104575:	e8 96 f5 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
8010457a:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104580:	e8 2b 0d 00 00       	call   801052b0 <popcli>
        return -1;
    return mythread()->tid;
80104585:	8b 43 0c             	mov    0xc(%ebx),%eax
}
80104588:	83 c4 04             	add    $0x4,%esp
8010458b:	5b                   	pop    %ebx
8010458c:	5d                   	pop    %ebp
8010458d:	c3                   	ret    
8010458e:	66 90                	xchg   %ax,%ax
        return -1;
80104590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104595:	eb f1                	jmp    80104588 <kthread_id+0x38>
80104597:	89 f6                	mov    %esi,%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045a0 <kthread_mutex_alloc>:
            sleep(t, &ptable.lock);  //DOC: wait-sleep
        }
    }
}

int kthread_mutex_alloc() {
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	57                   	push   %edi
801045a4:	56                   	push   %esi
801045a5:	53                   	push   %ebx
801045a6:	83 ec 18             	sub    $0x18,%esp
    int i;
    acquire(&mtable.lock);
801045a9:	68 40 3d 11 80       	push   $0x80113d40
801045ae:	e8 8d 0d 00 00       	call   80105340 <acquire>
801045b3:	ba b4 3d 11 80       	mov    $0x80113db4,%edx
801045b8:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < MAX_MUTEXES; i++) {
801045bb:	31 c0                	xor    %eax,%eax
801045bd:	eb 10                	jmp    801045cf <kthread_mutex_alloc+0x2f>
801045bf:	90                   	nop
801045c0:	83 c0 01             	add    $0x1,%eax
801045c3:	83 c2 4c             	add    $0x4c,%edx
801045c6:	83 f8 40             	cmp    $0x40,%eax
801045c9:	0f 84 a1 00 00 00    	je     80104670 <kthread_mutex_alloc+0xd0>
        if (mtable.mutex[i].state == UNINITIALIZED)
801045cf:	8b 0a                	mov    (%edx),%ecx
801045d1:	85 c9                	test   %ecx,%ecx
801045d3:	75 eb                	jne    801045c0 <kthread_mutex_alloc+0x20>
    }
    release(&mtable.lock);
    return -1;

    found:
    acquire(&mtable.mutex[i].mutexLock);
801045d5:	6b d8 4c             	imul   $0x4c,%eax,%ebx
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	8d b3 80 3d 11 80    	lea    -0x7feec280(%ebx),%esi
801045e1:	56                   	push   %esi
801045e2:	e8 59 0d 00 00       	call   80105340 <acquire>
    release(&mtable.lock);
801045e7:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801045ee:	e8 0d 0e 00 00       	call   80105400 <release>
    mtable.mutex[i].lock = 0;
    mtable.mutex[i].mid = nextmid++;
801045f3:	a1 04 b0 10 80       	mov    0x8010b004,%eax
    mtable.mutex[i].lock = 0;
801045f8:	c7 83 78 3d 11 80 00 	movl   $0x0,-0x7feec288(%ebx)
801045ff:	00 00 00 
    mtable.mutex[i].mid = nextmid++;
80104602:	8d 50 01             	lea    0x1(%eax),%edx
80104605:	89 83 74 3d 11 80    	mov    %eax,-0x7feec28c(%ebx)
8010460b:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
    pushcli();
80104611:	e8 5a 0c 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104616:	e8 f5 f4 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
8010461b:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80104621:	e8 8a 0c 00 00       	call   801052b0 <popcli>
    mtable.mutex[i].pid_holder=myproc()->pid;
80104626:	8b 47 0c             	mov    0xc(%edi),%eax
    mtable.mutex[i].numOfWaiting = 0;
    mtable.mutex[i].state = OPEN;
    mtable.mutex[i].holding = 0;
    release(&mtable.mutex[i].mutexLock);
80104629:	89 34 24             	mov    %esi,(%esp)
    mtable.mutex[i].numOfWaiting = 0;
8010462c:	c7 83 7c 3d 11 80 00 	movl   $0x0,-0x7feec284(%ebx)
80104633:	00 00 00 
    mtable.mutex[i].state = OPEN;
80104636:	c7 83 b4 3d 11 80 01 	movl   $0x1,-0x7feec24c(%ebx)
8010463d:	00 00 00 
    mtable.mutex[i].holding = 0;
80104640:	c7 83 b8 3d 11 80 00 	movl   $0x0,-0x7feec248(%ebx)
80104647:	00 00 00 
    mtable.mutex[i].pid_holder=myproc()->pid;
8010464a:	89 83 bc 3d 11 80    	mov    %eax,-0x7feec244(%ebx)
    release(&mtable.mutex[i].mutexLock);
80104650:	e8 ab 0d 00 00       	call   80105400 <release>
    return mtable.mutex[i].mid;
80104655:	8b 83 74 3d 11 80    	mov    -0x7feec28c(%ebx),%eax
8010465b:	83 c4 10             	add    $0x10,%esp
}
8010465e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104661:	5b                   	pop    %ebx
80104662:	5e                   	pop    %esi
80104663:	5f                   	pop    %edi
80104664:	5d                   	pop    %ebp
80104665:	c3                   	ret    
80104666:	8d 76 00             	lea    0x0(%esi),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&mtable.lock);
80104670:	83 ec 0c             	sub    $0xc,%esp
80104673:	68 40 3d 11 80       	push   $0x80113d40
80104678:	e8 83 0d 00 00       	call   80105400 <release>
    return -1;
8010467d:	83 c4 10             	add    $0x10,%esp
}
80104680:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80104683:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104688:	5b                   	pop    %ebx
80104689:	5e                   	pop    %esi
8010468a:	5f                   	pop    %edi
8010468b:	5d                   	pop    %ebp
8010468c:	c3                   	ret    
8010468d:	8d 76 00             	lea    0x0(%esi),%esi

80104690 <kthread_mutex_dealloc>:

int kthread_mutex_dealloc(int mutex_id) {
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	57                   	push   %edi
80104694:	56                   	push   %esi
80104695:	53                   	push   %ebx
80104696:	83 ec 18             	sub    $0x18,%esp
80104699:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int i;
    struct mutex *m;
    acquire(&mtable.lock);
8010469c:	68 40 3d 11 80       	push   $0x80113d40
801046a1:	e8 9a 0c 00 00       	call   80105340 <acquire>
801046a6:	ba 74 3d 11 80       	mov    $0x80113d74,%edx
801046ab:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < MAX_MUTEXES; i++) {
801046ae:	31 c0                	xor    %eax,%eax
801046b0:	eb 11                	jmp    801046c3 <kthread_mutex_dealloc+0x33>
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b8:	83 c0 01             	add    $0x1,%eax
801046bb:	83 c2 4c             	add    $0x4c,%edx
801046be:	83 f8 40             	cmp    $0x40,%eax
801046c1:	74 7d                	je     80104740 <kthread_mutex_dealloc+0xb0>
        if (mtable.mutex[i].mid == mutex_id)
801046c3:	39 1a                	cmp    %ebx,(%edx)
801046c5:	75 f1                	jne    801046b8 <kthread_mutex_dealloc+0x28>
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
    if (m == 0 || m->state == CLOSE || m->numOfWaiting != 0) {
801046c7:	6b d0 4c             	imul   $0x4c,%eax,%edx
801046ca:	83 ba b4 3d 11 80 02 	cmpl   $0x2,-0x7feec24c(%edx)
801046d1:	8d b2 40 3d 11 80    	lea    -0x7feec2c0(%edx),%esi
801046d7:	74 67                	je     80104740 <kthread_mutex_dealloc+0xb0>
801046d9:	8b ba 7c 3d 11 80    	mov    -0x7feec284(%edx),%edi
801046df:	85 ff                	test   %edi,%edi
801046e1:	75 5d                	jne    80104740 <kthread_mutex_dealloc+0xb0>
        release(&mtable.lock);
        return -1;
    }
    acquire(&m->mutexLock);
801046e3:	8d 9a 80 3d 11 80    	lea    -0x7feec280(%edx),%ebx
801046e9:	83 ec 0c             	sub    $0xc,%esp
801046ec:	53                   	push   %ebx
801046ed:	e8 4e 0c 00 00       	call   80105340 <acquire>
    m->mid = 0;
    m->lock = 0;
    m->numOfWaiting = 0;
    mtable.mutex[i].pid_holder=0;
    m->state = UNINITIALIZED;
    release(&m->mutexLock);
801046f2:	89 1c 24             	mov    %ebx,(%esp)
    m->holding = 0;
801046f5:	c7 46 78 00 00 00 00 	movl   $0x0,0x78(%esi)
    m->mid = 0;
801046fc:	c7 46 34 00 00 00 00 	movl   $0x0,0x34(%esi)
    m->lock = 0;
80104703:	c7 46 38 00 00 00 00 	movl   $0x0,0x38(%esi)
    m->numOfWaiting = 0;
8010470a:	c7 46 3c 00 00 00 00 	movl   $0x0,0x3c(%esi)
    mtable.mutex[i].pid_holder=0;
80104711:	c7 46 7c 00 00 00 00 	movl   $0x0,0x7c(%esi)
    m->state = UNINITIALIZED;
80104718:	c7 46 74 00 00 00 00 	movl   $0x0,0x74(%esi)
    release(&m->mutexLock);
8010471f:	e8 dc 0c 00 00       	call   80105400 <release>
    release(&mtable.lock);
80104724:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
8010472b:	e8 d0 0c 00 00       	call   80105400 <release>
    return 0;
80104730:	83 c4 10             	add    $0x10,%esp
}
80104733:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104736:	89 f8                	mov    %edi,%eax
80104738:	5b                   	pop    %ebx
80104739:	5e                   	pop    %esi
8010473a:	5f                   	pop    %edi
8010473b:	5d                   	pop    %ebp
8010473c:	c3                   	ret    
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&mtable.lock);
80104740:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80104743:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    release(&mtable.lock);
80104748:	68 40 3d 11 80       	push   $0x80113d40
8010474d:	e8 ae 0c 00 00       	call   80105400 <release>
    return -1;
80104752:	83 c4 10             	add    $0x10,%esp
}
80104755:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104758:	89 f8                	mov    %edi,%eax
8010475a:	5b                   	pop    %ebx
8010475b:	5e                   	pop    %esi
8010475c:	5f                   	pop    %edi
8010475d:	5d                   	pop    %ebp
8010475e:	c3                   	ret    
8010475f:	90                   	nop

80104760 <exit>:
exit(void) {
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	57                   	push   %edi
80104764:	56                   	push   %esi
80104765:	53                   	push   %ebx
80104766:	83 ec 2c             	sub    $0x2c,%esp
    pushcli();
80104769:	e8 02 0b 00 00       	call   80105270 <pushcli>
    c = mycpu();
8010476e:	e8 9d f3 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104773:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104779:	e8 32 0b 00 00       	call   801052b0 <popcli>
    pushcli();
8010477e:	e8 ed 0a 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104783:	e8 88 f3 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104788:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
8010478e:	e8 1d 0b 00 00       	call   801052b0 <popcli>
    if (curproc == initproc)
80104793:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80104799:	0f 84 a6 00 00 00    	je     80104845 <exit+0xe5>
    acquire(&ptable.lock);
8010479f:	83 ec 0c             	sub    $0xc,%esp
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
801047a2:	8d be dc 03 00 00    	lea    0x3dc(%esi),%edi
    acquire(&ptable.lock);
801047a8:	68 e0 50 11 80       	push   $0x801150e0
801047ad:	e8 8e 0b 00 00       	call   80105340 <acquire>
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
801047b2:	8d 46 5c             	lea    0x5c(%esi),%eax
801047b5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801047b8:	83 c4 10             	add    $0x10,%esp
801047bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        if (t->tid != curthread->tid)
801047be:	8b 7b 0c             	mov    0xc(%ebx),%edi
801047c1:	39 78 0c             	cmp    %edi,0xc(%eax)
801047c4:	74 07                	je     801047cd <exit+0x6d>
            t->shouldDie = 1;
801047c6:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
        if (t->state == T_SLEEPING)
801047cd:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801047d1:	75 07                	jne    801047da <exit+0x7a>
            t->state = T_RUNNABLE;
801047d3:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
801047da:	83 c0 38             	add    $0x38,%eax
801047dd:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
801047e0:	77 dc                	ja     801047be <exit+0x5e>
    release(&ptable.lock);
801047e2:	83 ec 0c             	sub    $0xc,%esp
        numthread = 0;
801047e5:	31 ff                	xor    %edi,%edi
    release(&ptable.lock);
801047e7:	68 e0 50 11 80       	push   $0x801150e0
801047ec:	e8 0f 0c 00 00       	call   80105400 <release>
801047f1:	83 c4 10             	add    $0x10,%esp
        for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
801047f4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801047f7:	eb 09                	jmp    80104802 <exit+0xa2>
                    numthread++;
801047f9:	83 f8 01             	cmp    $0x1,%eax
801047fc:	83 df ff             	sbb    $0xffffffff,%edi
        for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
801047ff:	83 c3 38             	add    $0x38,%ebx
80104802:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80104805:	73 32                	jae    80104839 <exit+0xd9>
            if (t->state == T_ZOMBIE) {
80104807:	8b 43 04             	mov    0x4(%ebx),%eax
8010480a:	83 f8 05             	cmp    $0x5,%eax
8010480d:	75 ea                	jne    801047f9 <exit+0x99>
                kfree(t->kstack);
8010480f:	83 ec 0c             	sub    $0xc,%esp
80104812:	ff 33                	pushl  (%ebx)
80104814:	e8 67 dc ff ff       	call   80102480 <kfree>
                t->kstack = 0;
80104819:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
                t->tid = 0;
8010481f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104826:	83 c4 10             	add    $0x10,%esp
                t->state = T_UNUSED;
80104829:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
                curproc->numOfthread--;
80104830:	83 ae ec 03 00 00 01 	subl   $0x1,0x3ec(%esi)
80104837:	eb c6                	jmp    801047ff <exit+0x9f>
    while (numthread > 1) {
80104839:	83 ff 01             	cmp    $0x1,%edi
8010483c:	7e 14                	jle    80104852 <exit+0xf2>
        for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
8010483e:	8b 5d e0             	mov    -0x20(%ebp),%ebx
        numthread = 0;
80104841:	31 ff                	xor    %edi,%edi
80104843:	eb c2                	jmp    80104807 <exit+0xa7>
        panic("init exiting");
80104845:	83 ec 0c             	sub    $0xc,%esp
80104848:	68 37 87 10 80       	push   $0x80108737
8010484d:	e8 3e bb ff ff       	call   80100390 <panic>
80104852:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
80104857:	eb 12                	jmp    8010486b <exit+0x10b>
80104859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(m=mtable.mutex;m<&(mtable.mutex[MAX_MUTEXES]);m++){
80104860:	83 c3 4c             	add    $0x4c,%ebx
80104863:	81 fb 74 50 11 80    	cmp    $0x80115074,%ebx
80104869:	73 20                	jae    8010488b <exit+0x12b>
        if(m->pid_holder==curproc->pid)
8010486b:	8b 46 0c             	mov    0xc(%esi),%eax
8010486e:	39 43 48             	cmp    %eax,0x48(%ebx)
80104871:	75 ed                	jne    80104860 <exit+0x100>
            kthread_mutex_dealloc(m->mid);
80104873:	83 ec 0c             	sub    $0xc,%esp
80104876:	ff 33                	pushl  (%ebx)
    for(m=mtable.mutex;m<&(mtable.mutex[MAX_MUTEXES]);m++){
80104878:	83 c3 4c             	add    $0x4c,%ebx
            kthread_mutex_dealloc(m->mid);
8010487b:	e8 10 fe ff ff       	call   80104690 <kthread_mutex_dealloc>
80104880:	83 c4 10             	add    $0x10,%esp
    for(m=mtable.mutex;m<&(mtable.mutex[MAX_MUTEXES]);m++){
80104883:	81 fb 74 50 11 80    	cmp    $0x80115074,%ebx
80104889:	72 e0                	jb     8010486b <exit+0x10b>
8010488b:	8d 7e 18             	lea    0x18(%esi),%edi
8010488e:	8d 5e 58             	lea    0x58(%esi),%ebx
        if (curproc->ofile[fd]) {
80104891:	8b 07                	mov    (%edi),%eax
80104893:	85 c0                	test   %eax,%eax
80104895:	74 12                	je     801048a9 <exit+0x149>
            fileclose(curproc->ofile[fd]);
80104897:	83 ec 0c             	sub    $0xc,%esp
8010489a:	50                   	push   %eax
8010489b:	e8 00 c7 ff ff       	call   80100fa0 <fileclose>
            curproc->ofile[fd] = 0;
801048a0:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801048a6:	83 c4 10             	add    $0x10,%esp
801048a9:	83 c7 04             	add    $0x4,%edi
    for (fd = 0; fd < NOFILE; fd++) {
801048ac:	39 fb                	cmp    %edi,%ebx
801048ae:	75 e1                	jne    80104891 <exit+0x131>
    begin_op();
801048b0:	e8 5b e4 ff ff       	call   80102d10 <begin_op>
    iput(curproc->cwd);
801048b5:	83 ec 0c             	sub    $0xc,%esp
801048b8:	ff 76 58             	pushl  0x58(%esi)
801048bb:	e8 60 d0 ff ff       	call   80101920 <iput>
    end_op();
801048c0:	e8 bb e4 ff ff       	call   80102d80 <end_op>
    curproc->cwd = 0;
801048c5:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
    acquire(&ptable.lock);
801048cc:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
801048d3:	e8 68 0a 00 00       	call   80105340 <acquire>
    for (t = curproc->parent->ttable; t < &curproc->parent->ttable[NTHREAD]; t++)
801048d8:	8b 46 10             	mov    0x10(%esi),%eax
801048db:	83 c4 10             	add    $0x10,%esp
801048de:	8d 58 5c             	lea    0x5c(%eax),%ebx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801048e1:	b9 14 51 11 80       	mov    $0x80115114,%ecx
801048e6:	8d 76 00             	lea    0x0(%esi),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048f0:	8d 41 5c             	lea    0x5c(%ecx),%eax
801048f3:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
801048f9:	eb 0c                	jmp    80104907 <exit+0x1a7>
801048fb:	90                   	nop
801048fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104900:	83 c0 38             	add    $0x38,%eax
80104903:	39 d0                	cmp    %edx,%eax
80104905:	73 29                	jae    80104930 <exit+0x1d0>
            if (t->state == T_SLEEPING && t->chan == chan) {
80104907:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010490b:	75 f3                	jne    80104900 <exit+0x1a0>
8010490d:	3b 58 18             	cmp    0x18(%eax),%ebx
80104910:	75 ee                	jne    80104900 <exit+0x1a0>
                p->state = USED;
80104912:	c7 41 08 01 00 00 00 	movl   $0x1,0x8(%ecx)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104919:	83 c0 38             	add    $0x38,%eax
                t->state = T_RUNNABLE;
8010491c:	c7 40 cc 03 00 00 00 	movl   $0x3,-0x34(%eax)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104923:	39 d0                	cmp    %edx,%eax
80104925:	72 e0                	jb     80104907 <exit+0x1a7>
80104927:	89 f6                	mov    %esi,%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104930:	81 c1 f0 03 00 00    	add    $0x3f0,%ecx
80104936:	81 f9 14 4d 12 80    	cmp    $0x80124d14,%ecx
8010493c:	72 b2                	jb     801048f0 <exit+0x190>
    for (t = curproc->parent->ttable; t < &curproc->parent->ttable[NTHREAD]; t++)
8010493e:	8b 46 10             	mov    0x10(%esi),%eax
80104941:	83 c3 38             	add    $0x38,%ebx
80104944:	05 dc 03 00 00       	add    $0x3dc,%eax
80104949:	39 c3                	cmp    %eax,%ebx
8010494b:	72 94                	jb     801048e1 <exit+0x181>
            p->parent = initproc;
8010494d:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
                for (t = initproc->ttable; t < &initproc->ttable[NTHREAD]; t++)
80104952:	8d 78 5c             	lea    0x5c(%eax),%edi
            p->parent = initproc;
80104955:	89 45 dc             	mov    %eax,-0x24(%ebp)
                for (t = initproc->ttable; t < &initproc->ttable[NTHREAD]; t++)
80104958:	05 dc 03 00 00       	add    $0x3dc,%eax
8010495d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80104960:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104963:	bf 14 51 11 80       	mov    $0x80115114,%edi
80104968:	eb 0e                	jmp    80104978 <exit+0x218>
8010496a:	81 c7 f0 03 00 00    	add    $0x3f0,%edi
80104970:	81 ff 14 4d 12 80    	cmp    $0x80124d14,%edi
80104976:	73 7c                	jae    801049f4 <exit+0x294>
        if (p->parent == curproc) {
80104978:	39 77 10             	cmp    %esi,0x10(%edi)
8010497b:	75 ed                	jne    8010496a <exit+0x20a>
            if (p->state == ZOMBIE) {
8010497d:	83 7f 08 02          	cmpl   $0x2,0x8(%edi)
            p->parent = initproc;
80104981:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104984:	89 47 10             	mov    %eax,0x10(%edi)
            if (p->state == ZOMBIE) {
80104987:	75 e1                	jne    8010496a <exit+0x20a>
                for (t = initproc->ttable; t < &initproc->ttable[NTHREAD]; t++)
80104989:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010498c:	b9 14 51 11 80       	mov    $0x80115114,%ecx
80104991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104998:	8d 41 5c             	lea    0x5c(%ecx),%eax
8010499b:	8d 91 dc 03 00 00    	lea    0x3dc(%ecx),%edx
801049a1:	eb 0c                	jmp    801049af <exit+0x24f>
801049a3:	90                   	nop
801049a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801049a8:	83 c0 38             	add    $0x38,%eax
801049ab:	39 d0                	cmp    %edx,%eax
801049ad:	73 21                	jae    801049d0 <exit+0x270>
            if (t->state == T_SLEEPING && t->chan == chan) {
801049af:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801049b3:	75 f3                	jne    801049a8 <exit+0x248>
801049b5:	3b 58 18             	cmp    0x18(%eax),%ebx
801049b8:	75 ee                	jne    801049a8 <exit+0x248>
                p->state = USED;
801049ba:	c7 41 08 01 00 00 00 	movl   $0x1,0x8(%ecx)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801049c1:	83 c0 38             	add    $0x38,%eax
                t->state = T_RUNNABLE;
801049c4:	c7 40 cc 03 00 00 00 	movl   $0x3,-0x34(%eax)
        for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
801049cb:	39 d0                	cmp    %edx,%eax
801049cd:	72 e0                	jb     801049af <exit+0x24f>
801049cf:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049d0:	81 c1 f0 03 00 00    	add    $0x3f0,%ecx
801049d6:	81 f9 14 4d 12 80    	cmp    $0x80124d14,%ecx
801049dc:	72 ba                	jb     80104998 <exit+0x238>
                for (t = initproc->ttable; t < &initproc->ttable[NTHREAD]; t++)
801049de:	83 c3 38             	add    $0x38,%ebx
801049e1:	3b 5d d8             	cmp    -0x28(%ebp),%ebx
801049e4:	72 a6                	jb     8010498c <exit+0x22c>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801049e6:	81 c7 f0 03 00 00    	add    $0x3f0,%edi
801049ec:	81 ff 14 4d 12 80    	cmp    $0x80124d14,%edi
801049f2:	72 84                	jb     80104978 <exit+0x218>
    curproc->state = ZOMBIE;
801049f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801049f7:	c7 46 08 02 00 00 00 	movl   $0x2,0x8(%esi)
        if (t->state != T_UNUSED)
801049fe:	8b 50 04             	mov    0x4(%eax),%edx
80104a01:	85 d2                	test   %edx,%edx
80104a03:	74 07                	je     80104a0c <exit+0x2ac>
            t->state = T_ZOMBIE;
80104a05:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
    for (t = curproc->ttable; t < &curproc->ttable[NTHREAD]; t++)
80104a0c:	83 c0 38             	add    $0x38,%eax
80104a0f:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
80104a12:	77 ea                	ja     801049fe <exit+0x29e>
    sched();
80104a14:	e8 27 f6 ff ff       	call   80104040 <sched>
    panic("zombie exit");
80104a19:	83 ec 0c             	sub    $0xc,%esp
80104a1c:	68 44 87 10 80       	push   $0x80108744
80104a21:	e8 6a b9 ff ff       	call   80100390 <panic>
80104a26:	8d 76 00             	lea    0x0(%esi),%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a30 <kthread_exit>:
void kthread_exit() {
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	56                   	push   %esi
80104a34:	53                   	push   %ebx
    pushcli();
80104a35:	e8 36 08 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104a3a:	e8 d1 f0 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104a3f:	8b b0 b0 00 00 00    	mov    0xb0(%eax),%esi
    popcli();
80104a45:	e8 66 08 00 00       	call   801052b0 <popcli>
    pushcli();
80104a4a:	e8 21 08 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104a4f:	e8 bc f0 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104a54:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104a5a:	e8 51 08 00 00       	call   801052b0 <popcli>
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80104a5f:	8d 43 5c             	lea    0x5c(%ebx),%eax
80104a62:	8d 8b dc 03 00 00    	lea    0x3dc(%ebx),%ecx
        if (curthread->tid != t->tid && (t->state != T_ZOMBIE && t->state != T_UNUSED))
80104a68:	8b 5e 0c             	mov    0xc(%esi),%ebx
80104a6b:	90                   	nop
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a70:	3b 58 0c             	cmp    0xc(%eax),%ebx
80104a73:	74 0c                	je     80104a81 <kthread_exit+0x51>
80104a75:	8b 50 04             	mov    0x4(%eax),%edx
80104a78:	83 fa 05             	cmp    $0x5,%edx
80104a7b:	74 04                	je     80104a81 <kthread_exit+0x51>
80104a7d:	85 d2                	test   %edx,%edx
80104a7f:	75 0c                	jne    80104a8d <kthread_exit+0x5d>
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80104a81:	83 c0 38             	add    $0x38,%eax
80104a84:	39 c8                	cmp    %ecx,%eax
80104a86:	72 e8                	jb     80104a70 <kthread_exit+0x40>
    exit();
80104a88:	e8 d3 fc ff ff       	call   80104760 <exit>
    exitThread();
80104a8d:	e8 7e f6 ff ff       	call   80104110 <exitThread>
80104a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <sleep>:
sleep(void *chan, struct spinlock *lk) {
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	56                   	push   %esi
80104aa5:	53                   	push   %ebx
80104aa6:	83 ec 1c             	sub    $0x1c,%esp
80104aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80104aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80104aaf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pushcli();
80104ab2:	e8 b9 07 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104ab7:	e8 54 f0 ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104abc:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80104ac2:	e8 e9 07 00 00       	call   801052b0 <popcli>
    pushcli();
80104ac7:	e8 a4 07 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104acc:	e8 3f f0 ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104ad1:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104ad7:	e8 d4 07 00 00       	call   801052b0 <popcli>
    if (p == 0)
80104adc:	85 ff                	test   %edi,%edi
80104ade:	0f 84 9c 00 00 00    	je     80104b80 <sleep+0xe0>
    if (t == 0)
80104ae4:	85 db                	test   %ebx,%ebx
80104ae6:	0f 84 94 00 00 00    	je     80104b80 <sleep+0xe0>
    if (lk == 0)
80104aec:	85 f6                	test   %esi,%esi
80104aee:	0f 84 99 00 00 00    	je     80104b8d <sleep+0xed>
    if (lk != &ptable.lock) {  //DOC: sleeplock0
80104af4:	81 fe e0 50 11 80    	cmp    $0x801150e0,%esi
80104afa:	74 5c                	je     80104b58 <sleep+0xb8>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104afc:	83 ec 0c             	sub    $0xc,%esp
80104aff:	68 e0 50 11 80       	push   $0x801150e0
80104b04:	e8 37 08 00 00       	call   80105340 <acquire>
        release(lk);
80104b09:	89 34 24             	mov    %esi,(%esp)
80104b0c:	e8 ef 08 00 00       	call   80105400 <release>
    t->chan = chan;
80104b11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    t->state = T_SLEEPING;
80104b14:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
    t->chan = chan;
80104b1b:	89 43 18             	mov    %eax,0x18(%ebx)
    sched();
80104b1e:	e8 1d f5 ff ff       	call   80104040 <sched>
    if(t->shouldDie){
80104b23:	8b 53 1c             	mov    0x1c(%ebx),%edx
80104b26:	83 c4 10             	add    $0x10,%esp
80104b29:	85 d2                	test   %edx,%edx
80104b2b:	75 6d                	jne    80104b9a <sleep+0xfa>
        release(&ptable.lock);
80104b2d:	83 ec 0c             	sub    $0xc,%esp
    t->chan = 0;
80104b30:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
        release(&ptable.lock);
80104b37:	68 e0 50 11 80       	push   $0x801150e0
80104b3c:	e8 bf 08 00 00       	call   80105400 <release>
        acquire(lk);
80104b41:	89 75 08             	mov    %esi,0x8(%ebp)
80104b44:	83 c4 10             	add    $0x10,%esp
}
80104b47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b4a:	5b                   	pop    %ebx
80104b4b:	5e                   	pop    %esi
80104b4c:	5f                   	pop    %edi
80104b4d:	5d                   	pop    %ebp
        acquire(lk);
80104b4e:	e9 ed 07 00 00       	jmp    80105340 <acquire>
80104b53:	90                   	nop
80104b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    t->chan = chan;
80104b58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    t->state = T_SLEEPING;
80104b5b:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
    t->chan = chan;
80104b62:	89 43 18             	mov    %eax,0x18(%ebx)
    sched();
80104b65:	e8 d6 f4 ff ff       	call   80104040 <sched>
    if(t->shouldDie){
80104b6a:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104b6d:	85 c0                	test   %eax,%eax
80104b6f:	75 29                	jne    80104b9a <sleep+0xfa>
    t->chan = 0;
80104b71:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
}
80104b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b7b:	5b                   	pop    %ebx
80104b7c:	5e                   	pop    %esi
80104b7d:	5f                   	pop    %edi
80104b7e:	5d                   	pop    %ebp
80104b7f:	c3                   	ret    
        panic("sleep");
80104b80:	83 ec 0c             	sub    $0xc,%esp
80104b83:	68 50 87 10 80       	push   $0x80108750
80104b88:	e8 03 b8 ff ff       	call   80100390 <panic>
        panic("sleep without lk");
80104b8d:	83 ec 0c             	sub    $0xc,%esp
80104b90:	68 56 87 10 80       	push   $0x80108756
80104b95:	e8 f6 b7 ff ff       	call   80100390 <panic>
        release(&ptable.lock);
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	68 e0 50 11 80       	push   $0x801150e0
80104ba2:	e8 59 08 00 00       	call   80105400 <release>
        kthread_exit();
80104ba7:	e8 84 fe ff ff       	call   80104a30 <kthread_exit>
80104bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <wait>:
wait(void) {
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	57                   	push   %edi
80104bb4:	56                   	push   %esi
80104bb5:	53                   	push   %ebx
80104bb6:	83 ec 0c             	sub    $0xc,%esp
    pushcli();
80104bb9:	e8 b2 06 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104bbe:	e8 4d ef ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104bc3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104bc9:	e8 e2 06 00 00       	call   801052b0 <popcli>
    pushcli();
80104bce:	e8 9d 06 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104bd3:	e8 38 ef ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104bd8:	8b b8 b0 00 00 00    	mov    0xb0(%eax),%edi
    popcli();
80104bde:	e8 cd 06 00 00       	call   801052b0 <popcli>
    acquire(&ptable.lock);
80104be3:	83 ec 0c             	sub    $0xc,%esp
80104be6:	68 e0 50 11 80       	push   $0x801150e0
80104beb:	e8 50 07 00 00       	call   80105340 <acquire>
80104bf0:	83 c4 10             	add    $0x10,%esp
        havekids = 0;
80104bf3:	31 c0                	xor    %eax,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104bf5:	bb 14 51 11 80       	mov    $0x80115114,%ebx
80104bfa:	eb 12                	jmp    80104c0e <wait+0x5e>
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c00:	81 c3 f0 03 00 00    	add    $0x3f0,%ebx
80104c06:	81 fb 14 4d 12 80    	cmp    $0x80124d14,%ebx
80104c0c:	73 1e                	jae    80104c2c <wait+0x7c>
            if (p->parent != curproc)
80104c0e:	39 73 10             	cmp    %esi,0x10(%ebx)
80104c11:	75 ed                	jne    80104c00 <wait+0x50>
            if (p->state == ZOMBIE) {
80104c13:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
80104c17:	74 3f                	je     80104c58 <wait+0xa8>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104c19:	81 c3 f0 03 00 00    	add    $0x3f0,%ebx
            havekids = 1;
80104c1f:	b8 01 00 00 00       	mov    $0x1,%eax
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104c24:	81 fb 14 4d 12 80    	cmp    $0x80124d14,%ebx
80104c2a:	72 e2                	jb     80104c0e <wait+0x5e>
        if (!havekids || curproc->killed) {
80104c2c:	85 c0                	test   %eax,%eax
80104c2e:	0f 84 b4 00 00 00    	je     80104ce8 <wait+0x138>
80104c34:	8b 46 14             	mov    0x14(%esi),%eax
80104c37:	85 c0                	test   %eax,%eax
80104c39:	0f 85 a9 00 00 00    	jne    80104ce8 <wait+0x138>
        sleep(curthread, &ptable.lock);  //DOC: wait-sleep
80104c3f:	83 ec 08             	sub    $0x8,%esp
80104c42:	68 e0 50 11 80       	push   $0x801150e0
80104c47:	57                   	push   %edi
80104c48:	e8 53 fe ff ff       	call   80104aa0 <sleep>
        havekids = 0;
80104c4d:	83 c4 10             	add    $0x10,%esp
80104c50:	eb a1                	jmp    80104bf3 <wait+0x43>
80104c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104c58:	8d 73 5c             	lea    0x5c(%ebx),%esi
80104c5b:	8d bb dc 03 00 00    	lea    0x3dc(%ebx),%edi
80104c61:	eb 0c                	jmp    80104c6f <wait+0xbf>
80104c63:	90                   	nop
80104c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c68:	83 c6 38             	add    $0x38,%esi
80104c6b:	39 f7                	cmp    %esi,%edi
80104c6d:	76 2f                	jbe    80104c9e <wait+0xee>
                    if (t->state == T_ZOMBIE) {
80104c6f:	83 7e 04 05          	cmpl   $0x5,0x4(%esi)
80104c73:	75 f3                	jne    80104c68 <wait+0xb8>
                        kfree(t->kstack);
80104c75:	83 ec 0c             	sub    $0xc,%esp
80104c78:	ff 36                	pushl  (%esi)
                for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104c7a:	83 c6 38             	add    $0x38,%esi
                        kfree(t->kstack);
80104c7d:	e8 fe d7 ff ff       	call   80102480 <kfree>
                        t->kstack = 0;
80104c82:	c7 46 c8 00 00 00 00 	movl   $0x0,-0x38(%esi)
                        t->tid = 0;
80104c89:	c7 46 d4 00 00 00 00 	movl   $0x0,-0x2c(%esi)
                        t->state = T_UNUSED;
80104c90:	83 c4 10             	add    $0x10,%esp
80104c93:	c7 46 cc 00 00 00 00 	movl   $0x0,-0x34(%esi)
                for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104c9a:	39 f7                	cmp    %esi,%edi
80104c9c:	77 d1                	ja     80104c6f <wait+0xbf>
                freevm(p->pgdir);
80104c9e:	83 ec 0c             	sub    $0xc,%esp
80104ca1:	ff 73 04             	pushl  0x4(%ebx)
                pid = p->pid;
80104ca4:	8b 73 0c             	mov    0xc(%ebx),%esi
                freevm(p->pgdir);
80104ca7:	e8 44 31 00 00       	call   80107df0 <freevm>
                release(&ptable.lock);
80104cac:	c7 04 24 e0 50 11 80 	movl   $0x801150e0,(%esp)
                p->pid = 0;
80104cb3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                p->parent = 0;
80104cba:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->name[0] = 0;
80104cc1:	c6 83 dc 03 00 00 00 	movb   $0x0,0x3dc(%ebx)
                p->killed = 0;
80104cc8:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->state = UNUSED;
80104ccf:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                release(&ptable.lock);
80104cd6:	e8 25 07 00 00       	call   80105400 <release>
                return pid;
80104cdb:	83 c4 10             	add    $0x10,%esp
}
80104cde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce1:	89 f0                	mov    %esi,%eax
80104ce3:	5b                   	pop    %ebx
80104ce4:	5e                   	pop    %esi
80104ce5:	5f                   	pop    %edi
80104ce6:	5d                   	pop    %ebp
80104ce7:	c3                   	ret    
            release(&ptable.lock);
80104ce8:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104ceb:	be ff ff ff ff       	mov    $0xffffffff,%esi
            release(&ptable.lock);
80104cf0:	68 e0 50 11 80       	push   $0x801150e0
80104cf5:	e8 06 07 00 00       	call   80105400 <release>
            return -1;
80104cfa:	83 c4 10             	add    $0x10,%esp
80104cfd:	eb df                	jmp    80104cde <wait+0x12e>
80104cff:	90                   	nop

80104d00 <kthread_join>:
int kthread_join(int thread_id) {
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
80104d05:	83 ec 1c             	sub    $0x1c,%esp
80104d08:	8b 75 08             	mov    0x8(%ebp),%esi
    acquire(&ptable.lock);
80104d0b:	68 e0 50 11 80       	push   $0x801150e0
80104d10:	e8 2b 06 00 00       	call   80105340 <acquire>
80104d15:	83 c4 10             	add    $0x10,%esp
80104d18:	90                   	nop
80104d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pushcli();
80104d20:	e8 4b 05 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104d25:	e8 e6 ed ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104d2a:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104d30:	e8 7b 05 00 00       	call   801052b0 <popcli>
        if(mythread()->shouldDie){
80104d35:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104d38:	85 c0                	test   %eax,%eax
80104d3a:	0f 85 cf 00 00 00    	jne    80104e0f <kthread_join+0x10f>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104d40:	ba 14 51 11 80       	mov    $0x80115114,%edx
            if (p->state == UNUSED)
80104d45:	8b 4a 08             	mov    0x8(%edx),%ecx
80104d48:	85 c9                	test   %ecx,%ecx
80104d4a:	74 20                	je     80104d6c <kthread_join+0x6c>
                if (t->tid == thread_id)
80104d4c:	3b 72 68             	cmp    0x68(%edx),%esi
80104d4f:	8d 5a 5c             	lea    0x5c(%edx),%ebx
80104d52:	8d 8a dc 03 00 00    	lea    0x3dc(%edx),%ecx
80104d58:	75 0b                	jne    80104d65 <kthread_join+0x65>
80104d5a:	eb 44                	jmp    80104da0 <kthread_join+0xa0>
80104d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d60:	39 73 0c             	cmp    %esi,0xc(%ebx)
80104d63:	74 3b                	je     80104da0 <kthread_join+0xa0>
            for (t = p->ttable; t < &(p->ttable[NTHREAD]); t++) {
80104d65:	83 c3 38             	add    $0x38,%ebx
80104d68:	39 cb                	cmp    %ecx,%ebx
80104d6a:	72 f4                	jb     80104d60 <kthread_join+0x60>
        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104d6c:	81 c2 f0 03 00 00    	add    $0x3f0,%edx
80104d72:	81 fa 14 4d 12 80    	cmp    $0x80124d14,%edx
80104d78:	72 cb                	jb     80104d45 <kthread_join+0x45>
        release(&ptable.lock);
80104d7a:	83 ec 0c             	sub    $0xc,%esp
80104d7d:	68 e0 50 11 80       	push   $0x801150e0
80104d82:	e8 79 06 00 00       	call   80105400 <release>
        return -1;
80104d87:	83 c4 10             	add    $0x10,%esp
}
80104d8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
        return -1;
80104d8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d92:	5b                   	pop    %ebx
80104d93:	5e                   	pop    %esi
80104d94:	5d                   	pop    %ebp
80104d95:	c3                   	ret    
80104d96:	8d 76 00             	lea    0x0(%esi),%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        if (t->state == T_UNUSED)
80104da0:	8b 53 04             	mov    0x4(%ebx),%edx
80104da3:	85 d2                	test   %edx,%edx
80104da5:	74 5b                	je     80104e02 <kthread_join+0x102>
        if (t->state == T_ZOMBIE) {
80104da7:	83 fa 05             	cmp    $0x5,%edx
80104daa:	74 16                	je     80104dc2 <kthread_join+0xc2>
            sleep(t, &ptable.lock);  //DOC: wait-sleep
80104dac:	83 ec 08             	sub    $0x8,%esp
80104daf:	68 e0 50 11 80       	push   $0x801150e0
80104db4:	53                   	push   %ebx
80104db5:	e8 e6 fc ff ff       	call   80104aa0 <sleep>
        if(mythread()->shouldDie){
80104dba:	83 c4 10             	add    $0x10,%esp
80104dbd:	e9 5e ff ff ff       	jmp    80104d20 <kthread_join+0x20>
            release(&ptable.lock);
80104dc2:	83 ec 0c             	sub    $0xc,%esp
80104dc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104dc8:	68 e0 50 11 80       	push   $0x801150e0
80104dcd:	e8 2e 06 00 00       	call   80105400 <release>
            kfree(t->kstack);
80104dd2:	58                   	pop    %eax
80104dd3:	ff 33                	pushl  (%ebx)
80104dd5:	e8 a6 d6 ff ff       	call   80102480 <kfree>
            t->kstack = 0;
80104dda:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
            t->tid = 0;
80104de0:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
            return 0;
80104de7:	83 c4 10             	add    $0x10,%esp
            t->shouldDie = 0;
80104dea:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
            t->state = T_UNUSED;
80104df1:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
            return 0;
80104df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104dfb:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dfe:	5b                   	pop    %ebx
80104dff:	5e                   	pop    %esi
80104e00:	5d                   	pop    %ebp
80104e01:	c3                   	ret    
            panic("kthread_join-thread unused is necessary");
80104e02:	83 ec 0c             	sub    $0xc,%esp
80104e05:	68 f4 89 10 80       	push   $0x801089f4
80104e0a:	e8 81 b5 ff ff       	call   80100390 <panic>
            release(&ptable.lock);
80104e0f:	83 ec 0c             	sub    $0xc,%esp
80104e12:	68 e0 50 11 80       	push   $0x801150e0
80104e17:	e8 e4 05 00 00       	call   80105400 <release>
            kthread_exit();
80104e1c:	e8 0f fc ff ff       	call   80104a30 <kthread_exit>
80104e21:	eb 0d                	jmp    80104e30 <kthread_mutex_lock>
80104e23:	90                   	nop
80104e24:	90                   	nop
80104e25:	90                   	nop
80104e26:	90                   	nop
80104e27:	90                   	nop
80104e28:	90                   	nop
80104e29:	90                   	nop
80104e2a:	90                   	nop
80104e2b:	90                   	nop
80104e2c:	90                   	nop
80104e2d:	90                   	nop
80104e2e:	90                   	nop
80104e2f:	90                   	nop

80104e30 <kthread_mutex_lock>:


int kthread_mutex_lock(int mutex_id) {
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	56                   	push   %esi
80104e35:	53                   	push   %ebx
    int i;
    struct mutex *m;
    acquire(&mtable.lock);
    for (i = 0; i < MAX_MUTEXES; i++) {
80104e36:	31 f6                	xor    %esi,%esi
int kthread_mutex_lock(int mutex_id) {
80104e38:	83 ec 28             	sub    $0x28,%esp
80104e3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&mtable.lock);
80104e3e:	68 40 3d 11 80       	push   $0x80113d40
80104e43:	e8 f8 04 00 00       	call   80105340 <acquire>
80104e48:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	eb 15                	jmp    80104e67 <kthread_mutex_lock+0x37>
80104e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (i = 0; i < MAX_MUTEXES; i++) {
80104e58:	83 c6 01             	add    $0x1,%esi
80104e5b:	83 c0 4c             	add    $0x4c,%eax
80104e5e:	83 fe 40             	cmp    $0x40,%esi
80104e61:	0f 84 f1 00 00 00    	je     80104f58 <kthread_mutex_lock+0x128>
        if (mtable.mutex[i].mid == mutex_id)
80104e67:	39 18                	cmp    %ebx,(%eax)
80104e69:	75 ed                	jne    80104e58 <kthread_mutex_lock+0x28>
80104e6b:	6b fe 4c             	imul   $0x4c,%esi,%edi
    }
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
80104e6e:	8d 87 74 3d 11 80    	lea    -0x7feec28c(%edi),%eax
80104e74:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if (m == 0 || m->state == UNINITIALIZED || m->holding->tid == mythread()->tid) {
80104e77:	8b 87 b4 3d 11 80    	mov    -0x7feec24c(%edi),%eax
80104e7d:	85 c0                	test   %eax,%eax
80104e7f:	0f 84 d3 00 00 00    	je     80104f58 <kthread_mutex_lock+0x128>
80104e85:	8b 87 b8 3d 11 80    	mov    -0x7feec248(%edi),%eax
80104e8b:	8b 48 0c             	mov    0xc(%eax),%ecx
80104e8e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pushcli();
80104e91:	e8 da 03 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104e96:	e8 75 ec ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104e9b:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
    popcli();
80104ea1:	e8 0a 04 00 00       	call   801052b0 <popcli>
    if (m == 0 || m->state == UNINITIALIZED || m->holding->tid == mythread()->tid) {
80104ea6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104ea9:	3b 4b 0c             	cmp    0xc(%ebx),%ecx
80104eac:	0f 84 a6 00 00 00    	je     80104f58 <kthread_mutex_lock+0x128>
        release(&mtable.lock);
        return -1;
    }
    acquire(&m->mutexLock);
80104eb2:	8d 87 80 3d 11 80    	lea    -0x7feec280(%edi),%eax
80104eb8:	83 ec 0c             	sub    $0xc,%esp
    release(&mtable.lock);
    while (xchg((uint *) &m->lock, 1) != 0) {
80104ebb:	8d 9f 78 3d 11 80    	lea    -0x7feec288(%edi),%ebx
80104ec1:	83 c7 38             	add    $0x38,%edi
    acquire(&m->mutexLock);
80104ec4:	50                   	push   %eax
80104ec5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104ec8:	e8 73 04 00 00       	call   80105340 <acquire>
    release(&mtable.lock);
80104ecd:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80104ed4:	e8 27 05 00 00       	call   80105400 <release>
  asm volatile("lock; xchgl %0, %1" :
80104ed9:	b8 01 00 00 00       	mov    $0x1,%eax
80104ede:	f0 87 87 40 3d 11 80 	lock xchg %eax,-0x7feec2c0(%edi)
    while (xchg((uint *) &m->lock, 1) != 0) {
80104ee5:	83 c4 10             	add    $0x10,%esp
80104ee8:	85 c0                	test   %eax,%eax
80104eea:	74 26                	je     80104f12 <kthread_mutex_lock+0xe2>
80104eec:	bf 01 00 00 00       	mov    $0x1,%edi
80104ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        sleep(m, &m->mutexLock);
80104ef8:	83 ec 08             	sub    $0x8,%esp
80104efb:	ff 75 e4             	pushl  -0x1c(%ebp)
80104efe:	ff 75 e0             	pushl  -0x20(%ebp)
80104f01:	e8 9a fb ff ff       	call   80104aa0 <sleep>
80104f06:	89 f8                	mov    %edi,%eax
80104f08:	f0 87 03             	lock xchg %eax,(%ebx)
    while (xchg((uint *) &m->lock, 1) != 0) {
80104f0b:	83 c4 10             	add    $0x10,%esp
80104f0e:	85 c0                	test   %eax,%eax
80104f10:	75 e6                	jne    80104ef8 <kthread_mutex_lock+0xc8>
    }
    m->state = CLOSE;
80104f12:	6b d6 4c             	imul   $0x4c,%esi,%edx
80104f15:	8d b2 40 3d 11 80    	lea    -0x7feec2c0(%edx),%esi
80104f1b:	c7 82 b4 3d 11 80 02 	movl   $0x2,-0x7feec24c(%edx)
80104f22:	00 00 00 
    pushcli();
80104f25:	e8 46 03 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104f2a:	e8 e1 eb ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80104f2f:	8b b8 b0 00 00 00    	mov    0xb0(%eax),%edi
    popcli();
80104f35:	e8 76 03 00 00       	call   801052b0 <popcli>
    m->holding = mythread();
    release(&m->mutexLock);
80104f3a:	83 ec 0c             	sub    $0xc,%esp
    m->holding = mythread();
80104f3d:	89 7e 78             	mov    %edi,0x78(%esi)
    release(&m->mutexLock);
80104f40:	ff 75 e4             	pushl  -0x1c(%ebp)
80104f43:	e8 b8 04 00 00       	call   80105400 <release>
    return 0;
80104f48:	83 c4 10             	add    $0x10,%esp
}
80104f4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104f4e:	31 c0                	xor    %eax,%eax
}
80104f50:	5b                   	pop    %ebx
80104f51:	5e                   	pop    %esi
80104f52:	5f                   	pop    %edi
80104f53:	5d                   	pop    %ebp
80104f54:	c3                   	ret    
80104f55:	8d 76 00             	lea    0x0(%esi),%esi
    release(&mtable.lock);
80104f58:	83 ec 0c             	sub    $0xc,%esp
80104f5b:	68 40 3d 11 80       	push   $0x80113d40
80104f60:	e8 9b 04 00 00       	call   80105400 <release>
    return -1;
80104f65:	83 c4 10             	add    $0x10,%esp
}
80104f68:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80104f6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f70:	5b                   	pop    %ebx
80104f71:	5e                   	pop    %esi
80104f72:	5f                   	pop    %edi
80104f73:	5d                   	pop    %ebp
80104f74:	c3                   	ret    
80104f75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <kthread_mutex_unlock>:


int kthread_mutex_unlock(int mutex_id) {
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
80104f86:	83 ec 1c             	sub    $0x1c,%esp
80104f89:	8b 5d 08             	mov    0x8(%ebp),%ebx
    pushcli();
80104f8c:	e8 df 02 00 00       	call   80105270 <pushcli>
    c = mycpu();
80104f91:	e8 7a eb ff ff       	call   80103b10 <mycpu>
    p = c->proc;
80104f96:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104f9c:	e8 0f 03 00 00       	call   801052b0 <popcli>
    int i;
    struct mutex *m;
    struct proc *curproc = myproc();
    struct thread *t;
    acquire(&mtable.lock);
80104fa1:	83 ec 0c             	sub    $0xc,%esp
80104fa4:	68 40 3d 11 80       	push   $0x80113d40
80104fa9:	e8 92 03 00 00       	call   80105340 <acquire>
80104fae:	ba 74 3d 11 80       	mov    $0x80113d74,%edx
80104fb3:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < MAX_MUTEXES; i++) {
80104fb6:	31 c0                	xor    %eax,%eax
80104fb8:	eb 15                	jmp    80104fcf <kthread_mutex_unlock+0x4f>
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fc0:	83 c0 01             	add    $0x1,%eax
80104fc3:	83 c2 4c             	add    $0x4c,%edx
80104fc6:	83 f8 40             	cmp    $0x40,%eax
80104fc9:	0f 84 c9 00 00 00    	je     80105098 <kthread_mutex_unlock+0x118>
        if (mtable.mutex[i].mid == mutex_id)
80104fcf:	39 1a                	cmp    %ebx,(%edx)
80104fd1:	75 ed                	jne    80104fc0 <kthread_mutex_unlock+0x40>
80104fd3:	6b d8 4c             	imul   $0x4c,%eax,%ebx
    release(&mtable.lock);
    return -1;

    found:
    m = &(mtable.mutex[i]);
    acquire(&m->mutexLock);
80104fd6:	83 ec 0c             	sub    $0xc,%esp
80104fd9:	8d 83 80 3d 11 80    	lea    -0x7feec280(%ebx),%eax
    m = &(mtable.mutex[i]);
80104fdf:	8d bb 74 3d 11 80    	lea    -0x7feec28c(%ebx),%edi
    release(&mtable.lock);
    if (m == 0 || m->state != CLOSE || m->holding->tid != mythread()->tid) {
80104fe5:	81 c3 40 3d 11 80    	add    $0x80113d40,%ebx
    acquire(&m->mutexLock);
80104feb:	50                   	push   %eax
80104fec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104fef:	e8 4c 03 00 00       	call   80105340 <acquire>
    release(&mtable.lock);
80104ff4:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80104ffb:	e8 00 04 00 00       	call   80105400 <release>
    if (m == 0 || m->state != CLOSE || m->holding->tid != mythread()->tid) {
80105000:	83 c4 10             	add    $0x10,%esp
80105003:	83 7b 74 02          	cmpl   $0x2,0x74(%ebx)
80105007:	0f 85 a8 00 00 00    	jne    801050b5 <kthread_mutex_unlock+0x135>
8010500d:	8b 43 78             	mov    0x78(%ebx),%eax
80105010:	8b 48 0c             	mov    0xc(%eax),%ecx
80105013:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    pushcli();
80105016:	e8 55 02 00 00       	call   80105270 <pushcli>
    c = mycpu();
8010501b:	e8 f0 ea ff ff       	call   80103b10 <mycpu>
    t = c->thread;
80105020:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105026:	89 45 e0             	mov    %eax,-0x20(%ebp)
    popcli();
80105029:	e8 82 02 00 00       	call   801052b0 <popcli>
    if (m == 0 || m->state != CLOSE || m->holding->tid != mythread()->tid) {
8010502e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105031:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105034:	3b 48 0c             	cmp    0xc(%eax),%ecx
80105037:	75 7c                	jne    801050b5 <kthread_mutex_unlock+0x135>
        return -1;
    }
    m->lock = 0;
    m->state=OPEN;
    m->holding=0;
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80105039:	8d 46 5c             	lea    0x5c(%esi),%eax
    m->lock = 0;
8010503c:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%ebx)
    m->state=OPEN;
80105043:	c7 43 74 01 00 00 00 	movl   $0x1,0x74(%ebx)
    m->holding=0;
8010504a:	c7 43 78 00 00 00 00 	movl   $0x0,0x78(%ebx)
    for (t = curproc->ttable; t < &(curproc->ttable[NTHREAD]); t++) {
80105051:	81 c6 dc 03 00 00    	add    $0x3dc,%esi
80105057:	eb 0e                	jmp    80105067 <kthread_mutex_unlock+0xe7>
80105059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105060:	83 c0 38             	add    $0x38,%eax
80105063:	39 c6                	cmp    %eax,%esi
80105065:	76 12                	jbe    80105079 <kthread_mutex_unlock+0xf9>
        if (t->state == T_SLEEPING && t->chan == m) {
80105067:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010506b:	75 f3                	jne    80105060 <kthread_mutex_unlock+0xe0>
8010506d:	39 78 18             	cmp    %edi,0x18(%eax)
80105070:	75 ee                	jne    80105060 <kthread_mutex_unlock+0xe0>
            t->state = T_RUNNABLE;
80105072:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
            release(&m->mutexLock);
            return 0;
        }
    }
    release(&m->mutexLock);
80105079:	83 ec 0c             	sub    $0xc,%esp
8010507c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010507f:	e8 7c 03 00 00       	call   80105400 <release>
    return 0;
80105084:	83 c4 10             	add    $0x10,%esp
80105087:	31 c0                	xor    %eax,%eax
}
80105089:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010508c:	5b                   	pop    %ebx
8010508d:	5e                   	pop    %esi
8010508e:	5f                   	pop    %edi
8010508f:	5d                   	pop    %ebp
80105090:	c3                   	ret    
80105091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&mtable.lock);
80105098:	83 ec 0c             	sub    $0xc,%esp
8010509b:	68 40 3d 11 80       	push   $0x80113d40
801050a0:	e8 5b 03 00 00       	call   80105400 <release>
    return -1;
801050a5:	83 c4 10             	add    $0x10,%esp
}
801050a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801050ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050b0:	5b                   	pop    %ebx
801050b1:	5e                   	pop    %esi
801050b2:	5f                   	pop    %edi
801050b3:	5d                   	pop    %ebp
801050b4:	c3                   	ret    
        release(&m->mutexLock);
801050b5:	83 ec 0c             	sub    $0xc,%esp
801050b8:	ff 75 e4             	pushl  -0x1c(%ebp)
801050bb:	e8 40 03 00 00       	call   80105400 <release>
        return -1;
801050c0:	83 c4 10             	add    $0x10,%esp
801050c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050c8:	eb bf                	jmp    80105089 <kthread_mutex_unlock+0x109>
801050ca:	66 90                	xchg   %ax,%ax
801050cc:	66 90                	xchg   %ax,%ax
801050ce:	66 90                	xchg   %ax,%ax

801050d0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	53                   	push   %ebx
801050d4:	83 ec 0c             	sub    $0xc,%esp
801050d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801050da:	68 4c 8a 10 80       	push   $0x80108a4c
801050df:	8d 43 04             	lea    0x4(%ebx),%eax
801050e2:	50                   	push   %eax
801050e3:	e8 18 01 00 00       	call   80105200 <initlock>
  lk->name = name;
801050e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801050eb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801050f1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801050f4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801050fb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801050fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105101:	c9                   	leave  
80105102:	c3                   	ret    
80105103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105110 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	56                   	push   %esi
80105114:	53                   	push   %ebx
80105115:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105118:	83 ec 0c             	sub    $0xc,%esp
8010511b:	8d 73 04             	lea    0x4(%ebx),%esi
8010511e:	56                   	push   %esi
8010511f:	e8 1c 02 00 00       	call   80105340 <acquire>
  while (lk->locked) {
80105124:	8b 13                	mov    (%ebx),%edx
80105126:	83 c4 10             	add    $0x10,%esp
80105129:	85 d2                	test   %edx,%edx
8010512b:	74 16                	je     80105143 <acquiresleep+0x33>
8010512d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105130:	83 ec 08             	sub    $0x8,%esp
80105133:	56                   	push   %esi
80105134:	53                   	push   %ebx
80105135:	e8 66 f9 ff ff       	call   80104aa0 <sleep>
  while (lk->locked) {
8010513a:	8b 03                	mov    (%ebx),%eax
8010513c:	83 c4 10             	add    $0x10,%esp
8010513f:	85 c0                	test   %eax,%eax
80105141:	75 ed                	jne    80105130 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105143:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105149:	e8 62 ea ff ff       	call   80103bb0 <myproc>
8010514e:	8b 40 0c             	mov    0xc(%eax),%eax
80105151:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105154:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105157:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010515a:	5b                   	pop    %ebx
8010515b:	5e                   	pop    %esi
8010515c:	5d                   	pop    %ebp
  release(&lk->lk);
8010515d:	e9 9e 02 00 00       	jmp    80105400 <release>
80105162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	56                   	push   %esi
80105174:	53                   	push   %ebx
80105175:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105178:	83 ec 0c             	sub    $0xc,%esp
8010517b:	8d 73 04             	lea    0x4(%ebx),%esi
8010517e:	56                   	push   %esi
8010517f:	e8 bc 01 00 00       	call   80105340 <acquire>
  lk->locked = 0;
80105184:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010518a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105191:	89 1c 24             	mov    %ebx,(%esp)
80105194:	e8 f7 f0 ff ff       	call   80104290 <wakeup>
  release(&lk->lk);
80105199:	89 75 08             	mov    %esi,0x8(%ebp)
8010519c:	83 c4 10             	add    $0x10,%esp
}
8010519f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051a2:	5b                   	pop    %ebx
801051a3:	5e                   	pop    %esi
801051a4:	5d                   	pop    %ebp
  release(&lk->lk);
801051a5:	e9 56 02 00 00       	jmp    80105400 <release>
801051aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051b0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	57                   	push   %edi
801051b4:	56                   	push   %esi
801051b5:	53                   	push   %ebx
801051b6:	31 ff                	xor    %edi,%edi
801051b8:	83 ec 18             	sub    $0x18,%esp
801051bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801051be:	8d 73 04             	lea    0x4(%ebx),%esi
801051c1:	56                   	push   %esi
801051c2:	e8 79 01 00 00       	call   80105340 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801051c7:	8b 03                	mov    (%ebx),%eax
801051c9:	83 c4 10             	add    $0x10,%esp
801051cc:	85 c0                	test   %eax,%eax
801051ce:	74 13                	je     801051e3 <holdingsleep+0x33>
801051d0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801051d3:	e8 d8 e9 ff ff       	call   80103bb0 <myproc>
801051d8:	39 58 0c             	cmp    %ebx,0xc(%eax)
801051db:	0f 94 c0             	sete   %al
801051de:	0f b6 c0             	movzbl %al,%eax
801051e1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801051e3:	83 ec 0c             	sub    $0xc,%esp
801051e6:	56                   	push   %esi
801051e7:	e8 14 02 00 00       	call   80105400 <release>
  return r;
}
801051ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ef:	89 f8                	mov    %edi,%eax
801051f1:	5b                   	pop    %ebx
801051f2:	5e                   	pop    %esi
801051f3:	5f                   	pop    %edi
801051f4:	5d                   	pop    %ebp
801051f5:	c3                   	ret    
801051f6:	66 90                	xchg   %ax,%ax
801051f8:	66 90                	xchg   %ax,%ax
801051fa:	66 90                	xchg   %ax,%ax
801051fc:	66 90                	xchg   %ax,%ax
801051fe:	66 90                	xchg   %ax,%ax

80105200 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105206:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105209:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010520f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105212:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105219:	5d                   	pop    %ebp
8010521a:	c3                   	ret    
8010521b:	90                   	nop
8010521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105220 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105220:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105221:	31 d2                	xor    %edx,%edx
{
80105223:	89 e5                	mov    %esp,%ebp
80105225:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105226:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105229:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010522c:	83 e8 08             	sub    $0x8,%eax
8010522f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105230:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105236:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010523c:	77 1a                	ja     80105258 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010523e:	8b 58 04             	mov    0x4(%eax),%ebx
80105241:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80105244:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105247:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105249:	83 fa 0a             	cmp    $0xa,%edx
8010524c:	75 e2                	jne    80105230 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010524e:	5b                   	pop    %ebx
8010524f:	5d                   	pop    %ebp
80105250:	c3                   	ret    
80105251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105258:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010525b:	83 c1 28             	add    $0x28,%ecx
8010525e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105260:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105266:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105269:	39 c1                	cmp    %eax,%ecx
8010526b:	75 f3                	jne    80105260 <getcallerpcs+0x40>
}
8010526d:	5b                   	pop    %ebx
8010526e:	5d                   	pop    %ebp
8010526f:	c3                   	ret    

80105270 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	53                   	push   %ebx
80105274:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105277:	9c                   	pushf  
80105278:	5b                   	pop    %ebx
  asm volatile("cli");
80105279:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010527a:	e8 91 e8 ff ff       	call   80103b10 <mycpu>
8010527f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105285:	85 c0                	test   %eax,%eax
80105287:	75 11                	jne    8010529a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105289:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010528f:	e8 7c e8 ff ff       	call   80103b10 <mycpu>
80105294:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010529a:	e8 71 e8 ff ff       	call   80103b10 <mycpu>
8010529f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801052a6:	83 c4 04             	add    $0x4,%esp
801052a9:	5b                   	pop    %ebx
801052aa:	5d                   	pop    %ebp
801052ab:	c3                   	ret    
801052ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052b0 <popcli>:

void
popcli(void)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801052b6:	9c                   	pushf  
801052b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801052b8:	f6 c4 02             	test   $0x2,%ah
801052bb:	75 35                	jne    801052f2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801052bd:	e8 4e e8 ff ff       	call   80103b10 <mycpu>
801052c2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801052c9:	78 34                	js     801052ff <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052cb:	e8 40 e8 ff ff       	call   80103b10 <mycpu>
801052d0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801052d6:	85 d2                	test   %edx,%edx
801052d8:	74 06                	je     801052e0 <popcli+0x30>
    sti();
}
801052da:	c9                   	leave  
801052db:	c3                   	ret    
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052e0:	e8 2b e8 ff ff       	call   80103b10 <mycpu>
801052e5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801052eb:	85 c0                	test   %eax,%eax
801052ed:	74 eb                	je     801052da <popcli+0x2a>
  asm volatile("sti");
801052ef:	fb                   	sti    
}
801052f0:	c9                   	leave  
801052f1:	c3                   	ret    
    panic("popcli - interruptible");
801052f2:	83 ec 0c             	sub    $0xc,%esp
801052f5:	68 57 8a 10 80       	push   $0x80108a57
801052fa:	e8 91 b0 ff ff       	call   80100390 <panic>
    panic("popcli");
801052ff:	83 ec 0c             	sub    $0xc,%esp
80105302:	68 6e 8a 10 80       	push   $0x80108a6e
80105307:	e8 84 b0 ff ff       	call   80100390 <panic>
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105310 <holding>:
{
80105310:	55                   	push   %ebp
80105311:	89 e5                	mov    %esp,%ebp
80105313:	56                   	push   %esi
80105314:	53                   	push   %ebx
80105315:	8b 75 08             	mov    0x8(%ebp),%esi
80105318:	31 db                	xor    %ebx,%ebx
  pushcli();
8010531a:	e8 51 ff ff ff       	call   80105270 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010531f:	8b 06                	mov    (%esi),%eax
80105321:	85 c0                	test   %eax,%eax
80105323:	74 10                	je     80105335 <holding+0x25>
80105325:	8b 5e 08             	mov    0x8(%esi),%ebx
80105328:	e8 e3 e7 ff ff       	call   80103b10 <mycpu>
8010532d:	39 c3                	cmp    %eax,%ebx
8010532f:	0f 94 c3             	sete   %bl
80105332:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105335:	e8 76 ff ff ff       	call   801052b0 <popcli>
}
8010533a:	89 d8                	mov    %ebx,%eax
8010533c:	5b                   	pop    %ebx
8010533d:	5e                   	pop    %esi
8010533e:	5d                   	pop    %ebp
8010533f:	c3                   	ret    

80105340 <acquire>:
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	56                   	push   %esi
80105344:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105345:	e8 26 ff ff ff       	call   80105270 <pushcli>
  if(holding(lk))
8010534a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010534d:	83 ec 0c             	sub    $0xc,%esp
80105350:	53                   	push   %ebx
80105351:	e8 ba ff ff ff       	call   80105310 <holding>
80105356:	83 c4 10             	add    $0x10,%esp
80105359:	85 c0                	test   %eax,%eax
8010535b:	0f 85 83 00 00 00    	jne    801053e4 <acquire+0xa4>
80105361:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105363:	ba 01 00 00 00       	mov    $0x1,%edx
80105368:	eb 09                	jmp    80105373 <acquire+0x33>
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105370:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105373:	89 d0                	mov    %edx,%eax
80105375:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80105378:	85 c0                	test   %eax,%eax
8010537a:	75 f4                	jne    80105370 <acquire+0x30>
  __sync_synchronize();
8010537c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105381:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105384:	e8 87 e7 ff ff       	call   80103b10 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105389:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010538c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010538f:	89 e8                	mov    %ebp,%eax
80105391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105398:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010539e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801053a4:	77 1a                	ja     801053c0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801053a6:	8b 48 04             	mov    0x4(%eax),%ecx
801053a9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801053ac:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801053af:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801053b1:	83 fe 0a             	cmp    $0xa,%esi
801053b4:	75 e2                	jne    80105398 <acquire+0x58>
}
801053b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053b9:	5b                   	pop    %ebx
801053ba:	5e                   	pop    %esi
801053bb:	5d                   	pop    %ebp
801053bc:	c3                   	ret    
801053bd:	8d 76 00             	lea    0x0(%esi),%esi
801053c0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801053c3:	83 c2 28             	add    $0x28,%edx
801053c6:	8d 76 00             	lea    0x0(%esi),%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
801053d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801053d6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801053d9:	39 d0                	cmp    %edx,%eax
801053db:	75 f3                	jne    801053d0 <acquire+0x90>
}
801053dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053e0:	5b                   	pop    %ebx
801053e1:	5e                   	pop    %esi
801053e2:	5d                   	pop    %ebp
801053e3:	c3                   	ret    
    panic("acquire");
801053e4:	83 ec 0c             	sub    $0xc,%esp
801053e7:	68 75 8a 10 80       	push   $0x80108a75
801053ec:	e8 9f af ff ff       	call   80100390 <panic>
801053f1:	eb 0d                	jmp    80105400 <release>
801053f3:	90                   	nop
801053f4:	90                   	nop
801053f5:	90                   	nop
801053f6:	90                   	nop
801053f7:	90                   	nop
801053f8:	90                   	nop
801053f9:	90                   	nop
801053fa:	90                   	nop
801053fb:	90                   	nop
801053fc:	90                   	nop
801053fd:	90                   	nop
801053fe:	90                   	nop
801053ff:	90                   	nop

80105400 <release>:
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	53                   	push   %ebx
80105404:	83 ec 10             	sub    $0x10,%esp
80105407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010540a:	53                   	push   %ebx
8010540b:	e8 00 ff ff ff       	call   80105310 <holding>
80105410:	83 c4 10             	add    $0x10,%esp
80105413:	85 c0                	test   %eax,%eax
80105415:	74 22                	je     80105439 <release+0x39>
  lk->pcs[0] = 0;
80105417:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010541e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105425:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010542a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105430:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105433:	c9                   	leave  
  popcli();
80105434:	e9 77 fe ff ff       	jmp    801052b0 <popcli>
    panic("release");
80105439:	83 ec 0c             	sub    $0xc,%esp
8010543c:	68 7d 8a 10 80       	push   $0x80108a7d
80105441:	e8 4a af ff ff       	call   80100390 <panic>
80105446:	66 90                	xchg   %ax,%ax
80105448:	66 90                	xchg   %ax,%ax
8010544a:	66 90                	xchg   %ax,%ax
8010544c:	66 90                	xchg   %ax,%ax
8010544e:	66 90                	xchg   %ax,%ax

80105450 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	57                   	push   %edi
80105454:	53                   	push   %ebx
80105455:	8b 55 08             	mov    0x8(%ebp),%edx
80105458:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010545b:	f6 c2 03             	test   $0x3,%dl
8010545e:	75 05                	jne    80105465 <memset+0x15>
80105460:	f6 c1 03             	test   $0x3,%cl
80105463:	74 13                	je     80105478 <memset+0x28>
  asm volatile("cld; rep stosb" :
80105465:	89 d7                	mov    %edx,%edi
80105467:	8b 45 0c             	mov    0xc(%ebp),%eax
8010546a:	fc                   	cld    
8010546b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010546d:	5b                   	pop    %ebx
8010546e:	89 d0                	mov    %edx,%eax
80105470:	5f                   	pop    %edi
80105471:	5d                   	pop    %ebp
80105472:	c3                   	ret    
80105473:	90                   	nop
80105474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80105478:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010547c:	c1 e9 02             	shr    $0x2,%ecx
8010547f:	89 f8                	mov    %edi,%eax
80105481:	89 fb                	mov    %edi,%ebx
80105483:	c1 e0 18             	shl    $0x18,%eax
80105486:	c1 e3 10             	shl    $0x10,%ebx
80105489:	09 d8                	or     %ebx,%eax
8010548b:	09 f8                	or     %edi,%eax
8010548d:	c1 e7 08             	shl    $0x8,%edi
80105490:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80105492:	89 d7                	mov    %edx,%edi
80105494:	fc                   	cld    
80105495:	f3 ab                	rep stos %eax,%es:(%edi)
}
80105497:	5b                   	pop    %ebx
80105498:	89 d0                	mov    %edx,%eax
8010549a:	5f                   	pop    %edi
8010549b:	5d                   	pop    %ebp
8010549c:	c3                   	ret    
8010549d:	8d 76 00             	lea    0x0(%esi),%esi

801054a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	57                   	push   %edi
801054a4:	56                   	push   %esi
801054a5:	53                   	push   %ebx
801054a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801054a9:	8b 75 08             	mov    0x8(%ebp),%esi
801054ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801054af:	85 db                	test   %ebx,%ebx
801054b1:	74 29                	je     801054dc <memcmp+0x3c>
    if(*s1 != *s2)
801054b3:	0f b6 16             	movzbl (%esi),%edx
801054b6:	0f b6 0f             	movzbl (%edi),%ecx
801054b9:	38 d1                	cmp    %dl,%cl
801054bb:	75 2b                	jne    801054e8 <memcmp+0x48>
801054bd:	b8 01 00 00 00       	mov    $0x1,%eax
801054c2:	eb 14                	jmp    801054d8 <memcmp+0x38>
801054c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054c8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801054cc:	83 c0 01             	add    $0x1,%eax
801054cf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801054d4:	38 ca                	cmp    %cl,%dl
801054d6:	75 10                	jne    801054e8 <memcmp+0x48>
  while(n-- > 0){
801054d8:	39 d8                	cmp    %ebx,%eax
801054da:	75 ec                	jne    801054c8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801054dc:	5b                   	pop    %ebx
  return 0;
801054dd:	31 c0                	xor    %eax,%eax
}
801054df:	5e                   	pop    %esi
801054e0:	5f                   	pop    %edi
801054e1:	5d                   	pop    %ebp
801054e2:	c3                   	ret    
801054e3:	90                   	nop
801054e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801054e8:	0f b6 c2             	movzbl %dl,%eax
}
801054eb:	5b                   	pop    %ebx
      return *s1 - *s2;
801054ec:	29 c8                	sub    %ecx,%eax
}
801054ee:	5e                   	pop    %esi
801054ef:	5f                   	pop    %edi
801054f0:	5d                   	pop    %ebp
801054f1:	c3                   	ret    
801054f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	56                   	push   %esi
80105504:	53                   	push   %ebx
80105505:	8b 45 08             	mov    0x8(%ebp),%eax
80105508:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010550b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010550e:	39 c3                	cmp    %eax,%ebx
80105510:	73 26                	jae    80105538 <memmove+0x38>
80105512:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105515:	39 c8                	cmp    %ecx,%eax
80105517:	73 1f                	jae    80105538 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105519:	85 f6                	test   %esi,%esi
8010551b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010551e:	74 0f                	je     8010552f <memmove+0x2f>
      *--d = *--s;
80105520:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105524:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105527:	83 ea 01             	sub    $0x1,%edx
8010552a:	83 fa ff             	cmp    $0xffffffff,%edx
8010552d:	75 f1                	jne    80105520 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010552f:	5b                   	pop    %ebx
80105530:	5e                   	pop    %esi
80105531:	5d                   	pop    %ebp
80105532:	c3                   	ret    
80105533:	90                   	nop
80105534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105538:	31 d2                	xor    %edx,%edx
8010553a:	85 f6                	test   %esi,%esi
8010553c:	74 f1                	je     8010552f <memmove+0x2f>
8010553e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105540:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105544:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105547:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010554a:	39 d6                	cmp    %edx,%esi
8010554c:	75 f2                	jne    80105540 <memmove+0x40>
}
8010554e:	5b                   	pop    %ebx
8010554f:	5e                   	pop    %esi
80105550:	5d                   	pop    %ebp
80105551:	c3                   	ret    
80105552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105563:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105564:	eb 9a                	jmp    80105500 <memmove>
80105566:	8d 76 00             	lea    0x0(%esi),%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
80105575:	8b 7d 10             	mov    0x10(%ebp),%edi
80105578:	53                   	push   %ebx
80105579:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010557c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010557f:	85 ff                	test   %edi,%edi
80105581:	74 2f                	je     801055b2 <strncmp+0x42>
80105583:	0f b6 01             	movzbl (%ecx),%eax
80105586:	0f b6 1e             	movzbl (%esi),%ebx
80105589:	84 c0                	test   %al,%al
8010558b:	74 37                	je     801055c4 <strncmp+0x54>
8010558d:	38 c3                	cmp    %al,%bl
8010558f:	75 33                	jne    801055c4 <strncmp+0x54>
80105591:	01 f7                	add    %esi,%edi
80105593:	eb 13                	jmp    801055a8 <strncmp+0x38>
80105595:	8d 76 00             	lea    0x0(%esi),%esi
80105598:	0f b6 01             	movzbl (%ecx),%eax
8010559b:	84 c0                	test   %al,%al
8010559d:	74 21                	je     801055c0 <strncmp+0x50>
8010559f:	0f b6 1a             	movzbl (%edx),%ebx
801055a2:	89 d6                	mov    %edx,%esi
801055a4:	38 d8                	cmp    %bl,%al
801055a6:	75 1c                	jne    801055c4 <strncmp+0x54>
    n--, p++, q++;
801055a8:	8d 56 01             	lea    0x1(%esi),%edx
801055ab:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801055ae:	39 fa                	cmp    %edi,%edx
801055b0:	75 e6                	jne    80105598 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801055b2:	5b                   	pop    %ebx
    return 0;
801055b3:	31 c0                	xor    %eax,%eax
}
801055b5:	5e                   	pop    %esi
801055b6:	5f                   	pop    %edi
801055b7:	5d                   	pop    %ebp
801055b8:	c3                   	ret    
801055b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055c0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801055c4:	29 d8                	sub    %ebx,%eax
}
801055c6:	5b                   	pop    %ebx
801055c7:	5e                   	pop    %esi
801055c8:	5f                   	pop    %edi
801055c9:	5d                   	pop    %ebp
801055ca:	c3                   	ret    
801055cb:	90                   	nop
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
801055d5:	8b 45 08             	mov    0x8(%ebp),%eax
801055d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801055db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801055de:	89 c2                	mov    %eax,%edx
801055e0:	eb 19                	jmp    801055fb <strncpy+0x2b>
801055e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055e8:	83 c3 01             	add    $0x1,%ebx
801055eb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801055ef:	83 c2 01             	add    $0x1,%edx
801055f2:	84 c9                	test   %cl,%cl
801055f4:	88 4a ff             	mov    %cl,-0x1(%edx)
801055f7:	74 09                	je     80105602 <strncpy+0x32>
801055f9:	89 f1                	mov    %esi,%ecx
801055fb:	85 c9                	test   %ecx,%ecx
801055fd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105600:	7f e6                	jg     801055e8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105602:	31 c9                	xor    %ecx,%ecx
80105604:	85 f6                	test   %esi,%esi
80105606:	7e 17                	jle    8010561f <strncpy+0x4f>
80105608:	90                   	nop
80105609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105610:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105614:	89 f3                	mov    %esi,%ebx
80105616:	83 c1 01             	add    $0x1,%ecx
80105619:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010561b:	85 db                	test   %ebx,%ebx
8010561d:	7f f1                	jg     80105610 <strncpy+0x40>
  return os;
}
8010561f:	5b                   	pop    %ebx
80105620:	5e                   	pop    %esi
80105621:	5d                   	pop    %ebp
80105622:	c3                   	ret    
80105623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105630 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	56                   	push   %esi
80105634:	53                   	push   %ebx
80105635:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105638:	8b 45 08             	mov    0x8(%ebp),%eax
8010563b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010563e:	85 c9                	test   %ecx,%ecx
80105640:	7e 26                	jle    80105668 <safestrcpy+0x38>
80105642:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105646:	89 c1                	mov    %eax,%ecx
80105648:	eb 17                	jmp    80105661 <safestrcpy+0x31>
8010564a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105650:	83 c2 01             	add    $0x1,%edx
80105653:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105657:	83 c1 01             	add    $0x1,%ecx
8010565a:	84 db                	test   %bl,%bl
8010565c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010565f:	74 04                	je     80105665 <safestrcpy+0x35>
80105661:	39 f2                	cmp    %esi,%edx
80105663:	75 eb                	jne    80105650 <safestrcpy+0x20>
    ;
  *s = 0;
80105665:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105668:	5b                   	pop    %ebx
80105669:	5e                   	pop    %esi
8010566a:	5d                   	pop    %ebp
8010566b:	c3                   	ret    
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105670 <strlen>:

int
strlen(const char *s)
{
80105670:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105671:	31 c0                	xor    %eax,%eax
{
80105673:	89 e5                	mov    %esp,%ebp
80105675:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105678:	80 3a 00             	cmpb   $0x0,(%edx)
8010567b:	74 0c                	je     80105689 <strlen+0x19>
8010567d:	8d 76 00             	lea    0x0(%esi),%esi
80105680:	83 c0 01             	add    $0x1,%eax
80105683:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105687:	75 f7                	jne    80105680 <strlen+0x10>
    ;
  return n;
}
80105689:	5d                   	pop    %ebp
8010568a:	c3                   	ret    

8010568b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010568b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010568f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105693:	55                   	push   %ebp
  pushl %ebx
80105694:	53                   	push   %ebx
  pushl %esi
80105695:	56                   	push   %esi
  pushl %edi
80105696:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105697:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105699:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010569b:	5f                   	pop    %edi
  popl %esi
8010569c:	5e                   	pop    %esi
  popl %ebx
8010569d:	5b                   	pop    %ebx
  popl %ebp
8010569e:	5d                   	pop    %ebp
  ret
8010569f:	c3                   	ret    

801056a0 <fetchint>:
// library system call function. The saved user %esp points
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip) {
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
801056a4:	83 ec 04             	sub    $0x4,%esp
801056a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *curproc = myproc();
801056aa:	e8 01 e5 ff ff       	call   80103bb0 <myproc>

    if (addr >= curproc->sz || addr + 4 > curproc->sz)
801056af:	8b 00                	mov    (%eax),%eax
801056b1:	39 d8                	cmp    %ebx,%eax
801056b3:	76 1b                	jbe    801056d0 <fetchint+0x30>
801056b5:	8d 53 04             	lea    0x4(%ebx),%edx
801056b8:	39 d0                	cmp    %edx,%eax
801056ba:	72 14                	jb     801056d0 <fetchint+0x30>
        return -1;
    *ip = *(int *) (addr);
801056bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801056bf:	8b 13                	mov    (%ebx),%edx
801056c1:	89 10                	mov    %edx,(%eax)
    return 0;
801056c3:	31 c0                	xor    %eax,%eax
}
801056c5:	83 c4 04             	add    $0x4,%esp
801056c8:	5b                   	pop    %ebx
801056c9:	5d                   	pop    %ebp
801056ca:	c3                   	ret    
801056cb:	90                   	nop
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801056d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d5:	eb ee                	jmp    801056c5 <fetchint+0x25>
801056d7:	89 f6                	mov    %esi,%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056e0 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp) {
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
801056e4:	83 ec 04             	sub    $0x4,%esp
801056e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char *s, *ep;
    struct proc *curproc = myproc();
801056ea:	e8 c1 e4 ff ff       	call   80103bb0 <myproc>

    if (addr >= curproc->sz)
801056ef:	39 18                	cmp    %ebx,(%eax)
801056f1:	76 29                	jbe    8010571c <fetchstr+0x3c>
        return -1;
    *pp = (char *) addr;
801056f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801056f6:	89 da                	mov    %ebx,%edx
801056f8:	89 19                	mov    %ebx,(%ecx)
    ep = (char *) curproc->sz;
801056fa:	8b 00                	mov    (%eax),%eax
    for (s = *pp; s < ep; s++) {
801056fc:	39 c3                	cmp    %eax,%ebx
801056fe:	73 1c                	jae    8010571c <fetchstr+0x3c>
        if (*s == 0)
80105700:	80 3b 00             	cmpb   $0x0,(%ebx)
80105703:	75 10                	jne    80105715 <fetchstr+0x35>
80105705:	eb 39                	jmp    80105740 <fetchstr+0x60>
80105707:	89 f6                	mov    %esi,%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105710:	80 3a 00             	cmpb   $0x0,(%edx)
80105713:	74 1b                	je     80105730 <fetchstr+0x50>
    for (s = *pp; s < ep; s++) {
80105715:	83 c2 01             	add    $0x1,%edx
80105718:	39 d0                	cmp    %edx,%eax
8010571a:	77 f4                	ja     80105710 <fetchstr+0x30>
        return -1;
8010571c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
            return s - *pp;
    }
    return -1;
}
80105721:	83 c4 04             	add    $0x4,%esp
80105724:	5b                   	pop    %ebx
80105725:	5d                   	pop    %ebp
80105726:	c3                   	ret    
80105727:	89 f6                	mov    %esi,%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105730:	83 c4 04             	add    $0x4,%esp
80105733:	89 d0                	mov    %edx,%eax
80105735:	29 d8                	sub    %ebx,%eax
80105737:	5b                   	pop    %ebx
80105738:	5d                   	pop    %ebp
80105739:	c3                   	ret    
8010573a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (*s == 0)
80105740:	31 c0                	xor    %eax,%eax
            return s - *pp;
80105742:	eb dd                	jmp    80105721 <fetchstr+0x41>
80105744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010574a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105750 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip) {
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	56                   	push   %esi
80105754:	53                   	push   %ebx
    return fetchint((mythread()->tf->esp) + 4 + 4 * n, ip);
80105755:	e8 86 e4 ff ff       	call   80103be0 <mythread>
8010575a:	8b 40 08             	mov    0x8(%eax),%eax
8010575d:	8b 55 08             	mov    0x8(%ebp),%edx
80105760:	8b 40 44             	mov    0x44(%eax),%eax
80105763:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    struct proc *curproc = myproc();
80105766:	e8 45 e4 ff ff       	call   80103bb0 <myproc>
    if (addr >= curproc->sz || addr + 4 > curproc->sz)
8010576b:	8b 00                	mov    (%eax),%eax
    return fetchint((mythread()->tf->esp) + 4 + 4 * n, ip);
8010576d:	8d 73 04             	lea    0x4(%ebx),%esi
    if (addr >= curproc->sz || addr + 4 > curproc->sz)
80105770:	39 c6                	cmp    %eax,%esi
80105772:	73 1c                	jae    80105790 <argint+0x40>
80105774:	8d 53 08             	lea    0x8(%ebx),%edx
80105777:	39 d0                	cmp    %edx,%eax
80105779:	72 15                	jb     80105790 <argint+0x40>
    *ip = *(int *) (addr);
8010577b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010577e:	8b 53 04             	mov    0x4(%ebx),%edx
80105781:	89 10                	mov    %edx,(%eax)
    return 0;
80105783:	31 c0                	xor    %eax,%eax
}
80105785:	5b                   	pop    %ebx
80105786:	5e                   	pop    %esi
80105787:	5d                   	pop    %ebp
80105788:	c3                   	ret    
80105789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80105790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return fetchint((mythread()->tf->esp) + 4 + 4 * n, ip);
80105795:	eb ee                	jmp    80105785 <argint+0x35>
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size) {
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	56                   	push   %esi
801057a4:	53                   	push   %ebx
801057a5:	83 ec 10             	sub    $0x10,%esp
801057a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
    int i;
    struct proc *curproc = myproc();
801057ab:	e8 00 e4 ff ff       	call   80103bb0 <myproc>
801057b0:	89 c6                	mov    %eax,%esi

    if (argint(n, &i) < 0)
801057b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057b5:	83 ec 08             	sub    $0x8,%esp
801057b8:	50                   	push   %eax
801057b9:	ff 75 08             	pushl  0x8(%ebp)
801057bc:	e8 8f ff ff ff       	call   80105750 <argint>
        return -1;
    if (size < 0 || (uint) i >= curproc->sz || (uint) i + size > curproc->sz)
801057c1:	83 c4 10             	add    $0x10,%esp
801057c4:	85 c0                	test   %eax,%eax
801057c6:	78 28                	js     801057f0 <argptr+0x50>
801057c8:	85 db                	test   %ebx,%ebx
801057ca:	78 24                	js     801057f0 <argptr+0x50>
801057cc:	8b 16                	mov    (%esi),%edx
801057ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057d1:	39 c2                	cmp    %eax,%edx
801057d3:	76 1b                	jbe    801057f0 <argptr+0x50>
801057d5:	01 c3                	add    %eax,%ebx
801057d7:	39 da                	cmp    %ebx,%edx
801057d9:	72 15                	jb     801057f0 <argptr+0x50>
        return -1;
    *pp = (char *) i;
801057db:	8b 55 0c             	mov    0xc(%ebp),%edx
801057de:	89 02                	mov    %eax,(%edx)
    return 0;
801057e0:	31 c0                	xor    %eax,%eax
}
801057e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057e5:	5b                   	pop    %ebx
801057e6:	5e                   	pop    %esi
801057e7:	5d                   	pop    %ebp
801057e8:	c3                   	ret    
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801057f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f5:	eb eb                	jmp    801057e2 <argptr+0x42>
801057f7:	89 f6                	mov    %esi,%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105800 <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp) {
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	83 ec 20             	sub    $0x20,%esp
    int addr;
    if (argint(n, &addr) < 0)
80105806:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105809:	50                   	push   %eax
8010580a:	ff 75 08             	pushl  0x8(%ebp)
8010580d:	e8 3e ff ff ff       	call   80105750 <argint>
80105812:	83 c4 10             	add    $0x10,%esp
80105815:	85 c0                	test   %eax,%eax
80105817:	78 17                	js     80105830 <argstr+0x30>
        return -1;
    return fetchstr(addr, pp);
80105819:	83 ec 08             	sub    $0x8,%esp
8010581c:	ff 75 0c             	pushl  0xc(%ebp)
8010581f:	ff 75 f4             	pushl  -0xc(%ebp)
80105822:	e8 b9 fe ff ff       	call   801056e0 <fetchstr>
80105827:	83 c4 10             	add    $0x10,%esp
}
8010582a:	c9                   	leave  
8010582b:	c3                   	ret    
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80105830:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105835:	c9                   	leave  
80105836:	c3                   	ret    
80105837:	89 f6                	mov    %esi,%esi
80105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105840 <syscall>:


};

void
syscall(void) {
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	53                   	push   %ebx
80105844:	83 ec 04             	sub    $0x4,%esp
    int num;
    struct thread *curthread = mythread();
80105847:	e8 94 e3 ff ff       	call   80103be0 <mythread>
8010584c:	89 c3                	mov    %eax,%ebx

    num = curthread->tf->eax;
8010584e:	8b 40 08             	mov    0x8(%eax),%eax
80105851:	8b 40 1c             	mov    0x1c(%eax),%eax
    if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105854:	8d 50 ff             	lea    -0x1(%eax),%edx
80105857:	83 fa 1c             	cmp    $0x1c,%edx
8010585a:	77 1c                	ja     80105878 <syscall+0x38>
8010585c:	8b 14 85 c0 8a 10 80 	mov    -0x7fef7540(,%eax,4),%edx
80105863:	85 d2                	test   %edx,%edx
80105865:	74 11                	je     80105878 <syscall+0x38>
        curthread->tf->eax = syscalls[num]();
80105867:	ff d2                	call   *%edx
80105869:	8b 53 08             	mov    0x8(%ebx),%edx
8010586c:	89 42 1c             	mov    %eax,0x1c(%edx)
    } else {
        cprintf("%d %s: unknown sys call %d\n",
                curthread->tid, curthread->name, num);
        curthread->tf->eax = -1;
    }
}
8010586f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105872:	c9                   	leave  
80105873:	c3                   	ret    
80105874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%d %s: unknown sys call %d\n",
80105878:	50                   	push   %eax
                curthread->tid, curthread->name, num);
80105879:	8d 43 28             	lea    0x28(%ebx),%eax
        cprintf("%d %s: unknown sys call %d\n",
8010587c:	50                   	push   %eax
8010587d:	ff 73 0c             	pushl  0xc(%ebx)
80105880:	68 85 8a 10 80       	push   $0x80108a85
80105885:	e8 d6 ad ff ff       	call   80100660 <cprintf>
        curthread->tf->eax = -1;
8010588a:	8b 43 08             	mov    0x8(%ebx),%eax
8010588d:	83 c4 10             	add    $0x10,%esp
80105890:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105897:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010589a:	c9                   	leave  
8010589b:	c3                   	ret    
8010589c:	66 90                	xchg   %ax,%ax
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	57                   	push   %edi
801058a4:	56                   	push   %esi
801058a5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801058a6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
801058a9:	83 ec 44             	sub    $0x44,%esp
801058ac:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801058af:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801058b2:	56                   	push   %esi
801058b3:	50                   	push   %eax
{
801058b4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801058b7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801058ba:	e8 b1 c7 ff ff       	call   80102070 <nameiparent>
801058bf:	83 c4 10             	add    $0x10,%esp
801058c2:	85 c0                	test   %eax,%eax
801058c4:	0f 84 46 01 00 00    	je     80105a10 <create+0x170>
    return 0;
  ilock(dp);
801058ca:	83 ec 0c             	sub    $0xc,%esp
801058cd:	89 c3                	mov    %eax,%ebx
801058cf:	50                   	push   %eax
801058d0:	e8 1b bf ff ff       	call   801017f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801058d5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801058d8:	83 c4 0c             	add    $0xc,%esp
801058db:	50                   	push   %eax
801058dc:	56                   	push   %esi
801058dd:	53                   	push   %ebx
801058de:	e8 3d c4 ff ff       	call   80101d20 <dirlookup>
801058e3:	83 c4 10             	add    $0x10,%esp
801058e6:	85 c0                	test   %eax,%eax
801058e8:	89 c7                	mov    %eax,%edi
801058ea:	74 34                	je     80105920 <create+0x80>
    iunlockput(dp);
801058ec:	83 ec 0c             	sub    $0xc,%esp
801058ef:	53                   	push   %ebx
801058f0:	e8 8b c1 ff ff       	call   80101a80 <iunlockput>
    ilock(ip);
801058f5:	89 3c 24             	mov    %edi,(%esp)
801058f8:	e8 f3 be ff ff       	call   801017f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105905:	0f 85 95 00 00 00    	jne    801059a0 <create+0x100>
8010590b:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105910:	0f 85 8a 00 00 00    	jne    801059a0 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105916:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105919:	89 f8                	mov    %edi,%eax
8010591b:	5b                   	pop    %ebx
8010591c:	5e                   	pop    %esi
8010591d:	5f                   	pop    %edi
8010591e:	5d                   	pop    %ebp
8010591f:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105920:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105924:	83 ec 08             	sub    $0x8,%esp
80105927:	50                   	push   %eax
80105928:	ff 33                	pushl  (%ebx)
8010592a:	e8 51 bd ff ff       	call   80101680 <ialloc>
8010592f:	83 c4 10             	add    $0x10,%esp
80105932:	85 c0                	test   %eax,%eax
80105934:	89 c7                	mov    %eax,%edi
80105936:	0f 84 e8 00 00 00    	je     80105a24 <create+0x184>
  ilock(ip);
8010593c:	83 ec 0c             	sub    $0xc,%esp
8010593f:	50                   	push   %eax
80105940:	e8 ab be ff ff       	call   801017f0 <ilock>
  ip->major = major;
80105945:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105949:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010594d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105951:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105955:	b8 01 00 00 00       	mov    $0x1,%eax
8010595a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010595e:	89 3c 24             	mov    %edi,(%esp)
80105961:	e8 da bd ff ff       	call   80101740 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105966:	83 c4 10             	add    $0x10,%esp
80105969:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010596e:	74 50                	je     801059c0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105970:	83 ec 04             	sub    $0x4,%esp
80105973:	ff 77 04             	pushl  0x4(%edi)
80105976:	56                   	push   %esi
80105977:	53                   	push   %ebx
80105978:	e8 13 c6 ff ff       	call   80101f90 <dirlink>
8010597d:	83 c4 10             	add    $0x10,%esp
80105980:	85 c0                	test   %eax,%eax
80105982:	0f 88 8f 00 00 00    	js     80105a17 <create+0x177>
  iunlockput(dp);
80105988:	83 ec 0c             	sub    $0xc,%esp
8010598b:	53                   	push   %ebx
8010598c:	e8 ef c0 ff ff       	call   80101a80 <iunlockput>
  return ip;
80105991:	83 c4 10             	add    $0x10,%esp
}
80105994:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105997:	89 f8                	mov    %edi,%eax
80105999:	5b                   	pop    %ebx
8010599a:	5e                   	pop    %esi
8010599b:	5f                   	pop    %edi
8010599c:	5d                   	pop    %ebp
8010599d:	c3                   	ret    
8010599e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	57                   	push   %edi
    return 0;
801059a4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801059a6:	e8 d5 c0 ff ff       	call   80101a80 <iunlockput>
    return 0;
801059ab:	83 c4 10             	add    $0x10,%esp
}
801059ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059b1:	89 f8                	mov    %edi,%eax
801059b3:	5b                   	pop    %ebx
801059b4:	5e                   	pop    %esi
801059b5:	5f                   	pop    %edi
801059b6:	5d                   	pop    %ebp
801059b7:	c3                   	ret    
801059b8:	90                   	nop
801059b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801059c0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801059c5:	83 ec 0c             	sub    $0xc,%esp
801059c8:	53                   	push   %ebx
801059c9:	e8 72 bd ff ff       	call   80101740 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801059ce:	83 c4 0c             	add    $0xc,%esp
801059d1:	ff 77 04             	pushl  0x4(%edi)
801059d4:	68 54 8b 10 80       	push   $0x80108b54
801059d9:	57                   	push   %edi
801059da:	e8 b1 c5 ff ff       	call   80101f90 <dirlink>
801059df:	83 c4 10             	add    $0x10,%esp
801059e2:	85 c0                	test   %eax,%eax
801059e4:	78 1c                	js     80105a02 <create+0x162>
801059e6:	83 ec 04             	sub    $0x4,%esp
801059e9:	ff 73 04             	pushl  0x4(%ebx)
801059ec:	68 53 8b 10 80       	push   $0x80108b53
801059f1:	57                   	push   %edi
801059f2:	e8 99 c5 ff ff       	call   80101f90 <dirlink>
801059f7:	83 c4 10             	add    $0x10,%esp
801059fa:	85 c0                	test   %eax,%eax
801059fc:	0f 89 6e ff ff ff    	jns    80105970 <create+0xd0>
      panic("create dots");
80105a02:	83 ec 0c             	sub    $0xc,%esp
80105a05:	68 47 8b 10 80       	push   $0x80108b47
80105a0a:	e8 81 a9 ff ff       	call   80100390 <panic>
80105a0f:	90                   	nop
    return 0;
80105a10:	31 ff                	xor    %edi,%edi
80105a12:	e9 ff fe ff ff       	jmp    80105916 <create+0x76>
    panic("create: dirlink");
80105a17:	83 ec 0c             	sub    $0xc,%esp
80105a1a:	68 56 8b 10 80       	push   $0x80108b56
80105a1f:	e8 6c a9 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105a24:	83 ec 0c             	sub    $0xc,%esp
80105a27:	68 38 8b 10 80       	push   $0x80108b38
80105a2c:	e8 5f a9 ff ff       	call   80100390 <panic>
80105a31:	eb 0d                	jmp    80105a40 <argfd.constprop.0>
80105a33:	90                   	nop
80105a34:	90                   	nop
80105a35:	90                   	nop
80105a36:	90                   	nop
80105a37:	90                   	nop
80105a38:	90                   	nop
80105a39:	90                   	nop
80105a3a:	90                   	nop
80105a3b:	90                   	nop
80105a3c:	90                   	nop
80105a3d:	90                   	nop
80105a3e:	90                   	nop
80105a3f:	90                   	nop

80105a40 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	56                   	push   %esi
80105a44:	53                   	push   %ebx
80105a45:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105a47:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80105a4a:	89 d6                	mov    %edx,%esi
80105a4c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a4f:	50                   	push   %eax
80105a50:	6a 00                	push   $0x0
80105a52:	e8 f9 fc ff ff       	call   80105750 <argint>
80105a57:	83 c4 10             	add    $0x10,%esp
80105a5a:	85 c0                	test   %eax,%eax
80105a5c:	78 2a                	js     80105a88 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a5e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a62:	77 24                	ja     80105a88 <argfd.constprop.0+0x48>
80105a64:	e8 47 e1 ff ff       	call   80103bb0 <myproc>
80105a69:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a6c:	8b 44 90 18          	mov    0x18(%eax,%edx,4),%eax
80105a70:	85 c0                	test   %eax,%eax
80105a72:	74 14                	je     80105a88 <argfd.constprop.0+0x48>
  if(pfd)
80105a74:	85 db                	test   %ebx,%ebx
80105a76:	74 02                	je     80105a7a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105a78:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80105a7a:	89 06                	mov    %eax,(%esi)
  return 0;
80105a7c:	31 c0                	xor    %eax,%eax
}
80105a7e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a81:	5b                   	pop    %ebx
80105a82:	5e                   	pop    %esi
80105a83:	5d                   	pop    %ebp
80105a84:	c3                   	ret    
80105a85:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8d:	eb ef                	jmp    80105a7e <argfd.constprop.0+0x3e>
80105a8f:	90                   	nop

80105a90 <sys_dup>:
{
80105a90:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105a91:	31 c0                	xor    %eax,%eax
{
80105a93:	89 e5                	mov    %esp,%ebp
80105a95:	56                   	push   %esi
80105a96:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105a97:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80105a9a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105a9d:	e8 9e ff ff ff       	call   80105a40 <argfd.constprop.0>
80105aa2:	85 c0                	test   %eax,%eax
80105aa4:	78 42                	js     80105ae8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80105aa6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105aa9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105aab:	e8 00 e1 ff ff       	call   80103bb0 <myproc>
80105ab0:	eb 0e                	jmp    80105ac0 <sys_dup+0x30>
80105ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105ab8:	83 c3 01             	add    $0x1,%ebx
80105abb:	83 fb 10             	cmp    $0x10,%ebx
80105abe:	74 28                	je     80105ae8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105ac0:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
80105ac4:	85 d2                	test   %edx,%edx
80105ac6:	75 f0                	jne    80105ab8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105ac8:	89 74 98 18          	mov    %esi,0x18(%eax,%ebx,4)
  filedup(f);
80105acc:	83 ec 0c             	sub    $0xc,%esp
80105acf:	ff 75 f4             	pushl  -0xc(%ebp)
80105ad2:	e8 79 b4 ff ff       	call   80100f50 <filedup>
  return fd;
80105ad7:	83 c4 10             	add    $0x10,%esp
}
80105ada:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105add:	89 d8                	mov    %ebx,%eax
80105adf:	5b                   	pop    %ebx
80105ae0:	5e                   	pop    %esi
80105ae1:	5d                   	pop    %ebp
80105ae2:	c3                   	ret    
80105ae3:	90                   	nop
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ae8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105aeb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105af0:	89 d8                	mov    %ebx,%eax
80105af2:	5b                   	pop    %ebx
80105af3:	5e                   	pop    %esi
80105af4:	5d                   	pop    %ebp
80105af5:	c3                   	ret    
80105af6:	8d 76 00             	lea    0x0(%esi),%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b00 <sys_read>:
{
80105b00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b01:	31 c0                	xor    %eax,%eax
{
80105b03:	89 e5                	mov    %esp,%ebp
80105b05:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105b0b:	e8 30 ff ff ff       	call   80105a40 <argfd.constprop.0>
80105b10:	85 c0                	test   %eax,%eax
80105b12:	78 4c                	js     80105b60 <sys_read+0x60>
80105b14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b17:	83 ec 08             	sub    $0x8,%esp
80105b1a:	50                   	push   %eax
80105b1b:	6a 02                	push   $0x2
80105b1d:	e8 2e fc ff ff       	call   80105750 <argint>
80105b22:	83 c4 10             	add    $0x10,%esp
80105b25:	85 c0                	test   %eax,%eax
80105b27:	78 37                	js     80105b60 <sys_read+0x60>
80105b29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b2c:	83 ec 04             	sub    $0x4,%esp
80105b2f:	ff 75 f0             	pushl  -0x10(%ebp)
80105b32:	50                   	push   %eax
80105b33:	6a 01                	push   $0x1
80105b35:	e8 66 fc ff ff       	call   801057a0 <argptr>
80105b3a:	83 c4 10             	add    $0x10,%esp
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	78 1f                	js     80105b60 <sys_read+0x60>
  return fileread(f, p, n);
80105b41:	83 ec 04             	sub    $0x4,%esp
80105b44:	ff 75 f0             	pushl  -0x10(%ebp)
80105b47:	ff 75 f4             	pushl  -0xc(%ebp)
80105b4a:	ff 75 ec             	pushl  -0x14(%ebp)
80105b4d:	e8 6e b5 ff ff       	call   801010c0 <fileread>
80105b52:	83 c4 10             	add    $0x10,%esp
}
80105b55:	c9                   	leave  
80105b56:	c3                   	ret    
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b65:	c9                   	leave  
80105b66:	c3                   	ret    
80105b67:	89 f6                	mov    %esi,%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b70 <sys_write>:
{
80105b70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b71:	31 c0                	xor    %eax,%eax
{
80105b73:	89 e5                	mov    %esp,%ebp
80105b75:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105b7b:	e8 c0 fe ff ff       	call   80105a40 <argfd.constprop.0>
80105b80:	85 c0                	test   %eax,%eax
80105b82:	78 4c                	js     80105bd0 <sys_write+0x60>
80105b84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b87:	83 ec 08             	sub    $0x8,%esp
80105b8a:	50                   	push   %eax
80105b8b:	6a 02                	push   $0x2
80105b8d:	e8 be fb ff ff       	call   80105750 <argint>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	85 c0                	test   %eax,%eax
80105b97:	78 37                	js     80105bd0 <sys_write+0x60>
80105b99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b9c:	83 ec 04             	sub    $0x4,%esp
80105b9f:	ff 75 f0             	pushl  -0x10(%ebp)
80105ba2:	50                   	push   %eax
80105ba3:	6a 01                	push   $0x1
80105ba5:	e8 f6 fb ff ff       	call   801057a0 <argptr>
80105baa:	83 c4 10             	add    $0x10,%esp
80105bad:	85 c0                	test   %eax,%eax
80105baf:	78 1f                	js     80105bd0 <sys_write+0x60>
  return filewrite(f, p, n);
80105bb1:	83 ec 04             	sub    $0x4,%esp
80105bb4:	ff 75 f0             	pushl  -0x10(%ebp)
80105bb7:	ff 75 f4             	pushl  -0xc(%ebp)
80105bba:	ff 75 ec             	pushl  -0x14(%ebp)
80105bbd:	e8 8e b5 ff ff       	call   80101150 <filewrite>
80105bc2:	83 c4 10             	add    $0x10,%esp
}
80105bc5:	c9                   	leave  
80105bc6:	c3                   	ret    
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bd5:	c9                   	leave  
80105bd6:	c3                   	ret    
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105be0 <sys_close>:
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105be6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105be9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bec:	e8 4f fe ff ff       	call   80105a40 <argfd.constprop.0>
80105bf1:	85 c0                	test   %eax,%eax
80105bf3:	78 2b                	js     80105c20 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105bf5:	e8 b6 df ff ff       	call   80103bb0 <myproc>
80105bfa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105bfd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105c00:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
80105c07:	00 
  fileclose(f);
80105c08:	ff 75 f4             	pushl  -0xc(%ebp)
80105c0b:	e8 90 b3 ff ff       	call   80100fa0 <fileclose>
  return 0;
80105c10:	83 c4 10             	add    $0x10,%esp
80105c13:	31 c0                	xor    %eax,%eax
}
80105c15:	c9                   	leave  
80105c16:	c3                   	ret    
80105c17:	89 f6                	mov    %esi,%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c25:	c9                   	leave  
80105c26:	c3                   	ret    
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c30 <sys_fstat>:
{
80105c30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c31:	31 c0                	xor    %eax,%eax
{
80105c33:	89 e5                	mov    %esp,%ebp
80105c35:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c38:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105c3b:	e8 00 fe ff ff       	call   80105a40 <argfd.constprop.0>
80105c40:	85 c0                	test   %eax,%eax
80105c42:	78 2c                	js     80105c70 <sys_fstat+0x40>
80105c44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c47:	83 ec 04             	sub    $0x4,%esp
80105c4a:	6a 14                	push   $0x14
80105c4c:	50                   	push   %eax
80105c4d:	6a 01                	push   $0x1
80105c4f:	e8 4c fb ff ff       	call   801057a0 <argptr>
80105c54:	83 c4 10             	add    $0x10,%esp
80105c57:	85 c0                	test   %eax,%eax
80105c59:	78 15                	js     80105c70 <sys_fstat+0x40>
  return filestat(f, st);
80105c5b:	83 ec 08             	sub    $0x8,%esp
80105c5e:	ff 75 f4             	pushl  -0xc(%ebp)
80105c61:	ff 75 f0             	pushl  -0x10(%ebp)
80105c64:	e8 07 b4 ff ff       	call   80101070 <filestat>
80105c69:	83 c4 10             	add    $0x10,%esp
}
80105c6c:	c9                   	leave  
80105c6d:	c3                   	ret    
80105c6e:	66 90                	xchg   %ax,%ax
    return -1;
80105c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c75:	c9                   	leave  
80105c76:	c3                   	ret    
80105c77:	89 f6                	mov    %esi,%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c80 <sys_link>:
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	57                   	push   %edi
80105c84:	56                   	push   %esi
80105c85:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105c86:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105c89:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105c8c:	50                   	push   %eax
80105c8d:	6a 00                	push   $0x0
80105c8f:	e8 6c fb ff ff       	call   80105800 <argstr>
80105c94:	83 c4 10             	add    $0x10,%esp
80105c97:	85 c0                	test   %eax,%eax
80105c99:	0f 88 fb 00 00 00    	js     80105d9a <sys_link+0x11a>
80105c9f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ca2:	83 ec 08             	sub    $0x8,%esp
80105ca5:	50                   	push   %eax
80105ca6:	6a 01                	push   $0x1
80105ca8:	e8 53 fb ff ff       	call   80105800 <argstr>
80105cad:	83 c4 10             	add    $0x10,%esp
80105cb0:	85 c0                	test   %eax,%eax
80105cb2:	0f 88 e2 00 00 00    	js     80105d9a <sys_link+0x11a>
  begin_op();
80105cb8:	e8 53 d0 ff ff       	call   80102d10 <begin_op>
  if((ip = namei(old)) == 0){
80105cbd:	83 ec 0c             	sub    $0xc,%esp
80105cc0:	ff 75 d4             	pushl  -0x2c(%ebp)
80105cc3:	e8 88 c3 ff ff       	call   80102050 <namei>
80105cc8:	83 c4 10             	add    $0x10,%esp
80105ccb:	85 c0                	test   %eax,%eax
80105ccd:	89 c3                	mov    %eax,%ebx
80105ccf:	0f 84 ea 00 00 00    	je     80105dbf <sys_link+0x13f>
  ilock(ip);
80105cd5:	83 ec 0c             	sub    $0xc,%esp
80105cd8:	50                   	push   %eax
80105cd9:	e8 12 bb ff ff       	call   801017f0 <ilock>
  if(ip->type == T_DIR){
80105cde:	83 c4 10             	add    $0x10,%esp
80105ce1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ce6:	0f 84 bb 00 00 00    	je     80105da7 <sys_link+0x127>
  ip->nlink++;
80105cec:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cf1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80105cf4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105cf7:	53                   	push   %ebx
80105cf8:	e8 43 ba ff ff       	call   80101740 <iupdate>
  iunlock(ip);
80105cfd:	89 1c 24             	mov    %ebx,(%esp)
80105d00:	e8 cb bb ff ff       	call   801018d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105d05:	58                   	pop    %eax
80105d06:	5a                   	pop    %edx
80105d07:	57                   	push   %edi
80105d08:	ff 75 d0             	pushl  -0x30(%ebp)
80105d0b:	e8 60 c3 ff ff       	call   80102070 <nameiparent>
80105d10:	83 c4 10             	add    $0x10,%esp
80105d13:	85 c0                	test   %eax,%eax
80105d15:	89 c6                	mov    %eax,%esi
80105d17:	74 5b                	je     80105d74 <sys_link+0xf4>
  ilock(dp);
80105d19:	83 ec 0c             	sub    $0xc,%esp
80105d1c:	50                   	push   %eax
80105d1d:	e8 ce ba ff ff       	call   801017f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105d22:	83 c4 10             	add    $0x10,%esp
80105d25:	8b 03                	mov    (%ebx),%eax
80105d27:	39 06                	cmp    %eax,(%esi)
80105d29:	75 3d                	jne    80105d68 <sys_link+0xe8>
80105d2b:	83 ec 04             	sub    $0x4,%esp
80105d2e:	ff 73 04             	pushl  0x4(%ebx)
80105d31:	57                   	push   %edi
80105d32:	56                   	push   %esi
80105d33:	e8 58 c2 ff ff       	call   80101f90 <dirlink>
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	85 c0                	test   %eax,%eax
80105d3d:	78 29                	js     80105d68 <sys_link+0xe8>
  iunlockput(dp);
80105d3f:	83 ec 0c             	sub    $0xc,%esp
80105d42:	56                   	push   %esi
80105d43:	e8 38 bd ff ff       	call   80101a80 <iunlockput>
  iput(ip);
80105d48:	89 1c 24             	mov    %ebx,(%esp)
80105d4b:	e8 d0 bb ff ff       	call   80101920 <iput>
  end_op();
80105d50:	e8 2b d0 ff ff       	call   80102d80 <end_op>
  return 0;
80105d55:	83 c4 10             	add    $0x10,%esp
80105d58:	31 c0                	xor    %eax,%eax
}
80105d5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d5d:	5b                   	pop    %ebx
80105d5e:	5e                   	pop    %esi
80105d5f:	5f                   	pop    %edi
80105d60:	5d                   	pop    %ebp
80105d61:	c3                   	ret    
80105d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105d68:	83 ec 0c             	sub    $0xc,%esp
80105d6b:	56                   	push   %esi
80105d6c:	e8 0f bd ff ff       	call   80101a80 <iunlockput>
    goto bad;
80105d71:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105d74:	83 ec 0c             	sub    $0xc,%esp
80105d77:	53                   	push   %ebx
80105d78:	e8 73 ba ff ff       	call   801017f0 <ilock>
  ip->nlink--;
80105d7d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105d82:	89 1c 24             	mov    %ebx,(%esp)
80105d85:	e8 b6 b9 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
80105d8a:	89 1c 24             	mov    %ebx,(%esp)
80105d8d:	e8 ee bc ff ff       	call   80101a80 <iunlockput>
  end_op();
80105d92:	e8 e9 cf ff ff       	call   80102d80 <end_op>
  return -1;
80105d97:	83 c4 10             	add    $0x10,%esp
}
80105d9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105da2:	5b                   	pop    %ebx
80105da3:	5e                   	pop    %esi
80105da4:	5f                   	pop    %edi
80105da5:	5d                   	pop    %ebp
80105da6:	c3                   	ret    
    iunlockput(ip);
80105da7:	83 ec 0c             	sub    $0xc,%esp
80105daa:	53                   	push   %ebx
80105dab:	e8 d0 bc ff ff       	call   80101a80 <iunlockput>
    end_op();
80105db0:	e8 cb cf ff ff       	call   80102d80 <end_op>
    return -1;
80105db5:	83 c4 10             	add    $0x10,%esp
80105db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dbd:	eb 9b                	jmp    80105d5a <sys_link+0xda>
    end_op();
80105dbf:	e8 bc cf ff ff       	call   80102d80 <end_op>
    return -1;
80105dc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dc9:	eb 8f                	jmp    80105d5a <sys_link+0xda>
80105dcb:	90                   	nop
80105dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <sys_unlink>:
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	57                   	push   %edi
80105dd4:	56                   	push   %esi
80105dd5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105dd6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105dd9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80105ddc:	50                   	push   %eax
80105ddd:	6a 00                	push   $0x0
80105ddf:	e8 1c fa ff ff       	call   80105800 <argstr>
80105de4:	83 c4 10             	add    $0x10,%esp
80105de7:	85 c0                	test   %eax,%eax
80105de9:	0f 88 77 01 00 00    	js     80105f66 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80105def:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105df2:	e8 19 cf ff ff       	call   80102d10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105df7:	83 ec 08             	sub    $0x8,%esp
80105dfa:	53                   	push   %ebx
80105dfb:	ff 75 c0             	pushl  -0x40(%ebp)
80105dfe:	e8 6d c2 ff ff       	call   80102070 <nameiparent>
80105e03:	83 c4 10             	add    $0x10,%esp
80105e06:	85 c0                	test   %eax,%eax
80105e08:	89 c6                	mov    %eax,%esi
80105e0a:	0f 84 60 01 00 00    	je     80105f70 <sys_unlink+0x1a0>
  ilock(dp);
80105e10:	83 ec 0c             	sub    $0xc,%esp
80105e13:	50                   	push   %eax
80105e14:	e8 d7 b9 ff ff       	call   801017f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105e19:	58                   	pop    %eax
80105e1a:	5a                   	pop    %edx
80105e1b:	68 54 8b 10 80       	push   $0x80108b54
80105e20:	53                   	push   %ebx
80105e21:	e8 da be ff ff       	call   80101d00 <namecmp>
80105e26:	83 c4 10             	add    $0x10,%esp
80105e29:	85 c0                	test   %eax,%eax
80105e2b:	0f 84 03 01 00 00    	je     80105f34 <sys_unlink+0x164>
80105e31:	83 ec 08             	sub    $0x8,%esp
80105e34:	68 53 8b 10 80       	push   $0x80108b53
80105e39:	53                   	push   %ebx
80105e3a:	e8 c1 be ff ff       	call   80101d00 <namecmp>
80105e3f:	83 c4 10             	add    $0x10,%esp
80105e42:	85 c0                	test   %eax,%eax
80105e44:	0f 84 ea 00 00 00    	je     80105f34 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105e4a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105e4d:	83 ec 04             	sub    $0x4,%esp
80105e50:	50                   	push   %eax
80105e51:	53                   	push   %ebx
80105e52:	56                   	push   %esi
80105e53:	e8 c8 be ff ff       	call   80101d20 <dirlookup>
80105e58:	83 c4 10             	add    $0x10,%esp
80105e5b:	85 c0                	test   %eax,%eax
80105e5d:	89 c3                	mov    %eax,%ebx
80105e5f:	0f 84 cf 00 00 00    	je     80105f34 <sys_unlink+0x164>
  ilock(ip);
80105e65:	83 ec 0c             	sub    $0xc,%esp
80105e68:	50                   	push   %eax
80105e69:	e8 82 b9 ff ff       	call   801017f0 <ilock>
  if(ip->nlink < 1)
80105e6e:	83 c4 10             	add    $0x10,%esp
80105e71:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105e76:	0f 8e 10 01 00 00    	jle    80105f8c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105e7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105e81:	74 6d                	je     80105ef0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105e83:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105e86:	83 ec 04             	sub    $0x4,%esp
80105e89:	6a 10                	push   $0x10
80105e8b:	6a 00                	push   $0x0
80105e8d:	50                   	push   %eax
80105e8e:	e8 bd f5 ff ff       	call   80105450 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e93:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105e96:	6a 10                	push   $0x10
80105e98:	ff 75 c4             	pushl  -0x3c(%ebp)
80105e9b:	50                   	push   %eax
80105e9c:	56                   	push   %esi
80105e9d:	e8 2e bd ff ff       	call   80101bd0 <writei>
80105ea2:	83 c4 20             	add    $0x20,%esp
80105ea5:	83 f8 10             	cmp    $0x10,%eax
80105ea8:	0f 85 eb 00 00 00    	jne    80105f99 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80105eae:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105eb3:	0f 84 97 00 00 00    	je     80105f50 <sys_unlink+0x180>
  iunlockput(dp);
80105eb9:	83 ec 0c             	sub    $0xc,%esp
80105ebc:	56                   	push   %esi
80105ebd:	e8 be bb ff ff       	call   80101a80 <iunlockput>
  ip->nlink--;
80105ec2:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ec7:	89 1c 24             	mov    %ebx,(%esp)
80105eca:	e8 71 b8 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
80105ecf:	89 1c 24             	mov    %ebx,(%esp)
80105ed2:	e8 a9 bb ff ff       	call   80101a80 <iunlockput>
  end_op();
80105ed7:	e8 a4 ce ff ff       	call   80102d80 <end_op>
  return 0;
80105edc:	83 c4 10             	add    $0x10,%esp
80105edf:	31 c0                	xor    %eax,%eax
}
80105ee1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ee4:	5b                   	pop    %ebx
80105ee5:	5e                   	pop    %esi
80105ee6:	5f                   	pop    %edi
80105ee7:	5d                   	pop    %ebp
80105ee8:	c3                   	ret    
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ef0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105ef4:	76 8d                	jbe    80105e83 <sys_unlink+0xb3>
80105ef6:	bf 20 00 00 00       	mov    $0x20,%edi
80105efb:	eb 0f                	jmp    80105f0c <sys_unlink+0x13c>
80105efd:	8d 76 00             	lea    0x0(%esi),%esi
80105f00:	83 c7 10             	add    $0x10,%edi
80105f03:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105f06:	0f 83 77 ff ff ff    	jae    80105e83 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f0c:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105f0f:	6a 10                	push   $0x10
80105f11:	57                   	push   %edi
80105f12:	50                   	push   %eax
80105f13:	53                   	push   %ebx
80105f14:	e8 b7 bb ff ff       	call   80101ad0 <readi>
80105f19:	83 c4 10             	add    $0x10,%esp
80105f1c:	83 f8 10             	cmp    $0x10,%eax
80105f1f:	75 5e                	jne    80105f7f <sys_unlink+0x1af>
    if(de.inum != 0)
80105f21:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105f26:	74 d8                	je     80105f00 <sys_unlink+0x130>
    iunlockput(ip);
80105f28:	83 ec 0c             	sub    $0xc,%esp
80105f2b:	53                   	push   %ebx
80105f2c:	e8 4f bb ff ff       	call   80101a80 <iunlockput>
    goto bad;
80105f31:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105f34:	83 ec 0c             	sub    $0xc,%esp
80105f37:	56                   	push   %esi
80105f38:	e8 43 bb ff ff       	call   80101a80 <iunlockput>
  end_op();
80105f3d:	e8 3e ce ff ff       	call   80102d80 <end_op>
  return -1;
80105f42:	83 c4 10             	add    $0x10,%esp
80105f45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f4a:	eb 95                	jmp    80105ee1 <sys_unlink+0x111>
80105f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105f50:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105f55:	83 ec 0c             	sub    $0xc,%esp
80105f58:	56                   	push   %esi
80105f59:	e8 e2 b7 ff ff       	call   80101740 <iupdate>
80105f5e:	83 c4 10             	add    $0x10,%esp
80105f61:	e9 53 ff ff ff       	jmp    80105eb9 <sys_unlink+0xe9>
    return -1;
80105f66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6b:	e9 71 ff ff ff       	jmp    80105ee1 <sys_unlink+0x111>
    end_op();
80105f70:	e8 0b ce ff ff       	call   80102d80 <end_op>
    return -1;
80105f75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f7a:	e9 62 ff ff ff       	jmp    80105ee1 <sys_unlink+0x111>
      panic("isdirempty: readi");
80105f7f:	83 ec 0c             	sub    $0xc,%esp
80105f82:	68 78 8b 10 80       	push   $0x80108b78
80105f87:	e8 04 a4 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105f8c:	83 ec 0c             	sub    $0xc,%esp
80105f8f:	68 66 8b 10 80       	push   $0x80108b66
80105f94:	e8 f7 a3 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105f99:	83 ec 0c             	sub    $0xc,%esp
80105f9c:	68 8a 8b 10 80       	push   $0x80108b8a
80105fa1:	e8 ea a3 ff ff       	call   80100390 <panic>
80105fa6:	8d 76 00             	lea    0x0(%esi),%esi
80105fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fb0 <sys_open>:

int
sys_open(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	57                   	push   %edi
80105fb4:	56                   	push   %esi
80105fb5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105fb6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105fb9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105fbc:	50                   	push   %eax
80105fbd:	6a 00                	push   $0x0
80105fbf:	e8 3c f8 ff ff       	call   80105800 <argstr>
80105fc4:	83 c4 10             	add    $0x10,%esp
80105fc7:	85 c0                	test   %eax,%eax
80105fc9:	0f 88 1d 01 00 00    	js     801060ec <sys_open+0x13c>
80105fcf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105fd2:	83 ec 08             	sub    $0x8,%esp
80105fd5:	50                   	push   %eax
80105fd6:	6a 01                	push   $0x1
80105fd8:	e8 73 f7 ff ff       	call   80105750 <argint>
80105fdd:	83 c4 10             	add    $0x10,%esp
80105fe0:	85 c0                	test   %eax,%eax
80105fe2:	0f 88 04 01 00 00    	js     801060ec <sys_open+0x13c>
    return -1;

  begin_op();
80105fe8:	e8 23 cd ff ff       	call   80102d10 <begin_op>

  if(omode & O_CREATE){
80105fed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105ff1:	0f 85 a9 00 00 00    	jne    801060a0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105ff7:	83 ec 0c             	sub    $0xc,%esp
80105ffa:	ff 75 e0             	pushl  -0x20(%ebp)
80105ffd:	e8 4e c0 ff ff       	call   80102050 <namei>
80106002:	83 c4 10             	add    $0x10,%esp
80106005:	85 c0                	test   %eax,%eax
80106007:	89 c6                	mov    %eax,%esi
80106009:	0f 84 b2 00 00 00    	je     801060c1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
8010600f:	83 ec 0c             	sub    $0xc,%esp
80106012:	50                   	push   %eax
80106013:	e8 d8 b7 ff ff       	call   801017f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106018:	83 c4 10             	add    $0x10,%esp
8010601b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106020:	0f 84 aa 00 00 00    	je     801060d0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106026:	e8 b5 ae ff ff       	call   80100ee0 <filealloc>
8010602b:	85 c0                	test   %eax,%eax
8010602d:	89 c7                	mov    %eax,%edi
8010602f:	0f 84 a6 00 00 00    	je     801060db <sys_open+0x12b>
  struct proc *curproc = myproc();
80106035:	e8 76 db ff ff       	call   80103bb0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010603a:	31 db                	xor    %ebx,%ebx
8010603c:	eb 0e                	jmp    8010604c <sys_open+0x9c>
8010603e:	66 90                	xchg   %ax,%ax
80106040:	83 c3 01             	add    $0x1,%ebx
80106043:	83 fb 10             	cmp    $0x10,%ebx
80106046:	0f 84 ac 00 00 00    	je     801060f8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010604c:	8b 54 98 18          	mov    0x18(%eax,%ebx,4),%edx
80106050:	85 d2                	test   %edx,%edx
80106052:	75 ec                	jne    80106040 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106054:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106057:	89 7c 98 18          	mov    %edi,0x18(%eax,%ebx,4)
  iunlock(ip);
8010605b:	56                   	push   %esi
8010605c:	e8 6f b8 ff ff       	call   801018d0 <iunlock>
  end_op();
80106061:	e8 1a cd ff ff       	call   80102d80 <end_op>

  f->type = FD_INODE;
80106066:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010606c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010606f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106072:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80106075:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010607c:	89 d0                	mov    %edx,%eax
8010607e:	f7 d0                	not    %eax
80106080:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106083:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106086:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106089:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010608d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106090:	89 d8                	mov    %ebx,%eax
80106092:	5b                   	pop    %ebx
80106093:	5e                   	pop    %esi
80106094:	5f                   	pop    %edi
80106095:	5d                   	pop    %ebp
80106096:	c3                   	ret    
80106097:	89 f6                	mov    %esi,%esi
80106099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801060a0:	83 ec 0c             	sub    $0xc,%esp
801060a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801060a6:	31 c9                	xor    %ecx,%ecx
801060a8:	6a 00                	push   $0x0
801060aa:	ba 02 00 00 00       	mov    $0x2,%edx
801060af:	e8 ec f7 ff ff       	call   801058a0 <create>
    if(ip == 0){
801060b4:	83 c4 10             	add    $0x10,%esp
801060b7:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801060b9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801060bb:	0f 85 65 ff ff ff    	jne    80106026 <sys_open+0x76>
      end_op();
801060c1:	e8 ba cc ff ff       	call   80102d80 <end_op>
      return -1;
801060c6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801060cb:	eb c0                	jmp    8010608d <sys_open+0xdd>
801060cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801060d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801060d3:	85 c9                	test   %ecx,%ecx
801060d5:	0f 84 4b ff ff ff    	je     80106026 <sys_open+0x76>
    iunlockput(ip);
801060db:	83 ec 0c             	sub    $0xc,%esp
801060de:	56                   	push   %esi
801060df:	e8 9c b9 ff ff       	call   80101a80 <iunlockput>
    end_op();
801060e4:	e8 97 cc ff ff       	call   80102d80 <end_op>
    return -1;
801060e9:	83 c4 10             	add    $0x10,%esp
801060ec:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801060f1:	eb 9a                	jmp    8010608d <sys_open+0xdd>
801060f3:	90                   	nop
801060f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801060f8:	83 ec 0c             	sub    $0xc,%esp
801060fb:	57                   	push   %edi
801060fc:	e8 9f ae ff ff       	call   80100fa0 <fileclose>
80106101:	83 c4 10             	add    $0x10,%esp
80106104:	eb d5                	jmp    801060db <sys_open+0x12b>
80106106:	8d 76 00             	lea    0x0(%esi),%esi
80106109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106110 <sys_mkdir>:

int
sys_mkdir(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106116:	e8 f5 cb ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010611b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010611e:	83 ec 08             	sub    $0x8,%esp
80106121:	50                   	push   %eax
80106122:	6a 00                	push   $0x0
80106124:	e8 d7 f6 ff ff       	call   80105800 <argstr>
80106129:	83 c4 10             	add    $0x10,%esp
8010612c:	85 c0                	test   %eax,%eax
8010612e:	78 30                	js     80106160 <sys_mkdir+0x50>
80106130:	83 ec 0c             	sub    $0xc,%esp
80106133:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106136:	31 c9                	xor    %ecx,%ecx
80106138:	6a 00                	push   $0x0
8010613a:	ba 01 00 00 00       	mov    $0x1,%edx
8010613f:	e8 5c f7 ff ff       	call   801058a0 <create>
80106144:	83 c4 10             	add    $0x10,%esp
80106147:	85 c0                	test   %eax,%eax
80106149:	74 15                	je     80106160 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010614b:	83 ec 0c             	sub    $0xc,%esp
8010614e:	50                   	push   %eax
8010614f:	e8 2c b9 ff ff       	call   80101a80 <iunlockput>
  end_op();
80106154:	e8 27 cc ff ff       	call   80102d80 <end_op>
  return 0;
80106159:	83 c4 10             	add    $0x10,%esp
8010615c:	31 c0                	xor    %eax,%eax
}
8010615e:	c9                   	leave  
8010615f:	c3                   	ret    
    end_op();
80106160:	e8 1b cc ff ff       	call   80102d80 <end_op>
    return -1;
80106165:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010616a:	c9                   	leave  
8010616b:	c3                   	ret    
8010616c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106170 <sys_mknod>:

int
sys_mknod(void)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106176:	e8 95 cb ff ff       	call   80102d10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010617b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010617e:	83 ec 08             	sub    $0x8,%esp
80106181:	50                   	push   %eax
80106182:	6a 00                	push   $0x0
80106184:	e8 77 f6 ff ff       	call   80105800 <argstr>
80106189:	83 c4 10             	add    $0x10,%esp
8010618c:	85 c0                	test   %eax,%eax
8010618e:	78 60                	js     801061f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106190:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106193:	83 ec 08             	sub    $0x8,%esp
80106196:	50                   	push   %eax
80106197:	6a 01                	push   $0x1
80106199:	e8 b2 f5 ff ff       	call   80105750 <argint>
  if((argstr(0, &path)) < 0 ||
8010619e:	83 c4 10             	add    $0x10,%esp
801061a1:	85 c0                	test   %eax,%eax
801061a3:	78 4b                	js     801061f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801061a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061a8:	83 ec 08             	sub    $0x8,%esp
801061ab:	50                   	push   %eax
801061ac:	6a 02                	push   $0x2
801061ae:	e8 9d f5 ff ff       	call   80105750 <argint>
     argint(1, &major) < 0 ||
801061b3:	83 c4 10             	add    $0x10,%esp
801061b6:	85 c0                	test   %eax,%eax
801061b8:	78 36                	js     801061f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801061ba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801061be:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801061c1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
801061c5:	ba 03 00 00 00       	mov    $0x3,%edx
801061ca:	50                   	push   %eax
801061cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061ce:	e8 cd f6 ff ff       	call   801058a0 <create>
801061d3:	83 c4 10             	add    $0x10,%esp
801061d6:	85 c0                	test   %eax,%eax
801061d8:	74 16                	je     801061f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801061da:	83 ec 0c             	sub    $0xc,%esp
801061dd:	50                   	push   %eax
801061de:	e8 9d b8 ff ff       	call   80101a80 <iunlockput>
  end_op();
801061e3:	e8 98 cb ff ff       	call   80102d80 <end_op>
  return 0;
801061e8:	83 c4 10             	add    $0x10,%esp
801061eb:	31 c0                	xor    %eax,%eax
}
801061ed:	c9                   	leave  
801061ee:	c3                   	ret    
801061ef:	90                   	nop
    end_op();
801061f0:	e8 8b cb ff ff       	call   80102d80 <end_op>
    return -1;
801061f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061fa:	c9                   	leave  
801061fb:	c3                   	ret    
801061fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106200 <sys_chdir>:

int
sys_chdir(void)
{
80106200:	55                   	push   %ebp
80106201:	89 e5                	mov    %esp,%ebp
80106203:	56                   	push   %esi
80106204:	53                   	push   %ebx
80106205:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106208:	e8 a3 d9 ff ff       	call   80103bb0 <myproc>
8010620d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010620f:	e8 fc ca ff ff       	call   80102d10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106214:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106217:	83 ec 08             	sub    $0x8,%esp
8010621a:	50                   	push   %eax
8010621b:	6a 00                	push   $0x0
8010621d:	e8 de f5 ff ff       	call   80105800 <argstr>
80106222:	83 c4 10             	add    $0x10,%esp
80106225:	85 c0                	test   %eax,%eax
80106227:	78 77                	js     801062a0 <sys_chdir+0xa0>
80106229:	83 ec 0c             	sub    $0xc,%esp
8010622c:	ff 75 f4             	pushl  -0xc(%ebp)
8010622f:	e8 1c be ff ff       	call   80102050 <namei>
80106234:	83 c4 10             	add    $0x10,%esp
80106237:	85 c0                	test   %eax,%eax
80106239:	89 c3                	mov    %eax,%ebx
8010623b:	74 63                	je     801062a0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010623d:	83 ec 0c             	sub    $0xc,%esp
80106240:	50                   	push   %eax
80106241:	e8 aa b5 ff ff       	call   801017f0 <ilock>
  if(ip->type != T_DIR){
80106246:	83 c4 10             	add    $0x10,%esp
80106249:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010624e:	75 30                	jne    80106280 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106250:	83 ec 0c             	sub    $0xc,%esp
80106253:	53                   	push   %ebx
80106254:	e8 77 b6 ff ff       	call   801018d0 <iunlock>
  iput(curproc->cwd);
80106259:	58                   	pop    %eax
8010625a:	ff 76 58             	pushl  0x58(%esi)
8010625d:	e8 be b6 ff ff       	call   80101920 <iput>
  end_op();
80106262:	e8 19 cb ff ff       	call   80102d80 <end_op>
  curproc->cwd = ip;
80106267:	89 5e 58             	mov    %ebx,0x58(%esi)
  return 0;
8010626a:	83 c4 10             	add    $0x10,%esp
8010626d:	31 c0                	xor    %eax,%eax
}
8010626f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106272:	5b                   	pop    %ebx
80106273:	5e                   	pop    %esi
80106274:	5d                   	pop    %ebp
80106275:	c3                   	ret    
80106276:	8d 76 00             	lea    0x0(%esi),%esi
80106279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106280:	83 ec 0c             	sub    $0xc,%esp
80106283:	53                   	push   %ebx
80106284:	e8 f7 b7 ff ff       	call   80101a80 <iunlockput>
    end_op();
80106289:	e8 f2 ca ff ff       	call   80102d80 <end_op>
    return -1;
8010628e:	83 c4 10             	add    $0x10,%esp
80106291:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106296:	eb d7                	jmp    8010626f <sys_chdir+0x6f>
80106298:	90                   	nop
80106299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801062a0:	e8 db ca ff ff       	call   80102d80 <end_op>
    return -1;
801062a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062aa:	eb c3                	jmp    8010626f <sys_chdir+0x6f>
801062ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062b0 <sys_exec>:

int
sys_exec(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	57                   	push   %edi
801062b4:	56                   	push   %esi
801062b5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062b6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801062bc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062c2:	50                   	push   %eax
801062c3:	6a 00                	push   $0x0
801062c5:	e8 36 f5 ff ff       	call   80105800 <argstr>
801062ca:	83 c4 10             	add    $0x10,%esp
801062cd:	85 c0                	test   %eax,%eax
801062cf:	0f 88 87 00 00 00    	js     8010635c <sys_exec+0xac>
801062d5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801062db:	83 ec 08             	sub    $0x8,%esp
801062de:	50                   	push   %eax
801062df:	6a 01                	push   $0x1
801062e1:	e8 6a f4 ff ff       	call   80105750 <argint>
801062e6:	83 c4 10             	add    $0x10,%esp
801062e9:	85 c0                	test   %eax,%eax
801062eb:	78 6f                	js     8010635c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801062ed:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801062f3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801062f6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801062f8:	68 80 00 00 00       	push   $0x80
801062fd:	6a 00                	push   $0x0
801062ff:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106305:	50                   	push   %eax
80106306:	e8 45 f1 ff ff       	call   80105450 <memset>
8010630b:	83 c4 10             	add    $0x10,%esp
8010630e:	eb 2c                	jmp    8010633c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106310:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106316:	85 c0                	test   %eax,%eax
80106318:	74 56                	je     80106370 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010631a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106320:	83 ec 08             	sub    $0x8,%esp
80106323:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106326:	52                   	push   %edx
80106327:	50                   	push   %eax
80106328:	e8 b3 f3 ff ff       	call   801056e0 <fetchstr>
8010632d:	83 c4 10             	add    $0x10,%esp
80106330:	85 c0                	test   %eax,%eax
80106332:	78 28                	js     8010635c <sys_exec+0xac>
  for(i=0;; i++){
80106334:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106337:	83 fb 20             	cmp    $0x20,%ebx
8010633a:	74 20                	je     8010635c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010633c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106342:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106349:	83 ec 08             	sub    $0x8,%esp
8010634c:	57                   	push   %edi
8010634d:	01 f0                	add    %esi,%eax
8010634f:	50                   	push   %eax
80106350:	e8 4b f3 ff ff       	call   801056a0 <fetchint>
80106355:	83 c4 10             	add    $0x10,%esp
80106358:	85 c0                	test   %eax,%eax
8010635a:	79 b4                	jns    80106310 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010635c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010635f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106364:	5b                   	pop    %ebx
80106365:	5e                   	pop    %esi
80106366:	5f                   	pop    %edi
80106367:	5d                   	pop    %ebp
80106368:	c3                   	ret    
80106369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106370:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106376:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80106379:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106380:	00 00 00 00 
  return exec(path, argv);
80106384:	50                   	push   %eax
80106385:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010638b:	e8 80 a6 ff ff       	call   80100a10 <exec>
80106390:	83 c4 10             	add    $0x10,%esp
}
80106393:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106396:	5b                   	pop    %ebx
80106397:	5e                   	pop    %esi
80106398:	5f                   	pop    %edi
80106399:	5d                   	pop    %ebp
8010639a:	c3                   	ret    
8010639b:	90                   	nop
8010639c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801063a0 <sys_pipe>:

int
sys_pipe(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	57                   	push   %edi
801063a4:	56                   	push   %esi
801063a5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063a6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801063a9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063ac:	6a 08                	push   $0x8
801063ae:	50                   	push   %eax
801063af:	6a 00                	push   $0x0
801063b1:	e8 ea f3 ff ff       	call   801057a0 <argptr>
801063b6:	83 c4 10             	add    $0x10,%esp
801063b9:	85 c0                	test   %eax,%eax
801063bb:	0f 88 ae 00 00 00    	js     8010646f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801063c1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063c4:	83 ec 08             	sub    $0x8,%esp
801063c7:	50                   	push   %eax
801063c8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801063cb:	50                   	push   %eax
801063cc:	e8 df cf ff ff       	call   801033b0 <pipealloc>
801063d1:	83 c4 10             	add    $0x10,%esp
801063d4:	85 c0                	test   %eax,%eax
801063d6:	0f 88 93 00 00 00    	js     8010646f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801063df:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801063e1:	e8 ca d7 ff ff       	call   80103bb0 <myproc>
801063e6:	eb 10                	jmp    801063f8 <sys_pipe+0x58>
801063e8:	90                   	nop
801063e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801063f0:	83 c3 01             	add    $0x1,%ebx
801063f3:	83 fb 10             	cmp    $0x10,%ebx
801063f6:	74 60                	je     80106458 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801063f8:	8b 74 98 18          	mov    0x18(%eax,%ebx,4),%esi
801063fc:	85 f6                	test   %esi,%esi
801063fe:	75 f0                	jne    801063f0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106400:	8d 73 04             	lea    0x4(%ebx),%esi
80106403:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106407:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010640a:	e8 a1 d7 ff ff       	call   80103bb0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010640f:	31 d2                	xor    %edx,%edx
80106411:	eb 0d                	jmp    80106420 <sys_pipe+0x80>
80106413:	90                   	nop
80106414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106418:	83 c2 01             	add    $0x1,%edx
8010641b:	83 fa 10             	cmp    $0x10,%edx
8010641e:	74 28                	je     80106448 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80106420:	8b 4c 90 18          	mov    0x18(%eax,%edx,4),%ecx
80106424:	85 c9                	test   %ecx,%ecx
80106426:	75 f0                	jne    80106418 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80106428:	89 7c 90 18          	mov    %edi,0x18(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010642c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010642f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106431:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106434:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106437:	31 c0                	xor    %eax,%eax
}
80106439:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010643c:	5b                   	pop    %ebx
8010643d:	5e                   	pop    %esi
8010643e:	5f                   	pop    %edi
8010643f:	5d                   	pop    %ebp
80106440:	c3                   	ret    
80106441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80106448:	e8 63 d7 ff ff       	call   80103bb0 <myproc>
8010644d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106454:	00 
80106455:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80106458:	83 ec 0c             	sub    $0xc,%esp
8010645b:	ff 75 e0             	pushl  -0x20(%ebp)
8010645e:	e8 3d ab ff ff       	call   80100fa0 <fileclose>
    fileclose(wf);
80106463:	58                   	pop    %eax
80106464:	ff 75 e4             	pushl  -0x1c(%ebp)
80106467:	e8 34 ab ff ff       	call   80100fa0 <fileclose>
    return -1;
8010646c:	83 c4 10             	add    $0x10,%esp
8010646f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106474:	eb c3                	jmp    80106439 <sys_pipe+0x99>
80106476:	66 90                	xchg   %ax,%ax
80106478:	66 90                	xchg   %ax,%ax
8010647a:	66 90                	xchg   %ax,%ax
8010647c:	66 90                	xchg   %ax,%ax
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void) {
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
    return fork();
}
80106483:	5d                   	pop    %ebp
    return fork();
80106484:	e9 67 d9 ff ff       	jmp    80103df0 <fork>
80106489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106490 <sys_exit>:

int
sys_exit(void) {
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	83 ec 08             	sub    $0x8,%esp
    exit();
80106496:	e8 c5 e2 ff ff       	call   80104760 <exit>
    return 0;  // not reached
}
8010649b:	31 c0                	xor    %eax,%eax
8010649d:	c9                   	leave  
8010649e:	c3                   	ret    
8010649f:	90                   	nop

801064a0 <sys_wait>:

int
sys_wait(void) {
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
    return wait();
}
801064a3:	5d                   	pop    %ebp
    return wait();
801064a4:	e9 07 e7 ff ff       	jmp    80104bb0 <wait>
801064a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064b0 <sys_kill>:

int
sys_kill(void) {
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	83 ec 20             	sub    $0x20,%esp
    int pid;

    if (argint(0, &pid) < 0)
801064b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064b9:	50                   	push   %eax
801064ba:	6a 00                	push   $0x0
801064bc:	e8 8f f2 ff ff       	call   80105750 <argint>
801064c1:	83 c4 10             	add    $0x10,%esp
801064c4:	85 c0                	test   %eax,%eax
801064c6:	78 18                	js     801064e0 <sys_kill+0x30>
        return -1;
    return kill(pid);
801064c8:	83 ec 0c             	sub    $0xc,%esp
801064cb:	ff 75 f4             	pushl  -0xc(%ebp)
801064ce:	e8 3d de ff ff       	call   80104310 <kill>
801064d3:	83 c4 10             	add    $0x10,%esp
}
801064d6:	c9                   	leave  
801064d7:	c3                   	ret    
801064d8:	90                   	nop
801064d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801064e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064e5:	c9                   	leave  
801064e6:	c3                   	ret    
801064e7:	89 f6                	mov    %esi,%esi
801064e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064f0 <sys_getpid>:

int
sys_getpid(void) {
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	83 ec 08             	sub    $0x8,%esp
    return myproc()->pid;
801064f6:	e8 b5 d6 ff ff       	call   80103bb0 <myproc>
801064fb:	8b 40 0c             	mov    0xc(%eax),%eax
}
801064fe:	c9                   	leave  
801064ff:	c3                   	ret    

80106500 <sys_sbrk>:

int
sys_sbrk(void) {
80106500:	55                   	push   %ebp
80106501:	89 e5                	mov    %esp,%ebp
80106503:	53                   	push   %ebx
    int addr;
    int n;

    if (argint(0, &n) < 0)
80106504:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_sbrk(void) {
80106507:	83 ec 1c             	sub    $0x1c,%esp
    if (argint(0, &n) < 0)
8010650a:	50                   	push   %eax
8010650b:	6a 00                	push   $0x0
8010650d:	e8 3e f2 ff ff       	call   80105750 <argint>
80106512:	83 c4 10             	add    $0x10,%esp
80106515:	85 c0                	test   %eax,%eax
80106517:	78 27                	js     80106540 <sys_sbrk+0x40>
        return -1;
    addr = myproc()->sz;
80106519:	e8 92 d6 ff ff       	call   80103bb0 <myproc>
    if (growproc(n) < 0)
8010651e:	83 ec 0c             	sub    $0xc,%esp
    addr = myproc()->sz;
80106521:	8b 18                	mov    (%eax),%ebx
    if (growproc(n) < 0)
80106523:	ff 75 f4             	pushl  -0xc(%ebp)
80106526:	e8 05 d8 ff ff       	call   80103d30 <growproc>
8010652b:	83 c4 10             	add    $0x10,%esp
8010652e:	85 c0                	test   %eax,%eax
80106530:	78 0e                	js     80106540 <sys_sbrk+0x40>
        return -1;
    return addr;
}
80106532:	89 d8                	mov    %ebx,%eax
80106534:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106537:	c9                   	leave  
80106538:	c3                   	ret    
80106539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106540:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106545:	eb eb                	jmp    80106532 <sys_sbrk+0x32>
80106547:	89 f6                	mov    %esi,%esi
80106549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106550 <sys_sleep>:

int
sys_sleep(void) {
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
80106553:	53                   	push   %ebx
    int n;
    uint ticks0;

    if (argint(0, &n) < 0)
80106554:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_sleep(void) {
80106557:	83 ec 1c             	sub    $0x1c,%esp
    if (argint(0, &n) < 0)
8010655a:	50                   	push   %eax
8010655b:	6a 00                	push   $0x0
8010655d:	e8 ee f1 ff ff       	call   80105750 <argint>
80106562:	83 c4 10             	add    $0x10,%esp
80106565:	85 c0                	test   %eax,%eax
80106567:	0f 88 8a 00 00 00    	js     801065f7 <sys_sleep+0xa7>
        return -1;
    acquire(&tickslock);
8010656d:	83 ec 0c             	sub    $0xc,%esp
80106570:	68 20 4d 12 80       	push   $0x80124d20
80106575:	e8 c6 ed ff ff       	call   80105340 <acquire>
    ticks0 = ticks;
    while (ticks - ticks0 < n) {
8010657a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010657d:	83 c4 10             	add    $0x10,%esp
    ticks0 = ticks;
80106580:	8b 1d 60 55 12 80    	mov    0x80125560,%ebx
    while (ticks - ticks0 < n) {
80106586:	85 d2                	test   %edx,%edx
80106588:	75 27                	jne    801065b1 <sys_sleep+0x61>
8010658a:	eb 54                	jmp    801065e0 <sys_sleep+0x90>
8010658c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (myproc()->killed) {
            release(&tickslock);
            return -1;
        }
        sleep(&ticks, &tickslock);
80106590:	83 ec 08             	sub    $0x8,%esp
80106593:	68 20 4d 12 80       	push   $0x80124d20
80106598:	68 60 55 12 80       	push   $0x80125560
8010659d:	e8 fe e4 ff ff       	call   80104aa0 <sleep>
    while (ticks - ticks0 < n) {
801065a2:	a1 60 55 12 80       	mov    0x80125560,%eax
801065a7:	83 c4 10             	add    $0x10,%esp
801065aa:	29 d8                	sub    %ebx,%eax
801065ac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801065af:	73 2f                	jae    801065e0 <sys_sleep+0x90>
        if (myproc()->killed) {
801065b1:	e8 fa d5 ff ff       	call   80103bb0 <myproc>
801065b6:	8b 40 14             	mov    0x14(%eax),%eax
801065b9:	85 c0                	test   %eax,%eax
801065bb:	74 d3                	je     80106590 <sys_sleep+0x40>
            release(&tickslock);
801065bd:	83 ec 0c             	sub    $0xc,%esp
801065c0:	68 20 4d 12 80       	push   $0x80124d20
801065c5:	e8 36 ee ff ff       	call   80105400 <release>
            return -1;
801065ca:	83 c4 10             	add    $0x10,%esp
801065cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    release(&tickslock);
    return 0;
}
801065d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065d5:	c9                   	leave  
801065d6:	c3                   	ret    
801065d7:	89 f6                	mov    %esi,%esi
801065d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&tickslock);
801065e0:	83 ec 0c             	sub    $0xc,%esp
801065e3:	68 20 4d 12 80       	push   $0x80124d20
801065e8:	e8 13 ee ff ff       	call   80105400 <release>
    return 0;
801065ed:	83 c4 10             	add    $0x10,%esp
801065f0:	31 c0                	xor    %eax,%eax
}
801065f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065f5:	c9                   	leave  
801065f6:	c3                   	ret    
        return -1;
801065f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065fc:	eb f4                	jmp    801065f2 <sys_sleep+0xa2>
801065fe:	66 90                	xchg   %ax,%ax

80106600 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void) {
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	53                   	push   %ebx
80106604:	83 ec 10             	sub    $0x10,%esp
    uint xticks;

    acquire(&tickslock);
80106607:	68 20 4d 12 80       	push   $0x80124d20
8010660c:	e8 2f ed ff ff       	call   80105340 <acquire>
    xticks = ticks;
80106611:	8b 1d 60 55 12 80    	mov    0x80125560,%ebx
    release(&tickslock);
80106617:	c7 04 24 20 4d 12 80 	movl   $0x80124d20,(%esp)
8010661e:	e8 dd ed ff ff       	call   80105400 <release>
    return xticks;
}
80106623:	89 d8                	mov    %ebx,%eax
80106625:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106628:	c9                   	leave  
80106629:	c3                   	ret    
8010662a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106630 <sys_kthread_create>:

int sys_kthread_create(void) {
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	83 ec 1c             	sub    $0x1c,%esp

    void (*start_func)();
    void *stack;

    if (argptr(0, (void *) &start_func, sizeof(*start_func)) < 0)
80106636:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106639:	6a 01                	push   $0x1
8010663b:	50                   	push   %eax
8010663c:	6a 00                	push   $0x0
8010663e:	e8 5d f1 ff ff       	call   801057a0 <argptr>
80106643:	83 c4 10             	add    $0x10,%esp
80106646:	85 c0                	test   %eax,%eax
80106648:	78 2e                	js     80106678 <sys_kthread_create+0x48>
        return -1;

    if (argptr(1, (void *) &stack, sizeof(*stack)) < 0)
8010664a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010664d:	83 ec 04             	sub    $0x4,%esp
80106650:	6a 01                	push   $0x1
80106652:	50                   	push   %eax
80106653:	6a 01                	push   $0x1
80106655:	e8 46 f1 ff ff       	call   801057a0 <argptr>
8010665a:	83 c4 10             	add    $0x10,%esp
8010665d:	85 c0                	test   %eax,%eax
8010665f:	78 17                	js     80106678 <sys_kthread_create+0x48>
        return -1;

    return kthread_create(start_func, stack);
80106661:	83 ec 08             	sub    $0x8,%esp
80106664:	ff 75 f4             	pushl  -0xc(%ebp)
80106667:	ff 75 f0             	pushl  -0x10(%ebp)
8010666a:	e8 11 de ff ff       	call   80104480 <kthread_create>
8010666f:	83 c4 10             	add    $0x10,%esp
}
80106672:	c9                   	leave  
80106673:	c3                   	ret    
80106674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106678:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010667d:	c9                   	leave  
8010667e:	c3                   	ret    
8010667f:	90                   	nop

80106680 <sys_kthread_id>:


int sys_kthread_id(void) {
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
    return kthread_id();
}
80106683:	5d                   	pop    %ebp
    return kthread_id();
80106684:	e9 c7 de ff ff       	jmp    80104550 <kthread_id>
80106689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106690 <sys_kthread_exit>:

int sys_kthread_exit(void) {
80106690:	55                   	push   %ebp
80106691:	89 e5                	mov    %esp,%ebp
80106693:	83 ec 08             	sub    $0x8,%esp
    kthread_exit();
80106696:	e8 95 e3 ff ff       	call   80104a30 <kthread_exit>
    return 0;
}
8010669b:	31 c0                	xor    %eax,%eax
8010669d:	c9                   	leave  
8010669e:	c3                   	ret    
8010669f:	90                   	nop

801066a0 <sys_kthread_join>:

int sys_kthread_join(void) {
801066a0:	55                   	push   %ebp
801066a1:	89 e5                	mov    %esp,%ebp
801066a3:	83 ec 20             	sub    $0x20,%esp
    int thread_id;

    if (argint(0, &thread_id) < 0)
801066a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066a9:	50                   	push   %eax
801066aa:	6a 00                	push   $0x0
801066ac:	e8 9f f0 ff ff       	call   80105750 <argint>
801066b1:	83 c4 10             	add    $0x10,%esp
801066b4:	85 c0                	test   %eax,%eax
801066b6:	78 18                	js     801066d0 <sys_kthread_join+0x30>
        return -1;

    return kthread_join(thread_id);
801066b8:	83 ec 0c             	sub    $0xc,%esp
801066bb:	ff 75 f4             	pushl  -0xc(%ebp)
801066be:	e8 3d e6 ff ff       	call   80104d00 <kthread_join>
801066c3:	83 c4 10             	add    $0x10,%esp
}
801066c6:	c9                   	leave  
801066c7:	c3                   	ret    
801066c8:	90                   	nop
801066c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801066d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066d5:	c9                   	leave  
801066d6:	c3                   	ret    
801066d7:	89 f6                	mov    %esi,%esi
801066d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801066e0 <sys_kthread_mutex_alloc>:


int sys_kthread_mutex_alloc(void){
801066e0:	55                   	push   %ebp
801066e1:	89 e5                	mov    %esp,%ebp
    return kthread_mutex_alloc();
}
801066e3:	5d                   	pop    %ebp
    return kthread_mutex_alloc();
801066e4:	e9 b7 de ff ff       	jmp    801045a0 <kthread_mutex_alloc>
801066e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801066f0 <sys_kthread_mutex_dealloc>:

int sys_kthread_mutex_dealloc(void){
801066f0:	55                   	push   %ebp
801066f1:	89 e5                	mov    %esp,%ebp
801066f3:	83 ec 20             	sub    $0x20,%esp
    int mutex_id;

    if (argint(0, &mutex_id) < 0)
801066f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066f9:	50                   	push   %eax
801066fa:	6a 00                	push   $0x0
801066fc:	e8 4f f0 ff ff       	call   80105750 <argint>
80106701:	83 c4 10             	add    $0x10,%esp
80106704:	85 c0                	test   %eax,%eax
80106706:	78 18                	js     80106720 <sys_kthread_mutex_dealloc+0x30>
        return -1;

    return kthread_mutex_dealloc(mutex_id);
80106708:	83 ec 0c             	sub    $0xc,%esp
8010670b:	ff 75 f4             	pushl  -0xc(%ebp)
8010670e:	e8 7d df ff ff       	call   80104690 <kthread_mutex_dealloc>
80106713:	83 c4 10             	add    $0x10,%esp
}
80106716:	c9                   	leave  
80106717:	c3                   	ret    
80106718:	90                   	nop
80106719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106720:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106725:	c9                   	leave  
80106726:	c3                   	ret    
80106727:	89 f6                	mov    %esi,%esi
80106729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106730 <sys_kthread_mutex_lock>:

int sys_kthread_mutex_lock(void){
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	83 ec 20             	sub    $0x20,%esp
    int mutex_id;

    if (argint(0, &mutex_id) < 0)
80106736:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106739:	50                   	push   %eax
8010673a:	6a 00                	push   $0x0
8010673c:	e8 0f f0 ff ff       	call   80105750 <argint>
80106741:	83 c4 10             	add    $0x10,%esp
80106744:	85 c0                	test   %eax,%eax
80106746:	78 18                	js     80106760 <sys_kthread_mutex_lock+0x30>
        return -1;

    return kthread_mutex_lock(mutex_id);
80106748:	83 ec 0c             	sub    $0xc,%esp
8010674b:	ff 75 f4             	pushl  -0xc(%ebp)
8010674e:	e8 dd e6 ff ff       	call   80104e30 <kthread_mutex_lock>
80106753:	83 c4 10             	add    $0x10,%esp
}
80106756:	c9                   	leave  
80106757:	c3                   	ret    
80106758:	90                   	nop
80106759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
80106760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106765:	c9                   	leave  
80106766:	c3                   	ret    
80106767:	89 f6                	mov    %esi,%esi
80106769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106770 <sys_kthread_mutex_unlock>:

int sys_kthread_mutex_unlock(void){
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	83 ec 20             	sub    $0x20,%esp
    int mutex_id;

    if (argint(0, &mutex_id) < 0)
80106776:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106779:	50                   	push   %eax
8010677a:	6a 00                	push   $0x0
8010677c:	e8 cf ef ff ff       	call   80105750 <argint>
80106781:	83 c4 10             	add    $0x10,%esp
80106784:	85 c0                	test   %eax,%eax
80106786:	78 18                	js     801067a0 <sys_kthread_mutex_unlock+0x30>
        return -1;

    return kthread_mutex_unlock(mutex_id);
80106788:	83 ec 0c             	sub    $0xc,%esp
8010678b:	ff 75 f4             	pushl  -0xc(%ebp)
8010678e:	e8 ed e7 ff ff       	call   80104f80 <kthread_mutex_unlock>
80106793:	83 c4 10             	add    $0x10,%esp
}
80106796:	c9                   	leave  
80106797:	c3                   	ret    
80106798:	90                   	nop
80106799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return -1;
801067a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067a5:	c9                   	leave  
801067a6:	c3                   	ret    

801067a7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801067a7:	1e                   	push   %ds
  pushl %es
801067a8:	06                   	push   %es
  pushl %fs
801067a9:	0f a0                	push   %fs
  pushl %gs
801067ab:	0f a8                	push   %gs
  pushal
801067ad:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801067ae:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801067b2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801067b4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801067b6:	54                   	push   %esp
  call trap
801067b7:	e8 c4 00 00 00       	call   80106880 <trap>
  addl $4, %esp
801067bc:	83 c4 04             	add    $0x4,%esp

801067bf <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801067bf:	61                   	popa   
  popl %gs
801067c0:	0f a9                	pop    %gs
  popl %fs
801067c2:	0f a1                	pop    %fs
  popl %es
801067c4:	07                   	pop    %es
  popl %ds
801067c5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801067c6:	83 c4 08             	add    $0x8,%esp
  iret
801067c9:	cf                   	iret   
801067ca:	66 90                	xchg   %ax,%ax
801067cc:	66 90                	xchg   %ax,%ax
801067ce:	66 90                	xchg   %ax,%ax

801067d0 <tvinit>:
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void) {
801067d0:	55                   	push   %ebp
    int i;

    for (i = 0; i < 256; i++) SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
801067d1:	31 c0                	xor    %eax,%eax
tvinit(void) {
801067d3:	89 e5                	mov    %esp,%ebp
801067d5:	83 ec 08             	sub    $0x8,%esp
801067d8:	90                   	nop
801067d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (i = 0; i < 256; i++) SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
801067e0:	8b 14 85 10 b0 10 80 	mov    -0x7fef4ff0(,%eax,4),%edx
801067e7:	c7 04 c5 62 4d 12 80 	movl   $0x8e000008,-0x7fedb29e(,%eax,8)
801067ee:	08 00 00 8e 
801067f2:	66 89 14 c5 60 4d 12 	mov    %dx,-0x7fedb2a0(,%eax,8)
801067f9:	80 
801067fa:	c1 ea 10             	shr    $0x10,%edx
801067fd:	66 89 14 c5 66 4d 12 	mov    %dx,-0x7fedb29a(,%eax,8)
80106804:	80 
80106805:	83 c0 01             	add    $0x1,%eax
80106808:	3d 00 01 00 00       	cmp    $0x100,%eax
8010680d:	75 d1                	jne    801067e0 <tvinit+0x10>
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
8010680f:	a1 10 b1 10 80       	mov    0x8010b110,%eax

    initlock(&tickslock, "time");
80106814:	83 ec 08             	sub    $0x8,%esp
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
80106817:	c7 05 62 4f 12 80 08 	movl   $0xef000008,0x80124f62
8010681e:	00 00 ef 
    initlock(&tickslock, "time");
80106821:	68 99 8b 10 80       	push   $0x80108b99
80106826:	68 20 4d 12 80       	push   $0x80124d20
    SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);
8010682b:	66 a3 60 4f 12 80    	mov    %ax,0x80124f60
80106831:	c1 e8 10             	shr    $0x10,%eax
80106834:	66 a3 66 4f 12 80    	mov    %ax,0x80124f66
    initlock(&tickslock, "time");
8010683a:	e8 c1 e9 ff ff       	call   80105200 <initlock>
}
8010683f:	83 c4 10             	add    $0x10,%esp
80106842:	c9                   	leave  
80106843:	c3                   	ret    
80106844:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010684a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106850 <idtinit>:

void
idtinit(void) {
80106850:	55                   	push   %ebp
  pd[0] = size-1;
80106851:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106856:	89 e5                	mov    %esp,%ebp
80106858:	83 ec 10             	sub    $0x10,%esp
8010685b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010685f:	b8 60 4d 12 80       	mov    $0x80124d60,%eax
80106864:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106868:	c1 e8 10             	shr    $0x10,%eax
8010686b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010686f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106872:	0f 01 18             	lidtl  (%eax)
    lidt(idt, sizeof(idt));
}
80106875:	c9                   	leave  
80106876:	c3                   	ret    
80106877:	89 f6                	mov    %esi,%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106880 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf) {
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
80106886:	83 ec 1c             	sub    $0x1c,%esp
80106889:	8b 7d 08             	mov    0x8(%ebp),%edi
    if (tf->trapno == T_SYSCALL) {
8010688c:	8b 47 30             	mov    0x30(%edi),%eax
8010688f:	83 f8 40             	cmp    $0x40,%eax
80106892:	0f 84 40 01 00 00    	je     801069d8 <trap+0x158>
            kthread_exit();
        }
        return;
    }

    switch (tf->trapno) {
80106898:	83 e8 20             	sub    $0x20,%eax
8010689b:	83 f8 1f             	cmp    $0x1f,%eax
8010689e:	77 10                	ja     801068b0 <trap+0x30>
801068a0:	ff 24 85 40 8c 10 80 	jmp    *-0x7fef73c0(,%eax,4)
801068a7:	89 f6                	mov    %esi,%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            lapiceoi();
            break;

            //PAGEBREAK: 13
        default:
            if (myproc() == 0 || (tf->cs & 3) == 0) {
801068b0:	e8 fb d2 ff ff       	call   80103bb0 <myproc>
801068b5:	85 c0                	test   %eax,%eax
801068b7:	8b 5f 38             	mov    0x38(%edi),%ebx
801068ba:	0f 84 cc 02 00 00    	je     80106b8c <trap+0x30c>
801068c0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801068c4:	0f 84 c2 02 00 00    	je     80106b8c <trap+0x30c>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801068ca:	0f 20 d1             	mov    %cr2,%ecx
801068cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
                cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
                        tf->trapno, cpuid(), tf->eip, rcr2());
                panic("trap");
            }
            // In user space, assume process misbehaved.
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801068d0:	e8 bb d2 ff ff       	call   80103b90 <cpuid>
801068d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801068d8:	8b 47 34             	mov    0x34(%edi),%eax
801068db:	8b 77 30             	mov    0x30(%edi),%esi
801068de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                            "eip 0x%x addr 0x%x--kill proc\n",
                    myproc()->pid, myproc()->name, tf->trapno,
801068e1:	e8 ca d2 ff ff       	call   80103bb0 <myproc>
801068e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801068e9:	e8 c2 d2 ff ff       	call   80103bb0 <myproc>
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801068ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801068f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801068f4:	51                   	push   %ecx
801068f5:	53                   	push   %ebx
801068f6:	52                   	push   %edx
                    myproc()->pid, myproc()->name, tf->trapno,
801068f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
            cprintf("pid %d %s: trap %d err %d on cpu %d "
801068fa:	ff 75 e4             	pushl  -0x1c(%ebp)
801068fd:	56                   	push   %esi
                    myproc()->pid, myproc()->name, tf->trapno,
801068fe:	81 c2 dc 03 00 00    	add    $0x3dc,%edx
            cprintf("pid %d %s: trap %d err %d on cpu %d "
80106904:	52                   	push   %edx
80106905:	ff 70 0c             	pushl  0xc(%eax)
80106908:	68 fc 8b 10 80       	push   $0x80108bfc
8010690d:	e8 4e 9d ff ff       	call   80100660 <cprintf>
                    tf->err, cpuid(), tf->eip, rcr2());
            myproc()->killed = 1;
80106912:	83 c4 20             	add    $0x20,%esp
80106915:	e8 96 d2 ff ff       	call   80103bb0 <myproc>
8010691a:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    }

    // Force process exit if it has been killed and is in user space.
    // (If it is still executing in the kernel, let it keep running
    // until it gets to the regular system call return.)
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106921:	e8 8a d2 ff ff       	call   80103bb0 <myproc>
80106926:	85 c0                	test   %eax,%eax
80106928:	74 1d                	je     80106947 <trap+0xc7>
8010692a:	e8 81 d2 ff ff       	call   80103bb0 <myproc>
8010692f:	8b 58 14             	mov    0x14(%eax),%ebx
80106932:	85 db                	test   %ebx,%ebx
80106934:	74 11                	je     80106947 <trap+0xc7>
80106936:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010693a:	83 e0 03             	and    $0x3,%eax
8010693d:	66 83 f8 03          	cmp    $0x3,%ax
80106941:	0f 84 01 02 00 00    	je     80106b48 <trap+0x2c8>
        exit();

    if (mythread() && mythread()->shouldDie && (tf->cs & 3) == DPL_USER) {
80106947:	e8 94 d2 ff ff       	call   80103be0 <mythread>
8010694c:	85 c0                	test   %eax,%eax
8010694e:	74 1d                	je     8010696d <trap+0xed>
80106950:	e8 8b d2 ff ff       	call   80103be0 <mythread>
80106955:	8b 48 1c             	mov    0x1c(%eax),%ecx
80106958:	85 c9                	test   %ecx,%ecx
8010695a:	74 11                	je     8010696d <trap+0xed>
8010695c:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106960:	83 e0 03             	and    $0x3,%eax
80106963:	66 83 f8 03          	cmp    $0x3,%ax
80106967:	0f 84 cb 01 00 00    	je     80106b38 <trap+0x2b8>
    }

    // Force process to give up CPU on clock tick.
    // Force process to give up CPU on clock tick.
    // If interrupts were on while locks held, would need to check nlock.
    if (mythread() && mythread()->state == T_RUNNING &&
8010696d:	e8 6e d2 ff ff       	call   80103be0 <mythread>
80106972:	85 c0                	test   %eax,%eax
80106974:	74 0f                	je     80106985 <trap+0x105>
80106976:	e8 65 d2 ff ff       	call   80103be0 <mythread>
8010697b:	83 78 04 04          	cmpl   $0x4,0x4(%eax)
8010697f:	0f 84 ab 00 00 00    	je     80106a30 <trap+0x1b0>
        tf->trapno == T_IRQ0 + IRQ_TIMER)
        yield();

    // Check if the process has been killed since we yielded
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106985:	e8 26 d2 ff ff       	call   80103bb0 <myproc>
8010698a:	85 c0                	test   %eax,%eax
8010698c:	74 1d                	je     801069ab <trap+0x12b>
8010698e:	e8 1d d2 ff ff       	call   80103bb0 <myproc>
80106993:	8b 50 14             	mov    0x14(%eax),%edx
80106996:	85 d2                	test   %edx,%edx
80106998:	74 11                	je     801069ab <trap+0x12b>
8010699a:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010699e:	83 e0 03             	and    $0x3,%eax
801069a1:	66 83 f8 03          	cmp    $0x3,%ax
801069a5:	0f 84 7d 01 00 00    	je     80106b28 <trap+0x2a8>
        exit();

    // Check if the process has been killed since we yielded
    if (mythread() && mythread()->shouldDie && (tf->cs & 3) == DPL_USER) {
801069ab:	e8 30 d2 ff ff       	call   80103be0 <mythread>
801069b0:	85 c0                	test   %eax,%eax
801069b2:	74 19                	je     801069cd <trap+0x14d>
801069b4:	e8 27 d2 ff ff       	call   80103be0 <mythread>
801069b9:	8b 40 1c             	mov    0x1c(%eax),%eax
801069bc:	85 c0                	test   %eax,%eax
801069be:	74 0d                	je     801069cd <trap+0x14d>
801069c0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801069c4:	83 e0 03             	and    $0x3,%eax
801069c7:	66 83 f8 03          	cmp    $0x3,%ax
801069cb:	74 54                	je     80106a21 <trap+0x1a1>
//        cprintState(mythread());
//        cprintf("\n");
        kthread_exit();
    }

}
801069cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069d0:	5b                   	pop    %ebx
801069d1:	5e                   	pop    %esi
801069d2:	5f                   	pop    %edi
801069d3:	5d                   	pop    %ebp
801069d4:	c3                   	ret    
801069d5:	8d 76 00             	lea    0x0(%esi),%esi
        if (myproc()->killed)
801069d8:	e8 d3 d1 ff ff       	call   80103bb0 <myproc>
801069dd:	8b 40 14             	mov    0x14(%eax),%eax
801069e0:	85 c0                	test   %eax,%eax
801069e2:	0f 85 30 01 00 00    	jne    80106b18 <trap+0x298>
        if (mythread()->shouldDie) {
801069e8:	e8 f3 d1 ff ff       	call   80103be0 <mythread>
801069ed:	8b 40 1c             	mov    0x1c(%eax),%eax
801069f0:	85 c0                	test   %eax,%eax
801069f2:	0f 85 10 01 00 00    	jne    80106b08 <trap+0x288>
        mythread()->tf = tf;
801069f8:	e8 e3 d1 ff ff       	call   80103be0 <mythread>
801069fd:	89 78 08             	mov    %edi,0x8(%eax)
        syscall();
80106a00:	e8 3b ee ff ff       	call   80105840 <syscall>
        if (myproc()->killed)
80106a05:	e8 a6 d1 ff ff       	call   80103bb0 <myproc>
80106a0a:	8b 78 14             	mov    0x14(%eax),%edi
80106a0d:	85 ff                	test   %edi,%edi
80106a0f:	0f 85 e3 00 00 00    	jne    80106af8 <trap+0x278>
        if (mythread()->shouldDie) {
80106a15:	e8 c6 d1 ff ff       	call   80103be0 <mythread>
80106a1a:	8b 70 1c             	mov    0x1c(%eax),%esi
80106a1d:	85 f6                	test   %esi,%esi
80106a1f:	74 ac                	je     801069cd <trap+0x14d>
}
80106a21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a24:	5b                   	pop    %ebx
80106a25:	5e                   	pop    %esi
80106a26:	5f                   	pop    %edi
80106a27:	5d                   	pop    %ebp
            kthread_exit();
80106a28:	e9 03 e0 ff ff       	jmp    80104a30 <kthread_exit>
80106a2d:	8d 76 00             	lea    0x0(%esi),%esi
    if (mythread() && mythread()->state == T_RUNNING &&
80106a30:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106a34:	0f 85 4b ff ff ff    	jne    80106985 <trap+0x105>
        yield();
80106a3a:	e8 e1 d7 ff ff       	call   80104220 <yield>
80106a3f:	e9 41 ff ff ff       	jmp    80106985 <trap+0x105>
80106a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if (cpuid() == 0) {
80106a48:	e8 43 d1 ff ff       	call   80103b90 <cpuid>
80106a4d:	85 c0                	test   %eax,%eax
80106a4f:	0f 84 03 01 00 00    	je     80106b58 <trap+0x2d8>
            lapiceoi();
80106a55:	e8 66 be ff ff       	call   801028c0 <lapiceoi>
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106a5a:	e8 51 d1 ff ff       	call   80103bb0 <myproc>
80106a5f:	85 c0                	test   %eax,%eax
80106a61:	0f 85 c3 fe ff ff    	jne    8010692a <trap+0xaa>
80106a67:	e9 db fe ff ff       	jmp    80106947 <trap+0xc7>
80106a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kbdintr();
80106a70:	e8 0b bd ff ff       	call   80102780 <kbdintr>
            lapiceoi();
80106a75:	e8 46 be ff ff       	call   801028c0 <lapiceoi>
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106a7a:	e8 31 d1 ff ff       	call   80103bb0 <myproc>
80106a7f:	85 c0                	test   %eax,%eax
80106a81:	0f 85 a3 fe ff ff    	jne    8010692a <trap+0xaa>
80106a87:	e9 bb fe ff ff       	jmp    80106947 <trap+0xc7>
80106a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            uartintr();
80106a90:	e8 9b 02 00 00       	call   80106d30 <uartintr>
            lapiceoi();
80106a95:	e8 26 be ff ff       	call   801028c0 <lapiceoi>
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106a9a:	e8 11 d1 ff ff       	call   80103bb0 <myproc>
80106a9f:	85 c0                	test   %eax,%eax
80106aa1:	0f 85 83 fe ff ff    	jne    8010692a <trap+0xaa>
80106aa7:	e9 9b fe ff ff       	jmp    80106947 <trap+0xc7>
80106aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ab0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106ab4:	8b 77 38             	mov    0x38(%edi),%esi
80106ab7:	e8 d4 d0 ff ff       	call   80103b90 <cpuid>
80106abc:	56                   	push   %esi
80106abd:	53                   	push   %ebx
80106abe:	50                   	push   %eax
80106abf:	68 a4 8b 10 80       	push   $0x80108ba4
80106ac4:	e8 97 9b ff ff       	call   80100660 <cprintf>
            lapiceoi();
80106ac9:	e8 f2 bd ff ff       	call   801028c0 <lapiceoi>
            break;
80106ace:	83 c4 10             	add    $0x10,%esp
    if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
80106ad1:	e8 da d0 ff ff       	call   80103bb0 <myproc>
80106ad6:	85 c0                	test   %eax,%eax
80106ad8:	0f 85 4c fe ff ff    	jne    8010692a <trap+0xaa>
80106ade:	e9 64 fe ff ff       	jmp    80106947 <trap+0xc7>
80106ae3:	90                   	nop
80106ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            ideintr();
80106ae8:	e8 03 b7 ff ff       	call   801021f0 <ideintr>
80106aed:	e9 63 ff ff ff       	jmp    80106a55 <trap+0x1d5>
80106af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            exit();
80106af8:	e8 63 dc ff ff       	call   80104760 <exit>
80106afd:	e9 13 ff ff ff       	jmp    80106a15 <trap+0x195>
80106b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            kthread_exit();
80106b08:	e8 23 df ff ff       	call   80104a30 <kthread_exit>
80106b0d:	e9 e6 fe ff ff       	jmp    801069f8 <trap+0x178>
80106b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            exit();
80106b18:	e8 43 dc ff ff       	call   80104760 <exit>
80106b1d:	e9 c6 fe ff ff       	jmp    801069e8 <trap+0x168>
80106b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        exit();
80106b28:	e8 33 dc ff ff       	call   80104760 <exit>
80106b2d:	e9 79 fe ff ff       	jmp    801069ab <trap+0x12b>
80106b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kthread_exit();
80106b38:	e8 f3 de ff ff       	call   80104a30 <kthread_exit>
80106b3d:	e9 2b fe ff ff       	jmp    8010696d <trap+0xed>
80106b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        exit();
80106b48:	e8 13 dc ff ff       	call   80104760 <exit>
80106b4d:	e9 f5 fd ff ff       	jmp    80106947 <trap+0xc7>
80106b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                acquire(&tickslock);
80106b58:	83 ec 0c             	sub    $0xc,%esp
80106b5b:	68 20 4d 12 80       	push   $0x80124d20
80106b60:	e8 db e7 ff ff       	call   80105340 <acquire>
                wakeup(&ticks);
80106b65:	c7 04 24 60 55 12 80 	movl   $0x80125560,(%esp)
                ticks++;
80106b6c:	83 05 60 55 12 80 01 	addl   $0x1,0x80125560
                wakeup(&ticks);
80106b73:	e8 18 d7 ff ff       	call   80104290 <wakeup>
                release(&tickslock);
80106b78:	c7 04 24 20 4d 12 80 	movl   $0x80124d20,(%esp)
80106b7f:	e8 7c e8 ff ff       	call   80105400 <release>
80106b84:	83 c4 10             	add    $0x10,%esp
80106b87:	e9 c9 fe ff ff       	jmp    80106a55 <trap+0x1d5>
80106b8c:	0f 20 d6             	mov    %cr2,%esi
                cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106b8f:	e8 fc cf ff ff       	call   80103b90 <cpuid>
80106b94:	83 ec 0c             	sub    $0xc,%esp
80106b97:	56                   	push   %esi
80106b98:	53                   	push   %ebx
80106b99:	50                   	push   %eax
80106b9a:	ff 77 30             	pushl  0x30(%edi)
80106b9d:	68 c8 8b 10 80       	push   $0x80108bc8
80106ba2:	e8 b9 9a ff ff       	call   80100660 <cprintf>
                panic("trap");
80106ba7:	83 c4 14             	add    $0x14,%esp
80106baa:	68 9e 8b 10 80       	push   $0x80108b9e
80106baf:	e8 dc 97 ff ff       	call   80100390 <panic>
80106bb4:	66 90                	xchg   %ax,%ax
80106bb6:	66 90                	xchg   %ax,%ax
80106bb8:	66 90                	xchg   %ax,%ax
80106bba:	66 90                	xchg   %ax,%ax
80106bbc:	66 90                	xchg   %ax,%ax
80106bbe:	66 90                	xchg   %ax,%ax

80106bc0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106bc0:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80106bc5:	55                   	push   %ebp
80106bc6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106bc8:	85 c0                	test   %eax,%eax
80106bca:	74 1c                	je     80106be8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106bcc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106bd1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106bd2:	a8 01                	test   $0x1,%al
80106bd4:	74 12                	je     80106be8 <uartgetc+0x28>
80106bd6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106bdb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106bdc:	0f b6 c0             	movzbl %al,%eax
}
80106bdf:	5d                   	pop    %ebp
80106be0:	c3                   	ret    
80106be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bed:	5d                   	pop    %ebp
80106bee:	c3                   	ret    
80106bef:	90                   	nop

80106bf0 <uartputc.part.0>:
uartputc(int c)
80106bf0:	55                   	push   %ebp
80106bf1:	89 e5                	mov    %esp,%ebp
80106bf3:	57                   	push   %edi
80106bf4:	56                   	push   %esi
80106bf5:	53                   	push   %ebx
80106bf6:	89 c7                	mov    %eax,%edi
80106bf8:	bb 80 00 00 00       	mov    $0x80,%ebx
80106bfd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106c02:	83 ec 0c             	sub    $0xc,%esp
80106c05:	eb 1b                	jmp    80106c22 <uartputc.part.0+0x32>
80106c07:	89 f6                	mov    %esi,%esi
80106c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106c10:	83 ec 0c             	sub    $0xc,%esp
80106c13:	6a 0a                	push   $0xa
80106c15:	e8 c6 bc ff ff       	call   801028e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c1a:	83 c4 10             	add    $0x10,%esp
80106c1d:	83 eb 01             	sub    $0x1,%ebx
80106c20:	74 07                	je     80106c29 <uartputc.part.0+0x39>
80106c22:	89 f2                	mov    %esi,%edx
80106c24:	ec                   	in     (%dx),%al
80106c25:	a8 20                	test   $0x20,%al
80106c27:	74 e7                	je     80106c10 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106c29:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106c2e:	89 f8                	mov    %edi,%eax
80106c30:	ee                   	out    %al,(%dx)
}
80106c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c34:	5b                   	pop    %ebx
80106c35:	5e                   	pop    %esi
80106c36:	5f                   	pop    %edi
80106c37:	5d                   	pop    %ebp
80106c38:	c3                   	ret    
80106c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c40 <uartinit>:
{
80106c40:	55                   	push   %ebp
80106c41:	31 c9                	xor    %ecx,%ecx
80106c43:	89 c8                	mov    %ecx,%eax
80106c45:	89 e5                	mov    %esp,%ebp
80106c47:	57                   	push   %edi
80106c48:	56                   	push   %esi
80106c49:	53                   	push   %ebx
80106c4a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106c4f:	89 da                	mov    %ebx,%edx
80106c51:	83 ec 0c             	sub    $0xc,%esp
80106c54:	ee                   	out    %al,(%dx)
80106c55:	bf fb 03 00 00       	mov    $0x3fb,%edi
80106c5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106c5f:	89 fa                	mov    %edi,%edx
80106c61:	ee                   	out    %al,(%dx)
80106c62:	b8 0c 00 00 00       	mov    $0xc,%eax
80106c67:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106c6c:	ee                   	out    %al,(%dx)
80106c6d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106c72:	89 c8                	mov    %ecx,%eax
80106c74:	89 f2                	mov    %esi,%edx
80106c76:	ee                   	out    %al,(%dx)
80106c77:	b8 03 00 00 00       	mov    $0x3,%eax
80106c7c:	89 fa                	mov    %edi,%edx
80106c7e:	ee                   	out    %al,(%dx)
80106c7f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106c84:	89 c8                	mov    %ecx,%eax
80106c86:	ee                   	out    %al,(%dx)
80106c87:	b8 01 00 00 00       	mov    $0x1,%eax
80106c8c:	89 f2                	mov    %esi,%edx
80106c8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106c8f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106c94:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106c95:	3c ff                	cmp    $0xff,%al
80106c97:	74 5a                	je     80106cf3 <uartinit+0xb3>
  uart = 1;
80106c99:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106ca0:	00 00 00 
80106ca3:	89 da                	mov    %ebx,%edx
80106ca5:	ec                   	in     (%dx),%al
80106ca6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106cab:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106cac:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106caf:	bb c0 8c 10 80       	mov    $0x80108cc0,%ebx
  ioapicenable(IRQ_COM1, 0);
80106cb4:	6a 00                	push   $0x0
80106cb6:	6a 04                	push   $0x4
80106cb8:	e8 83 b7 ff ff       	call   80102440 <ioapicenable>
80106cbd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106cc0:	b8 78 00 00 00       	mov    $0x78,%eax
80106cc5:	eb 13                	jmp    80106cda <uartinit+0x9a>
80106cc7:	89 f6                	mov    %esi,%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106cd0:	83 c3 01             	add    $0x1,%ebx
80106cd3:	0f be 03             	movsbl (%ebx),%eax
80106cd6:	84 c0                	test   %al,%al
80106cd8:	74 19                	je     80106cf3 <uartinit+0xb3>
  if(!uart)
80106cda:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80106ce0:	85 d2                	test   %edx,%edx
80106ce2:	74 ec                	je     80106cd0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106ce4:	83 c3 01             	add    $0x1,%ebx
80106ce7:	e8 04 ff ff ff       	call   80106bf0 <uartputc.part.0>
80106cec:	0f be 03             	movsbl (%ebx),%eax
80106cef:	84 c0                	test   %al,%al
80106cf1:	75 e7                	jne    80106cda <uartinit+0x9a>
}
80106cf3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cf6:	5b                   	pop    %ebx
80106cf7:	5e                   	pop    %esi
80106cf8:	5f                   	pop    %edi
80106cf9:	5d                   	pop    %ebp
80106cfa:	c3                   	ret    
80106cfb:	90                   	nop
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d00 <uartputc>:
  if(!uart)
80106d00:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
80106d06:	55                   	push   %ebp
80106d07:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106d09:	85 d2                	test   %edx,%edx
{
80106d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106d0e:	74 10                	je     80106d20 <uartputc+0x20>
}
80106d10:	5d                   	pop    %ebp
80106d11:	e9 da fe ff ff       	jmp    80106bf0 <uartputc.part.0>
80106d16:	8d 76 00             	lea    0x0(%esi),%esi
80106d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106d20:	5d                   	pop    %ebp
80106d21:	c3                   	ret    
80106d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d30 <uartintr>:

void
uartintr(void)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106d36:	68 c0 6b 10 80       	push   $0x80106bc0
80106d3b:	e8 d0 9a ff ff       	call   80100810 <consoleintr>
}
80106d40:	83 c4 10             	add    $0x10,%esp
80106d43:	c9                   	leave  
80106d44:	c3                   	ret    

80106d45 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106d45:	6a 00                	push   $0x0
  pushl $0
80106d47:	6a 00                	push   $0x0
  jmp alltraps
80106d49:	e9 59 fa ff ff       	jmp    801067a7 <alltraps>

80106d4e <vector1>:
.globl vector1
vector1:
  pushl $0
80106d4e:	6a 00                	push   $0x0
  pushl $1
80106d50:	6a 01                	push   $0x1
  jmp alltraps
80106d52:	e9 50 fa ff ff       	jmp    801067a7 <alltraps>

80106d57 <vector2>:
.globl vector2
vector2:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $2
80106d59:	6a 02                	push   $0x2
  jmp alltraps
80106d5b:	e9 47 fa ff ff       	jmp    801067a7 <alltraps>

80106d60 <vector3>:
.globl vector3
vector3:
  pushl $0
80106d60:	6a 00                	push   $0x0
  pushl $3
80106d62:	6a 03                	push   $0x3
  jmp alltraps
80106d64:	e9 3e fa ff ff       	jmp    801067a7 <alltraps>

80106d69 <vector4>:
.globl vector4
vector4:
  pushl $0
80106d69:	6a 00                	push   $0x0
  pushl $4
80106d6b:	6a 04                	push   $0x4
  jmp alltraps
80106d6d:	e9 35 fa ff ff       	jmp    801067a7 <alltraps>

80106d72 <vector5>:
.globl vector5
vector5:
  pushl $0
80106d72:	6a 00                	push   $0x0
  pushl $5
80106d74:	6a 05                	push   $0x5
  jmp alltraps
80106d76:	e9 2c fa ff ff       	jmp    801067a7 <alltraps>

80106d7b <vector6>:
.globl vector6
vector6:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $6
80106d7d:	6a 06                	push   $0x6
  jmp alltraps
80106d7f:	e9 23 fa ff ff       	jmp    801067a7 <alltraps>

80106d84 <vector7>:
.globl vector7
vector7:
  pushl $0
80106d84:	6a 00                	push   $0x0
  pushl $7
80106d86:	6a 07                	push   $0x7
  jmp alltraps
80106d88:	e9 1a fa ff ff       	jmp    801067a7 <alltraps>

80106d8d <vector8>:
.globl vector8
vector8:
  pushl $8
80106d8d:	6a 08                	push   $0x8
  jmp alltraps
80106d8f:	e9 13 fa ff ff       	jmp    801067a7 <alltraps>

80106d94 <vector9>:
.globl vector9
vector9:
  pushl $0
80106d94:	6a 00                	push   $0x0
  pushl $9
80106d96:	6a 09                	push   $0x9
  jmp alltraps
80106d98:	e9 0a fa ff ff       	jmp    801067a7 <alltraps>

80106d9d <vector10>:
.globl vector10
vector10:
  pushl $10
80106d9d:	6a 0a                	push   $0xa
  jmp alltraps
80106d9f:	e9 03 fa ff ff       	jmp    801067a7 <alltraps>

80106da4 <vector11>:
.globl vector11
vector11:
  pushl $11
80106da4:	6a 0b                	push   $0xb
  jmp alltraps
80106da6:	e9 fc f9 ff ff       	jmp    801067a7 <alltraps>

80106dab <vector12>:
.globl vector12
vector12:
  pushl $12
80106dab:	6a 0c                	push   $0xc
  jmp alltraps
80106dad:	e9 f5 f9 ff ff       	jmp    801067a7 <alltraps>

80106db2 <vector13>:
.globl vector13
vector13:
  pushl $13
80106db2:	6a 0d                	push   $0xd
  jmp alltraps
80106db4:	e9 ee f9 ff ff       	jmp    801067a7 <alltraps>

80106db9 <vector14>:
.globl vector14
vector14:
  pushl $14
80106db9:	6a 0e                	push   $0xe
  jmp alltraps
80106dbb:	e9 e7 f9 ff ff       	jmp    801067a7 <alltraps>

80106dc0 <vector15>:
.globl vector15
vector15:
  pushl $0
80106dc0:	6a 00                	push   $0x0
  pushl $15
80106dc2:	6a 0f                	push   $0xf
  jmp alltraps
80106dc4:	e9 de f9 ff ff       	jmp    801067a7 <alltraps>

80106dc9 <vector16>:
.globl vector16
vector16:
  pushl $0
80106dc9:	6a 00                	push   $0x0
  pushl $16
80106dcb:	6a 10                	push   $0x10
  jmp alltraps
80106dcd:	e9 d5 f9 ff ff       	jmp    801067a7 <alltraps>

80106dd2 <vector17>:
.globl vector17
vector17:
  pushl $17
80106dd2:	6a 11                	push   $0x11
  jmp alltraps
80106dd4:	e9 ce f9 ff ff       	jmp    801067a7 <alltraps>

80106dd9 <vector18>:
.globl vector18
vector18:
  pushl $0
80106dd9:	6a 00                	push   $0x0
  pushl $18
80106ddb:	6a 12                	push   $0x12
  jmp alltraps
80106ddd:	e9 c5 f9 ff ff       	jmp    801067a7 <alltraps>

80106de2 <vector19>:
.globl vector19
vector19:
  pushl $0
80106de2:	6a 00                	push   $0x0
  pushl $19
80106de4:	6a 13                	push   $0x13
  jmp alltraps
80106de6:	e9 bc f9 ff ff       	jmp    801067a7 <alltraps>

80106deb <vector20>:
.globl vector20
vector20:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $20
80106ded:	6a 14                	push   $0x14
  jmp alltraps
80106def:	e9 b3 f9 ff ff       	jmp    801067a7 <alltraps>

80106df4 <vector21>:
.globl vector21
vector21:
  pushl $0
80106df4:	6a 00                	push   $0x0
  pushl $21
80106df6:	6a 15                	push   $0x15
  jmp alltraps
80106df8:	e9 aa f9 ff ff       	jmp    801067a7 <alltraps>

80106dfd <vector22>:
.globl vector22
vector22:
  pushl $0
80106dfd:	6a 00                	push   $0x0
  pushl $22
80106dff:	6a 16                	push   $0x16
  jmp alltraps
80106e01:	e9 a1 f9 ff ff       	jmp    801067a7 <alltraps>

80106e06 <vector23>:
.globl vector23
vector23:
  pushl $0
80106e06:	6a 00                	push   $0x0
  pushl $23
80106e08:	6a 17                	push   $0x17
  jmp alltraps
80106e0a:	e9 98 f9 ff ff       	jmp    801067a7 <alltraps>

80106e0f <vector24>:
.globl vector24
vector24:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $24
80106e11:	6a 18                	push   $0x18
  jmp alltraps
80106e13:	e9 8f f9 ff ff       	jmp    801067a7 <alltraps>

80106e18 <vector25>:
.globl vector25
vector25:
  pushl $0
80106e18:	6a 00                	push   $0x0
  pushl $25
80106e1a:	6a 19                	push   $0x19
  jmp alltraps
80106e1c:	e9 86 f9 ff ff       	jmp    801067a7 <alltraps>

80106e21 <vector26>:
.globl vector26
vector26:
  pushl $0
80106e21:	6a 00                	push   $0x0
  pushl $26
80106e23:	6a 1a                	push   $0x1a
  jmp alltraps
80106e25:	e9 7d f9 ff ff       	jmp    801067a7 <alltraps>

80106e2a <vector27>:
.globl vector27
vector27:
  pushl $0
80106e2a:	6a 00                	push   $0x0
  pushl $27
80106e2c:	6a 1b                	push   $0x1b
  jmp alltraps
80106e2e:	e9 74 f9 ff ff       	jmp    801067a7 <alltraps>

80106e33 <vector28>:
.globl vector28
vector28:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $28
80106e35:	6a 1c                	push   $0x1c
  jmp alltraps
80106e37:	e9 6b f9 ff ff       	jmp    801067a7 <alltraps>

80106e3c <vector29>:
.globl vector29
vector29:
  pushl $0
80106e3c:	6a 00                	push   $0x0
  pushl $29
80106e3e:	6a 1d                	push   $0x1d
  jmp alltraps
80106e40:	e9 62 f9 ff ff       	jmp    801067a7 <alltraps>

80106e45 <vector30>:
.globl vector30
vector30:
  pushl $0
80106e45:	6a 00                	push   $0x0
  pushl $30
80106e47:	6a 1e                	push   $0x1e
  jmp alltraps
80106e49:	e9 59 f9 ff ff       	jmp    801067a7 <alltraps>

80106e4e <vector31>:
.globl vector31
vector31:
  pushl $0
80106e4e:	6a 00                	push   $0x0
  pushl $31
80106e50:	6a 1f                	push   $0x1f
  jmp alltraps
80106e52:	e9 50 f9 ff ff       	jmp    801067a7 <alltraps>

80106e57 <vector32>:
.globl vector32
vector32:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $32
80106e59:	6a 20                	push   $0x20
  jmp alltraps
80106e5b:	e9 47 f9 ff ff       	jmp    801067a7 <alltraps>

80106e60 <vector33>:
.globl vector33
vector33:
  pushl $0
80106e60:	6a 00                	push   $0x0
  pushl $33
80106e62:	6a 21                	push   $0x21
  jmp alltraps
80106e64:	e9 3e f9 ff ff       	jmp    801067a7 <alltraps>

80106e69 <vector34>:
.globl vector34
vector34:
  pushl $0
80106e69:	6a 00                	push   $0x0
  pushl $34
80106e6b:	6a 22                	push   $0x22
  jmp alltraps
80106e6d:	e9 35 f9 ff ff       	jmp    801067a7 <alltraps>

80106e72 <vector35>:
.globl vector35
vector35:
  pushl $0
80106e72:	6a 00                	push   $0x0
  pushl $35
80106e74:	6a 23                	push   $0x23
  jmp alltraps
80106e76:	e9 2c f9 ff ff       	jmp    801067a7 <alltraps>

80106e7b <vector36>:
.globl vector36
vector36:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $36
80106e7d:	6a 24                	push   $0x24
  jmp alltraps
80106e7f:	e9 23 f9 ff ff       	jmp    801067a7 <alltraps>

80106e84 <vector37>:
.globl vector37
vector37:
  pushl $0
80106e84:	6a 00                	push   $0x0
  pushl $37
80106e86:	6a 25                	push   $0x25
  jmp alltraps
80106e88:	e9 1a f9 ff ff       	jmp    801067a7 <alltraps>

80106e8d <vector38>:
.globl vector38
vector38:
  pushl $0
80106e8d:	6a 00                	push   $0x0
  pushl $38
80106e8f:	6a 26                	push   $0x26
  jmp alltraps
80106e91:	e9 11 f9 ff ff       	jmp    801067a7 <alltraps>

80106e96 <vector39>:
.globl vector39
vector39:
  pushl $0
80106e96:	6a 00                	push   $0x0
  pushl $39
80106e98:	6a 27                	push   $0x27
  jmp alltraps
80106e9a:	e9 08 f9 ff ff       	jmp    801067a7 <alltraps>

80106e9f <vector40>:
.globl vector40
vector40:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $40
80106ea1:	6a 28                	push   $0x28
  jmp alltraps
80106ea3:	e9 ff f8 ff ff       	jmp    801067a7 <alltraps>

80106ea8 <vector41>:
.globl vector41
vector41:
  pushl $0
80106ea8:	6a 00                	push   $0x0
  pushl $41
80106eaa:	6a 29                	push   $0x29
  jmp alltraps
80106eac:	e9 f6 f8 ff ff       	jmp    801067a7 <alltraps>

80106eb1 <vector42>:
.globl vector42
vector42:
  pushl $0
80106eb1:	6a 00                	push   $0x0
  pushl $42
80106eb3:	6a 2a                	push   $0x2a
  jmp alltraps
80106eb5:	e9 ed f8 ff ff       	jmp    801067a7 <alltraps>

80106eba <vector43>:
.globl vector43
vector43:
  pushl $0
80106eba:	6a 00                	push   $0x0
  pushl $43
80106ebc:	6a 2b                	push   $0x2b
  jmp alltraps
80106ebe:	e9 e4 f8 ff ff       	jmp    801067a7 <alltraps>

80106ec3 <vector44>:
.globl vector44
vector44:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $44
80106ec5:	6a 2c                	push   $0x2c
  jmp alltraps
80106ec7:	e9 db f8 ff ff       	jmp    801067a7 <alltraps>

80106ecc <vector45>:
.globl vector45
vector45:
  pushl $0
80106ecc:	6a 00                	push   $0x0
  pushl $45
80106ece:	6a 2d                	push   $0x2d
  jmp alltraps
80106ed0:	e9 d2 f8 ff ff       	jmp    801067a7 <alltraps>

80106ed5 <vector46>:
.globl vector46
vector46:
  pushl $0
80106ed5:	6a 00                	push   $0x0
  pushl $46
80106ed7:	6a 2e                	push   $0x2e
  jmp alltraps
80106ed9:	e9 c9 f8 ff ff       	jmp    801067a7 <alltraps>

80106ede <vector47>:
.globl vector47
vector47:
  pushl $0
80106ede:	6a 00                	push   $0x0
  pushl $47
80106ee0:	6a 2f                	push   $0x2f
  jmp alltraps
80106ee2:	e9 c0 f8 ff ff       	jmp    801067a7 <alltraps>

80106ee7 <vector48>:
.globl vector48
vector48:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $48
80106ee9:	6a 30                	push   $0x30
  jmp alltraps
80106eeb:	e9 b7 f8 ff ff       	jmp    801067a7 <alltraps>

80106ef0 <vector49>:
.globl vector49
vector49:
  pushl $0
80106ef0:	6a 00                	push   $0x0
  pushl $49
80106ef2:	6a 31                	push   $0x31
  jmp alltraps
80106ef4:	e9 ae f8 ff ff       	jmp    801067a7 <alltraps>

80106ef9 <vector50>:
.globl vector50
vector50:
  pushl $0
80106ef9:	6a 00                	push   $0x0
  pushl $50
80106efb:	6a 32                	push   $0x32
  jmp alltraps
80106efd:	e9 a5 f8 ff ff       	jmp    801067a7 <alltraps>

80106f02 <vector51>:
.globl vector51
vector51:
  pushl $0
80106f02:	6a 00                	push   $0x0
  pushl $51
80106f04:	6a 33                	push   $0x33
  jmp alltraps
80106f06:	e9 9c f8 ff ff       	jmp    801067a7 <alltraps>

80106f0b <vector52>:
.globl vector52
vector52:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $52
80106f0d:	6a 34                	push   $0x34
  jmp alltraps
80106f0f:	e9 93 f8 ff ff       	jmp    801067a7 <alltraps>

80106f14 <vector53>:
.globl vector53
vector53:
  pushl $0
80106f14:	6a 00                	push   $0x0
  pushl $53
80106f16:	6a 35                	push   $0x35
  jmp alltraps
80106f18:	e9 8a f8 ff ff       	jmp    801067a7 <alltraps>

80106f1d <vector54>:
.globl vector54
vector54:
  pushl $0
80106f1d:	6a 00                	push   $0x0
  pushl $54
80106f1f:	6a 36                	push   $0x36
  jmp alltraps
80106f21:	e9 81 f8 ff ff       	jmp    801067a7 <alltraps>

80106f26 <vector55>:
.globl vector55
vector55:
  pushl $0
80106f26:	6a 00                	push   $0x0
  pushl $55
80106f28:	6a 37                	push   $0x37
  jmp alltraps
80106f2a:	e9 78 f8 ff ff       	jmp    801067a7 <alltraps>

80106f2f <vector56>:
.globl vector56
vector56:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $56
80106f31:	6a 38                	push   $0x38
  jmp alltraps
80106f33:	e9 6f f8 ff ff       	jmp    801067a7 <alltraps>

80106f38 <vector57>:
.globl vector57
vector57:
  pushl $0
80106f38:	6a 00                	push   $0x0
  pushl $57
80106f3a:	6a 39                	push   $0x39
  jmp alltraps
80106f3c:	e9 66 f8 ff ff       	jmp    801067a7 <alltraps>

80106f41 <vector58>:
.globl vector58
vector58:
  pushl $0
80106f41:	6a 00                	push   $0x0
  pushl $58
80106f43:	6a 3a                	push   $0x3a
  jmp alltraps
80106f45:	e9 5d f8 ff ff       	jmp    801067a7 <alltraps>

80106f4a <vector59>:
.globl vector59
vector59:
  pushl $0
80106f4a:	6a 00                	push   $0x0
  pushl $59
80106f4c:	6a 3b                	push   $0x3b
  jmp alltraps
80106f4e:	e9 54 f8 ff ff       	jmp    801067a7 <alltraps>

80106f53 <vector60>:
.globl vector60
vector60:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $60
80106f55:	6a 3c                	push   $0x3c
  jmp alltraps
80106f57:	e9 4b f8 ff ff       	jmp    801067a7 <alltraps>

80106f5c <vector61>:
.globl vector61
vector61:
  pushl $0
80106f5c:	6a 00                	push   $0x0
  pushl $61
80106f5e:	6a 3d                	push   $0x3d
  jmp alltraps
80106f60:	e9 42 f8 ff ff       	jmp    801067a7 <alltraps>

80106f65 <vector62>:
.globl vector62
vector62:
  pushl $0
80106f65:	6a 00                	push   $0x0
  pushl $62
80106f67:	6a 3e                	push   $0x3e
  jmp alltraps
80106f69:	e9 39 f8 ff ff       	jmp    801067a7 <alltraps>

80106f6e <vector63>:
.globl vector63
vector63:
  pushl $0
80106f6e:	6a 00                	push   $0x0
  pushl $63
80106f70:	6a 3f                	push   $0x3f
  jmp alltraps
80106f72:	e9 30 f8 ff ff       	jmp    801067a7 <alltraps>

80106f77 <vector64>:
.globl vector64
vector64:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $64
80106f79:	6a 40                	push   $0x40
  jmp alltraps
80106f7b:	e9 27 f8 ff ff       	jmp    801067a7 <alltraps>

80106f80 <vector65>:
.globl vector65
vector65:
  pushl $0
80106f80:	6a 00                	push   $0x0
  pushl $65
80106f82:	6a 41                	push   $0x41
  jmp alltraps
80106f84:	e9 1e f8 ff ff       	jmp    801067a7 <alltraps>

80106f89 <vector66>:
.globl vector66
vector66:
  pushl $0
80106f89:	6a 00                	push   $0x0
  pushl $66
80106f8b:	6a 42                	push   $0x42
  jmp alltraps
80106f8d:	e9 15 f8 ff ff       	jmp    801067a7 <alltraps>

80106f92 <vector67>:
.globl vector67
vector67:
  pushl $0
80106f92:	6a 00                	push   $0x0
  pushl $67
80106f94:	6a 43                	push   $0x43
  jmp alltraps
80106f96:	e9 0c f8 ff ff       	jmp    801067a7 <alltraps>

80106f9b <vector68>:
.globl vector68
vector68:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $68
80106f9d:	6a 44                	push   $0x44
  jmp alltraps
80106f9f:	e9 03 f8 ff ff       	jmp    801067a7 <alltraps>

80106fa4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106fa4:	6a 00                	push   $0x0
  pushl $69
80106fa6:	6a 45                	push   $0x45
  jmp alltraps
80106fa8:	e9 fa f7 ff ff       	jmp    801067a7 <alltraps>

80106fad <vector70>:
.globl vector70
vector70:
  pushl $0
80106fad:	6a 00                	push   $0x0
  pushl $70
80106faf:	6a 46                	push   $0x46
  jmp alltraps
80106fb1:	e9 f1 f7 ff ff       	jmp    801067a7 <alltraps>

80106fb6 <vector71>:
.globl vector71
vector71:
  pushl $0
80106fb6:	6a 00                	push   $0x0
  pushl $71
80106fb8:	6a 47                	push   $0x47
  jmp alltraps
80106fba:	e9 e8 f7 ff ff       	jmp    801067a7 <alltraps>

80106fbf <vector72>:
.globl vector72
vector72:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $72
80106fc1:	6a 48                	push   $0x48
  jmp alltraps
80106fc3:	e9 df f7 ff ff       	jmp    801067a7 <alltraps>

80106fc8 <vector73>:
.globl vector73
vector73:
  pushl $0
80106fc8:	6a 00                	push   $0x0
  pushl $73
80106fca:	6a 49                	push   $0x49
  jmp alltraps
80106fcc:	e9 d6 f7 ff ff       	jmp    801067a7 <alltraps>

80106fd1 <vector74>:
.globl vector74
vector74:
  pushl $0
80106fd1:	6a 00                	push   $0x0
  pushl $74
80106fd3:	6a 4a                	push   $0x4a
  jmp alltraps
80106fd5:	e9 cd f7 ff ff       	jmp    801067a7 <alltraps>

80106fda <vector75>:
.globl vector75
vector75:
  pushl $0
80106fda:	6a 00                	push   $0x0
  pushl $75
80106fdc:	6a 4b                	push   $0x4b
  jmp alltraps
80106fde:	e9 c4 f7 ff ff       	jmp    801067a7 <alltraps>

80106fe3 <vector76>:
.globl vector76
vector76:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $76
80106fe5:	6a 4c                	push   $0x4c
  jmp alltraps
80106fe7:	e9 bb f7 ff ff       	jmp    801067a7 <alltraps>

80106fec <vector77>:
.globl vector77
vector77:
  pushl $0
80106fec:	6a 00                	push   $0x0
  pushl $77
80106fee:	6a 4d                	push   $0x4d
  jmp alltraps
80106ff0:	e9 b2 f7 ff ff       	jmp    801067a7 <alltraps>

80106ff5 <vector78>:
.globl vector78
vector78:
  pushl $0
80106ff5:	6a 00                	push   $0x0
  pushl $78
80106ff7:	6a 4e                	push   $0x4e
  jmp alltraps
80106ff9:	e9 a9 f7 ff ff       	jmp    801067a7 <alltraps>

80106ffe <vector79>:
.globl vector79
vector79:
  pushl $0
80106ffe:	6a 00                	push   $0x0
  pushl $79
80107000:	6a 4f                	push   $0x4f
  jmp alltraps
80107002:	e9 a0 f7 ff ff       	jmp    801067a7 <alltraps>

80107007 <vector80>:
.globl vector80
vector80:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $80
80107009:	6a 50                	push   $0x50
  jmp alltraps
8010700b:	e9 97 f7 ff ff       	jmp    801067a7 <alltraps>

80107010 <vector81>:
.globl vector81
vector81:
  pushl $0
80107010:	6a 00                	push   $0x0
  pushl $81
80107012:	6a 51                	push   $0x51
  jmp alltraps
80107014:	e9 8e f7 ff ff       	jmp    801067a7 <alltraps>

80107019 <vector82>:
.globl vector82
vector82:
  pushl $0
80107019:	6a 00                	push   $0x0
  pushl $82
8010701b:	6a 52                	push   $0x52
  jmp alltraps
8010701d:	e9 85 f7 ff ff       	jmp    801067a7 <alltraps>

80107022 <vector83>:
.globl vector83
vector83:
  pushl $0
80107022:	6a 00                	push   $0x0
  pushl $83
80107024:	6a 53                	push   $0x53
  jmp alltraps
80107026:	e9 7c f7 ff ff       	jmp    801067a7 <alltraps>

8010702b <vector84>:
.globl vector84
vector84:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $84
8010702d:	6a 54                	push   $0x54
  jmp alltraps
8010702f:	e9 73 f7 ff ff       	jmp    801067a7 <alltraps>

80107034 <vector85>:
.globl vector85
vector85:
  pushl $0
80107034:	6a 00                	push   $0x0
  pushl $85
80107036:	6a 55                	push   $0x55
  jmp alltraps
80107038:	e9 6a f7 ff ff       	jmp    801067a7 <alltraps>

8010703d <vector86>:
.globl vector86
vector86:
  pushl $0
8010703d:	6a 00                	push   $0x0
  pushl $86
8010703f:	6a 56                	push   $0x56
  jmp alltraps
80107041:	e9 61 f7 ff ff       	jmp    801067a7 <alltraps>

80107046 <vector87>:
.globl vector87
vector87:
  pushl $0
80107046:	6a 00                	push   $0x0
  pushl $87
80107048:	6a 57                	push   $0x57
  jmp alltraps
8010704a:	e9 58 f7 ff ff       	jmp    801067a7 <alltraps>

8010704f <vector88>:
.globl vector88
vector88:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $88
80107051:	6a 58                	push   $0x58
  jmp alltraps
80107053:	e9 4f f7 ff ff       	jmp    801067a7 <alltraps>

80107058 <vector89>:
.globl vector89
vector89:
  pushl $0
80107058:	6a 00                	push   $0x0
  pushl $89
8010705a:	6a 59                	push   $0x59
  jmp alltraps
8010705c:	e9 46 f7 ff ff       	jmp    801067a7 <alltraps>

80107061 <vector90>:
.globl vector90
vector90:
  pushl $0
80107061:	6a 00                	push   $0x0
  pushl $90
80107063:	6a 5a                	push   $0x5a
  jmp alltraps
80107065:	e9 3d f7 ff ff       	jmp    801067a7 <alltraps>

8010706a <vector91>:
.globl vector91
vector91:
  pushl $0
8010706a:	6a 00                	push   $0x0
  pushl $91
8010706c:	6a 5b                	push   $0x5b
  jmp alltraps
8010706e:	e9 34 f7 ff ff       	jmp    801067a7 <alltraps>

80107073 <vector92>:
.globl vector92
vector92:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $92
80107075:	6a 5c                	push   $0x5c
  jmp alltraps
80107077:	e9 2b f7 ff ff       	jmp    801067a7 <alltraps>

8010707c <vector93>:
.globl vector93
vector93:
  pushl $0
8010707c:	6a 00                	push   $0x0
  pushl $93
8010707e:	6a 5d                	push   $0x5d
  jmp alltraps
80107080:	e9 22 f7 ff ff       	jmp    801067a7 <alltraps>

80107085 <vector94>:
.globl vector94
vector94:
  pushl $0
80107085:	6a 00                	push   $0x0
  pushl $94
80107087:	6a 5e                	push   $0x5e
  jmp alltraps
80107089:	e9 19 f7 ff ff       	jmp    801067a7 <alltraps>

8010708e <vector95>:
.globl vector95
vector95:
  pushl $0
8010708e:	6a 00                	push   $0x0
  pushl $95
80107090:	6a 5f                	push   $0x5f
  jmp alltraps
80107092:	e9 10 f7 ff ff       	jmp    801067a7 <alltraps>

80107097 <vector96>:
.globl vector96
vector96:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $96
80107099:	6a 60                	push   $0x60
  jmp alltraps
8010709b:	e9 07 f7 ff ff       	jmp    801067a7 <alltraps>

801070a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801070a0:	6a 00                	push   $0x0
  pushl $97
801070a2:	6a 61                	push   $0x61
  jmp alltraps
801070a4:	e9 fe f6 ff ff       	jmp    801067a7 <alltraps>

801070a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801070a9:	6a 00                	push   $0x0
  pushl $98
801070ab:	6a 62                	push   $0x62
  jmp alltraps
801070ad:	e9 f5 f6 ff ff       	jmp    801067a7 <alltraps>

801070b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801070b2:	6a 00                	push   $0x0
  pushl $99
801070b4:	6a 63                	push   $0x63
  jmp alltraps
801070b6:	e9 ec f6 ff ff       	jmp    801067a7 <alltraps>

801070bb <vector100>:
.globl vector100
vector100:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $100
801070bd:	6a 64                	push   $0x64
  jmp alltraps
801070bf:	e9 e3 f6 ff ff       	jmp    801067a7 <alltraps>

801070c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801070c4:	6a 00                	push   $0x0
  pushl $101
801070c6:	6a 65                	push   $0x65
  jmp alltraps
801070c8:	e9 da f6 ff ff       	jmp    801067a7 <alltraps>

801070cd <vector102>:
.globl vector102
vector102:
  pushl $0
801070cd:	6a 00                	push   $0x0
  pushl $102
801070cf:	6a 66                	push   $0x66
  jmp alltraps
801070d1:	e9 d1 f6 ff ff       	jmp    801067a7 <alltraps>

801070d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801070d6:	6a 00                	push   $0x0
  pushl $103
801070d8:	6a 67                	push   $0x67
  jmp alltraps
801070da:	e9 c8 f6 ff ff       	jmp    801067a7 <alltraps>

801070df <vector104>:
.globl vector104
vector104:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $104
801070e1:	6a 68                	push   $0x68
  jmp alltraps
801070e3:	e9 bf f6 ff ff       	jmp    801067a7 <alltraps>

801070e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801070e8:	6a 00                	push   $0x0
  pushl $105
801070ea:	6a 69                	push   $0x69
  jmp alltraps
801070ec:	e9 b6 f6 ff ff       	jmp    801067a7 <alltraps>

801070f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801070f1:	6a 00                	push   $0x0
  pushl $106
801070f3:	6a 6a                	push   $0x6a
  jmp alltraps
801070f5:	e9 ad f6 ff ff       	jmp    801067a7 <alltraps>

801070fa <vector107>:
.globl vector107
vector107:
  pushl $0
801070fa:	6a 00                	push   $0x0
  pushl $107
801070fc:	6a 6b                	push   $0x6b
  jmp alltraps
801070fe:	e9 a4 f6 ff ff       	jmp    801067a7 <alltraps>

80107103 <vector108>:
.globl vector108
vector108:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $108
80107105:	6a 6c                	push   $0x6c
  jmp alltraps
80107107:	e9 9b f6 ff ff       	jmp    801067a7 <alltraps>

8010710c <vector109>:
.globl vector109
vector109:
  pushl $0
8010710c:	6a 00                	push   $0x0
  pushl $109
8010710e:	6a 6d                	push   $0x6d
  jmp alltraps
80107110:	e9 92 f6 ff ff       	jmp    801067a7 <alltraps>

80107115 <vector110>:
.globl vector110
vector110:
  pushl $0
80107115:	6a 00                	push   $0x0
  pushl $110
80107117:	6a 6e                	push   $0x6e
  jmp alltraps
80107119:	e9 89 f6 ff ff       	jmp    801067a7 <alltraps>

8010711e <vector111>:
.globl vector111
vector111:
  pushl $0
8010711e:	6a 00                	push   $0x0
  pushl $111
80107120:	6a 6f                	push   $0x6f
  jmp alltraps
80107122:	e9 80 f6 ff ff       	jmp    801067a7 <alltraps>

80107127 <vector112>:
.globl vector112
vector112:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $112
80107129:	6a 70                	push   $0x70
  jmp alltraps
8010712b:	e9 77 f6 ff ff       	jmp    801067a7 <alltraps>

80107130 <vector113>:
.globl vector113
vector113:
  pushl $0
80107130:	6a 00                	push   $0x0
  pushl $113
80107132:	6a 71                	push   $0x71
  jmp alltraps
80107134:	e9 6e f6 ff ff       	jmp    801067a7 <alltraps>

80107139 <vector114>:
.globl vector114
vector114:
  pushl $0
80107139:	6a 00                	push   $0x0
  pushl $114
8010713b:	6a 72                	push   $0x72
  jmp alltraps
8010713d:	e9 65 f6 ff ff       	jmp    801067a7 <alltraps>

80107142 <vector115>:
.globl vector115
vector115:
  pushl $0
80107142:	6a 00                	push   $0x0
  pushl $115
80107144:	6a 73                	push   $0x73
  jmp alltraps
80107146:	e9 5c f6 ff ff       	jmp    801067a7 <alltraps>

8010714b <vector116>:
.globl vector116
vector116:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $116
8010714d:	6a 74                	push   $0x74
  jmp alltraps
8010714f:	e9 53 f6 ff ff       	jmp    801067a7 <alltraps>

80107154 <vector117>:
.globl vector117
vector117:
  pushl $0
80107154:	6a 00                	push   $0x0
  pushl $117
80107156:	6a 75                	push   $0x75
  jmp alltraps
80107158:	e9 4a f6 ff ff       	jmp    801067a7 <alltraps>

8010715d <vector118>:
.globl vector118
vector118:
  pushl $0
8010715d:	6a 00                	push   $0x0
  pushl $118
8010715f:	6a 76                	push   $0x76
  jmp alltraps
80107161:	e9 41 f6 ff ff       	jmp    801067a7 <alltraps>

80107166 <vector119>:
.globl vector119
vector119:
  pushl $0
80107166:	6a 00                	push   $0x0
  pushl $119
80107168:	6a 77                	push   $0x77
  jmp alltraps
8010716a:	e9 38 f6 ff ff       	jmp    801067a7 <alltraps>

8010716f <vector120>:
.globl vector120
vector120:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $120
80107171:	6a 78                	push   $0x78
  jmp alltraps
80107173:	e9 2f f6 ff ff       	jmp    801067a7 <alltraps>

80107178 <vector121>:
.globl vector121
vector121:
  pushl $0
80107178:	6a 00                	push   $0x0
  pushl $121
8010717a:	6a 79                	push   $0x79
  jmp alltraps
8010717c:	e9 26 f6 ff ff       	jmp    801067a7 <alltraps>

80107181 <vector122>:
.globl vector122
vector122:
  pushl $0
80107181:	6a 00                	push   $0x0
  pushl $122
80107183:	6a 7a                	push   $0x7a
  jmp alltraps
80107185:	e9 1d f6 ff ff       	jmp    801067a7 <alltraps>

8010718a <vector123>:
.globl vector123
vector123:
  pushl $0
8010718a:	6a 00                	push   $0x0
  pushl $123
8010718c:	6a 7b                	push   $0x7b
  jmp alltraps
8010718e:	e9 14 f6 ff ff       	jmp    801067a7 <alltraps>

80107193 <vector124>:
.globl vector124
vector124:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $124
80107195:	6a 7c                	push   $0x7c
  jmp alltraps
80107197:	e9 0b f6 ff ff       	jmp    801067a7 <alltraps>

8010719c <vector125>:
.globl vector125
vector125:
  pushl $0
8010719c:	6a 00                	push   $0x0
  pushl $125
8010719e:	6a 7d                	push   $0x7d
  jmp alltraps
801071a0:	e9 02 f6 ff ff       	jmp    801067a7 <alltraps>

801071a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801071a5:	6a 00                	push   $0x0
  pushl $126
801071a7:	6a 7e                	push   $0x7e
  jmp alltraps
801071a9:	e9 f9 f5 ff ff       	jmp    801067a7 <alltraps>

801071ae <vector127>:
.globl vector127
vector127:
  pushl $0
801071ae:	6a 00                	push   $0x0
  pushl $127
801071b0:	6a 7f                	push   $0x7f
  jmp alltraps
801071b2:	e9 f0 f5 ff ff       	jmp    801067a7 <alltraps>

801071b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $128
801071b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801071be:	e9 e4 f5 ff ff       	jmp    801067a7 <alltraps>

801071c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $129
801071c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801071ca:	e9 d8 f5 ff ff       	jmp    801067a7 <alltraps>

801071cf <vector130>:
.globl vector130
vector130:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $130
801071d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801071d6:	e9 cc f5 ff ff       	jmp    801067a7 <alltraps>

801071db <vector131>:
.globl vector131
vector131:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $131
801071dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801071e2:	e9 c0 f5 ff ff       	jmp    801067a7 <alltraps>

801071e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $132
801071e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801071ee:	e9 b4 f5 ff ff       	jmp    801067a7 <alltraps>

801071f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $133
801071f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801071fa:	e9 a8 f5 ff ff       	jmp    801067a7 <alltraps>

801071ff <vector134>:
.globl vector134
vector134:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $134
80107201:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107206:	e9 9c f5 ff ff       	jmp    801067a7 <alltraps>

8010720b <vector135>:
.globl vector135
vector135:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $135
8010720d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107212:	e9 90 f5 ff ff       	jmp    801067a7 <alltraps>

80107217 <vector136>:
.globl vector136
vector136:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $136
80107219:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010721e:	e9 84 f5 ff ff       	jmp    801067a7 <alltraps>

80107223 <vector137>:
.globl vector137
vector137:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $137
80107225:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010722a:	e9 78 f5 ff ff       	jmp    801067a7 <alltraps>

8010722f <vector138>:
.globl vector138
vector138:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $138
80107231:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107236:	e9 6c f5 ff ff       	jmp    801067a7 <alltraps>

8010723b <vector139>:
.globl vector139
vector139:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $139
8010723d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107242:	e9 60 f5 ff ff       	jmp    801067a7 <alltraps>

80107247 <vector140>:
.globl vector140
vector140:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $140
80107249:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010724e:	e9 54 f5 ff ff       	jmp    801067a7 <alltraps>

80107253 <vector141>:
.globl vector141
vector141:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $141
80107255:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010725a:	e9 48 f5 ff ff       	jmp    801067a7 <alltraps>

8010725f <vector142>:
.globl vector142
vector142:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $142
80107261:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107266:	e9 3c f5 ff ff       	jmp    801067a7 <alltraps>

8010726b <vector143>:
.globl vector143
vector143:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $143
8010726d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107272:	e9 30 f5 ff ff       	jmp    801067a7 <alltraps>

80107277 <vector144>:
.globl vector144
vector144:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $144
80107279:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010727e:	e9 24 f5 ff ff       	jmp    801067a7 <alltraps>

80107283 <vector145>:
.globl vector145
vector145:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $145
80107285:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010728a:	e9 18 f5 ff ff       	jmp    801067a7 <alltraps>

8010728f <vector146>:
.globl vector146
vector146:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $146
80107291:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107296:	e9 0c f5 ff ff       	jmp    801067a7 <alltraps>

8010729b <vector147>:
.globl vector147
vector147:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $147
8010729d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801072a2:	e9 00 f5 ff ff       	jmp    801067a7 <alltraps>

801072a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $148
801072a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801072ae:	e9 f4 f4 ff ff       	jmp    801067a7 <alltraps>

801072b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $149
801072b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801072ba:	e9 e8 f4 ff ff       	jmp    801067a7 <alltraps>

801072bf <vector150>:
.globl vector150
vector150:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $150
801072c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801072c6:	e9 dc f4 ff ff       	jmp    801067a7 <alltraps>

801072cb <vector151>:
.globl vector151
vector151:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $151
801072cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801072d2:	e9 d0 f4 ff ff       	jmp    801067a7 <alltraps>

801072d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $152
801072d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801072de:	e9 c4 f4 ff ff       	jmp    801067a7 <alltraps>

801072e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $153
801072e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801072ea:	e9 b8 f4 ff ff       	jmp    801067a7 <alltraps>

801072ef <vector154>:
.globl vector154
vector154:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $154
801072f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801072f6:	e9 ac f4 ff ff       	jmp    801067a7 <alltraps>

801072fb <vector155>:
.globl vector155
vector155:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $155
801072fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107302:	e9 a0 f4 ff ff       	jmp    801067a7 <alltraps>

80107307 <vector156>:
.globl vector156
vector156:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $156
80107309:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010730e:	e9 94 f4 ff ff       	jmp    801067a7 <alltraps>

80107313 <vector157>:
.globl vector157
vector157:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $157
80107315:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010731a:	e9 88 f4 ff ff       	jmp    801067a7 <alltraps>

8010731f <vector158>:
.globl vector158
vector158:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $158
80107321:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107326:	e9 7c f4 ff ff       	jmp    801067a7 <alltraps>

8010732b <vector159>:
.globl vector159
vector159:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $159
8010732d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107332:	e9 70 f4 ff ff       	jmp    801067a7 <alltraps>

80107337 <vector160>:
.globl vector160
vector160:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $160
80107339:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010733e:	e9 64 f4 ff ff       	jmp    801067a7 <alltraps>

80107343 <vector161>:
.globl vector161
vector161:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $161
80107345:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010734a:	e9 58 f4 ff ff       	jmp    801067a7 <alltraps>

8010734f <vector162>:
.globl vector162
vector162:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $162
80107351:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107356:	e9 4c f4 ff ff       	jmp    801067a7 <alltraps>

8010735b <vector163>:
.globl vector163
vector163:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $163
8010735d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107362:	e9 40 f4 ff ff       	jmp    801067a7 <alltraps>

80107367 <vector164>:
.globl vector164
vector164:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $164
80107369:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010736e:	e9 34 f4 ff ff       	jmp    801067a7 <alltraps>

80107373 <vector165>:
.globl vector165
vector165:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $165
80107375:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010737a:	e9 28 f4 ff ff       	jmp    801067a7 <alltraps>

8010737f <vector166>:
.globl vector166
vector166:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $166
80107381:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107386:	e9 1c f4 ff ff       	jmp    801067a7 <alltraps>

8010738b <vector167>:
.globl vector167
vector167:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $167
8010738d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107392:	e9 10 f4 ff ff       	jmp    801067a7 <alltraps>

80107397 <vector168>:
.globl vector168
vector168:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $168
80107399:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010739e:	e9 04 f4 ff ff       	jmp    801067a7 <alltraps>

801073a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $169
801073a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801073aa:	e9 f8 f3 ff ff       	jmp    801067a7 <alltraps>

801073af <vector170>:
.globl vector170
vector170:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $170
801073b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801073b6:	e9 ec f3 ff ff       	jmp    801067a7 <alltraps>

801073bb <vector171>:
.globl vector171
vector171:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $171
801073bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801073c2:	e9 e0 f3 ff ff       	jmp    801067a7 <alltraps>

801073c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $172
801073c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801073ce:	e9 d4 f3 ff ff       	jmp    801067a7 <alltraps>

801073d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $173
801073d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801073da:	e9 c8 f3 ff ff       	jmp    801067a7 <alltraps>

801073df <vector174>:
.globl vector174
vector174:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $174
801073e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801073e6:	e9 bc f3 ff ff       	jmp    801067a7 <alltraps>

801073eb <vector175>:
.globl vector175
vector175:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $175
801073ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801073f2:	e9 b0 f3 ff ff       	jmp    801067a7 <alltraps>

801073f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $176
801073f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801073fe:	e9 a4 f3 ff ff       	jmp    801067a7 <alltraps>

80107403 <vector177>:
.globl vector177
vector177:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $177
80107405:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010740a:	e9 98 f3 ff ff       	jmp    801067a7 <alltraps>

8010740f <vector178>:
.globl vector178
vector178:
  pushl $0
8010740f:	6a 00                	push   $0x0
  pushl $178
80107411:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107416:	e9 8c f3 ff ff       	jmp    801067a7 <alltraps>

8010741b <vector179>:
.globl vector179
vector179:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $179
8010741d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107422:	e9 80 f3 ff ff       	jmp    801067a7 <alltraps>

80107427 <vector180>:
.globl vector180
vector180:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $180
80107429:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010742e:	e9 74 f3 ff ff       	jmp    801067a7 <alltraps>

80107433 <vector181>:
.globl vector181
vector181:
  pushl $0
80107433:	6a 00                	push   $0x0
  pushl $181
80107435:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010743a:	e9 68 f3 ff ff       	jmp    801067a7 <alltraps>

8010743f <vector182>:
.globl vector182
vector182:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $182
80107441:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107446:	e9 5c f3 ff ff       	jmp    801067a7 <alltraps>

8010744b <vector183>:
.globl vector183
vector183:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $183
8010744d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107452:	e9 50 f3 ff ff       	jmp    801067a7 <alltraps>

80107457 <vector184>:
.globl vector184
vector184:
  pushl $0
80107457:	6a 00                	push   $0x0
  pushl $184
80107459:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010745e:	e9 44 f3 ff ff       	jmp    801067a7 <alltraps>

80107463 <vector185>:
.globl vector185
vector185:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $185
80107465:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010746a:	e9 38 f3 ff ff       	jmp    801067a7 <alltraps>

8010746f <vector186>:
.globl vector186
vector186:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $186
80107471:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107476:	e9 2c f3 ff ff       	jmp    801067a7 <alltraps>

8010747b <vector187>:
.globl vector187
vector187:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $187
8010747d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107482:	e9 20 f3 ff ff       	jmp    801067a7 <alltraps>

80107487 <vector188>:
.globl vector188
vector188:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $188
80107489:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010748e:	e9 14 f3 ff ff       	jmp    801067a7 <alltraps>

80107493 <vector189>:
.globl vector189
vector189:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $189
80107495:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010749a:	e9 08 f3 ff ff       	jmp    801067a7 <alltraps>

8010749f <vector190>:
.globl vector190
vector190:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $190
801074a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801074a6:	e9 fc f2 ff ff       	jmp    801067a7 <alltraps>

801074ab <vector191>:
.globl vector191
vector191:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $191
801074ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801074b2:	e9 f0 f2 ff ff       	jmp    801067a7 <alltraps>

801074b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $192
801074b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801074be:	e9 e4 f2 ff ff       	jmp    801067a7 <alltraps>

801074c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $193
801074c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801074ca:	e9 d8 f2 ff ff       	jmp    801067a7 <alltraps>

801074cf <vector194>:
.globl vector194
vector194:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $194
801074d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801074d6:	e9 cc f2 ff ff       	jmp    801067a7 <alltraps>

801074db <vector195>:
.globl vector195
vector195:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $195
801074dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801074e2:	e9 c0 f2 ff ff       	jmp    801067a7 <alltraps>

801074e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $196
801074e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801074ee:	e9 b4 f2 ff ff       	jmp    801067a7 <alltraps>

801074f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $197
801074f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801074fa:	e9 a8 f2 ff ff       	jmp    801067a7 <alltraps>

801074ff <vector198>:
.globl vector198
vector198:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $198
80107501:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107506:	e9 9c f2 ff ff       	jmp    801067a7 <alltraps>

8010750b <vector199>:
.globl vector199
vector199:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $199
8010750d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107512:	e9 90 f2 ff ff       	jmp    801067a7 <alltraps>

80107517 <vector200>:
.globl vector200
vector200:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $200
80107519:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010751e:	e9 84 f2 ff ff       	jmp    801067a7 <alltraps>

80107523 <vector201>:
.globl vector201
vector201:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $201
80107525:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010752a:	e9 78 f2 ff ff       	jmp    801067a7 <alltraps>

8010752f <vector202>:
.globl vector202
vector202:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $202
80107531:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107536:	e9 6c f2 ff ff       	jmp    801067a7 <alltraps>

8010753b <vector203>:
.globl vector203
vector203:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $203
8010753d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107542:	e9 60 f2 ff ff       	jmp    801067a7 <alltraps>

80107547 <vector204>:
.globl vector204
vector204:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $204
80107549:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010754e:	e9 54 f2 ff ff       	jmp    801067a7 <alltraps>

80107553 <vector205>:
.globl vector205
vector205:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $205
80107555:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010755a:	e9 48 f2 ff ff       	jmp    801067a7 <alltraps>

8010755f <vector206>:
.globl vector206
vector206:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $206
80107561:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107566:	e9 3c f2 ff ff       	jmp    801067a7 <alltraps>

8010756b <vector207>:
.globl vector207
vector207:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $207
8010756d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107572:	e9 30 f2 ff ff       	jmp    801067a7 <alltraps>

80107577 <vector208>:
.globl vector208
vector208:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $208
80107579:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010757e:	e9 24 f2 ff ff       	jmp    801067a7 <alltraps>

80107583 <vector209>:
.globl vector209
vector209:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $209
80107585:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010758a:	e9 18 f2 ff ff       	jmp    801067a7 <alltraps>

8010758f <vector210>:
.globl vector210
vector210:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $210
80107591:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107596:	e9 0c f2 ff ff       	jmp    801067a7 <alltraps>

8010759b <vector211>:
.globl vector211
vector211:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $211
8010759d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801075a2:	e9 00 f2 ff ff       	jmp    801067a7 <alltraps>

801075a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $212
801075a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801075ae:	e9 f4 f1 ff ff       	jmp    801067a7 <alltraps>

801075b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $213
801075b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801075ba:	e9 e8 f1 ff ff       	jmp    801067a7 <alltraps>

801075bf <vector214>:
.globl vector214
vector214:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $214
801075c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801075c6:	e9 dc f1 ff ff       	jmp    801067a7 <alltraps>

801075cb <vector215>:
.globl vector215
vector215:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $215
801075cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801075d2:	e9 d0 f1 ff ff       	jmp    801067a7 <alltraps>

801075d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $216
801075d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801075de:	e9 c4 f1 ff ff       	jmp    801067a7 <alltraps>

801075e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $217
801075e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801075ea:	e9 b8 f1 ff ff       	jmp    801067a7 <alltraps>

801075ef <vector218>:
.globl vector218
vector218:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $218
801075f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801075f6:	e9 ac f1 ff ff       	jmp    801067a7 <alltraps>

801075fb <vector219>:
.globl vector219
vector219:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $219
801075fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107602:	e9 a0 f1 ff ff       	jmp    801067a7 <alltraps>

80107607 <vector220>:
.globl vector220
vector220:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $220
80107609:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010760e:	e9 94 f1 ff ff       	jmp    801067a7 <alltraps>

80107613 <vector221>:
.globl vector221
vector221:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $221
80107615:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010761a:	e9 88 f1 ff ff       	jmp    801067a7 <alltraps>

8010761f <vector222>:
.globl vector222
vector222:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $222
80107621:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107626:	e9 7c f1 ff ff       	jmp    801067a7 <alltraps>

8010762b <vector223>:
.globl vector223
vector223:
  pushl $0
8010762b:	6a 00                	push   $0x0
  pushl $223
8010762d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107632:	e9 70 f1 ff ff       	jmp    801067a7 <alltraps>

80107637 <vector224>:
.globl vector224
vector224:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $224
80107639:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010763e:	e9 64 f1 ff ff       	jmp    801067a7 <alltraps>

80107643 <vector225>:
.globl vector225
vector225:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $225
80107645:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010764a:	e9 58 f1 ff ff       	jmp    801067a7 <alltraps>

8010764f <vector226>:
.globl vector226
vector226:
  pushl $0
8010764f:	6a 00                	push   $0x0
  pushl $226
80107651:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107656:	e9 4c f1 ff ff       	jmp    801067a7 <alltraps>

8010765b <vector227>:
.globl vector227
vector227:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $227
8010765d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107662:	e9 40 f1 ff ff       	jmp    801067a7 <alltraps>

80107667 <vector228>:
.globl vector228
vector228:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $228
80107669:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010766e:	e9 34 f1 ff ff       	jmp    801067a7 <alltraps>

80107673 <vector229>:
.globl vector229
vector229:
  pushl $0
80107673:	6a 00                	push   $0x0
  pushl $229
80107675:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010767a:	e9 28 f1 ff ff       	jmp    801067a7 <alltraps>

8010767f <vector230>:
.globl vector230
vector230:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $230
80107681:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107686:	e9 1c f1 ff ff       	jmp    801067a7 <alltraps>

8010768b <vector231>:
.globl vector231
vector231:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $231
8010768d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107692:	e9 10 f1 ff ff       	jmp    801067a7 <alltraps>

80107697 <vector232>:
.globl vector232
vector232:
  pushl $0
80107697:	6a 00                	push   $0x0
  pushl $232
80107699:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010769e:	e9 04 f1 ff ff       	jmp    801067a7 <alltraps>

801076a3 <vector233>:
.globl vector233
vector233:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $233
801076a5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801076aa:	e9 f8 f0 ff ff       	jmp    801067a7 <alltraps>

801076af <vector234>:
.globl vector234
vector234:
  pushl $0
801076af:	6a 00                	push   $0x0
  pushl $234
801076b1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801076b6:	e9 ec f0 ff ff       	jmp    801067a7 <alltraps>

801076bb <vector235>:
.globl vector235
vector235:
  pushl $0
801076bb:	6a 00                	push   $0x0
  pushl $235
801076bd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801076c2:	e9 e0 f0 ff ff       	jmp    801067a7 <alltraps>

801076c7 <vector236>:
.globl vector236
vector236:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $236
801076c9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801076ce:	e9 d4 f0 ff ff       	jmp    801067a7 <alltraps>

801076d3 <vector237>:
.globl vector237
vector237:
  pushl $0
801076d3:	6a 00                	push   $0x0
  pushl $237
801076d5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801076da:	e9 c8 f0 ff ff       	jmp    801067a7 <alltraps>

801076df <vector238>:
.globl vector238
vector238:
  pushl $0
801076df:	6a 00                	push   $0x0
  pushl $238
801076e1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801076e6:	e9 bc f0 ff ff       	jmp    801067a7 <alltraps>

801076eb <vector239>:
.globl vector239
vector239:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $239
801076ed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801076f2:	e9 b0 f0 ff ff       	jmp    801067a7 <alltraps>

801076f7 <vector240>:
.globl vector240
vector240:
  pushl $0
801076f7:	6a 00                	push   $0x0
  pushl $240
801076f9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801076fe:	e9 a4 f0 ff ff       	jmp    801067a7 <alltraps>

80107703 <vector241>:
.globl vector241
vector241:
  pushl $0
80107703:	6a 00                	push   $0x0
  pushl $241
80107705:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010770a:	e9 98 f0 ff ff       	jmp    801067a7 <alltraps>

8010770f <vector242>:
.globl vector242
vector242:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $242
80107711:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107716:	e9 8c f0 ff ff       	jmp    801067a7 <alltraps>

8010771b <vector243>:
.globl vector243
vector243:
  pushl $0
8010771b:	6a 00                	push   $0x0
  pushl $243
8010771d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107722:	e9 80 f0 ff ff       	jmp    801067a7 <alltraps>

80107727 <vector244>:
.globl vector244
vector244:
  pushl $0
80107727:	6a 00                	push   $0x0
  pushl $244
80107729:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010772e:	e9 74 f0 ff ff       	jmp    801067a7 <alltraps>

80107733 <vector245>:
.globl vector245
vector245:
  pushl $0
80107733:	6a 00                	push   $0x0
  pushl $245
80107735:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010773a:	e9 68 f0 ff ff       	jmp    801067a7 <alltraps>

8010773f <vector246>:
.globl vector246
vector246:
  pushl $0
8010773f:	6a 00                	push   $0x0
  pushl $246
80107741:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107746:	e9 5c f0 ff ff       	jmp    801067a7 <alltraps>

8010774b <vector247>:
.globl vector247
vector247:
  pushl $0
8010774b:	6a 00                	push   $0x0
  pushl $247
8010774d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107752:	e9 50 f0 ff ff       	jmp    801067a7 <alltraps>

80107757 <vector248>:
.globl vector248
vector248:
  pushl $0
80107757:	6a 00                	push   $0x0
  pushl $248
80107759:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010775e:	e9 44 f0 ff ff       	jmp    801067a7 <alltraps>

80107763 <vector249>:
.globl vector249
vector249:
  pushl $0
80107763:	6a 00                	push   $0x0
  pushl $249
80107765:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010776a:	e9 38 f0 ff ff       	jmp    801067a7 <alltraps>

8010776f <vector250>:
.globl vector250
vector250:
  pushl $0
8010776f:	6a 00                	push   $0x0
  pushl $250
80107771:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107776:	e9 2c f0 ff ff       	jmp    801067a7 <alltraps>

8010777b <vector251>:
.globl vector251
vector251:
  pushl $0
8010777b:	6a 00                	push   $0x0
  pushl $251
8010777d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107782:	e9 20 f0 ff ff       	jmp    801067a7 <alltraps>

80107787 <vector252>:
.globl vector252
vector252:
  pushl $0
80107787:	6a 00                	push   $0x0
  pushl $252
80107789:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010778e:	e9 14 f0 ff ff       	jmp    801067a7 <alltraps>

80107793 <vector253>:
.globl vector253
vector253:
  pushl $0
80107793:	6a 00                	push   $0x0
  pushl $253
80107795:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010779a:	e9 08 f0 ff ff       	jmp    801067a7 <alltraps>

8010779f <vector254>:
.globl vector254
vector254:
  pushl $0
8010779f:	6a 00                	push   $0x0
  pushl $254
801077a1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801077a6:	e9 fc ef ff ff       	jmp    801067a7 <alltraps>

801077ab <vector255>:
.globl vector255
vector255:
  pushl $0
801077ab:	6a 00                	push   $0x0
  pushl $255
801077ad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801077b2:	e9 f0 ef ff ff       	jmp    801067a7 <alltraps>
801077b7:	66 90                	xchg   %ax,%ax
801077b9:	66 90                	xchg   %ax,%ax
801077bb:	66 90                	xchg   %ax,%ax
801077bd:	66 90                	xchg   %ax,%ax
801077bf:	90                   	nop

801077c0 <walkpgdir>:

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	57                   	push   %edi
801077c4:	56                   	push   %esi
801077c5:	53                   	push   %ebx
    pde_t *pde;
    pte_t *pgtab;

    pde = &pgdir[PDX(va)];
801077c6:	89 d3                	mov    %edx,%ebx
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801077c8:	89 d7                	mov    %edx,%edi
    pde = &pgdir[PDX(va)];
801077ca:	c1 eb 16             	shr    $0x16,%ebx
801077cd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
walkpgdir(pde_t *pgdir, const void *va, int alloc) {
801077d0:	83 ec 0c             	sub    $0xc,%esp
    if (*pde & PTE_P) {
801077d3:	8b 06                	mov    (%esi),%eax
801077d5:	a8 01                	test   $0x1,%al
801077d7:	74 27                	je     80107800 <walkpgdir+0x40>
        pgtab = (pte_t *) P2V(PTE_ADDR(*pde));
801077d9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077de:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
        // The permissions here are overly generous, but they can
        // be further restricted by the permissions in the page table
        // entries, if necessary.
        *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
    }
    return &pgtab[PTX(va)];
801077e4:	c1 ef 0a             	shr    $0xa,%edi
}
801077e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return &pgtab[PTX(va)];
801077ea:	89 fa                	mov    %edi,%edx
801077ec:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801077f2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801077f5:	5b                   	pop    %ebx
801077f6:	5e                   	pop    %esi
801077f7:	5f                   	pop    %edi
801077f8:	5d                   	pop    %ebp
801077f9:	c3                   	ret    
801077fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (!alloc || (pgtab = (pte_t *) kalloc()) == 0)
80107800:	85 c9                	test   %ecx,%ecx
80107802:	74 2c                	je     80107830 <walkpgdir+0x70>
80107804:	e8 27 ae ff ff       	call   80102630 <kalloc>
80107809:	85 c0                	test   %eax,%eax
8010780b:	89 c3                	mov    %eax,%ebx
8010780d:	74 21                	je     80107830 <walkpgdir+0x70>
        memset(pgtab, 0, PGSIZE);
8010780f:	83 ec 04             	sub    $0x4,%esp
80107812:	68 00 10 00 00       	push   $0x1000
80107817:	6a 00                	push   $0x0
80107819:	50                   	push   %eax
8010781a:	e8 31 dc ff ff       	call   80105450 <memset>
        *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010781f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107825:	83 c4 10             	add    $0x10,%esp
80107828:	83 c8 07             	or     $0x7,%eax
8010782b:	89 06                	mov    %eax,(%esi)
8010782d:	eb b5                	jmp    801077e4 <walkpgdir+0x24>
8010782f:	90                   	nop
}
80107830:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return 0;
80107833:	31 c0                	xor    %eax,%eax
}
80107835:	5b                   	pop    %ebx
80107836:	5e                   	pop    %esi
80107837:	5f                   	pop    %edi
80107838:	5d                   	pop    %ebp
80107839:	c3                   	ret    
8010783a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107840 <mappages>:

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm) {
80107840:	55                   	push   %ebp
80107841:	89 e5                	mov    %esp,%ebp
80107843:	57                   	push   %edi
80107844:	56                   	push   %esi
80107845:	53                   	push   %ebx
    char *a, *last;
    pte_t *pte;

    a = (char *) PGROUNDDOWN((uint) va);
80107846:	89 d3                	mov    %edx,%ebx
80107848:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm) {
8010784e:	83 ec 1c             	sub    $0x1c,%esp
80107851:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    last = (char *) PGROUNDDOWN(((uint) va) + size - 1);
80107854:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107858:	8b 7d 08             	mov    0x8(%ebp),%edi
8010785b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107860:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for (;;) {
        if ((pte = walkpgdir(pgdir, a, 1)) == 0)
            return -1;
        if (*pte & PTE_P)
            panic("remap");
        *pte = pa | perm | PTE_P;
80107863:	8b 45 0c             	mov    0xc(%ebp),%eax
80107866:	29 df                	sub    %ebx,%edi
80107868:	83 c8 01             	or     $0x1,%eax
8010786b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010786e:	eb 15                	jmp    80107885 <mappages+0x45>
        if (*pte & PTE_P)
80107870:	f6 00 01             	testb  $0x1,(%eax)
80107873:	75 45                	jne    801078ba <mappages+0x7a>
        *pte = pa | perm | PTE_P;
80107875:	0b 75 dc             	or     -0x24(%ebp),%esi
        if (a == last)
80107878:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
        *pte = pa | perm | PTE_P;
8010787b:	89 30                	mov    %esi,(%eax)
        if (a == last)
8010787d:	74 31                	je     801078b0 <mappages+0x70>
            break;
        a += PGSIZE;
8010787f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
        if ((pte = walkpgdir(pgdir, a, 1)) == 0)
80107885:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107888:	b9 01 00 00 00       	mov    $0x1,%ecx
8010788d:	89 da                	mov    %ebx,%edx
8010788f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107892:	e8 29 ff ff ff       	call   801077c0 <walkpgdir>
80107897:	85 c0                	test   %eax,%eax
80107899:	75 d5                	jne    80107870 <mappages+0x30>
        pa += PGSIZE;
    }
    return 0;
}
8010789b:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
8010789e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078a3:	5b                   	pop    %ebx
801078a4:	5e                   	pop    %esi
801078a5:	5f                   	pop    %edi
801078a6:	5d                   	pop    %ebp
801078a7:	c3                   	ret    
801078a8:	90                   	nop
801078a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801078b3:	31 c0                	xor    %eax,%eax
}
801078b5:	5b                   	pop    %ebx
801078b6:	5e                   	pop    %esi
801078b7:	5f                   	pop    %edi
801078b8:	5d                   	pop    %ebp
801078b9:	c3                   	ret    
            panic("remap");
801078ba:	83 ec 0c             	sub    $0xc,%esp
801078bd:	68 c8 8c 10 80       	push   $0x80108cc8
801078c2:	e8 c9 8a ff ff       	call   80100390 <panic>
801078c7:	89 f6                	mov    %esi,%esi
801078c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801078d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	57                   	push   %edi
801078d4:	56                   	push   %esi
801078d5:	53                   	push   %ebx
    uint a, pa;

    if (newsz >= oldsz)
        return oldsz;

    a = PGROUNDUP(newsz);
801078d6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801078dc:	89 c7                	mov    %eax,%edi
    a = PGROUNDUP(newsz);
801078de:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
801078e4:	83 ec 1c             	sub    $0x1c,%esp
801078e7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    for (; a < oldsz; a += PGSIZE) {
801078ea:	39 d3                	cmp    %edx,%ebx
801078ec:	73 66                	jae    80107954 <deallocuvm.part.0+0x84>
801078ee:	89 d6                	mov    %edx,%esi
801078f0:	eb 3d                	jmp    8010792f <deallocuvm.part.0+0x5f>
801078f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pte = walkpgdir(pgdir, (char *) a, 0);
        if (!pte)
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
        else if ((*pte & PTE_P) != 0) {
801078f8:	8b 10                	mov    (%eax),%edx
801078fa:	f6 c2 01             	test   $0x1,%dl
801078fd:	74 26                	je     80107925 <deallocuvm.part.0+0x55>
            pa = PTE_ADDR(*pte);
            if (pa == 0)
801078ff:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107905:	74 58                	je     8010795f <deallocuvm.part.0+0x8f>
                panic("kfree");
            char *v = P2V(pa);
            kfree(v);
80107907:	83 ec 0c             	sub    $0xc,%esp
            char *v = P2V(pa);
8010790a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107910:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            kfree(v);
80107913:	52                   	push   %edx
80107914:	e8 67 ab ff ff       	call   80102480 <kfree>
            *pte = 0;
80107919:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010791c:	83 c4 10             	add    $0x10,%esp
8010791f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (; a < oldsz; a += PGSIZE) {
80107925:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010792b:	39 f3                	cmp    %esi,%ebx
8010792d:	73 25                	jae    80107954 <deallocuvm.part.0+0x84>
        pte = walkpgdir(pgdir, (char *) a, 0);
8010792f:	31 c9                	xor    %ecx,%ecx
80107931:	89 da                	mov    %ebx,%edx
80107933:	89 f8                	mov    %edi,%eax
80107935:	e8 86 fe ff ff       	call   801077c0 <walkpgdir>
        if (!pte)
8010793a:	85 c0                	test   %eax,%eax
8010793c:	75 ba                	jne    801078f8 <deallocuvm.part.0+0x28>
            a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010793e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107944:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
    for (; a < oldsz; a += PGSIZE) {
8010794a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107950:	39 f3                	cmp    %esi,%ebx
80107952:	72 db                	jb     8010792f <deallocuvm.part.0+0x5f>
        }
    }
    return newsz;
}
80107954:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107957:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010795a:	5b                   	pop    %ebx
8010795b:	5e                   	pop    %esi
8010795c:	5f                   	pop    %edi
8010795d:	5d                   	pop    %ebp
8010795e:	c3                   	ret    
                panic("kfree");
8010795f:	83 ec 0c             	sub    $0xc,%esp
80107962:	68 86 83 10 80       	push   $0x80108386
80107967:	e8 24 8a ff ff       	call   80100390 <panic>
8010796c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107970 <seginit>:
seginit(void) {
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	83 ec 18             	sub    $0x18,%esp
    c = &cpus[cpuid()];
80107976:	e8 15 c2 ff ff       	call   80103b90 <cpuid>
8010797b:	69 c0 b4 00 00 00    	imul   $0xb4,%eax,%eax
  pd[0] = size-1;
80107981:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107986:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
    c->gdt[SEG_KCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, 0);
8010798a:	c7 80 f8 37 11 80 ff 	movl   $0xffff,-0x7feec808(%eax)
80107991:	ff 00 00 
80107994:	c7 80 fc 37 11 80 00 	movl   $0xcf9a00,-0x7feec804(%eax)
8010799b:	9a cf 00 
    c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010799e:	c7 80 00 38 11 80 ff 	movl   $0xffff,-0x7feec800(%eax)
801079a5:	ff 00 00 
801079a8:	c7 80 04 38 11 80 00 	movl   $0xcf9200,-0x7feec7fc(%eax)
801079af:	92 cf 00 
    c->gdt[SEG_UCODE] = SEG(STA_X | STA_R, 0, 0xffffffff, DPL_USER);
801079b2:	c7 80 08 38 11 80 ff 	movl   $0xffff,-0x7feec7f8(%eax)
801079b9:	ff 00 00 
801079bc:	c7 80 0c 38 11 80 00 	movl   $0xcffa00,-0x7feec7f4(%eax)
801079c3:	fa cf 00 
    c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801079c6:	c7 80 10 38 11 80 ff 	movl   $0xffff,-0x7feec7f0(%eax)
801079cd:	ff 00 00 
801079d0:	c7 80 14 38 11 80 00 	movl   $0xcff200,-0x7feec7ec(%eax)
801079d7:	f2 cf 00 
    lgdt(c->gdt, sizeof(c->gdt));
801079da:	05 f0 37 11 80       	add    $0x801137f0,%eax
  pd[1] = (uint)p;
801079df:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801079e3:	c1 e8 10             	shr    $0x10,%eax
801079e6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801079ea:	8d 45 f2             	lea    -0xe(%ebp),%eax
801079ed:	0f 01 10             	lgdtl  (%eax)
}
801079f0:	c9                   	leave  
801079f1:	c3                   	ret    
801079f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a00 <switchkvm>:
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a00:	a1 64 55 12 80       	mov    0x80125564,%eax
switchkvm(void) {
80107a05:	55                   	push   %ebp
80107a06:	89 e5                	mov    %esp,%ebp
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a08:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107a0d:	0f 22 d8             	mov    %eax,%cr3
}
80107a10:	5d                   	pop    %ebp
80107a11:	c3                   	ret    
80107a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a20 <switchuvm>:
switchuvm(struct thread *t, struct proc *p) {
80107a20:	55                   	push   %ebp
80107a21:	89 e5                	mov    %esp,%ebp
80107a23:	57                   	push   %edi
80107a24:	56                   	push   %esi
80107a25:	53                   	push   %ebx
80107a26:	83 ec 1c             	sub    $0x1c,%esp
80107a29:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if (p == 0)
80107a2f:	85 d2                	test   %edx,%edx
80107a31:	0f 84 db 00 00 00    	je     80107b12 <switchuvm+0xf2>
    if (t == 0)
80107a37:	85 c9                	test   %ecx,%ecx
80107a39:	0f 84 fa 00 00 00    	je     80107b39 <switchuvm+0x119>
    if (t->kstack == 0)
80107a3f:	8b 01                	mov    (%ecx),%eax
80107a41:	85 c0                	test   %eax,%eax
80107a43:	0f 84 e3 00 00 00    	je     80107b2c <switchuvm+0x10c>
    if (p->pgdir == 0)
80107a49:	8b 7a 04             	mov    0x4(%edx),%edi
80107a4c:	85 ff                	test   %edi,%edi
80107a4e:	0f 84 cb 00 00 00    	je     80107b1f <switchuvm+0xff>
80107a54:	89 55 e0             	mov    %edx,-0x20(%ebp)
80107a57:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pushcli();
80107a5a:	e8 11 d8 ff ff       	call   80105270 <pushcli>
    mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107a5f:	e8 ac c0 ff ff       	call   80103b10 <mycpu>
80107a64:	89 c3                	mov    %eax,%ebx
80107a66:	e8 a5 c0 ff ff       	call   80103b10 <mycpu>
80107a6b:	89 c7                	mov    %eax,%edi
80107a6d:	e8 9e c0 ff ff       	call   80103b10 <mycpu>
80107a72:	89 c6                	mov    %eax,%esi
80107a74:	83 c7 08             	add    $0x8,%edi
80107a77:	83 c6 08             	add    $0x8,%esi
80107a7a:	e8 91 c0 ff ff       	call   80103b10 <mycpu>
80107a7f:	c1 ee 10             	shr    $0x10,%esi
80107a82:	ba 67 00 00 00       	mov    $0x67,%edx
80107a87:	83 c0 08             	add    $0x8,%eax
80107a8a:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107a8f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107a96:	c1 e8 18             	shr    $0x18,%eax
80107a99:	89 f2                	mov    %esi,%edx
80107a9b:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80107aa2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107aa9:	88 93 9c 00 00 00    	mov    %dl,0x9c(%ebx)
80107aaf:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
    mycpu()->ts.ss0 = SEG_KDATA << 3;
80107ab5:	bb 10 00 00 00       	mov    $0x10,%ebx
    mycpu()->gdt[SEG_TSS].s = 0;
80107aba:	e8 51 c0 ff ff       	call   80103b10 <mycpu>
80107abf:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
    mycpu()->ts.iomb = (ushort) 0xFFFF;
80107ac6:	be ff ff ff ff       	mov    $0xffffffff,%esi
    mycpu()->ts.ss0 = SEG_KDATA << 3;
80107acb:	e8 40 c0 ff ff       	call   80103b10 <mycpu>
    mycpu()->ts.esp0 = (uint) t->kstack + KSTACKSIZE;
80107ad0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    mycpu()->ts.ss0 = SEG_KDATA << 3;
80107ad3:	66 89 58 10          	mov    %bx,0x10(%eax)
    mycpu()->ts.esp0 = (uint) t->kstack + KSTACKSIZE;
80107ad7:	8b 19                	mov    (%ecx),%ebx
80107ad9:	e8 32 c0 ff ff       	call   80103b10 <mycpu>
80107ade:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107ae4:	89 58 0c             	mov    %ebx,0xc(%eax)
    mycpu()->ts.iomb = (ushort) 0xFFFF;
80107ae7:	e8 24 c0 ff ff       	call   80103b10 <mycpu>
80107aec:	66 89 70 6e          	mov    %si,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107af0:	b8 28 00 00 00       	mov    $0x28,%eax
80107af5:	0f 00 d8             	ltr    %ax
    lcr3(V2P(p->pgdir));  // switch to process's address space
80107af8:	8b 55 e0             	mov    -0x20(%ebp),%edx
80107afb:	8b 42 04             	mov    0x4(%edx),%eax
80107afe:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107b03:	0f 22 d8             	mov    %eax,%cr3
}
80107b06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b09:	5b                   	pop    %ebx
80107b0a:	5e                   	pop    %esi
80107b0b:	5f                   	pop    %edi
80107b0c:	5d                   	pop    %ebp
    popcli();
80107b0d:	e9 9e d7 ff ff       	jmp    801052b0 <popcli>
        panic("switchuvm: no process");
80107b12:	83 ec 0c             	sub    $0xc,%esp
80107b15:	68 ce 8c 10 80       	push   $0x80108cce
80107b1a:	e8 71 88 ff ff       	call   80100390 <panic>
        panic("switchuvm: no pgdir");
80107b1f:	83 ec 0c             	sub    $0xc,%esp
80107b22:	68 0e 8d 10 80       	push   $0x80108d0e
80107b27:	e8 64 88 ff ff       	call   80100390 <panic>
        panic("switchuvm: no kstack");
80107b2c:	83 ec 0c             	sub    $0xc,%esp
80107b2f:	68 f9 8c 10 80       	push   $0x80108cf9
80107b34:	e8 57 88 ff ff       	call   80100390 <panic>
        panic("switchuvm: no thread");
80107b39:	83 ec 0c             	sub    $0xc,%esp
80107b3c:	68 e4 8c 10 80       	push   $0x80108ce4
80107b41:	e8 4a 88 ff ff       	call   80100390 <panic>
80107b46:	8d 76 00             	lea    0x0(%esi),%esi
80107b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107b50 <inituvm>:
inituvm(pde_t *pgdir, char *init, uint sz) {
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	57                   	push   %edi
80107b54:	56                   	push   %esi
80107b55:	53                   	push   %ebx
80107b56:	83 ec 1c             	sub    $0x1c,%esp
80107b59:	8b 75 10             	mov    0x10(%ebp),%esi
80107b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80107b5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
    if (sz >= PGSIZE)
80107b62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
inituvm(pde_t *pgdir, char *init, uint sz) {
80107b68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (sz >= PGSIZE)
80107b6b:	77 49                	ja     80107bb6 <inituvm+0x66>
    mem = kalloc();
80107b6d:	e8 be aa ff ff       	call   80102630 <kalloc>
    memset(mem, 0, PGSIZE);
80107b72:	83 ec 04             	sub    $0x4,%esp
    mem = kalloc();
80107b75:	89 c3                	mov    %eax,%ebx
    memset(mem, 0, PGSIZE);
80107b77:	68 00 10 00 00       	push   $0x1000
80107b7c:	6a 00                	push   $0x0
80107b7e:	50                   	push   %eax
80107b7f:	e8 cc d8 ff ff       	call   80105450 <memset>
    mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W | PTE_U);
80107b84:	58                   	pop    %eax
80107b85:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b8b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b90:	5a                   	pop    %edx
80107b91:	6a 06                	push   $0x6
80107b93:	50                   	push   %eax
80107b94:	31 d2                	xor    %edx,%edx
80107b96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b99:	e8 a2 fc ff ff       	call   80107840 <mappages>
    memmove(mem, init, sz);
80107b9e:	89 75 10             	mov    %esi,0x10(%ebp)
80107ba1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107ba4:	83 c4 10             	add    $0x10,%esp
80107ba7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107baa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bad:	5b                   	pop    %ebx
80107bae:	5e                   	pop    %esi
80107baf:	5f                   	pop    %edi
80107bb0:	5d                   	pop    %ebp
    memmove(mem, init, sz);
80107bb1:	e9 4a d9 ff ff       	jmp    80105500 <memmove>
        panic("inituvm: more than a page");
80107bb6:	83 ec 0c             	sub    $0xc,%esp
80107bb9:	68 22 8d 10 80       	push   $0x80108d22
80107bbe:	e8 cd 87 ff ff       	call   80100390 <panic>
80107bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107bd0 <loaduvm>:
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz) {
80107bd0:	55                   	push   %ebp
80107bd1:	89 e5                	mov    %esp,%ebp
80107bd3:	57                   	push   %edi
80107bd4:	56                   	push   %esi
80107bd5:	53                   	push   %ebx
80107bd6:	83 ec 0c             	sub    $0xc,%esp
    if ((uint) addr % PGSIZE != 0)
80107bd9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107be0:	0f 85 91 00 00 00    	jne    80107c77 <loaduvm+0xa7>
    for (i = 0; i < sz; i += PGSIZE) {
80107be6:	8b 75 18             	mov    0x18(%ebp),%esi
80107be9:	31 db                	xor    %ebx,%ebx
80107beb:	85 f6                	test   %esi,%esi
80107bed:	75 1a                	jne    80107c09 <loaduvm+0x39>
80107bef:	eb 6f                	jmp    80107c60 <loaduvm+0x90>
80107bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bf8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107bfe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107c04:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107c07:	76 57                	jbe    80107c60 <loaduvm+0x90>
        if ((pte = walkpgdir(pgdir, addr + i, 0)) == 0)
80107c09:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c0c:	8b 45 08             	mov    0x8(%ebp),%eax
80107c0f:	31 c9                	xor    %ecx,%ecx
80107c11:	01 da                	add    %ebx,%edx
80107c13:	e8 a8 fb ff ff       	call   801077c0 <walkpgdir>
80107c18:	85 c0                	test   %eax,%eax
80107c1a:	74 4e                	je     80107c6a <loaduvm+0x9a>
        pa = PTE_ADDR(*pte);
80107c1c:	8b 00                	mov    (%eax),%eax
        if (readi(ip, P2V(pa), offset + i, n) != n)
80107c1e:	8b 4d 14             	mov    0x14(%ebp),%ecx
        if (sz - i < PGSIZE)
80107c21:	bf 00 10 00 00       	mov    $0x1000,%edi
        pa = PTE_ADDR(*pte);
80107c26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        if (sz - i < PGSIZE)
80107c2b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107c31:	0f 46 fe             	cmovbe %esi,%edi
        if (readi(ip, P2V(pa), offset + i, n) != n)
80107c34:	01 d9                	add    %ebx,%ecx
80107c36:	05 00 00 00 80       	add    $0x80000000,%eax
80107c3b:	57                   	push   %edi
80107c3c:	51                   	push   %ecx
80107c3d:	50                   	push   %eax
80107c3e:	ff 75 10             	pushl  0x10(%ebp)
80107c41:	e8 8a 9e ff ff       	call   80101ad0 <readi>
80107c46:	83 c4 10             	add    $0x10,%esp
80107c49:	39 f8                	cmp    %edi,%eax
80107c4b:	74 ab                	je     80107bf8 <loaduvm+0x28>
}
80107c4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
80107c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c55:	5b                   	pop    %ebx
80107c56:	5e                   	pop    %esi
80107c57:	5f                   	pop    %edi
80107c58:	5d                   	pop    %ebp
80107c59:	c3                   	ret    
80107c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107c63:	31 c0                	xor    %eax,%eax
}
80107c65:	5b                   	pop    %ebx
80107c66:	5e                   	pop    %esi
80107c67:	5f                   	pop    %edi
80107c68:	5d                   	pop    %ebp
80107c69:	c3                   	ret    
            panic("loaduvm: address should exist");
80107c6a:	83 ec 0c             	sub    $0xc,%esp
80107c6d:	68 3c 8d 10 80       	push   $0x80108d3c
80107c72:	e8 19 87 ff ff       	call   80100390 <panic>
        panic("loaduvm: addr must be page aligned");
80107c77:	83 ec 0c             	sub    $0xc,%esp
80107c7a:	68 e0 8d 10 80       	push   $0x80108de0
80107c7f:	e8 0c 87 ff ff       	call   80100390 <panic>
80107c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107c90 <allocuvm>:
allocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
80107c90:	55                   	push   %ebp
80107c91:	89 e5                	mov    %esp,%ebp
80107c93:	57                   	push   %edi
80107c94:	56                   	push   %esi
80107c95:	53                   	push   %ebx
80107c96:	83 ec 1c             	sub    $0x1c,%esp
    if (newsz >= KERNBASE)
80107c99:	8b 7d 10             	mov    0x10(%ebp),%edi
80107c9c:	85 ff                	test   %edi,%edi
80107c9e:	0f 88 8e 00 00 00    	js     80107d32 <allocuvm+0xa2>
    if (newsz < oldsz)
80107ca4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107ca7:	0f 82 93 00 00 00    	jb     80107d40 <allocuvm+0xb0>
    a = PGROUNDUP(oldsz);
80107cad:	8b 45 0c             	mov    0xc(%ebp),%eax
80107cb0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107cb6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    for (; a < newsz; a += PGSIZE) {
80107cbc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107cbf:	0f 86 7e 00 00 00    	jbe    80107d43 <allocuvm+0xb3>
80107cc5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107cc8:	8b 7d 08             	mov    0x8(%ebp),%edi
80107ccb:	eb 42                	jmp    80107d0f <allocuvm+0x7f>
80107ccd:	8d 76 00             	lea    0x0(%esi),%esi
        memset(mem, 0, PGSIZE);
80107cd0:	83 ec 04             	sub    $0x4,%esp
80107cd3:	68 00 10 00 00       	push   $0x1000
80107cd8:	6a 00                	push   $0x0
80107cda:	50                   	push   %eax
80107cdb:	e8 70 d7 ff ff       	call   80105450 <memset>
        if (mappages(pgdir, (char *) a, PGSIZE, V2P(mem), PTE_W | PTE_U) < 0) {
80107ce0:	58                   	pop    %eax
80107ce1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107ce7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107cec:	5a                   	pop    %edx
80107ced:	6a 06                	push   $0x6
80107cef:	50                   	push   %eax
80107cf0:	89 da                	mov    %ebx,%edx
80107cf2:	89 f8                	mov    %edi,%eax
80107cf4:	e8 47 fb ff ff       	call   80107840 <mappages>
80107cf9:	83 c4 10             	add    $0x10,%esp
80107cfc:	85 c0                	test   %eax,%eax
80107cfe:	78 50                	js     80107d50 <allocuvm+0xc0>
    for (; a < newsz; a += PGSIZE) {
80107d00:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d06:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107d09:	0f 86 81 00 00 00    	jbe    80107d90 <allocuvm+0x100>
        mem = kalloc();
80107d0f:	e8 1c a9 ff ff       	call   80102630 <kalloc>
        if (mem == 0) {
80107d14:	85 c0                	test   %eax,%eax
        mem = kalloc();
80107d16:	89 c6                	mov    %eax,%esi
        if (mem == 0) {
80107d18:	75 b6                	jne    80107cd0 <allocuvm+0x40>
            cprintf("allocuvm out of memory\n");
80107d1a:	83 ec 0c             	sub    $0xc,%esp
80107d1d:	68 5a 8d 10 80       	push   $0x80108d5a
80107d22:	e8 39 89 ff ff       	call   80100660 <cprintf>
    if (newsz >= oldsz)
80107d27:	83 c4 10             	add    $0x10,%esp
80107d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107d30:	77 6e                	ja     80107da0 <allocuvm+0x110>
}
80107d32:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
80107d35:	31 ff                	xor    %edi,%edi
}
80107d37:	89 f8                	mov    %edi,%eax
80107d39:	5b                   	pop    %ebx
80107d3a:	5e                   	pop    %esi
80107d3b:	5f                   	pop    %edi
80107d3c:	5d                   	pop    %ebp
80107d3d:	c3                   	ret    
80107d3e:	66 90                	xchg   %ax,%ax
        return oldsz;
80107d40:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d46:	89 f8                	mov    %edi,%eax
80107d48:	5b                   	pop    %ebx
80107d49:	5e                   	pop    %esi
80107d4a:	5f                   	pop    %edi
80107d4b:	5d                   	pop    %ebp
80107d4c:	c3                   	ret    
80107d4d:	8d 76 00             	lea    0x0(%esi),%esi
            cprintf("allocuvm out of memory (2)\n");
80107d50:	83 ec 0c             	sub    $0xc,%esp
80107d53:	68 72 8d 10 80       	push   $0x80108d72
80107d58:	e8 03 89 ff ff       	call   80100660 <cprintf>
    if (newsz >= oldsz)
80107d5d:	83 c4 10             	add    $0x10,%esp
80107d60:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d63:	39 45 10             	cmp    %eax,0x10(%ebp)
80107d66:	76 0d                	jbe    80107d75 <allocuvm+0xe5>
80107d68:	89 c1                	mov    %eax,%ecx
80107d6a:	8b 55 10             	mov    0x10(%ebp),%edx
80107d6d:	8b 45 08             	mov    0x8(%ebp),%eax
80107d70:	e8 5b fb ff ff       	call   801078d0 <deallocuvm.part.0>
            kfree(mem);
80107d75:	83 ec 0c             	sub    $0xc,%esp
            return 0;
80107d78:	31 ff                	xor    %edi,%edi
            kfree(mem);
80107d7a:	56                   	push   %esi
80107d7b:	e8 00 a7 ff ff       	call   80102480 <kfree>
            return 0;
80107d80:	83 c4 10             	add    $0x10,%esp
}
80107d83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d86:	89 f8                	mov    %edi,%eax
80107d88:	5b                   	pop    %ebx
80107d89:	5e                   	pop    %esi
80107d8a:	5f                   	pop    %edi
80107d8b:	5d                   	pop    %ebp
80107d8c:	c3                   	ret    
80107d8d:	8d 76 00             	lea    0x0(%esi),%esi
80107d90:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107d93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d96:	5b                   	pop    %ebx
80107d97:	89 f8                	mov    %edi,%eax
80107d99:	5e                   	pop    %esi
80107d9a:	5f                   	pop    %edi
80107d9b:	5d                   	pop    %ebp
80107d9c:	c3                   	ret    
80107d9d:	8d 76 00             	lea    0x0(%esi),%esi
80107da0:	89 c1                	mov    %eax,%ecx
80107da2:	8b 55 10             	mov    0x10(%ebp),%edx
80107da5:	8b 45 08             	mov    0x8(%ebp),%eax
            return 0;
80107da8:	31 ff                	xor    %edi,%edi
80107daa:	e8 21 fb ff ff       	call   801078d0 <deallocuvm.part.0>
80107daf:	eb 92                	jmp    80107d43 <allocuvm+0xb3>
80107db1:	eb 0d                	jmp    80107dc0 <deallocuvm>
80107db3:	90                   	nop
80107db4:	90                   	nop
80107db5:	90                   	nop
80107db6:	90                   	nop
80107db7:	90                   	nop
80107db8:	90                   	nop
80107db9:	90                   	nop
80107dba:	90                   	nop
80107dbb:	90                   	nop
80107dbc:	90                   	nop
80107dbd:	90                   	nop
80107dbe:	90                   	nop
80107dbf:	90                   	nop

80107dc0 <deallocuvm>:
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz) {
80107dc0:	55                   	push   %ebp
80107dc1:	89 e5                	mov    %esp,%ebp
80107dc3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107dc6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    if (newsz >= oldsz)
80107dcc:	39 d1                	cmp    %edx,%ecx
80107dce:	73 10                	jae    80107de0 <deallocuvm+0x20>
}
80107dd0:	5d                   	pop    %ebp
80107dd1:	e9 fa fa ff ff       	jmp    801078d0 <deallocuvm.part.0>
80107dd6:	8d 76 00             	lea    0x0(%esi),%esi
80107dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107de0:	89 d0                	mov    %edx,%eax
80107de2:	5d                   	pop    %ebp
80107de3:	c3                   	ret    
80107de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107df0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir) {
80107df0:	55                   	push   %ebp
80107df1:	89 e5                	mov    %esp,%ebp
80107df3:	57                   	push   %edi
80107df4:	56                   	push   %esi
80107df5:	53                   	push   %ebx
80107df6:	83 ec 0c             	sub    $0xc,%esp
80107df9:	8b 75 08             	mov    0x8(%ebp),%esi
    uint i;

    if (pgdir == 0)
80107dfc:	85 f6                	test   %esi,%esi
80107dfe:	74 59                	je     80107e59 <freevm+0x69>
80107e00:	31 c9                	xor    %ecx,%ecx
80107e02:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107e07:	89 f0                	mov    %esi,%eax
80107e09:	e8 c2 fa ff ff       	call   801078d0 <deallocuvm.part.0>
80107e0e:	89 f3                	mov    %esi,%ebx
80107e10:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107e16:	eb 0f                	jmp    80107e27 <freevm+0x37>
80107e18:	90                   	nop
80107e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e20:	83 c3 04             	add    $0x4,%ebx
        panic("freevm: no pgdir");
    deallocuvm(pgdir, KERNBASE, 0);
    for (i = 0; i < NPDENTRIES; i++) {
80107e23:	39 fb                	cmp    %edi,%ebx
80107e25:	74 23                	je     80107e4a <freevm+0x5a>
        if (pgdir[i] & PTE_P) {
80107e27:	8b 03                	mov    (%ebx),%eax
80107e29:	a8 01                	test   $0x1,%al
80107e2b:	74 f3                	je     80107e20 <freevm+0x30>
            char *v = P2V(PTE_ADDR(pgdir[i]));
80107e2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
            kfree(v);
80107e32:	83 ec 0c             	sub    $0xc,%esp
80107e35:	83 c3 04             	add    $0x4,%ebx
            char *v = P2V(PTE_ADDR(pgdir[i]));
80107e38:	05 00 00 00 80       	add    $0x80000000,%eax
            kfree(v);
80107e3d:	50                   	push   %eax
80107e3e:	e8 3d a6 ff ff       	call   80102480 <kfree>
80107e43:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NPDENTRIES; i++) {
80107e46:	39 fb                	cmp    %edi,%ebx
80107e48:	75 dd                	jne    80107e27 <freevm+0x37>
        }
    }
    kfree((char *) pgdir);
80107e4a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e50:	5b                   	pop    %ebx
80107e51:	5e                   	pop    %esi
80107e52:	5f                   	pop    %edi
80107e53:	5d                   	pop    %ebp
    kfree((char *) pgdir);
80107e54:	e9 27 a6 ff ff       	jmp    80102480 <kfree>
        panic("freevm: no pgdir");
80107e59:	83 ec 0c             	sub    $0xc,%esp
80107e5c:	68 8e 8d 10 80       	push   $0x80108d8e
80107e61:	e8 2a 85 ff ff       	call   80100390 <panic>
80107e66:	8d 76 00             	lea    0x0(%esi),%esi
80107e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e70 <setupkvm>:
setupkvm(void) {
80107e70:	55                   	push   %ebp
80107e71:	89 e5                	mov    %esp,%ebp
80107e73:	56                   	push   %esi
80107e74:	53                   	push   %ebx
    if ((pgdir = (pde_t *) kalloc()) == 0)
80107e75:	e8 b6 a7 ff ff       	call   80102630 <kalloc>
80107e7a:	85 c0                	test   %eax,%eax
80107e7c:	89 c6                	mov    %eax,%esi
80107e7e:	74 42                	je     80107ec2 <setupkvm+0x52>
    memset(pgdir, 0, PGSIZE);
80107e80:	83 ec 04             	sub    $0x4,%esp
    for (k = kmap; k < &kmap[NELEM(kmap)];
80107e83:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
    memset(pgdir, 0, PGSIZE);
80107e88:	68 00 10 00 00       	push   $0x1000
80107e8d:	6a 00                	push   $0x0
80107e8f:	50                   	push   %eax
80107e90:	e8 bb d5 ff ff       	call   80105450 <memset>
80107e95:	83 c4 10             	add    $0x10,%esp
                 (uint) k->phys_start, k->perm) < 0) {
80107e98:	8b 43 04             	mov    0x4(%ebx),%eax
    if (mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107e9b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107e9e:	83 ec 08             	sub    $0x8,%esp
80107ea1:	8b 13                	mov    (%ebx),%edx
80107ea3:	ff 73 0c             	pushl  0xc(%ebx)
80107ea6:	50                   	push   %eax
80107ea7:	29 c1                	sub    %eax,%ecx
80107ea9:	89 f0                	mov    %esi,%eax
80107eab:	e8 90 f9 ff ff       	call   80107840 <mappages>
80107eb0:	83 c4 10             	add    $0x10,%esp
80107eb3:	85 c0                	test   %eax,%eax
80107eb5:	78 19                	js     80107ed0 <setupkvm+0x60>
    k++)
80107eb7:	83 c3 10             	add    $0x10,%ebx
    for (k = kmap; k < &kmap[NELEM(kmap)];
80107eba:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107ec0:	75 d6                	jne    80107e98 <setupkvm+0x28>
}
80107ec2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ec5:	89 f0                	mov    %esi,%eax
80107ec7:	5b                   	pop    %ebx
80107ec8:	5e                   	pop    %esi
80107ec9:	5d                   	pop    %ebp
80107eca:	c3                   	ret    
80107ecb:	90                   	nop
80107ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        freevm(pgdir);
80107ed0:	83 ec 0c             	sub    $0xc,%esp
80107ed3:	56                   	push   %esi
        return 0;
80107ed4:	31 f6                	xor    %esi,%esi
        freevm(pgdir);
80107ed6:	e8 15 ff ff ff       	call   80107df0 <freevm>
        return 0;
80107edb:	83 c4 10             	add    $0x10,%esp
}
80107ede:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ee1:	89 f0                	mov    %esi,%eax
80107ee3:	5b                   	pop    %ebx
80107ee4:	5e                   	pop    %esi
80107ee5:	5d                   	pop    %ebp
80107ee6:	c3                   	ret    
80107ee7:	89 f6                	mov    %esi,%esi
80107ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ef0 <kvmalloc>:
kvmalloc(void) {
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	83 ec 08             	sub    $0x8,%esp
    kpgdir = setupkvm();
80107ef6:	e8 75 ff ff ff       	call   80107e70 <setupkvm>
80107efb:	a3 64 55 12 80       	mov    %eax,0x80125564
    lcr3(V2P(kpgdir));   // switch to the kernel page table
80107f00:	05 00 00 00 80       	add    $0x80000000,%eax
80107f05:	0f 22 d8             	mov    %eax,%cr3
}
80107f08:	c9                   	leave  
80107f09:	c3                   	ret    
80107f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f10 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva) {
80107f10:	55                   	push   %ebp
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
80107f11:	31 c9                	xor    %ecx,%ecx
clearpteu(pde_t *pgdir, char *uva) {
80107f13:	89 e5                	mov    %esp,%ebp
80107f15:	83 ec 08             	sub    $0x8,%esp
    pte = walkpgdir(pgdir, uva, 0);
80107f18:	8b 55 0c             	mov    0xc(%ebp),%edx
80107f1b:	8b 45 08             	mov    0x8(%ebp),%eax
80107f1e:	e8 9d f8 ff ff       	call   801077c0 <walkpgdir>
    if (pte == 0)
80107f23:	85 c0                	test   %eax,%eax
80107f25:	74 05                	je     80107f2c <clearpteu+0x1c>
        panic("clearpteu");
    *pte &= ~PTE_U;
80107f27:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107f2a:	c9                   	leave  
80107f2b:	c3                   	ret    
        panic("clearpteu");
80107f2c:	83 ec 0c             	sub    $0xc,%esp
80107f2f:	68 9f 8d 10 80       	push   $0x80108d9f
80107f34:	e8 57 84 ff ff       	call   80100390 <panic>
80107f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107f40 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t *
copyuvm(pde_t *pgdir, uint sz) {
80107f40:	55                   	push   %ebp
80107f41:	89 e5                	mov    %esp,%ebp
80107f43:	57                   	push   %edi
80107f44:	56                   	push   %esi
80107f45:	53                   	push   %ebx
80107f46:	83 ec 1c             	sub    $0x1c,%esp
    pde_t *d;
    pte_t *pte;
    uint pa, i, flags;
    char *mem;

    if ((d = setupkvm()) == 0)
80107f49:	e8 22 ff ff ff       	call   80107e70 <setupkvm>
80107f4e:	85 c0                	test   %eax,%eax
80107f50:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107f53:	0f 84 9f 00 00 00    	je     80107ff8 <copyuvm+0xb8>
        return 0;
    for (i = 0; i < sz; i += PGSIZE) {
80107f59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107f5c:	85 c9                	test   %ecx,%ecx
80107f5e:	0f 84 94 00 00 00    	je     80107ff8 <copyuvm+0xb8>
80107f64:	31 ff                	xor    %edi,%edi
80107f66:	eb 4a                	jmp    80107fb2 <copyuvm+0x72>
80107f68:	90                   	nop
80107f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            panic("copyuvm: page not present");
        pa = PTE_ADDR(*pte);
        flags = PTE_FLAGS(*pte);
        if ((mem = kalloc()) == 0)
            goto bad;
        memmove(mem, (char *) P2V(pa), PGSIZE);
80107f70:	83 ec 04             	sub    $0x4,%esp
80107f73:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107f79:	68 00 10 00 00       	push   $0x1000
80107f7e:	53                   	push   %ebx
80107f7f:	50                   	push   %eax
80107f80:	e8 7b d5 ff ff       	call   80105500 <memmove>
        if (mappages(d, (void *) i, PGSIZE, V2P(mem), flags) < 0) {
80107f85:	58                   	pop    %eax
80107f86:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107f8c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107f91:	5a                   	pop    %edx
80107f92:	ff 75 e4             	pushl  -0x1c(%ebp)
80107f95:	50                   	push   %eax
80107f96:	89 fa                	mov    %edi,%edx
80107f98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107f9b:	e8 a0 f8 ff ff       	call   80107840 <mappages>
80107fa0:	83 c4 10             	add    $0x10,%esp
80107fa3:	85 c0                	test   %eax,%eax
80107fa5:	78 61                	js     80108008 <copyuvm+0xc8>
    for (i = 0; i < sz; i += PGSIZE) {
80107fa7:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107fad:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107fb0:	76 46                	jbe    80107ff8 <copyuvm+0xb8>
        if ((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80107fb5:	31 c9                	xor    %ecx,%ecx
80107fb7:	89 fa                	mov    %edi,%edx
80107fb9:	e8 02 f8 ff ff       	call   801077c0 <walkpgdir>
80107fbe:	85 c0                	test   %eax,%eax
80107fc0:	74 61                	je     80108023 <copyuvm+0xe3>
        if (!(*pte & PTE_P))
80107fc2:	8b 00                	mov    (%eax),%eax
80107fc4:	a8 01                	test   $0x1,%al
80107fc6:	74 4e                	je     80108016 <copyuvm+0xd6>
        pa = PTE_ADDR(*pte);
80107fc8:	89 c3                	mov    %eax,%ebx
        flags = PTE_FLAGS(*pte);
80107fca:	25 ff 0f 00 00       	and    $0xfff,%eax
        pa = PTE_ADDR(*pte);
80107fcf:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
        flags = PTE_FLAGS(*pte);
80107fd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if ((mem = kalloc()) == 0)
80107fd8:	e8 53 a6 ff ff       	call   80102630 <kalloc>
80107fdd:	85 c0                	test   %eax,%eax
80107fdf:	89 c6                	mov    %eax,%esi
80107fe1:	75 8d                	jne    80107f70 <copyuvm+0x30>
        }
    }
    return d;

    bad:
    freevm(d);
80107fe3:	83 ec 0c             	sub    $0xc,%esp
80107fe6:	ff 75 e0             	pushl  -0x20(%ebp)
80107fe9:	e8 02 fe ff ff       	call   80107df0 <freevm>
    return 0;
80107fee:	83 c4 10             	add    $0x10,%esp
80107ff1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107ff8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ffb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ffe:	5b                   	pop    %ebx
80107fff:	5e                   	pop    %esi
80108000:	5f                   	pop    %edi
80108001:	5d                   	pop    %ebp
80108002:	c3                   	ret    
80108003:	90                   	nop
80108004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            kfree(mem);
80108008:	83 ec 0c             	sub    $0xc,%esp
8010800b:	56                   	push   %esi
8010800c:	e8 6f a4 ff ff       	call   80102480 <kfree>
            goto bad;
80108011:	83 c4 10             	add    $0x10,%esp
80108014:	eb cd                	jmp    80107fe3 <copyuvm+0xa3>
            panic("copyuvm: page not present");
80108016:	83 ec 0c             	sub    $0xc,%esp
80108019:	68 c3 8d 10 80       	push   $0x80108dc3
8010801e:	e8 6d 83 ff ff       	call   80100390 <panic>
            panic("copyuvm: pte should exist");
80108023:	83 ec 0c             	sub    $0xc,%esp
80108026:	68 a9 8d 10 80       	push   $0x80108da9
8010802b:	e8 60 83 ff ff       	call   80100390 <panic>

80108030 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char *
uva2ka(pde_t *pgdir, char *uva) {
80108030:	55                   	push   %ebp
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
80108031:	31 c9                	xor    %ecx,%ecx
uva2ka(pde_t *pgdir, char *uva) {
80108033:	89 e5                	mov    %esp,%ebp
80108035:	83 ec 08             	sub    $0x8,%esp
    pte = walkpgdir(pgdir, uva, 0);
80108038:	8b 55 0c             	mov    0xc(%ebp),%edx
8010803b:	8b 45 08             	mov    0x8(%ebp),%eax
8010803e:	e8 7d f7 ff ff       	call   801077c0 <walkpgdir>
    if ((*pte & PTE_P) == 0)
80108043:	8b 00                	mov    (%eax),%eax
        return 0;
    if ((*pte & PTE_U) == 0)
        return 0;
    return (char *) P2V(PTE_ADDR(*pte));
}
80108045:	c9                   	leave  
    if ((*pte & PTE_U) == 0)
80108046:	89 c2                	mov    %eax,%edx
    return (char *) P2V(PTE_ADDR(*pte));
80108048:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if ((*pte & PTE_U) == 0)
8010804d:	83 e2 05             	and    $0x5,%edx
    return (char *) P2V(PTE_ADDR(*pte));
80108050:	05 00 00 00 80       	add    $0x80000000,%eax
80108055:	83 fa 05             	cmp    $0x5,%edx
80108058:	ba 00 00 00 00       	mov    $0x0,%edx
8010805d:	0f 45 c2             	cmovne %edx,%eax
}
80108060:	c3                   	ret    
80108061:	eb 0d                	jmp    80108070 <copyout>
80108063:	90                   	nop
80108064:	90                   	nop
80108065:	90                   	nop
80108066:	90                   	nop
80108067:	90                   	nop
80108068:	90                   	nop
80108069:	90                   	nop
8010806a:	90                   	nop
8010806b:	90                   	nop
8010806c:	90                   	nop
8010806d:	90                   	nop
8010806e:	90                   	nop
8010806f:	90                   	nop

80108070 <copyout>:

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len) {
80108070:	55                   	push   %ebp
80108071:	89 e5                	mov    %esp,%ebp
80108073:	57                   	push   %edi
80108074:	56                   	push   %esi
80108075:	53                   	push   %ebx
80108076:	83 ec 1c             	sub    $0x1c,%esp
80108079:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010807c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010807f:	8b 7d 10             	mov    0x10(%ebp),%edi
    char *buf, *pa0;
    uint n, va0;

    buf = (char *) p;
    while (len > 0) {
80108082:	85 db                	test   %ebx,%ebx
80108084:	75 40                	jne    801080c6 <copyout+0x56>
80108086:	eb 70                	jmp    801080f8 <copyout+0x88>
80108088:	90                   	nop
80108089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        va0 = (uint) PGROUNDDOWN(va);
        pa0 = uva2ka(pgdir, (char *) va0);
        if (pa0 == 0)
            return -1;
        n = PGSIZE - (va - va0);
80108090:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80108093:	89 f1                	mov    %esi,%ecx
80108095:	29 d1                	sub    %edx,%ecx
80108097:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010809d:	39 d9                	cmp    %ebx,%ecx
8010809f:	0f 47 cb             	cmova  %ebx,%ecx
        if (n > len)
            n = len;
        memmove(pa0 + (va - va0), buf, n);
801080a2:	29 f2                	sub    %esi,%edx
801080a4:	83 ec 04             	sub    $0x4,%esp
801080a7:	01 d0                	add    %edx,%eax
801080a9:	51                   	push   %ecx
801080aa:	57                   	push   %edi
801080ab:	50                   	push   %eax
801080ac:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801080af:	e8 4c d4 ff ff       	call   80105500 <memmove>
        len -= n;
        buf += n;
801080b4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    while (len > 0) {
801080b7:	83 c4 10             	add    $0x10,%esp
        va = va0 + PGSIZE;
801080ba:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
        buf += n;
801080c0:	01 cf                	add    %ecx,%edi
    while (len > 0) {
801080c2:	29 cb                	sub    %ecx,%ebx
801080c4:	74 32                	je     801080f8 <copyout+0x88>
        va0 = (uint) PGROUNDDOWN(va);
801080c6:	89 d6                	mov    %edx,%esi
        pa0 = uva2ka(pgdir, (char *) va0);
801080c8:	83 ec 08             	sub    $0x8,%esp
        va0 = (uint) PGROUNDDOWN(va);
801080cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801080ce:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
        pa0 = uva2ka(pgdir, (char *) va0);
801080d4:	56                   	push   %esi
801080d5:	ff 75 08             	pushl  0x8(%ebp)
801080d8:	e8 53 ff ff ff       	call   80108030 <uva2ka>
        if (pa0 == 0)
801080dd:	83 c4 10             	add    $0x10,%esp
801080e0:	85 c0                	test   %eax,%eax
801080e2:	75 ac                	jne    80108090 <copyout+0x20>
    }
    return 0;
}
801080e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;
801080e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801080ec:	5b                   	pop    %ebx
801080ed:	5e                   	pop    %esi
801080ee:	5f                   	pop    %edi
801080ef:	5d                   	pop    %ebp
801080f0:	c3                   	ret    
801080f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801080fb:	31 c0                	xor    %eax,%eax
}
801080fd:	5b                   	pop    %ebx
801080fe:	5e                   	pop    %esi
801080ff:	5f                   	pop    %edi
80108100:	5d                   	pop    %ebp
80108101:	c3                   	ret    
