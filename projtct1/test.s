
test.exe:     file format pei-x86-64


Disassembly of section .text:

0000000000401000 <__mingw_invalidParameterHandler>:
  401000:	c3                   	ret    
  401001:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  401006:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40100d:	00 00 00 

0000000000401010 <pre_c_init>:
  401010:	48 83 ec 28          	sub    rsp,0x28
  401014:	48 8b 05 45 34 00 00 	mov    rax,QWORD PTR [rip+0x3445]        # 404460 <.refptr.mingw_initltsdrot_force>
  40101b:	31 d2                	xor    edx,edx
  40101d:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
  401023:	48 8b 05 46 34 00 00 	mov    rax,QWORD PTR [rip+0x3446]        # 404470 <.refptr.mingw_initltsdyn_force>
  40102a:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
  401030:	48 8b 05 49 34 00 00 	mov    rax,QWORD PTR [rip+0x3449]        # 404480 <.refptr.mingw_initltssuo_force>
  401037:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
  40103d:	48 8b 05 0c 34 00 00 	mov    rax,QWORD PTR [rip+0x340c]        # 404450 <.refptr.mingw_initcharmax>
  401044:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
  40104a:	48 8b 05 ef 32 00 00 	mov    rax,QWORD PTR [rip+0x32ef]        # 404340 <.refptr.__image_base__>
  401051:	66 81 38 4d 5a       	cmp    WORD PTR [rax],0x5a4d
  401056:	74 58                	je     4010b0 <pre_c_init+0xa0>
  401058:	48 8b 05 e1 33 00 00 	mov    rax,QWORD PTR [rip+0x33e1]        # 404440 <.refptr.mingw_app_type>
  40105f:	89 15 a3 5f 00 00    	mov    DWORD PTR [rip+0x5fa3],edx        # 407008 <managedapp>
  401065:	8b 00                	mov    eax,DWORD PTR [rax]
  401067:	85 c0                	test   eax,eax
  401069:	74 35                	je     4010a0 <pre_c_init+0x90>
  40106b:	b9 02 00 00 00       	mov    ecx,0x2
  401070:	e8 e3 1a 00 00       	call   402b58 <__set_app_type>
  401075:	e8 56 1b 00 00       	call   402bd0 <__p__fmode>
  40107a:	48 8b 15 7f 33 00 00 	mov    rdx,QWORD PTR [rip+0x337f]        # 404400 <.refptr._fmode>
  401081:	8b 12                	mov    edx,DWORD PTR [rdx]
  401083:	89 10                	mov    DWORD PTR [rax],edx
  401085:	e8 56 06 00 00       	call   4016e0 <_setargv>
  40108a:	48 8b 05 5f 32 00 00 	mov    rax,QWORD PTR [rip+0x325f]        # 4042f0 <.refptr._MINGW_INSTALL_DEBUG_MATHERR>
  401091:	83 38 01             	cmp    DWORD PTR [rax],0x1
  401094:	74 5a                	je     4010f0 <pre_c_init+0xe0>
  401096:	31 c0                	xor    eax,eax
  401098:	48 83 c4 28          	add    rsp,0x28
  40109c:	c3                   	ret    
  40109d:	0f 1f 00             	nop    DWORD PTR [rax]
  4010a0:	b9 01 00 00 00       	mov    ecx,0x1
  4010a5:	e8 ae 1a 00 00       	call   402b58 <__set_app_type>
  4010aa:	eb c9                	jmp    401075 <pre_c_init+0x65>
  4010ac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4010b0:	48 63 48 3c          	movsxd rcx,DWORD PTR [rax+0x3c]
  4010b4:	48 01 c8             	add    rax,rcx
  4010b7:	81 38 50 45 00 00    	cmp    DWORD PTR [rax],0x4550
  4010bd:	75 99                	jne    401058 <pre_c_init+0x48>
  4010bf:	0f b7 48 18          	movzx  ecx,WORD PTR [rax+0x18]
  4010c3:	66 81 f9 0b 01       	cmp    cx,0x10b
  4010c8:	74 39                	je     401103 <pre_c_init+0xf3>
  4010ca:	66 81 f9 0b 02       	cmp    cx,0x20b
  4010cf:	75 87                	jne    401058 <pre_c_init+0x48>
  4010d1:	83 b8 84 00 00 00 0e 	cmp    DWORD PTR [rax+0x84],0xe
  4010d8:	0f 86 7a ff ff ff    	jbe    401058 <pre_c_init+0x48>
  4010de:	8b 88 f8 00 00 00    	mov    ecx,DWORD PTR [rax+0xf8]
  4010e4:	31 d2                	xor    edx,edx
  4010e6:	85 c9                	test   ecx,ecx
  4010e8:	0f 95 c2             	setne  dl
  4010eb:	e9 68 ff ff ff       	jmp    401058 <pre_c_init+0x48>
  4010f0:	48 8d 0d f9 08 00 00 	lea    rcx,[rip+0x8f9]        # 4019f0 <_matherr>
  4010f7:	e8 e4 08 00 00       	call   4019e0 <__mingw_setusermatherr>
  4010fc:	31 c0                	xor    eax,eax
  4010fe:	48 83 c4 28          	add    rsp,0x28
  401102:	c3                   	ret    
  401103:	83 78 74 0e          	cmp    DWORD PTR [rax+0x74],0xe
  401107:	0f 86 4b ff ff ff    	jbe    401058 <pre_c_init+0x48>
  40110d:	44 8b 80 e8 00 00 00 	mov    r8d,DWORD PTR [rax+0xe8]
  401114:	31 d2                	xor    edx,edx
  401116:	45 85 c0             	test   r8d,r8d
  401119:	0f 95 c2             	setne  dl
  40111c:	e9 37 ff ff ff       	jmp    401058 <pre_c_init+0x48>
  401121:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  401126:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40112d:	00 00 00 

0000000000401130 <pre_cpp_init>:
  401130:	48 83 ec 38          	sub    rsp,0x38
  401134:	48 8b 05 f5 32 00 00 	mov    rax,QWORD PTR [rip+0x32f5]        # 404430 <.refptr._newmode>
  40113b:	4c 8d 05 ce 5e 00 00 	lea    r8,[rip+0x5ece]        # 407010 <envp>
  401142:	48 8d 15 cf 5e 00 00 	lea    rdx,[rip+0x5ecf]        # 407018 <argv>
  401149:	48 8d 0d d0 5e 00 00 	lea    rcx,[rip+0x5ed0]        # 407020 <argc>
  401150:	8b 00                	mov    eax,DWORD PTR [rax]
  401152:	89 05 a8 5e 00 00    	mov    DWORD PTR [rip+0x5ea8],eax        # 407000 <__bss_start__>
  401158:	48 8d 05 a1 5e 00 00 	lea    rax,[rip+0x5ea1]        # 407000 <__bss_start__>
  40115f:	48 89 44 24 20       	mov    QWORD PTR [rsp+0x20],rax
  401164:	48 8b 05 85 32 00 00 	mov    rax,QWORD PTR [rip+0x3285]        # 4043f0 <.refptr._dowildcard>
  40116b:	44 8b 08             	mov    r9d,DWORD PTR [rax]
  40116e:	e8 f5 19 00 00       	call   402b68 <__getmainargs>
  401173:	90                   	nop
  401174:	48 83 c4 38          	add    rsp,0x38
  401178:	c3                   	ret    
  401179:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000401180 <__tmainCRTStartup>:
  401180:	41 55                	push   r13
  401182:	41 54                	push   r12
  401184:	55                   	push   rbp
  401185:	57                   	push   rdi
  401186:	56                   	push   rsi
  401187:	53                   	push   rbx
  401188:	48 81 ec 98 00 00 00 	sub    rsp,0x98
  40118f:	31 c0                	xor    eax,eax
  401191:	b9 0d 00 00 00       	mov    ecx,0xd
  401196:	48 8d 54 24 20       	lea    rdx,[rsp+0x20]
  40119b:	48 89 d7             	mov    rdi,rdx
  40119e:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
  4011a1:	48 8b 3d 98 32 00 00 	mov    rdi,QWORD PTR [rip+0x3298]        # 404440 <.refptr.mingw_app_type>
  4011a8:	44 8b 0f             	mov    r9d,DWORD PTR [rdi]
  4011ab:	45 85 c9             	test   r9d,r9d
  4011ae:	0f 85 bc 02 00 00    	jne    401470 <__tmainCRTStartup+0x2f0>
  4011b4:	65 48 8b 04 25 30 00 	mov    rax,QWORD PTR gs:0x30
  4011bb:	00 00 
  4011bd:	48 8b 1d cc 31 00 00 	mov    rbx,QWORD PTR [rip+0x31cc]        # 404390 <.refptr.__native_startup_lock>
  4011c4:	31 ed                	xor    ebp,ebp
  4011c6:	48 8b 70 08          	mov    rsi,QWORD PTR [rax+0x8]
  4011ca:	4c 8b 25 93 70 00 00 	mov    r12,QWORD PTR [rip+0x7093]        # 408264 <__imp_Sleep>
  4011d1:	eb 11                	jmp    4011e4 <__tmainCRTStartup+0x64>
  4011d3:	48 39 c6             	cmp    rsi,rax
  4011d6:	0f 84 34 02 00 00    	je     401410 <__tmainCRTStartup+0x290>
  4011dc:	b9 e8 03 00 00       	mov    ecx,0x3e8
  4011e1:	41 ff d4             	call   r12
  4011e4:	48 89 e8             	mov    rax,rbp
  4011e7:	f0 48 0f b1 33       	lock cmpxchg QWORD PTR [rbx],rsi
  4011ec:	48 85 c0             	test   rax,rax
  4011ef:	75 e2                	jne    4011d3 <__tmainCRTStartup+0x53>
  4011f1:	48 8b 35 a8 31 00 00 	mov    rsi,QWORD PTR [rip+0x31a8]        # 4043a0 <.refptr.__native_startup_state>
  4011f8:	31 ed                	xor    ebp,ebp
  4011fa:	8b 06                	mov    eax,DWORD PTR [rsi]
  4011fc:	83 f8 01             	cmp    eax,0x1
  4011ff:	0f 84 22 02 00 00    	je     401427 <__tmainCRTStartup+0x2a7>
  401205:	8b 06                	mov    eax,DWORD PTR [rsi]
  401207:	85 c0                	test   eax,eax
  401209:	0f 84 71 02 00 00    	je     401480 <__tmainCRTStartup+0x300>
  40120f:	c7 05 eb 5d 00 00 01 	mov    DWORD PTR [rip+0x5deb],0x1        # 407004 <has_cctor>
  401216:	00 00 00 
  401219:	8b 06                	mov    eax,DWORD PTR [rsi]
  40121b:	83 f8 01             	cmp    eax,0x1
  40121e:	0f 84 18 02 00 00    	je     40143c <__tmainCRTStartup+0x2bc>
  401224:	85 ed                	test   ebp,ebp
  401226:	0f 84 31 02 00 00    	je     40145d <__tmainCRTStartup+0x2dd>
  40122c:	48 8b 05 fd 30 00 00 	mov    rax,QWORD PTR [rip+0x30fd]        # 404330 <.refptr.__dyn_tls_init_callback>
  401233:	48 8b 00             	mov    rax,QWORD PTR [rax]
  401236:	48 85 c0             	test   rax,rax
  401239:	74 0c                	je     401247 <__tmainCRTStartup+0xc7>
  40123b:	45 31 c0             	xor    r8d,r8d
  40123e:	ba 02 00 00 00       	mov    edx,0x2
  401243:	31 c9                	xor    ecx,ecx
  401245:	ff d0                	call   rax
  401247:	e8 a4 0a 00 00       	call   401cf0 <_pei386_runtime_relocator>
  40124c:	48 8d 0d ed 0f 00 00 	lea    rcx,[rip+0xfed]        # 402240 <_gnu_exception_handler>
  401253:	ff 15 03 70 00 00    	call   QWORD PTR [rip+0x7003]        # 40825c <__imp_SetUnhandledExceptionFilter>
  401259:	48 8b 15 20 31 00 00 	mov    rdx,QWORD PTR [rip+0x3120]        # 404380 <.refptr.__mingw_oldexcpt_handler>
  401260:	48 89 02             	mov    QWORD PTR [rdx],rax
  401263:	e8 e8 0e 00 00       	call   402150 <__mingw_init_ehandler>
  401268:	48 8d 0d 91 fd ff ff 	lea    rcx,[rip+0xfffffffffffffd91]        # 401000 <__mingw_invalidParameterHandler>
  40126f:	e8 3c 19 00 00       	call   402bb0 <_set_invalid_parameter_handler>
  401274:	e8 77 08 00 00       	call   401af0 <_fpreset>
  401279:	48 8b 05 c0 30 00 00 	mov    rax,QWORD PTR [rip+0x30c0]        # 404340 <.refptr.__image_base__>
  401280:	48 89 05 e1 66 00 00 	mov    QWORD PTR [rip+0x66e1],rax        # 407968 <__mingw_winmain_hInstance>
  401287:	e8 34 19 00 00       	call   402bc0 <__p__acmdln>
  40128c:	31 c9                	xor    ecx,ecx
  40128e:	48 8b 00             	mov    rax,QWORD PTR [rax]
  401291:	48 85 c0             	test   rax,rax
  401294:	75 1c                	jne    4012b2 <__tmainCRTStartup+0x132>
  401296:	eb 5f                	jmp    4012f7 <__tmainCRTStartup+0x177>
  401298:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40129f:	00 
  4012a0:	84 d2                	test   dl,dl
  4012a2:	74 2c                	je     4012d0 <__tmainCRTStartup+0x150>
  4012a4:	83 e1 01             	and    ecx,0x1
  4012a7:	74 27                	je     4012d0 <__tmainCRTStartup+0x150>
  4012a9:	b9 01 00 00 00       	mov    ecx,0x1
  4012ae:	48 83 c0 01          	add    rax,0x1
  4012b2:	0f b6 10             	movzx  edx,BYTE PTR [rax]
  4012b5:	80 fa 20             	cmp    dl,0x20
  4012b8:	7e e6                	jle    4012a0 <__tmainCRTStartup+0x120>
  4012ba:	41 89 c8             	mov    r8d,ecx
  4012bd:	41 83 f0 01          	xor    r8d,0x1
  4012c1:	80 fa 22             	cmp    dl,0x22
  4012c4:	41 0f 44 c8          	cmove  ecx,r8d
  4012c8:	eb e4                	jmp    4012ae <__tmainCRTStartup+0x12e>
  4012ca:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  4012d0:	84 d2                	test   dl,dl
  4012d2:	75 11                	jne    4012e5 <__tmainCRTStartup+0x165>
  4012d4:	eb 1a                	jmp    4012f0 <__tmainCRTStartup+0x170>
  4012d6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4012dd:	00 00 00 
  4012e0:	80 fa 20             	cmp    dl,0x20
  4012e3:	7f 0b                	jg     4012f0 <__tmainCRTStartup+0x170>
  4012e5:	48 83 c0 01          	add    rax,0x1
  4012e9:	0f b6 10             	movzx  edx,BYTE PTR [rax]
  4012ec:	84 d2                	test   dl,dl
  4012ee:	75 f0                	jne    4012e0 <__tmainCRTStartup+0x160>
  4012f0:	48 89 05 69 66 00 00 	mov    QWORD PTR [rip+0x6669],rax        # 407960 <__mingw_winmain_lpCmdLine>
  4012f7:	44 8b 07             	mov    r8d,DWORD PTR [rdi]
  4012fa:	45 85 c0             	test   r8d,r8d
  4012fd:	74 16                	je     401315 <__tmainCRTStartup+0x195>
  4012ff:	f6 44 24 5c 01       	test   BYTE PTR [rsp+0x5c],0x1
  401304:	b8 0a 00 00 00       	mov    eax,0xa
  401309:	0f 85 f1 00 00 00    	jne    401400 <__tmainCRTStartup+0x280>
  40130f:	89 05 eb 1c 00 00    	mov    DWORD PTR [rip+0x1ceb],eax        # 403000 <__data_start__>
  401315:	8b 1d 05 5d 00 00    	mov    ebx,DWORD PTR [rip+0x5d05]        # 407020 <argc>
  40131b:	44 8d 63 01          	lea    r12d,[rbx+0x1]
  40131f:	4d 63 e4             	movsxd r12,r12d
  401322:	49 c1 e4 03          	shl    r12,0x3
  401326:	4c 89 e1             	mov    rcx,r12
  401329:	e8 c2 17 00 00       	call   402af0 <malloc>
  40132e:	85 db                	test   ebx,ebx
  401330:	48 8b 3d e1 5c 00 00 	mov    rdi,QWORD PTR [rip+0x5ce1]        # 407018 <argv>
  401337:	48 89 c5             	mov    rbp,rax
  40133a:	7e 4b                	jle    401387 <__tmainCRTStartup+0x207>
  40133c:	8d 43 ff             	lea    eax,[rbx-0x1]
  40133f:	31 db                	xor    ebx,ebx
  401341:	4c 8d 2c c5 08 00 00 	lea    r13,[rax*8+0x8]
  401348:	00 
  401349:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
  401350:	48 8b 0c 1f          	mov    rcx,QWORD PTR [rdi+rbx*1]
  401354:	e8 77 17 00 00       	call   402ad0 <strlen>
  401359:	48 8d 70 01          	lea    rsi,[rax+0x1]
  40135d:	48 89 f1             	mov    rcx,rsi
  401360:	e8 8b 17 00 00       	call   402af0 <malloc>
  401365:	49 89 f0             	mov    r8,rsi
  401368:	48 89 44 1d 00       	mov    QWORD PTR [rbp+rbx*1+0x0],rax
  40136d:	48 8b 14 1f          	mov    rdx,QWORD PTR [rdi+rbx*1]
  401371:	48 89 c1             	mov    rcx,rax
  401374:	48 83 c3 08          	add    rbx,0x8
  401378:	e8 6b 17 00 00       	call   402ae8 <memcpy>
  40137d:	49 39 dd             	cmp    r13,rbx
  401380:	75 ce                	jne    401350 <__tmainCRTStartup+0x1d0>
  401382:	4a 8d 44 25 f8       	lea    rax,[rbp+r12*1-0x8]
  401387:	48 c7 00 00 00 00 00 	mov    QWORD PTR [rax],0x0
  40138e:	48 89 2d 83 5c 00 00 	mov    QWORD PTR [rip+0x5c83],rbp        # 407018 <argv>
  401395:	e8 16 03 00 00       	call   4016b0 <__main>
  40139a:	48 8b 05 af 2f 00 00 	mov    rax,QWORD PTR [rip+0x2faf]        # 404350 <.refptr.__imp___initenv>
  4013a1:	48 8b 15 68 5c 00 00 	mov    rdx,QWORD PTR [rip+0x5c68]        # 407010 <envp>
  4013a8:	8b 0d 72 5c 00 00    	mov    ecx,DWORD PTR [rip+0x5c72]        # 407020 <argc>
  4013ae:	48 8b 00             	mov    rax,QWORD PTR [rax]
  4013b1:	48 89 10             	mov    QWORD PTR [rax],rdx
  4013b4:	4c 8b 05 55 5c 00 00 	mov    r8,QWORD PTR [rip+0x5c55]        # 407010 <envp>
  4013bb:	48 8b 15 56 5c 00 00 	mov    rdx,QWORD PTR [rip+0x5c56]        # 407018 <argv>
  4013c2:	e8 1b 02 00 00       	call   4015e2 <main>
  4013c7:	8b 0d 3b 5c 00 00    	mov    ecx,DWORD PTR [rip+0x5c3b]        # 407008 <managedapp>
  4013cd:	89 05 39 5c 00 00    	mov    DWORD PTR [rip+0x5c39],eax        # 40700c <mainret>
  4013d3:	85 c9                	test   ecx,ecx
  4013d5:	0f 84 c3 00 00 00    	je     40149e <__tmainCRTStartup+0x31e>
  4013db:	8b 15 23 5c 00 00    	mov    edx,DWORD PTR [rip+0x5c23]        # 407004 <has_cctor>
  4013e1:	85 d2                	test   edx,edx
  4013e3:	75 0b                	jne    4013f0 <__tmainCRTStartup+0x270>
  4013e5:	e8 56 17 00 00       	call   402b40 <_cexit>
  4013ea:	8b 05 1c 5c 00 00    	mov    eax,DWORD PTR [rip+0x5c1c]        # 40700c <mainret>
  4013f0:	48 81 c4 98 00 00 00 	add    rsp,0x98
  4013f7:	5b                   	pop    rbx
  4013f8:	5e                   	pop    rsi
  4013f9:	5f                   	pop    rdi
  4013fa:	5d                   	pop    rbp
  4013fb:	41 5c                	pop    r12
  4013fd:	41 5d                	pop    r13
  4013ff:	c3                   	ret    
  401400:	0f b7 44 24 60       	movzx  eax,WORD PTR [rsp+0x60]
  401405:	e9 05 ff ff ff       	jmp    40130f <__tmainCRTStartup+0x18f>
  40140a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  401410:	48 8b 35 89 2f 00 00 	mov    rsi,QWORD PTR [rip+0x2f89]        # 4043a0 <.refptr.__native_startup_state>
  401417:	bd 01 00 00 00       	mov    ebp,0x1
  40141c:	8b 06                	mov    eax,DWORD PTR [rsi]
  40141e:	83 f8 01             	cmp    eax,0x1
  401421:	0f 85 de fd ff ff    	jne    401205 <__tmainCRTStartup+0x85>
  401427:	b9 1f 00 00 00       	mov    ecx,0x1f
  40142c:	e8 17 17 00 00       	call   402b48 <_amsg_exit>
  401431:	8b 06                	mov    eax,DWORD PTR [rsi]
  401433:	83 f8 01             	cmp    eax,0x1
  401436:	0f 85 e8 fd ff ff    	jne    401224 <__tmainCRTStartup+0xa4>
  40143c:	48 8b 15 7d 2f 00 00 	mov    rdx,QWORD PTR [rip+0x2f7d]        # 4043c0 <.refptr.__xc_z>
  401443:	48 8b 0d 66 2f 00 00 	mov    rcx,QWORD PTR [rip+0x2f66]        # 4043b0 <.refptr.__xc_a>
  40144a:	e8 e9 16 00 00       	call   402b38 <_initterm>
  40144f:	85 ed                	test   ebp,ebp
  401451:	c7 06 02 00 00 00    	mov    DWORD PTR [rsi],0x2
  401457:	0f 85 cf fd ff ff    	jne    40122c <__tmainCRTStartup+0xac>
  40145d:	31 c0                	xor    eax,eax
  40145f:	48 87 03             	xchg   QWORD PTR [rbx],rax
  401462:	e9 c5 fd ff ff       	jmp    40122c <__tmainCRTStartup+0xac>
  401467:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
  40146e:	00 00 
  401470:	48 89 d1             	mov    rcx,rdx
  401473:	ff 15 93 6d 00 00    	call   QWORD PTR [rip+0x6d93]        # 40820c <__imp_GetStartupInfoA>
  401479:	e9 36 fd ff ff       	jmp    4011b4 <__tmainCRTStartup+0x34>
  40147e:	66 90                	xchg   ax,ax
  401480:	48 8b 15 59 2f 00 00 	mov    rdx,QWORD PTR [rip+0x2f59]        # 4043e0 <.refptr.__xi_z>
  401487:	c7 06 01 00 00 00    	mov    DWORD PTR [rsi],0x1
  40148d:	48 8b 0d 3c 2f 00 00 	mov    rcx,QWORD PTR [rip+0x2f3c]        # 4043d0 <.refptr.__xi_a>
  401494:	e8 9f 16 00 00       	call   402b38 <_initterm>
  401499:	e9 7b fd ff ff       	jmp    401219 <__tmainCRTStartup+0x99>
  40149e:	89 c1                	mov    ecx,eax
  4014a0:	e8 73 16 00 00       	call   402b18 <exit>
  4014a5:	90                   	nop
  4014a6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4014ad:	00 00 00 

00000000004014b0 <WinMainCRTStartup>:
  4014b0:	48 83 ec 28          	sub    rsp,0x28

00000000004014b4 <.l_startw>:
  4014b4:	48 8b 05 85 2f 00 00 	mov    rax,QWORD PTR [rip+0x2f85]        # 404440 <.refptr.mingw_app_type>
  4014bb:	c7 00 01 00 00 00    	mov    DWORD PTR [rax],0x1
  4014c1:	e8 2a 02 00 00       	call   4016f0 <__security_init_cookie>
  4014c6:	e8 b5 fc ff ff       	call   401180 <__tmainCRTStartup>
  4014cb:	90                   	nop

00000000004014cc <.l_endw>:
  4014cc:	90                   	nop
  4014cd:	48 83 c4 28          	add    rsp,0x28
  4014d1:	c3                   	ret    
  4014d2:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4014d6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4014dd:	00 00 00 

00000000004014e0 <mainCRTStartup>:
  4014e0:	48 83 ec 28          	sub    rsp,0x28

00000000004014e4 <.l_start>:
  4014e4:	48 8b 05 55 2f 00 00 	mov    rax,QWORD PTR [rip+0x2f55]        # 404440 <.refptr.mingw_app_type>
  4014eb:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
  4014f1:	e8 fa 01 00 00       	call   4016f0 <__security_init_cookie>
  4014f6:	e8 85 fc ff ff       	call   401180 <__tmainCRTStartup>
  4014fb:	90                   	nop

00000000004014fc <.l_end>:
  4014fc:	90                   	nop
  4014fd:	48 83 c4 28          	add    rsp,0x28
  401501:	c3                   	ret    
  401502:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401506:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40150d:	00 00 00 

0000000000401510 <atexit>:
  401510:	48 83 ec 28          	sub    rsp,0x28
  401514:	e8 17 16 00 00       	call   402b30 <_onexit>
  401519:	48 85 c0             	test   rax,rax
  40151c:	0f 94 c0             	sete   al
  40151f:	0f b6 c0             	movzx  eax,al
  401522:	f7 d8                	neg    eax
  401524:	48 83 c4 28          	add    rsp,0x28
  401528:	c3                   	ret    
  401529:	90                   	nop
  40152a:	90                   	nop
  40152b:	90                   	nop
  40152c:	90                   	nop
  40152d:	90                   	nop
  40152e:	90                   	nop
  40152f:	90                   	nop

0000000000401530 <__gcc_register_frame>:
  401530:	48 8d 0d 09 00 00 00 	lea    rcx,[rip+0x9]        # 401540 <__gcc_deregister_frame>
  401537:	e9 d4 ff ff ff       	jmp    401510 <atexit>
  40153c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000401540 <__gcc_deregister_frame>:
  401540:	c3                   	ret    
  401541:	90                   	nop
  401542:	90                   	nop
  401543:	90                   	nop
  401544:	90                   	nop
  401545:	90                   	nop
  401546:	90                   	nop
  401547:	90                   	nop
  401548:	90                   	nop
  401549:	90                   	nop
  40154a:	90                   	nop
  40154b:	90                   	nop
  40154c:	90                   	nop
  40154d:	90                   	nop
  40154e:	90                   	nop
  40154f:	90                   	nop

0000000000401550 <gets>:
  401550:	55                   	push   rbp
  401551:	48 89 e5             	mov    rbp,rsp
  401554:	48 83 ec 30          	sub    rsp,0x30
  401558:	48 89 4d 10          	mov    QWORD PTR [rbp+0x10],rcx
  40155c:	48 8b 45 10          	mov    rax,QWORD PTR [rbp+0x10]
  401560:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  401564:	eb 28                	jmp    40158e <gets+0x3e>
  401566:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  40156a:	48 8d 50 01          	lea    rdx,[rax+0x1]
  40156e:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
  401572:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
  401575:	88 10                	mov    BYTE PTR [rax],dl
  401577:	83 7d f4 ff          	cmp    DWORD PTR [rbp-0xc],0xffffffff
  40157b:	75 11                	jne    40158e <gets+0x3e>
  40157d:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  401581:	48 3b 45 10          	cmp    rax,QWORD PTR [rbp+0x10]
  401585:	75 07                	jne    40158e <gets+0x3e>
  401587:	b8 00 00 00 00       	mov    eax,0x0
  40158c:	eb 27                	jmp    4015b5 <gets+0x65>
  40158e:	e8 65 15 00 00       	call   402af8 <getchar>
  401593:	89 45 f4             	mov    DWORD PTR [rbp-0xc],eax
  401596:	83 7d f4 0a          	cmp    DWORD PTR [rbp-0xc],0xa
  40159a:	74 06                	je     4015a2 <gets+0x52>
  40159c:	83 7d f4 ff          	cmp    DWORD PTR [rbp-0xc],0xffffffff
  4015a0:	75 c4                	jne    401566 <gets+0x16>
  4015a2:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  4015a6:	48 8d 50 01          	lea    rdx,[rax+0x1]
  4015aa:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
  4015ae:	c6 00 00             	mov    BYTE PTR [rax],0x0
  4015b1:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
  4015b5:	48 83 c4 30          	add    rsp,0x30
  4015b9:	5d                   	pop    rbp
  4015ba:	c3                   	ret    

00000000004015bb <test>:
  4015bb:	55                   	push   rbp
  4015bc:	48 89 e5             	mov    rbp,rsp
  4015bf:	48 83 ec 30          	sub    rsp,0x30
  4015c3:	48 8d 45 ff          	lea    rax,[rbp-0x1]
  4015c7:	48 89 c1             	mov    rcx,rax
  4015ca:	e8 81 ff ff ff       	call   401550 <gets>
  4015cf:	48 8d 45 ff          	lea    rax,[rbp-0x1]
  4015d3:	48 89 c1             	mov    rcx,rax
  4015d6:	e8 05 15 00 00       	call   402ae0 <puts>
  4015db:	90                   	nop
  4015dc:	48 83 c4 30          	add    rsp,0x30
  4015e0:	5d                   	pop    rbp
  4015e1:	c3                   	ret    

00000000004015e2 <main>:
  4015e2:	55                   	push   rbp
  4015e3:	48 89 e5             	mov    rbp,rsp
  4015e6:	48 83 ec 20          	sub    rsp,0x20
  4015ea:	e8 c1 00 00 00       	call   4016b0 <__main>
  4015ef:	e8 c7 ff ff ff       	call   4015bb <test>
  4015f4:	b8 00 00 00 00       	mov    eax,0x0
  4015f9:	48 83 c4 20          	add    rsp,0x20
  4015fd:	5d                   	pop    rbp
  4015fe:	c3                   	ret    
  4015ff:	90                   	nop

0000000000401600 <__do_global_dtors>:
  401600:	48 83 ec 28          	sub    rsp,0x28
  401604:	48 8b 05 05 1a 00 00 	mov    rax,QWORD PTR [rip+0x1a05]        # 403010 <p.93846>
  40160b:	48 8b 00             	mov    rax,QWORD PTR [rax]
  40160e:	48 85 c0             	test   rax,rax
  401611:	74 1d                	je     401630 <__do_global_dtors+0x30>
  401613:	ff d0                	call   rax
  401615:	48 8b 05 f4 19 00 00 	mov    rax,QWORD PTR [rip+0x19f4]        # 403010 <p.93846>
  40161c:	48 8d 50 08          	lea    rdx,[rax+0x8]
  401620:	48 8b 40 08          	mov    rax,QWORD PTR [rax+0x8]
  401624:	48 89 15 e5 19 00 00 	mov    QWORD PTR [rip+0x19e5],rdx        # 403010 <p.93846>
  40162b:	48 85 c0             	test   rax,rax
  40162e:	75 e3                	jne    401613 <__do_global_dtors+0x13>
  401630:	48 83 c4 28          	add    rsp,0x28
  401634:	c3                   	ret    
  401635:	90                   	nop
  401636:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40163d:	00 00 00 

0000000000401640 <__do_global_ctors>:
  401640:	56                   	push   rsi
  401641:	53                   	push   rbx
  401642:	48 83 ec 28          	sub    rsp,0x28
  401646:	48 8b 0d b3 2c 00 00 	mov    rcx,QWORD PTR [rip+0x2cb3]        # 404300 <.refptr.__CTOR_LIST__>
  40164d:	48 8b 11             	mov    rdx,QWORD PTR [rcx]
  401650:	83 fa ff             	cmp    edx,0xffffffff
  401653:	89 d0                	mov    eax,edx
  401655:	74 39                	je     401690 <__do_global_ctors+0x50>
  401657:	85 c0                	test   eax,eax
  401659:	74 20                	je     40167b <__do_global_ctors+0x3b>
  40165b:	89 c2                	mov    edx,eax
  40165d:	83 e8 01             	sub    eax,0x1
  401660:	48 8d 1c d1          	lea    rbx,[rcx+rdx*8]
  401664:	48 29 c2             	sub    rdx,rax
  401667:	48 8d 74 d1 f8       	lea    rsi,[rcx+rdx*8-0x8]
  40166c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401670:	ff 13                	call   QWORD PTR [rbx]
  401672:	48 83 eb 08          	sub    rbx,0x8
  401676:	48 39 f3             	cmp    rbx,rsi
  401679:	75 f5                	jne    401670 <__do_global_ctors+0x30>
  40167b:	48 8d 0d 7e ff ff ff 	lea    rcx,[rip+0xffffffffffffff7e]        # 401600 <__do_global_dtors>
  401682:	48 83 c4 28          	add    rsp,0x28
  401686:	5b                   	pop    rbx
  401687:	5e                   	pop    rsi
  401688:	e9 83 fe ff ff       	jmp    401510 <atexit>
  40168d:	0f 1f 00             	nop    DWORD PTR [rax]
  401690:	31 c0                	xor    eax,eax
  401692:	eb 02                	jmp    401696 <__do_global_ctors+0x56>
  401694:	89 d0                	mov    eax,edx
  401696:	44 8d 40 01          	lea    r8d,[rax+0x1]
  40169a:	4a 83 3c c1 00       	cmp    QWORD PTR [rcx+r8*8],0x0
  40169f:	4c 89 c2             	mov    rdx,r8
  4016a2:	75 f0                	jne    401694 <__do_global_ctors+0x54>
  4016a4:	eb b1                	jmp    401657 <__do_global_ctors+0x17>
  4016a6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4016ad:	00 00 00 

00000000004016b0 <__main>:
  4016b0:	8b 05 7a 59 00 00    	mov    eax,DWORD PTR [rip+0x597a]        # 407030 <initialized>
  4016b6:	85 c0                	test   eax,eax
  4016b8:	74 06                	je     4016c0 <__main+0x10>
  4016ba:	c3                   	ret    
  4016bb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  4016c0:	c7 05 66 59 00 00 01 	mov    DWORD PTR [rip+0x5966],0x1        # 407030 <initialized>
  4016c7:	00 00 00 
  4016ca:	e9 71 ff ff ff       	jmp    401640 <__do_global_ctors>
  4016cf:	90                   	nop

00000000004016d0 <my_lconv_init>:
  4016d0:	48 ff 25 e5 6b 00 00 	rex.W jmp QWORD PTR [rip+0x6be5]        # 4082bc <__imp___lconv_init>
  4016d7:	90                   	nop
  4016d8:	90                   	nop
  4016d9:	90                   	nop
  4016da:	90                   	nop
  4016db:	90                   	nop
  4016dc:	90                   	nop
  4016dd:	90                   	nop
  4016de:	90                   	nop
  4016df:	90                   	nop

00000000004016e0 <_setargv>:
  4016e0:	31 c0                	xor    eax,eax
  4016e2:	c3                   	ret    
  4016e3:	90                   	nop
  4016e4:	90                   	nop
  4016e5:	90                   	nop
  4016e6:	90                   	nop
  4016e7:	90                   	nop
  4016e8:	90                   	nop
  4016e9:	90                   	nop
  4016ea:	90                   	nop
  4016eb:	90                   	nop
  4016ec:	90                   	nop
  4016ed:	90                   	nop
  4016ee:	90                   	nop
  4016ef:	90                   	nop

00000000004016f0 <__security_init_cookie>:
  4016f0:	41 54                	push   r12
  4016f2:	55                   	push   rbp
  4016f3:	57                   	push   rdi
  4016f4:	56                   	push   rsi
  4016f5:	53                   	push   rbx
  4016f6:	48 83 ec 30          	sub    rsp,0x30
  4016fa:	48 8b 1d af 19 00 00 	mov    rbx,QWORD PTR [rip+0x19af]        # 4030b0 <__security_cookie>
  401701:	48 b8 32 a2 df 2d 99 	movabs rax,0x2b992ddfa232
  401708:	2b 00 00 
  40170b:	48 39 c3             	cmp    rbx,rax
  40170e:	48 c7 44 24 20 00 00 	mov    QWORD PTR [rsp+0x20],0x0
  401715:	00 00 
  401717:	74 17                	je     401730 <__security_init_cookie+0x40>
  401719:	48 f7 d3             	not    rbx
  40171c:	48 89 1d 9d 19 00 00 	mov    QWORD PTR [rip+0x199d],rbx        # 4030c0 <__security_cookie_complement>
  401723:	48 83 c4 30          	add    rsp,0x30
  401727:	5b                   	pop    rbx
  401728:	5e                   	pop    rsi
  401729:	5f                   	pop    rdi
  40172a:	5d                   	pop    rbp
  40172b:	41 5c                	pop    r12
  40172d:	c3                   	ret    
  40172e:	66 90                	xchg   ax,ax
  401730:	48 8d 4c 24 20       	lea    rcx,[rsp+0x20]
  401735:	ff 15 d9 6a 00 00    	call   QWORD PTR [rip+0x6ad9]        # 408214 <__imp_GetSystemTimeAsFileTime>
  40173b:	48 8b 74 24 20       	mov    rsi,QWORD PTR [rsp+0x20]
  401740:	ff 15 ae 6a 00 00    	call   QWORD PTR [rip+0x6aae]        # 4081f4 <__imp_GetCurrentProcessId>
  401746:	41 89 c4             	mov    r12d,eax
  401749:	ff 15 ad 6a 00 00    	call   QWORD PTR [rip+0x6aad]        # 4081fc <__imp_GetCurrentThreadId>
  40174f:	89 c5                	mov    ebp,eax
  401751:	ff 15 c5 6a 00 00    	call   QWORD PTR [rip+0x6ac5]        # 40821c <__imp_GetTickCount>
  401757:	48 8d 4c 24 28       	lea    rcx,[rsp+0x28]
  40175c:	89 c7                	mov    edi,eax
  40175e:	ff 15 d0 6a 00 00    	call   QWORD PTR [rip+0x6ad0]        # 408234 <__imp_QueryPerformanceCounter>
  401764:	48 33 74 24 28       	xor    rsi,QWORD PTR [rsp+0x28]
  401769:	44 89 e0             	mov    eax,r12d
  40176c:	48 ba ff ff ff ff ff 	movabs rdx,0xffffffffffff
  401773:	ff 00 00 
  401776:	48 31 f0             	xor    rax,rsi
  401779:	89 ee                	mov    esi,ebp
  40177b:	48 31 c6             	xor    rsi,rax
  40177e:	89 f8                	mov    eax,edi
  401780:	48 31 f0             	xor    rax,rsi
  401783:	48 21 d0             	and    rax,rdx
  401786:	48 39 d8             	cmp    rax,rbx
  401789:	74 25                	je     4017b0 <__security_init_cookie+0xc0>
  40178b:	48 89 c2             	mov    rdx,rax
  40178e:	48 f7 d2             	not    rdx
  401791:	48 89 05 18 19 00 00 	mov    QWORD PTR [rip+0x1918],rax        # 4030b0 <__security_cookie>
  401798:	48 89 15 21 19 00 00 	mov    QWORD PTR [rip+0x1921],rdx        # 4030c0 <__security_cookie_complement>
  40179f:	48 83 c4 30          	add    rsp,0x30
  4017a3:	5b                   	pop    rbx
  4017a4:	5e                   	pop    rsi
  4017a5:	5f                   	pop    rdi
  4017a6:	5d                   	pop    rbp
  4017a7:	41 5c                	pop    r12
  4017a9:	c3                   	ret    
  4017aa:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  4017b0:	48 ba cc 5d 20 d2 66 	movabs rdx,0xffffd466d2205dcc
  4017b7:	d4 ff ff 
  4017ba:	48 b8 33 a2 df 2d 99 	movabs rax,0x2b992ddfa233
  4017c1:	2b 00 00 
  4017c4:	eb cb                	jmp    401791 <__security_init_cookie+0xa1>
  4017c6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4017cd:	00 00 00 

00000000004017d0 <__report_gsfailure>:
  4017d0:	55                   	push   rbp
  4017d1:	56                   	push   rsi
  4017d2:	53                   	push   rbx
  4017d3:	48 89 e5             	mov    rbp,rsp
  4017d6:	48 83 ec 70          	sub    rsp,0x70
  4017da:	48 89 ce             	mov    rsi,rcx
  4017dd:	48 8d 0d 7c 58 00 00 	lea    rcx,[rip+0x587c]        # 407060 <GS_ContextRecord>
  4017e4:	ff 15 5a 6a 00 00    	call   QWORD PTR [rip+0x6a5a]        # 408244 <__imp_RtlCaptureContext>
  4017ea:	48 8b 1d 67 59 00 00 	mov    rbx,QWORD PTR [rip+0x5967]        # 407158 <GS_ContextRecord+0xf8>
  4017f1:	48 8d 55 d8          	lea    rdx,[rbp-0x28]
  4017f5:	45 31 c0             	xor    r8d,r8d
  4017f8:	48 89 d9             	mov    rcx,rbx
  4017fb:	ff 15 4b 6a 00 00    	call   QWORD PTR [rip+0x6a4b]        # 40824c <__imp_RtlLookupFunctionEntry>
  401801:	48 85 c0             	test   rax,rax
  401804:	0f 84 a3 00 00 00    	je     4018ad <__report_gsfailure+0xdd>
  40180a:	48 8d 55 e0          	lea    rdx,[rbp-0x20]
  40180e:	49 89 c1             	mov    r9,rax
  401811:	49 89 d8             	mov    r8,rbx
  401814:	48 c7 44 24 38 00 00 	mov    QWORD PTR [rsp+0x38],0x0
  40181b:	00 00 
  40181d:	48 8d 0d 3c 58 00 00 	lea    rcx,[rip+0x583c]        # 407060 <GS_ContextRecord>
  401824:	48 89 54 24 30       	mov    QWORD PTR [rsp+0x30],rdx
  401829:	48 8d 55 e8          	lea    rdx,[rbp-0x18]
  40182d:	48 89 4c 24 20       	mov    QWORD PTR [rsp+0x20],rcx
  401832:	31 c9                	xor    ecx,ecx
  401834:	48 89 54 24 28       	mov    QWORD PTR [rsp+0x28],rdx
  401839:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
  40183d:	ff 15 11 6a 00 00    	call   QWORD PTR [rip+0x6a11]        # 408254 <__imp_RtlVirtualUnwind>
  401843:	48 8b 05 0e 59 00 00 	mov    rax,QWORD PTR [rip+0x590e]        # 407158 <GS_ContextRecord+0xf8>
  40184a:	31 c9                	xor    ecx,ecx
  40184c:	48 89 35 8d 58 00 00 	mov    QWORD PTR [rip+0x588d],rsi        # 4070e0 <GS_ContextRecord+0x80>
  401853:	48 89 05 f6 5c 00 00 	mov    QWORD PTR [rip+0x5cf6],rax        # 407550 <GS_ExceptionRecord+0x10>
  40185a:	48 b8 09 04 00 c0 01 	movabs rax,0x1c0000409
  401861:	00 00 00 
  401864:	48 89 05 d5 5c 00 00 	mov    QWORD PTR [rip+0x5cd5],rax        # 407540 <GS_ExceptionRecord>
  40186b:	48 8b 05 3e 18 00 00 	mov    rax,QWORD PTR [rip+0x183e]        # 4030b0 <__security_cookie>
  401872:	48 89 45 f0          	mov    QWORD PTR [rbp-0x10],rax
  401876:	48 8b 05 43 18 00 00 	mov    rax,QWORD PTR [rip+0x1843]        # 4030c0 <__security_cookie_complement>
  40187d:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
  401881:	ff 15 d5 69 00 00    	call   QWORD PTR [rip+0x69d5]        # 40825c <__imp_SetUnhandledExceptionFilter>
  401887:	48 8d 0d 72 27 00 00 	lea    rcx,[rip+0x2772]        # 404000 <GS_ExceptionPointers>
  40188e:	ff 15 e8 69 00 00    	call   QWORD PTR [rip+0x69e8]        # 40827c <__imp_UnhandledExceptionFilter>
  401894:	ff 15 52 69 00 00    	call   QWORD PTR [rip+0x6952]        # 4081ec <__imp_GetCurrentProcess>
  40189a:	ba 09 04 00 c0       	mov    edx,0xc0000409
  40189f:	48 89 c1             	mov    rcx,rax
  4018a2:	ff 15 c4 69 00 00    	call   QWORD PTR [rip+0x69c4]        # 40826c <__imp_TerminateProcess>
  4018a8:	e8 7b 12 00 00       	call   402b28 <abort>
  4018ad:	48 8b 45 18          	mov    rax,QWORD PTR [rbp+0x18]
  4018b1:	48 89 05 a0 58 00 00 	mov    QWORD PTR [rip+0x58a0],rax        # 407158 <GS_ContextRecord+0xf8>
  4018b8:	48 8d 45 08          	lea    rax,[rbp+0x8]
  4018bc:	48 89 05 35 58 00 00 	mov    QWORD PTR [rip+0x5835],rax        # 4070f8 <GS_ContextRecord+0x98>
  4018c3:	e9 7b ff ff ff       	jmp    401843 <__report_gsfailure+0x73>
  4018c8:	90                   	nop
  4018c9:	90                   	nop
  4018ca:	90                   	nop
  4018cb:	90                   	nop
  4018cc:	90                   	nop
  4018cd:	90                   	nop
  4018ce:	90                   	nop
  4018cf:	90                   	nop

00000000004018d0 <__dyn_tls_dtor>:
  4018d0:	48 83 ec 28          	sub    rsp,0x28
  4018d4:	83 fa 03             	cmp    edx,0x3
  4018d7:	74 17                	je     4018f0 <__dyn_tls_dtor+0x20>
  4018d9:	85 d2                	test   edx,edx
  4018db:	74 13                	je     4018f0 <__dyn_tls_dtor+0x20>
  4018dd:	b8 01 00 00 00       	mov    eax,0x1
  4018e2:	48 83 c4 28          	add    rsp,0x28
  4018e6:	c3                   	ret    
  4018e7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
  4018ee:	00 00 
  4018f0:	e8 cb 0c 00 00       	call   4025c0 <__mingw_TLScallback>
  4018f5:	b8 01 00 00 00       	mov    eax,0x1
  4018fa:	48 83 c4 28          	add    rsp,0x28
  4018fe:	c3                   	ret    
  4018ff:	90                   	nop

0000000000401900 <__dyn_tls_init>:
  401900:	56                   	push   rsi
  401901:	53                   	push   rbx
  401902:	48 83 ec 28          	sub    rsp,0x28
  401906:	48 8b 05 d3 29 00 00 	mov    rax,QWORD PTR [rip+0x29d3]        # 4042e0 <.refptr._CRT_MT>
  40190d:	83 38 02             	cmp    DWORD PTR [rax],0x2
  401910:	74 06                	je     401918 <__dyn_tls_init+0x18>
  401912:	c7 00 02 00 00 00    	mov    DWORD PTR [rax],0x2
  401918:	83 fa 02             	cmp    edx,0x2
  40191b:	74 13                	je     401930 <__dyn_tls_init+0x30>
  40191d:	83 fa 01             	cmp    edx,0x1
  401920:	74 40                	je     401962 <__dyn_tls_init+0x62>
  401922:	b8 01 00 00 00       	mov    eax,0x1
  401927:	48 83 c4 28          	add    rsp,0x28
  40192b:	5b                   	pop    rbx
  40192c:	5e                   	pop    rsi
  40192d:	c3                   	ret    
  40192e:	66 90                	xchg   ax,ax
  401930:	48 8d 1d 29 77 00 00 	lea    rbx,[rip+0x7729]        # 409060 <__xd_z>
  401937:	48 8d 35 22 77 00 00 	lea    rsi,[rip+0x7722]        # 409060 <__xd_z>
  40193e:	48 39 de             	cmp    rsi,rbx
  401941:	74 df                	je     401922 <__dyn_tls_init+0x22>
  401943:	48 8b 03             	mov    rax,QWORD PTR [rbx]
  401946:	48 85 c0             	test   rax,rax
  401949:	74 02                	je     40194d <__dyn_tls_init+0x4d>
  40194b:	ff d0                	call   rax
  40194d:	48 83 c3 08          	add    rbx,0x8
  401951:	48 39 de             	cmp    rsi,rbx
  401954:	75 ed                	jne    401943 <__dyn_tls_init+0x43>
  401956:	b8 01 00 00 00       	mov    eax,0x1
  40195b:	48 83 c4 28          	add    rsp,0x28
  40195f:	5b                   	pop    rbx
  401960:	5e                   	pop    rsi
  401961:	c3                   	ret    
  401962:	e8 59 0c 00 00       	call   4025c0 <__mingw_TLScallback>
  401967:	b8 01 00 00 00       	mov    eax,0x1
  40196c:	48 83 c4 28          	add    rsp,0x28
  401970:	5b                   	pop    rbx
  401971:	5e                   	pop    rsi
  401972:	c3                   	ret    
  401973:	0f 1f 00             	nop    DWORD PTR [rax]
  401976:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40197d:	00 00 00 

0000000000401980 <__tlregdtor>:
  401980:	31 c0                	xor    eax,eax
  401982:	c3                   	ret    
  401983:	90                   	nop
  401984:	90                   	nop
  401985:	90                   	nop
  401986:	90                   	nop
  401987:	90                   	nop
  401988:	90                   	nop
  401989:	90                   	nop
  40198a:	90                   	nop
  40198b:	90                   	nop
  40198c:	90                   	nop
  40198d:	90                   	nop
  40198e:	90                   	nop
  40198f:	90                   	nop

0000000000401990 <__mingw_raise_matherr>:
  401990:	48 83 ec 58          	sub    rsp,0x58
  401994:	48 8b 05 65 5c 00 00 	mov    rax,QWORD PTR [rip+0x5c65]        # 407600 <stUserMathErr>
  40199b:	48 85 c0             	test   rax,rax
  40199e:	74 2c                	je     4019cc <__mingw_raise_matherr+0x3c>
  4019a0:	f2 0f 10 84 24 80 00 	movsd  xmm0,QWORD PTR [rsp+0x80]
  4019a7:	00 00 
  4019a9:	89 4c 24 20          	mov    DWORD PTR [rsp+0x20],ecx
  4019ad:	48 8d 4c 24 20       	lea    rcx,[rsp+0x20]
  4019b2:	48 89 54 24 28       	mov    QWORD PTR [rsp+0x28],rdx
  4019b7:	f2 0f 11 54 24 30    	movsd  QWORD PTR [rsp+0x30],xmm2
  4019bd:	f2 0f 11 5c 24 38    	movsd  QWORD PTR [rsp+0x38],xmm3
  4019c3:	f2 0f 11 44 24 40    	movsd  QWORD PTR [rsp+0x40],xmm0
  4019c9:	ff d0                	call   rax
  4019cb:	90                   	nop
  4019cc:	48 83 c4 58          	add    rsp,0x58
  4019d0:	c3                   	ret    
  4019d1:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  4019d6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4019dd:	00 00 00 

00000000004019e0 <__mingw_setusermatherr>:
  4019e0:	48 89 0d 19 5c 00 00 	mov    QWORD PTR [rip+0x5c19],rcx        # 407600 <stUserMathErr>
  4019e7:	e9 64 11 00 00       	jmp    402b50 <__setusermatherr>
  4019ec:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

00000000004019f0 <_matherr>:
  4019f0:	56                   	push   rsi
  4019f1:	53                   	push   rbx
  4019f2:	48 83 ec 78          	sub    rsp,0x78
  4019f6:	0f 29 74 24 40       	movaps XMMWORD PTR [rsp+0x40],xmm6
  4019fb:	0f 29 7c 24 50       	movaps XMMWORD PTR [rsp+0x50],xmm7
  401a00:	44 0f 29 44 24 60    	movaps XMMWORD PTR [rsp+0x60],xmm8
  401a06:	83 39 06             	cmp    DWORD PTR [rcx],0x6
  401a09:	0f 87 d1 00 00 00    	ja     401ae0 <_matherr+0xf0>
  401a0f:	8b 01                	mov    eax,DWORD PTR [rcx]
  401a11:	48 8d 15 8c 27 00 00 	lea    rdx,[rip+0x278c]        # 4041a4 <.rdata+0x124>
  401a18:	48 63 04 82          	movsxd rax,DWORD PTR [rdx+rax*4]
  401a1c:	48 01 d0             	add    rax,rdx
  401a1f:	ff e0                	jmp    rax
  401a21:	48 8d 1d 58 26 00 00 	lea    rbx,[rip+0x2658]        # 404080 <.rdata>
  401a28:	48 8b 71 08          	mov    rsi,QWORD PTR [rcx+0x8]
  401a2c:	f2 44 0f 10 41 20    	movsd  xmm8,QWORD PTR [rcx+0x20]
  401a32:	f2 0f 10 79 18       	movsd  xmm7,QWORD PTR [rcx+0x18]
  401a37:	f2 0f 10 71 10       	movsd  xmm6,QWORD PTR [rcx+0x10]
  401a3c:	b9 02 00 00 00       	mov    ecx,0x2
  401a41:	e8 3a 11 00 00       	call   402b80 <__acrt_iob_func>
  401a46:	f2 44 0f 11 44 24 30 	movsd  QWORD PTR [rsp+0x30],xmm8
  401a4d:	49 89 f1             	mov    r9,rsi
  401a50:	49 89 d8             	mov    r8,rbx
  401a53:	f2 0f 11 7c 24 28    	movsd  QWORD PTR [rsp+0x28],xmm7
  401a59:	48 8d 15 18 27 00 00 	lea    rdx,[rip+0x2718]        # 404178 <.rdata+0xf8>
  401a60:	48 89 c1             	mov    rcx,rax
  401a63:	f2 0f 11 74 24 20    	movsd  QWORD PTR [rsp+0x20],xmm6
  401a69:	e8 a2 10 00 00       	call   402b10 <fprintf>
  401a6e:	90                   	nop
  401a6f:	0f 28 74 24 40       	movaps xmm6,XMMWORD PTR [rsp+0x40]
  401a74:	31 c0                	xor    eax,eax
  401a76:	0f 28 7c 24 50       	movaps xmm7,XMMWORD PTR [rsp+0x50]
  401a7b:	44 0f 28 44 24 60    	movaps xmm8,XMMWORD PTR [rsp+0x60]
  401a81:	48 83 c4 78          	add    rsp,0x78
  401a85:	5b                   	pop    rbx
  401a86:	5e                   	pop    rsi
  401a87:	c3                   	ret    
  401a88:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  401a8f:	00 
  401a90:	48 8d 1d 08 26 00 00 	lea    rbx,[rip+0x2608]        # 40409f <.rdata+0x1f>
  401a97:	eb 8f                	jmp    401a28 <_matherr+0x38>
  401a99:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
  401aa0:	48 8d 1d 19 26 00 00 	lea    rbx,[rip+0x2619]        # 4040c0 <.rdata+0x40>
  401aa7:	e9 7c ff ff ff       	jmp    401a28 <_matherr+0x38>
  401aac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401ab0:	48 8d 1d 79 26 00 00 	lea    rbx,[rip+0x2679]        # 404130 <.rdata+0xb0>
  401ab7:	e9 6c ff ff ff       	jmp    401a28 <_matherr+0x38>
  401abc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401ac0:	48 8d 1d 41 26 00 00 	lea    rbx,[rip+0x2641]        # 404108 <.rdata+0x88>
  401ac7:	e9 5c ff ff ff       	jmp    401a28 <_matherr+0x38>
  401acc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401ad0:	48 8d 1d 09 26 00 00 	lea    rbx,[rip+0x2609]        # 4040e0 <.rdata+0x60>
  401ad7:	e9 4c ff ff ff       	jmp    401a28 <_matherr+0x38>
  401adc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  401ae0:	48 8d 1d 7f 26 00 00 	lea    rbx,[rip+0x267f]        # 404166 <.rdata+0xe6>
  401ae7:	e9 3c ff ff ff       	jmp    401a28 <_matherr+0x38>
  401aec:	90                   	nop
  401aed:	90                   	nop
  401aee:	90                   	nop
  401aef:	90                   	nop

0000000000401af0 <_fpreset>:
  401af0:	db e3                	fninit 
  401af2:	c3                   	ret    
  401af3:	90                   	nop
  401af4:	90                   	nop
  401af5:	90                   	nop
  401af6:	90                   	nop
  401af7:	90                   	nop
  401af8:	90                   	nop
  401af9:	90                   	nop
  401afa:	90                   	nop
  401afb:	90                   	nop
  401afc:	90                   	nop
  401afd:	90                   	nop
  401afe:	90                   	nop
  401aff:	90                   	nop

0000000000401b00 <_decode_pointer>:
  401b00:	48 89 c8             	mov    rax,rcx
  401b03:	c3                   	ret    
  401b04:	66 90                	xchg   ax,ax
  401b06:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  401b0d:	00 00 00 

0000000000401b10 <_encode_pointer>:
  401b10:	48 89 c8             	mov    rax,rcx
  401b13:	c3                   	ret    
  401b14:	90                   	nop
  401b15:	90                   	nop
  401b16:	90                   	nop
  401b17:	90                   	nop
  401b18:	90                   	nop
  401b19:	90                   	nop
  401b1a:	90                   	nop
  401b1b:	90                   	nop
  401b1c:	90                   	nop
  401b1d:	90                   	nop
  401b1e:	90                   	nop
  401b1f:	90                   	nop

0000000000401b20 <__write_memory.part.0>:
  401b20:	41 54                	push   r12
  401b22:	55                   	push   rbp
  401b23:	57                   	push   rdi
  401b24:	56                   	push   rsi
  401b25:	53                   	push   rbx
  401b26:	48 83 ec 50          	sub    rsp,0x50
  401b2a:	48 63 35 f3 5a 00 00 	movsxd rsi,DWORD PTR [rip+0x5af3]        # 407624 <maxSections>
  401b31:	85 f6                	test   esi,esi
  401b33:	48 89 cb             	mov    rbx,rcx
  401b36:	48 89 d5             	mov    rbp,rdx
  401b39:	4c 89 c7             	mov    rdi,r8
  401b3c:	0f 8e 66 01 00 00    	jle    401ca8 <__write_memory.part.0+0x188>
  401b42:	48 8b 05 df 5a 00 00 	mov    rax,QWORD PTR [rip+0x5adf]        # 407628 <the_secs>
  401b49:	31 c9                	xor    ecx,ecx
  401b4b:	48 83 c0 18          	add    rax,0x18
  401b4f:	90                   	nop
  401b50:	48 8b 10             	mov    rdx,QWORD PTR [rax]
  401b53:	48 39 d3             	cmp    rbx,rdx
  401b56:	72 14                	jb     401b6c <__write_memory.part.0+0x4c>
  401b58:	4c 8b 40 08          	mov    r8,QWORD PTR [rax+0x8]
  401b5c:	45 8b 40 08          	mov    r8d,DWORD PTR [r8+0x8]
  401b60:	4c 01 c2             	add    rdx,r8
  401b63:	48 39 d3             	cmp    rbx,rdx
  401b66:	0f 82 89 00 00 00    	jb     401bf5 <__write_memory.part.0+0xd5>
  401b6c:	83 c1 01             	add    ecx,0x1
  401b6f:	48 83 c0 28          	add    rax,0x28
  401b73:	39 f1                	cmp    ecx,esi
  401b75:	75 d9                	jne    401b50 <__write_memory.part.0+0x30>
  401b77:	48 89 d9             	mov    rcx,rbx
  401b7a:	e8 41 0c 00 00       	call   4027c0 <__mingw_GetSectionForAddress>
  401b7f:	48 85 c0             	test   rax,rax
  401b82:	49 89 c4             	mov    r12,rax
  401b85:	0f 84 52 01 00 00    	je     401cdd <__write_memory.part.0+0x1bd>
  401b8b:	48 8b 05 96 5a 00 00 	mov    rax,QWORD PTR [rip+0x5a96]        # 407628 <the_secs>
  401b92:	48 8d 34 b6          	lea    rsi,[rsi+rsi*4]
  401b96:	48 c1 e6 03          	shl    rsi,0x3
  401b9a:	48 01 f0             	add    rax,rsi
  401b9d:	4c 89 60 20          	mov    QWORD PTR [rax+0x20],r12
  401ba1:	c7 00 00 00 00 00    	mov    DWORD PTR [rax],0x0
  401ba7:	e8 44 0d 00 00       	call   4028f0 <_GetPEImageBase>
  401bac:	41 8b 4c 24 0c       	mov    ecx,DWORD PTR [r12+0xc]
  401bb1:	48 8d 54 24 20       	lea    rdx,[rsp+0x20]
  401bb6:	41 b8 30 00 00 00    	mov    r8d,0x30
  401bbc:	48 01 c1             	add    rcx,rax
  401bbf:	48 8b 05 62 5a 00 00 	mov    rax,QWORD PTR [rip+0x5a62]        # 407628 <the_secs>
  401bc6:	48 89 4c 30 18       	mov    QWORD PTR [rax+rsi*1+0x18],rcx
  401bcb:	ff 15 bb 66 00 00    	call   QWORD PTR [rip+0x66bb]        # 40828c <__imp_VirtualQuery>
  401bd1:	48 85 c0             	test   rax,rax
  401bd4:	0f 84 e6 00 00 00    	je     401cc0 <__write_memory.part.0+0x1a0>
  401bda:	8b 44 24 44          	mov    eax,DWORD PTR [rsp+0x44]
  401bde:	8d 50 fc             	lea    edx,[rax-0x4]
  401be1:	83 e2 fb             	and    edx,0xfffffffb
  401be4:	74 08                	je     401bee <__write_memory.part.0+0xce>
  401be6:	83 e8 40             	sub    eax,0x40
  401be9:	83 e0 bf             	and    eax,0xffffffbf
  401bec:	75 62                	jne    401c50 <__write_memory.part.0+0x130>
  401bee:	83 05 2f 5a 00 00 01 	add    DWORD PTR [rip+0x5a2f],0x1        # 407624 <maxSections>
  401bf5:	83 ff 08             	cmp    edi,0x8
  401bf8:	73 29                	jae    401c23 <__write_memory.part.0+0x103>
  401bfa:	40 f6 c7 04          	test   dil,0x4
  401bfe:	0f 85 90 00 00 00    	jne    401c94 <__write_memory.part.0+0x174>
  401c04:	85 ff                	test   edi,edi
  401c06:	74 10                	je     401c18 <__write_memory.part.0+0xf8>
  401c08:	0f b6 45 00          	movzx  eax,BYTE PTR [rbp+0x0]
  401c0c:	40 f6 c7 02          	test   dil,0x2
  401c10:	88 03                	mov    BYTE PTR [rbx],al
  401c12:	0f 85 97 00 00 00    	jne    401caf <__write_memory.part.0+0x18f>
  401c18:	48 83 c4 50          	add    rsp,0x50
  401c1c:	5b                   	pop    rbx
  401c1d:	5e                   	pop    rsi
  401c1e:	5f                   	pop    rdi
  401c1f:	5d                   	pop    rbp
  401c20:	41 5c                	pop    r12
  401c22:	c3                   	ret    
  401c23:	89 f8                	mov    eax,edi
  401c25:	83 ef 01             	sub    edi,0x1
  401c28:	48 8b 54 05 f8       	mov    rdx,QWORD PTR [rbp+rax*1-0x8]
  401c2d:	83 ff 08             	cmp    edi,0x8
  401c30:	48 89 54 03 f8       	mov    QWORD PTR [rbx+rax*1-0x8],rdx
  401c35:	72 e1                	jb     401c18 <__write_memory.part.0+0xf8>
  401c37:	83 e7 f8             	and    edi,0xfffffff8
  401c3a:	31 c0                	xor    eax,eax
  401c3c:	89 c2                	mov    edx,eax
  401c3e:	83 c0 08             	add    eax,0x8
  401c41:	48 8b 4c 15 00       	mov    rcx,QWORD PTR [rbp+rdx*1+0x0]
  401c46:	39 f8                	cmp    eax,edi
  401c48:	48 89 0c 13          	mov    QWORD PTR [rbx+rdx*1],rcx
  401c4c:	72 ee                	jb     401c3c <__write_memory.part.0+0x11c>
  401c4e:	eb c8                	jmp    401c18 <__write_memory.part.0+0xf8>
  401c50:	48 03 35 d1 59 00 00 	add    rsi,QWORD PTR [rip+0x59d1]        # 407628 <the_secs>
  401c57:	41 b8 40 00 00 00    	mov    r8d,0x40
  401c5d:	48 8b 4c 24 20       	mov    rcx,QWORD PTR [rsp+0x20]
  401c62:	48 8b 54 24 38       	mov    rdx,QWORD PTR [rsp+0x38]
  401c67:	49 89 f1             	mov    r9,rsi
  401c6a:	48 89 4e 08          	mov    QWORD PTR [rsi+0x8],rcx
  401c6e:	48 89 56 10          	mov    QWORD PTR [rsi+0x10],rdx
  401c72:	ff 15 0c 66 00 00    	call   QWORD PTR [rip+0x660c]        # 408284 <__imp_VirtualProtect>
  401c78:	85 c0                	test   eax,eax
  401c7a:	0f 85 6e ff ff ff    	jne    401bee <__write_memory.part.0+0xce>
  401c80:	ff 15 7e 65 00 00    	call   QWORD PTR [rip+0x657e]        # 408204 <__imp_GetLastError>
  401c86:	48 8d 0d ab 25 00 00 	lea    rcx,[rip+0x25ab]        # 404238 <.rdata+0x78>
  401c8d:	89 c2                	mov    edx,eax
  401c8f:	e8 1c 10 00 00       	call   402cb0 <__report_error>
  401c94:	8b 45 00             	mov    eax,DWORD PTR [rbp+0x0]
  401c97:	89 ff                	mov    edi,edi
  401c99:	89 03                	mov    DWORD PTR [rbx],eax
  401c9b:	8b 44 3d fc          	mov    eax,DWORD PTR [rbp+rdi*1-0x4]
  401c9f:	89 44 3b fc          	mov    DWORD PTR [rbx+rdi*1-0x4],eax
  401ca3:	e9 70 ff ff ff       	jmp    401c18 <__write_memory.part.0+0xf8>
  401ca8:	31 f6                	xor    esi,esi
  401caa:	e9 c8 fe ff ff       	jmp    401b77 <__write_memory.part.0+0x57>
  401caf:	89 ff                	mov    edi,edi
  401cb1:	0f b7 44 3d fe       	movzx  eax,WORD PTR [rbp+rdi*1-0x2]
  401cb6:	66 89 44 3b fe       	mov    WORD PTR [rbx+rdi*1-0x2],ax
  401cbb:	e9 58 ff ff ff       	jmp    401c18 <__write_memory.part.0+0xf8>
  401cc0:	48 8b 05 61 59 00 00 	mov    rax,QWORD PTR [rip+0x5961]        # 407628 <the_secs>
  401cc7:	48 8d 0d 32 25 00 00 	lea    rcx,[rip+0x2532]        # 404200 <.rdata+0x40>
  401cce:	41 8b 54 24 08       	mov    edx,DWORD PTR [r12+0x8]
  401cd3:	4c 8b 44 30 18       	mov    r8,QWORD PTR [rax+rsi*1+0x18]
  401cd8:	e8 d3 0f 00 00       	call   402cb0 <__report_error>
  401cdd:	48 8d 0d fc 24 00 00 	lea    rcx,[rip+0x24fc]        # 4041e0 <.rdata+0x20>
  401ce4:	48 89 da             	mov    rdx,rbx
  401ce7:	e8 c4 0f 00 00       	call   402cb0 <__report_error>
  401cec:	90                   	nop
  401ced:	0f 1f 00             	nop    DWORD PTR [rax]

0000000000401cf0 <_pei386_runtime_relocator>:
  401cf0:	55                   	push   rbp
  401cf1:	41 57                	push   r15
  401cf3:	41 56                	push   r14
  401cf5:	41 55                	push   r13
  401cf7:	41 54                	push   r12
  401cf9:	57                   	push   rdi
  401cfa:	56                   	push   rsi
  401cfb:	53                   	push   rbx
  401cfc:	48 83 ec 38          	sub    rsp,0x38
  401d00:	48 8d ac 24 80 00 00 	lea    rbp,[rsp+0x80]
  401d07:	00 
  401d08:	8b 1d 12 59 00 00    	mov    ebx,DWORD PTR [rip+0x5912]        # 407620 <was_init.95174>
  401d0e:	85 db                	test   ebx,ebx
  401d10:	74 11                	je     401d23 <_pei386_runtime_relocator+0x33>
  401d12:	48 8d 65 b8          	lea    rsp,[rbp-0x48]
  401d16:	5b                   	pop    rbx
  401d17:	5e                   	pop    rsi
  401d18:	5f                   	pop    rdi
  401d19:	41 5c                	pop    r12
  401d1b:	41 5d                	pop    r13
  401d1d:	41 5e                	pop    r14
  401d1f:	41 5f                	pop    r15
  401d21:	5d                   	pop    rbp
  401d22:	c3                   	ret    
  401d23:	c7 05 f3 58 00 00 01 	mov    DWORD PTR [rip+0x58f3],0x1        # 407620 <was_init.95174>
  401d2a:	00 00 00 
  401d2d:	e8 0e 0b 00 00       	call   402840 <__mingw_GetSectionCount>
  401d32:	48 98                	cdqe   
  401d34:	48 8d 04 80          	lea    rax,[rax+rax*4]
  401d38:	48 8d 04 c5 1e 00 00 	lea    rax,[rax*8+0x1e]
  401d3f:	00 
  401d40:	48 83 e0 f0          	and    rax,0xfffffffffffffff0
  401d44:	e8 37 0d 00 00       	call   402a80 <___chkstk_ms>
  401d49:	4c 8b 25 c0 25 00 00 	mov    r12,QWORD PTR [rip+0x25c0]        # 404310 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST_END__>
  401d50:	c7 05 ca 58 00 00 00 	mov    DWORD PTR [rip+0x58ca],0x0        # 407624 <maxSections>
  401d57:	00 00 00 
  401d5a:	48 8b 35 bf 25 00 00 	mov    rsi,QWORD PTR [rip+0x25bf]        # 404320 <.refptr.__RUNTIME_PSEUDO_RELOC_LIST__>
  401d61:	48 29 c4             	sub    rsp,rax
  401d64:	48 8d 44 24 20       	lea    rax,[rsp+0x20]
  401d69:	48 89 05 b8 58 00 00 	mov    QWORD PTR [rip+0x58b8],rax        # 407628 <the_secs>
  401d70:	4c 89 e0             	mov    rax,r12
  401d73:	48 29 f0             	sub    rax,rsi
  401d76:	48 83 f8 07          	cmp    rax,0x7
  401d7a:	7e 96                	jle    401d12 <_pei386_runtime_relocator+0x22>
  401d7c:	48 83 f8 0b          	cmp    rax,0xb
  401d80:	8b 16                	mov    edx,DWORD PTR [rsi]
  401d82:	0f 8e c8 00 00 00    	jle    401e50 <_pei386_runtime_relocator+0x160>
  401d88:	85 d2                	test   edx,edx
  401d8a:	0f 84 a4 00 00 00    	je     401e34 <_pei386_runtime_relocator+0x144>
  401d90:	4c 39 e6             	cmp    rsi,r12
  401d93:	0f 83 79 ff ff ff    	jae    401d12 <_pei386_runtime_relocator+0x22>
  401d99:	4c 8d 76 08          	lea    r14,[rsi+0x8]
  401d9d:	49 83 c4 07          	add    r12,0x7
  401da1:	4c 8b 2d 98 25 00 00 	mov    r13,QWORD PTR [rip+0x2598]        # 404340 <.refptr.__image_base__>
  401da8:	48 8d 7d a8          	lea    rdi,[rbp-0x58]
  401dac:	4d 29 f4             	sub    r12,r14
  401daf:	49 c1 ec 03          	shr    r12,0x3
  401db3:	4e 8d 64 e6 08       	lea    r12,[rsi+r12*8+0x8]
  401db8:	eb 0a                	jmp    401dc4 <_pei386_runtime_relocator+0xd4>
  401dba:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  401dc0:	49 83 c6 08          	add    r14,0x8
  401dc4:	8b 4e 04             	mov    ecx,DWORD PTR [rsi+0x4]
  401dc7:	41 b8 04 00 00 00    	mov    r8d,0x4
  401dcd:	48 89 fa             	mov    rdx,rdi
  401dd0:	8b 06                	mov    eax,DWORD PTR [rsi]
  401dd2:	4c 89 f6             	mov    rsi,r14
  401dd5:	4c 01 e9             	add    rcx,r13
  401dd8:	03 01                	add    eax,DWORD PTR [rcx]
  401dda:	89 45 a8             	mov    DWORD PTR [rbp-0x58],eax
  401ddd:	e8 3e fd ff ff       	call   401b20 <__write_memory.part.0>
  401de2:	4d 39 e6             	cmp    r14,r12
  401de5:	75 d9                	jne    401dc0 <_pei386_runtime_relocator+0xd0>
  401de7:	8b 05 37 58 00 00    	mov    eax,DWORD PTR [rip+0x5837]        # 407624 <maxSections>
  401ded:	31 f6                	xor    esi,esi
  401def:	4c 8b 25 8e 64 00 00 	mov    r12,QWORD PTR [rip+0x648e]        # 408284 <__imp_VirtualProtect>
  401df6:	85 c0                	test   eax,eax
  401df8:	0f 8e 14 ff ff ff    	jle    401d12 <_pei386_runtime_relocator+0x22>
  401dfe:	66 90                	xchg   ax,ax
  401e00:	48 8b 05 21 58 00 00 	mov    rax,QWORD PTR [rip+0x5821]        # 407628 <the_secs>
  401e07:	48 01 f0             	add    rax,rsi
  401e0a:	44 8b 00             	mov    r8d,DWORD PTR [rax]
  401e0d:	45 85 c0             	test   r8d,r8d
  401e10:	74 0e                	je     401e20 <_pei386_runtime_relocator+0x130>
  401e12:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
  401e16:	49 89 f9             	mov    r9,rdi
  401e19:	48 8b 48 08          	mov    rcx,QWORD PTR [rax+0x8]
  401e1d:	41 ff d4             	call   r12
  401e20:	83 c3 01             	add    ebx,0x1
  401e23:	48 83 c6 28          	add    rsi,0x28
  401e27:	3b 1d f7 57 00 00    	cmp    ebx,DWORD PTR [rip+0x57f7]        # 407624 <maxSections>
  401e2d:	7c d1                	jl     401e00 <_pei386_runtime_relocator+0x110>
  401e2f:	e9 de fe ff ff       	jmp    401d12 <_pei386_runtime_relocator+0x22>
  401e34:	8b 4e 04             	mov    ecx,DWORD PTR [rsi+0x4]
  401e37:	85 c9                	test   ecx,ecx
  401e39:	0f 85 51 ff ff ff    	jne    401d90 <_pei386_runtime_relocator+0xa0>
  401e3f:	8b 56 08             	mov    edx,DWORD PTR [rsi+0x8]
  401e42:	85 d2                	test   edx,edx
  401e44:	75 1d                	jne    401e63 <_pei386_runtime_relocator+0x173>
  401e46:	8b 56 0c             	mov    edx,DWORD PTR [rsi+0xc]
  401e49:	48 83 c6 0c          	add    rsi,0xc
  401e4d:	0f 1f 00             	nop    DWORD PTR [rax]
  401e50:	85 d2                	test   edx,edx
  401e52:	0f 85 38 ff ff ff    	jne    401d90 <_pei386_runtime_relocator+0xa0>
  401e58:	8b 46 04             	mov    eax,DWORD PTR [rsi+0x4]
  401e5b:	85 c0                	test   eax,eax
  401e5d:	0f 85 2d ff ff ff    	jne    401d90 <_pei386_runtime_relocator+0xa0>
  401e63:	8b 56 08             	mov    edx,DWORD PTR [rsi+0x8]
  401e66:	83 fa 01             	cmp    edx,0x1
  401e69:	0f 85 2f 01 00 00    	jne    401f9e <_pei386_runtime_relocator+0x2ae>
  401e6f:	4c 8b 2d ca 24 00 00 	mov    r13,QWORD PTR [rip+0x24ca]        # 404340 <.refptr.__image_base__>
  401e76:	48 83 c6 0c          	add    rsi,0xc
  401e7a:	49 bf 00 00 00 00 ff 	movabs r15,0xffffffff00000000
  401e81:	ff ff ff 
  401e84:	4c 8d 75 a8          	lea    r14,[rbp-0x58]
  401e88:	4c 39 e6             	cmp    rsi,r12
  401e8b:	72 48                	jb     401ed5 <_pei386_runtime_relocator+0x1e5>
  401e8d:	e9 80 fe ff ff       	jmp    401d12 <_pei386_runtime_relocator+0x22>
  401e92:	0f 86 b8 00 00 00    	jbe    401f50 <_pei386_runtime_relocator+0x260>
  401e98:	83 fa 20             	cmp    edx,0x20
  401e9b:	0f 84 7f 00 00 00    	je     401f20 <_pei386_runtime_relocator+0x230>
  401ea1:	83 fa 40             	cmp    edx,0x40
  401ea4:	0f 85 e0 00 00 00    	jne    401f8a <_pei386_runtime_relocator+0x29a>
  401eaa:	48 8b 11             	mov    rdx,QWORD PTR [rcx]
  401ead:	41 b8 08 00 00 00    	mov    r8d,0x8
  401eb3:	4c 89 f7             	mov    rdi,r14
  401eb6:	48 29 c2             	sub    rdx,rax
  401eb9:	4c 01 ca             	add    rdx,r9
  401ebc:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
  401ec0:	4c 89 f2             	mov    rdx,r14
  401ec3:	e8 58 fc ff ff       	call   401b20 <__write_memory.part.0>
  401ec8:	48 83 c6 0c          	add    rsi,0xc
  401ecc:	4c 39 e6             	cmp    rsi,r12
  401ecf:	0f 83 12 ff ff ff    	jae    401de7 <_pei386_runtime_relocator+0xf7>
  401ed5:	8b 4e 04             	mov    ecx,DWORD PTR [rsi+0x4]
  401ed8:	8b 06                	mov    eax,DWORD PTR [rsi]
  401eda:	0f b6 56 08          	movzx  edx,BYTE PTR [rsi+0x8]
  401ede:	4c 01 e9             	add    rcx,r13
  401ee1:	4c 01 e8             	add    rax,r13
  401ee4:	83 fa 10             	cmp    edx,0x10
  401ee7:	4c 8b 08             	mov    r9,QWORD PTR [rax]
  401eea:	75 a6                	jne    401e92 <_pei386_runtime_relocator+0x1a2>
  401eec:	44 0f b7 01          	movzx  r8d,WORD PTR [rcx]
  401ef0:	4c 89 f2             	mov    rdx,r14
  401ef3:	4c 89 f7             	mov    rdi,r14
  401ef6:	4d 89 c2             	mov    r10,r8
  401ef9:	49 81 ca 00 00 ff ff 	or     r10,0xffffffffffff0000
  401f00:	66 45 85 c0          	test   r8w,r8w
  401f04:	4d 0f 48 c2          	cmovs  r8,r10
  401f08:	49 29 c0             	sub    r8,rax
  401f0b:	4d 01 c8             	add    r8,r9
  401f0e:	4c 89 45 a8          	mov    QWORD PTR [rbp-0x58],r8
  401f12:	41 b8 02 00 00 00    	mov    r8d,0x2
  401f18:	e8 03 fc ff ff       	call   401b20 <__write_memory.part.0>
  401f1d:	eb a9                	jmp    401ec8 <_pei386_runtime_relocator+0x1d8>
  401f1f:	90                   	nop
  401f20:	8b 11                	mov    edx,DWORD PTR [rcx]
  401f22:	4c 89 f7             	mov    rdi,r14
  401f25:	49 89 d0             	mov    r8,rdx
  401f28:	4c 09 fa             	or     rdx,r15
  401f2b:	45 85 c0             	test   r8d,r8d
  401f2e:	49 0f 49 d0          	cmovns rdx,r8
  401f32:	41 b8 04 00 00 00    	mov    r8d,0x4
  401f38:	48 29 c2             	sub    rdx,rax
  401f3b:	4c 01 ca             	add    rdx,r9
  401f3e:	48 89 55 a8          	mov    QWORD PTR [rbp-0x58],rdx
  401f42:	4c 89 f2             	mov    rdx,r14
  401f45:	e8 d6 fb ff ff       	call   401b20 <__write_memory.part.0>
  401f4a:	e9 79 ff ff ff       	jmp    401ec8 <_pei386_runtime_relocator+0x1d8>
  401f4f:	90                   	nop
  401f50:	83 fa 08             	cmp    edx,0x8
  401f53:	75 35                	jne    401f8a <_pei386_runtime_relocator+0x29a>
  401f55:	44 0f b6 01          	movzx  r8d,BYTE PTR [rcx]
  401f59:	4c 89 f2             	mov    rdx,r14
  401f5c:	4c 89 f7             	mov    rdi,r14
  401f5f:	4d 89 c2             	mov    r10,r8
  401f62:	49 81 ca 00 ff ff ff 	or     r10,0xffffffffffffff00
  401f69:	45 84 c0             	test   r8b,r8b
  401f6c:	4d 0f 48 c2          	cmovs  r8,r10
  401f70:	49 29 c0             	sub    r8,rax
  401f73:	4d 01 c8             	add    r8,r9
  401f76:	4c 89 45 a8          	mov    QWORD PTR [rbp-0x58],r8
  401f7a:	41 b8 01 00 00 00    	mov    r8d,0x1
  401f80:	e8 9b fb ff ff       	call   401b20 <__write_memory.part.0>
  401f85:	e9 3e ff ff ff       	jmp    401ec8 <_pei386_runtime_relocator+0x1d8>
  401f8a:	48 8d 0d 07 23 00 00 	lea    rcx,[rip+0x2307]        # 404298 <.rdata+0xd8>
  401f91:	48 c7 45 a8 00 00 00 	mov    QWORD PTR [rbp-0x58],0x0
  401f98:	00 
  401f99:	e8 12 0d 00 00       	call   402cb0 <__report_error>
  401f9e:	48 8d 0d bb 22 00 00 	lea    rcx,[rip+0x22bb]        # 404260 <.rdata+0xa0>
  401fa5:	e8 06 0d 00 00       	call   402cb0 <__report_error>
  401faa:	90                   	nop
  401fab:	90                   	nop
  401fac:	90                   	nop
  401fad:	90                   	nop
  401fae:	90                   	nop
  401faf:	90                   	nop

0000000000401fb0 <__mingw_SEH_error_handler>:
  401fb0:	48 83 ec 28          	sub    rsp,0x28
  401fb4:	8b 01                	mov    eax,DWORD PTR [rcx]
  401fb6:	3d 91 00 00 c0       	cmp    eax,0xc0000091
  401fbb:	77 63                	ja     402020 <__mingw_SEH_error_handler+0x70>
  401fbd:	3d 8d 00 00 c0       	cmp    eax,0xc000008d
  401fc2:	73 7b                	jae    40203f <__mingw_SEH_error_handler+0x8f>
  401fc4:	3d 08 00 00 c0       	cmp    eax,0xc0000008
  401fc9:	0f 84 05 01 00 00    	je     4020d4 <__mingw_SEH_error_handler+0x124>
  401fcf:	0f 87 cb 00 00 00    	ja     4020a0 <__mingw_SEH_error_handler+0xf0>
  401fd5:	3d 02 00 00 80       	cmp    eax,0x80000002
  401fda:	0f 84 f4 00 00 00    	je     4020d4 <__mingw_SEH_error_handler+0x124>
  401fe0:	3d 05 00 00 c0       	cmp    eax,0xc0000005
  401fe5:	0f 85 c3 00 00 00    	jne    4020ae <__mingw_SEH_error_handler+0xfe>
  401feb:	31 d2                	xor    edx,edx
  401fed:	b9 0b 00 00 00       	mov    ecx,0xb
  401ff2:	e8 e1 0a 00 00       	call   402ad8 <signal>
  401ff7:	48 83 f8 01          	cmp    rax,0x1
  401ffb:	0f 84 2f 01 00 00    	je     402130 <__mingw_SEH_error_handler+0x180>
  402001:	48 85 c0             	test   rax,rax
  402004:	0f 84 3c 01 00 00    	je     402146 <__mingw_SEH_error_handler+0x196>
  40200a:	b9 0b 00 00 00       	mov    ecx,0xb
  40200f:	ff d0                	call   rax
  402011:	31 c0                	xor    eax,eax
  402013:	48 83 c4 28          	add    rsp,0x28
  402017:	c3                   	ret    
  402018:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40201f:	00 
  402020:	3d 94 00 00 c0       	cmp    eax,0xc0000094
  402025:	0f 84 b5 00 00 00    	je     4020e0 <__mingw_SEH_error_handler+0x130>
  40202b:	77 37                	ja     402064 <__mingw_SEH_error_handler+0xb4>
  40202d:	3d 92 00 00 c0       	cmp    eax,0xc0000092
  402032:	0f 84 9c 00 00 00    	je     4020d4 <__mingw_SEH_error_handler+0x124>
  402038:	3d 93 00 00 c0       	cmp    eax,0xc0000093
  40203d:	75 6f                	jne    4020ae <__mingw_SEH_error_handler+0xfe>
  40203f:	31 d2                	xor    edx,edx
  402041:	b9 08 00 00 00       	mov    ecx,0x8
  402046:	e8 8d 0a 00 00       	call   402ad8 <signal>
  40204b:	48 83 f8 01          	cmp    rax,0x1
  40204f:	74 6f                	je     4020c0 <__mingw_SEH_error_handler+0x110>
  402051:	48 85 c0             	test   rax,rax
  402054:	74 58                	je     4020ae <__mingw_SEH_error_handler+0xfe>
  402056:	b9 08 00 00 00       	mov    ecx,0x8
  40205b:	ff d0                	call   rax
  40205d:	31 c0                	xor    eax,eax
  40205f:	48 83 c4 28          	add    rsp,0x28
  402063:	c3                   	ret    
  402064:	3d 95 00 00 c0       	cmp    eax,0xc0000095
  402069:	74 69                	je     4020d4 <__mingw_SEH_error_handler+0x124>
  40206b:	3d 96 00 00 c0       	cmp    eax,0xc0000096
  402070:	75 3c                	jne    4020ae <__mingw_SEH_error_handler+0xfe>
  402072:	31 d2                	xor    edx,edx
  402074:	b9 04 00 00 00       	mov    ecx,0x4
  402079:	e8 5a 0a 00 00       	call   402ad8 <signal>
  40207e:	48 83 f8 01          	cmp    rax,0x1
  402082:	0f 84 88 00 00 00    	je     402110 <__mingw_SEH_error_handler+0x160>
  402088:	48 85 c0             	test   rax,rax
  40208b:	0f 84 b5 00 00 00    	je     402146 <__mingw_SEH_error_handler+0x196>
  402091:	b9 04 00 00 00       	mov    ecx,0x4
  402096:	ff d0                	call   rax
  402098:	31 c0                	xor    eax,eax
  40209a:	48 83 c4 28          	add    rsp,0x28
  40209e:	c3                   	ret    
  40209f:	90                   	nop
  4020a0:	3d 1d 00 00 c0       	cmp    eax,0xc000001d
  4020a5:	74 cb                	je     402072 <__mingw_SEH_error_handler+0xc2>
  4020a7:	3d 8c 00 00 c0       	cmp    eax,0xc000008c
  4020ac:	74 26                	je     4020d4 <__mingw_SEH_error_handler+0x124>
  4020ae:	b8 01 00 00 00       	mov    eax,0x1
  4020b3:	48 83 c4 28          	add    rsp,0x28
  4020b7:	c3                   	ret    
  4020b8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  4020bf:	00 
  4020c0:	ba 01 00 00 00       	mov    edx,0x1
  4020c5:	b9 08 00 00 00       	mov    ecx,0x8
  4020ca:	e8 09 0a 00 00       	call   402ad8 <signal>
  4020cf:	e8 1c fa ff ff       	call   401af0 <_fpreset>
  4020d4:	31 c0                	xor    eax,eax
  4020d6:	48 83 c4 28          	add    rsp,0x28
  4020da:	c3                   	ret    
  4020db:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  4020e0:	31 d2                	xor    edx,edx
  4020e2:	b9 08 00 00 00       	mov    ecx,0x8
  4020e7:	e8 ec 09 00 00       	call   402ad8 <signal>
  4020ec:	48 83 f8 01          	cmp    rax,0x1
  4020f0:	0f 85 5b ff ff ff    	jne    402051 <__mingw_SEH_error_handler+0xa1>
  4020f6:	ba 01 00 00 00       	mov    edx,0x1
  4020fb:	b9 08 00 00 00       	mov    ecx,0x8
  402100:	e8 d3 09 00 00       	call   402ad8 <signal>
  402105:	31 c0                	xor    eax,eax
  402107:	e9 07 ff ff ff       	jmp    402013 <__mingw_SEH_error_handler+0x63>
  40210c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  402110:	ba 01 00 00 00       	mov    edx,0x1
  402115:	b9 04 00 00 00       	mov    ecx,0x4
  40211a:	e8 b9 09 00 00       	call   402ad8 <signal>
  40211f:	31 c0                	xor    eax,eax
  402121:	e9 ed fe ff ff       	jmp    402013 <__mingw_SEH_error_handler+0x63>
  402126:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40212d:	00 00 00 
  402130:	ba 01 00 00 00       	mov    edx,0x1
  402135:	b9 0b 00 00 00       	mov    ecx,0xb
  40213a:	e8 99 09 00 00       	call   402ad8 <signal>
  40213f:	31 c0                	xor    eax,eax
  402141:	e9 cd fe ff ff       	jmp    402013 <__mingw_SEH_error_handler+0x63>
  402146:	b8 04 00 00 00       	mov    eax,0x4
  40214b:	e9 c3 fe ff ff       	jmp    402013 <__mingw_SEH_error_handler+0x63>

0000000000402150 <__mingw_init_ehandler>:
  402150:	41 54                	push   r12
  402152:	55                   	push   rbp
  402153:	57                   	push   rdi
  402154:	56                   	push   rsi
  402155:	53                   	push   rbx
  402156:	48 83 ec 20          	sub    rsp,0x20
  40215a:	e8 91 07 00 00       	call   4028f0 <_GetPEImageBase>
  40215f:	48 89 c5             	mov    rbp,rax
  402162:	8b 05 e0 54 00 00    	mov    eax,DWORD PTR [rip+0x54e0]        # 407648 <was_here.95013>
  402168:	85 c0                	test   eax,eax
  40216a:	75 25                	jne    402191 <__mingw_init_ehandler+0x41>
  40216c:	48 85 ed             	test   rbp,rbp
  40216f:	74 20                	je     402191 <__mingw_init_ehandler+0x41>
  402171:	48 8d 0d 58 21 00 00 	lea    rcx,[rip+0x2158]        # 4042d0 <.rdata>
  402178:	c7 05 c6 54 00 00 01 	mov    DWORD PTR [rip+0x54c6],0x1        # 407648 <was_here.95013>
  40217f:	00 00 00 
  402182:	e8 a9 05 00 00       	call   402730 <_FindPESectionByName>
  402187:	48 85 c0             	test   rax,rax
  40218a:	74 14                	je     4021a0 <__mingw_init_ehandler+0x50>
  40218c:	b8 01 00 00 00       	mov    eax,0x1
  402191:	48 83 c4 20          	add    rsp,0x20
  402195:	5b                   	pop    rbx
  402196:	5e                   	pop    rsi
  402197:	5f                   	pop    rdi
  402198:	5d                   	pop    rbp
  402199:	41 5c                	pop    r12
  40219b:	c3                   	ret    
  40219c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4021a0:	48 8d 1d b9 55 00 00 	lea    rbx,[rip+0x55b9]        # 407760 <emu_pdata>
  4021a7:	b9 30 00 00 00       	mov    ecx,0x30
  4021ac:	31 f6                	xor    esi,esi
  4021ae:	48 8d 15 ab 54 00 00 	lea    rdx,[rip+0x54ab]        # 407660 <emu_xdata>
  4021b5:	48 89 df             	mov    rdi,rbx
  4021b8:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
  4021bb:	4c 8d 25 ee fd ff ff 	lea    r12,[rip+0xfffffffffffffdee]        # 401fb0 <__mingw_SEH_error_handler>
  4021c2:	b9 20 00 00 00       	mov    ecx,0x20
  4021c7:	48 89 d7             	mov    rdi,rdx
  4021ca:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
  4021cd:	49 29 ec             	sub    r12,rbp
  4021d0:	48 89 d7             	mov    rdi,rdx
  4021d3:	eb 2e                	jmp    402203 <__mingw_init_ehandler+0xb3>
  4021d5:	c6 07 09             	mov    BYTE PTR [rdi],0x9
  4021d8:	48 83 c6 01          	add    rsi,0x1
  4021dc:	48 83 c3 0c          	add    rbx,0xc
  4021e0:	44 89 67 04          	mov    DWORD PTR [rdi+0x4],r12d
  4021e4:	8b 48 0c             	mov    ecx,DWORD PTR [rax+0xc]
  4021e7:	89 4b f4             	mov    DWORD PTR [rbx-0xc],ecx
  4021ea:	03 48 08             	add    ecx,DWORD PTR [rax+0x8]
  4021ed:	48 89 f8             	mov    rax,rdi
  4021f0:	48 83 c7 08          	add    rdi,0x8
  4021f4:	48 29 e8             	sub    rax,rbp
  4021f7:	89 43 fc             	mov    DWORD PTR [rbx-0x4],eax
  4021fa:	89 4b f8             	mov    DWORD PTR [rbx-0x8],ecx
  4021fd:	48 83 fe 20          	cmp    rsi,0x20
  402201:	74 32                	je     402235 <__mingw_init_ehandler+0xe5>
  402203:	48 89 f1             	mov    rcx,rsi
  402206:	e8 75 06 00 00       	call   402880 <_FindPESectionExec>
  40220b:	48 85 c0             	test   rax,rax
  40220e:	75 c5                	jne    4021d5 <__mingw_init_ehandler+0x85>
  402210:	48 85 f6             	test   rsi,rsi
  402213:	89 f2                	mov    edx,esi
  402215:	0f 84 71 ff ff ff    	je     40218c <__mingw_init_ehandler+0x3c>
  40221b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  402220:	48 8d 0d 39 55 00 00 	lea    rcx,[rip+0x5539]        # 407760 <emu_pdata>
  402227:	49 89 e8             	mov    r8,rbp
  40222a:	ff 15 0c 60 00 00    	call   QWORD PTR [rip+0x600c]        # 40823c <__imp_RtlAddFunctionTable>
  402230:	e9 57 ff ff ff       	jmp    40218c <__mingw_init_ehandler+0x3c>
  402235:	ba 20 00 00 00       	mov    edx,0x20
  40223a:	eb e4                	jmp    402220 <__mingw_init_ehandler+0xd0>
  40223c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000402240 <_gnu_exception_handler>:
  402240:	53                   	push   rbx
  402241:	48 83 ec 20          	sub    rsp,0x20
  402245:	48 8b 11             	mov    rdx,QWORD PTR [rcx]
  402248:	8b 02                	mov    eax,DWORD PTR [rdx]
  40224a:	48 89 cb             	mov    rbx,rcx
  40224d:	89 c1                	mov    ecx,eax
  40224f:	81 e1 ff ff ff 20    	and    ecx,0x20ffffff
  402255:	81 f9 43 43 47 20    	cmp    ecx,0x20474343
  40225b:	0f 84 bf 00 00 00    	je     402320 <_gnu_exception_handler+0xe0>
  402261:	3d 91 00 00 c0       	cmp    eax,0xc0000091
  402266:	77 68                	ja     4022d0 <_gnu_exception_handler+0x90>
  402268:	3d 8d 00 00 c0       	cmp    eax,0xc000008d
  40226d:	73 7c                	jae    4022eb <_gnu_exception_handler+0xab>
  40226f:	3d 08 00 00 c0       	cmp    eax,0xc0000008
  402274:	0f 84 b0 00 00 00    	je     40232a <_gnu_exception_handler+0xea>
  40227a:	0f 87 f4 00 00 00    	ja     402374 <_gnu_exception_handler+0x134>
  402280:	3d 02 00 00 80       	cmp    eax,0x80000002
  402285:	0f 84 9f 00 00 00    	je     40232a <_gnu_exception_handler+0xea>
  40228b:	3d 05 00 00 c0       	cmp    eax,0xc0000005
  402290:	75 1f                	jne    4022b1 <_gnu_exception_handler+0x71>
  402292:	31 d2                	xor    edx,edx
  402294:	b9 0b 00 00 00       	mov    ecx,0xb
  402299:	e8 3a 08 00 00       	call   402ad8 <signal>
  40229e:	48 83 f8 01          	cmp    rax,0x1
  4022a2:	0f 84 51 01 00 00    	je     4023f9 <_gnu_exception_handler+0x1b9>
  4022a8:	48 85 c0             	test   rax,rax
  4022ab:	0f 85 0f 01 00 00    	jne    4023c0 <_gnu_exception_handler+0x180>
  4022b1:	48 8b 05 88 53 00 00 	mov    rax,QWORD PTR [rip+0x5388]        # 407640 <__mingw_oldexcpt_handler>
  4022b8:	48 85 c0             	test   rax,rax
  4022bb:	0f 84 10 01 00 00    	je     4023d1 <_gnu_exception_handler+0x191>
  4022c1:	48 89 d9             	mov    rcx,rbx
  4022c4:	48 83 c4 20          	add    rsp,0x20
  4022c8:	5b                   	pop    rbx
  4022c9:	48 ff e0             	rex.W jmp rax
  4022cc:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4022d0:	3d 94 00 00 c0       	cmp    eax,0xc0000094
  4022d5:	0f 84 b5 00 00 00    	je     402390 <_gnu_exception_handler+0x150>
  4022db:	77 58                	ja     402335 <_gnu_exception_handler+0xf5>
  4022dd:	3d 92 00 00 c0       	cmp    eax,0xc0000092
  4022e2:	74 46                	je     40232a <_gnu_exception_handler+0xea>
  4022e4:	3d 93 00 00 c0       	cmp    eax,0xc0000093
  4022e9:	75 c6                	jne    4022b1 <_gnu_exception_handler+0x71>
  4022eb:	31 d2                	xor    edx,edx
  4022ed:	b9 08 00 00 00       	mov    ecx,0x8
  4022f2:	e8 e1 07 00 00       	call   402ad8 <signal>
  4022f7:	48 83 f8 01          	cmp    rax,0x1
  4022fb:	0f 84 df 00 00 00    	je     4023e0 <_gnu_exception_handler+0x1a0>
  402301:	48 85 c0             	test   rax,rax
  402304:	74 ab                	je     4022b1 <_gnu_exception_handler+0x71>
  402306:	b9 08 00 00 00       	mov    ecx,0x8
  40230b:	ff d0                	call   rax
  40230d:	b8 ff ff ff ff       	mov    eax,0xffffffff
  402312:	48 83 c4 20          	add    rsp,0x20
  402316:	5b                   	pop    rbx
  402317:	c3                   	ret    
  402318:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40231f:	00 
  402320:	f6 42 04 01          	test   BYTE PTR [rdx+0x4],0x1
  402324:	0f 85 37 ff ff ff    	jne    402261 <_gnu_exception_handler+0x21>
  40232a:	b8 ff ff ff ff       	mov    eax,0xffffffff
  40232f:	48 83 c4 20          	add    rsp,0x20
  402333:	5b                   	pop    rbx
  402334:	c3                   	ret    
  402335:	3d 95 00 00 c0       	cmp    eax,0xc0000095
  40233a:	74 ee                	je     40232a <_gnu_exception_handler+0xea>
  40233c:	3d 96 00 00 c0       	cmp    eax,0xc0000096
  402341:	0f 85 6a ff ff ff    	jne    4022b1 <_gnu_exception_handler+0x71>
  402347:	31 d2                	xor    edx,edx
  402349:	b9 04 00 00 00       	mov    ecx,0x4
  40234e:	e8 85 07 00 00       	call   402ad8 <signal>
  402353:	48 83 f8 01          	cmp    rax,0x1
  402357:	0f 84 b3 00 00 00    	je     402410 <_gnu_exception_handler+0x1d0>
  40235d:	48 85 c0             	test   rax,rax
  402360:	0f 84 4b ff ff ff    	je     4022b1 <_gnu_exception_handler+0x71>
  402366:	b9 04 00 00 00       	mov    ecx,0x4
  40236b:	ff d0                	call   rax
  40236d:	b8 ff ff ff ff       	mov    eax,0xffffffff
  402372:	eb 9e                	jmp    402312 <_gnu_exception_handler+0xd2>
  402374:	3d 1d 00 00 c0       	cmp    eax,0xc000001d
  402379:	74 cc                	je     402347 <_gnu_exception_handler+0x107>
  40237b:	3d 8c 00 00 c0       	cmp    eax,0xc000008c
  402380:	0f 85 2b ff ff ff    	jne    4022b1 <_gnu_exception_handler+0x71>
  402386:	eb a2                	jmp    40232a <_gnu_exception_handler+0xea>
  402388:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40238f:	00 
  402390:	31 d2                	xor    edx,edx
  402392:	b9 08 00 00 00       	mov    ecx,0x8
  402397:	e8 3c 07 00 00       	call   402ad8 <signal>
  40239c:	48 83 f8 01          	cmp    rax,0x1
  4023a0:	0f 85 5b ff ff ff    	jne    402301 <_gnu_exception_handler+0xc1>
  4023a6:	ba 01 00 00 00       	mov    edx,0x1
  4023ab:	b9 08 00 00 00       	mov    ecx,0x8
  4023b0:	e8 23 07 00 00       	call   402ad8 <signal>
  4023b5:	b8 ff ff ff ff       	mov    eax,0xffffffff
  4023ba:	e9 53 ff ff ff       	jmp    402312 <_gnu_exception_handler+0xd2>
  4023bf:	90                   	nop
  4023c0:	b9 0b 00 00 00       	mov    ecx,0xb
  4023c5:	ff d0                	call   rax
  4023c7:	b8 ff ff ff ff       	mov    eax,0xffffffff
  4023cc:	e9 41 ff ff ff       	jmp    402312 <_gnu_exception_handler+0xd2>
  4023d1:	31 c0                	xor    eax,eax
  4023d3:	e9 3a ff ff ff       	jmp    402312 <_gnu_exception_handler+0xd2>
  4023d8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  4023df:	00 
  4023e0:	ba 01 00 00 00       	mov    edx,0x1
  4023e5:	b9 08 00 00 00       	mov    ecx,0x8
  4023ea:	e8 e9 06 00 00       	call   402ad8 <signal>
  4023ef:	e8 fc f6 ff ff       	call   401af0 <_fpreset>
  4023f4:	e9 31 ff ff ff       	jmp    40232a <_gnu_exception_handler+0xea>
  4023f9:	ba 01 00 00 00       	mov    edx,0x1
  4023fe:	b9 0b 00 00 00       	mov    ecx,0xb
  402403:	e8 d0 06 00 00       	call   402ad8 <signal>
  402408:	83 c8 ff             	or     eax,0xffffffff
  40240b:	e9 02 ff ff ff       	jmp    402312 <_gnu_exception_handler+0xd2>
  402410:	ba 01 00 00 00       	mov    edx,0x1
  402415:	b9 04 00 00 00       	mov    ecx,0x4
  40241a:	e8 b9 06 00 00       	call   402ad8 <signal>
  40241f:	83 c8 ff             	or     eax,0xffffffff
  402422:	e9 eb fe ff ff       	jmp    402312 <_gnu_exception_handler+0xd2>
  402427:	90                   	nop
  402428:	90                   	nop
  402429:	90                   	nop
  40242a:	90                   	nop
  40242b:	90                   	nop
  40242c:	90                   	nop
  40242d:	90                   	nop
  40242e:	90                   	nop
  40242f:	90                   	nop

0000000000402430 <__mingwthr_run_key_dtors.part.0>:
  402430:	55                   	push   rbp
  402431:	57                   	push   rdi
  402432:	56                   	push   rsi
  402433:	53                   	push   rbx
  402434:	48 83 ec 28          	sub    rsp,0x28
  402438:	48 8d 0d c1 54 00 00 	lea    rcx,[rip+0x54c1]        # 407900 <__mingwthr_cs>
  40243f:	ff 15 9f 5d 00 00    	call   QWORD PTR [rip+0x5d9f]        # 4081e4 <__imp_EnterCriticalSection>
  402445:	48 8b 1d 94 54 00 00 	mov    rbx,QWORD PTR [rip+0x5494]        # 4078e0 <key_dtor_list>
  40244c:	48 85 db             	test   rbx,rbx
  40244f:	74 33                	je     402484 <__mingwthr_run_key_dtors.part.0+0x54>
  402451:	48 8b 2d 1c 5e 00 00 	mov    rbp,QWORD PTR [rip+0x5e1c]        # 408274 <__imp_TlsGetValue>
  402458:	48 8b 3d a5 5d 00 00 	mov    rdi,QWORD PTR [rip+0x5da5]        # 408204 <__imp_GetLastError>
  40245f:	90                   	nop
  402460:	8b 0b                	mov    ecx,DWORD PTR [rbx]
  402462:	ff d5                	call   rbp
  402464:	48 89 c6             	mov    rsi,rax
  402467:	ff d7                	call   rdi
  402469:	85 c0                	test   eax,eax
  40246b:	75 0e                	jne    40247b <__mingwthr_run_key_dtors.part.0+0x4b>
  40246d:	48 85 f6             	test   rsi,rsi
  402470:	74 09                	je     40247b <__mingwthr_run_key_dtors.part.0+0x4b>
  402472:	48 8b 43 08          	mov    rax,QWORD PTR [rbx+0x8]
  402476:	48 89 f1             	mov    rcx,rsi
  402479:	ff d0                	call   rax
  40247b:	48 8b 5b 10          	mov    rbx,QWORD PTR [rbx+0x10]
  40247f:	48 85 db             	test   rbx,rbx
  402482:	75 dc                	jne    402460 <__mingwthr_run_key_dtors.part.0+0x30>
  402484:	48 8d 0d 75 54 00 00 	lea    rcx,[rip+0x5475]        # 407900 <__mingwthr_cs>
  40248b:	48 83 c4 28          	add    rsp,0x28
  40248f:	5b                   	pop    rbx
  402490:	5e                   	pop    rsi
  402491:	5f                   	pop    rdi
  402492:	5d                   	pop    rbp
  402493:	48 ff 25 92 5d 00 00 	rex.W jmp QWORD PTR [rip+0x5d92]        # 40822c <__imp_LeaveCriticalSection>
  40249a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

00000000004024a0 <___w64_mingwthr_add_key_dtor>:
  4024a0:	55                   	push   rbp
  4024a1:	57                   	push   rdi
  4024a2:	56                   	push   rsi
  4024a3:	53                   	push   rbx
  4024a4:	48 83 ec 28          	sub    rsp,0x28
  4024a8:	8b 05 3a 54 00 00    	mov    eax,DWORD PTR [rip+0x543a]        # 4078e8 <__mingwthr_cs_init>
  4024ae:	31 f6                	xor    esi,esi
  4024b0:	85 c0                	test   eax,eax
  4024b2:	89 cd                	mov    ebp,ecx
  4024b4:	48 89 d7             	mov    rdi,rdx
  4024b7:	75 0b                	jne    4024c4 <___w64_mingwthr_add_key_dtor+0x24>
  4024b9:	89 f0                	mov    eax,esi
  4024bb:	48 83 c4 28          	add    rsp,0x28
  4024bf:	5b                   	pop    rbx
  4024c0:	5e                   	pop    rsi
  4024c1:	5f                   	pop    rdi
  4024c2:	5d                   	pop    rbp
  4024c3:	c3                   	ret    
  4024c4:	ba 18 00 00 00       	mov    edx,0x18
  4024c9:	b9 01 00 00 00       	mov    ecx,0x1
  4024ce:	e8 4d 06 00 00       	call   402b20 <calloc>
  4024d3:	48 85 c0             	test   rax,rax
  4024d6:	48 89 c3             	mov    rbx,rax
  4024d9:	74 3d                	je     402518 <___w64_mingwthr_add_key_dtor+0x78>
  4024db:	89 28                	mov    DWORD PTR [rax],ebp
  4024dd:	48 8d 0d 1c 54 00 00 	lea    rcx,[rip+0x541c]        # 407900 <__mingwthr_cs>
  4024e4:	48 89 78 08          	mov    QWORD PTR [rax+0x8],rdi
  4024e8:	ff 15 f6 5c 00 00    	call   QWORD PTR [rip+0x5cf6]        # 4081e4 <__imp_EnterCriticalSection>
  4024ee:	48 8b 05 eb 53 00 00 	mov    rax,QWORD PTR [rip+0x53eb]        # 4078e0 <key_dtor_list>
  4024f5:	48 8d 0d 04 54 00 00 	lea    rcx,[rip+0x5404]        # 407900 <__mingwthr_cs>
  4024fc:	48 89 1d dd 53 00 00 	mov    QWORD PTR [rip+0x53dd],rbx        # 4078e0 <key_dtor_list>
  402503:	48 89 43 10          	mov    QWORD PTR [rbx+0x10],rax
  402507:	ff 15 1f 5d 00 00    	call   QWORD PTR [rip+0x5d1f]        # 40822c <__imp_LeaveCriticalSection>
  40250d:	89 f0                	mov    eax,esi
  40250f:	48 83 c4 28          	add    rsp,0x28
  402513:	5b                   	pop    rbx
  402514:	5e                   	pop    rsi
  402515:	5f                   	pop    rdi
  402516:	5d                   	pop    rbp
  402517:	c3                   	ret    
  402518:	be ff ff ff ff       	mov    esi,0xffffffff
  40251d:	eb 9a                	jmp    4024b9 <___w64_mingwthr_add_key_dtor+0x19>
  40251f:	90                   	nop

0000000000402520 <___w64_mingwthr_remove_key_dtor>:
  402520:	53                   	push   rbx
  402521:	48 83 ec 20          	sub    rsp,0x20
  402525:	8b 05 bd 53 00 00    	mov    eax,DWORD PTR [rip+0x53bd]        # 4078e8 <__mingwthr_cs_init>
  40252b:	85 c0                	test   eax,eax
  40252d:	89 cb                	mov    ebx,ecx
  40252f:	75 0f                	jne    402540 <___w64_mingwthr_remove_key_dtor+0x20>
  402531:	31 c0                	xor    eax,eax
  402533:	48 83 c4 20          	add    rsp,0x20
  402537:	5b                   	pop    rbx
  402538:	c3                   	ret    
  402539:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
  402540:	48 8d 0d b9 53 00 00 	lea    rcx,[rip+0x53b9]        # 407900 <__mingwthr_cs>
  402547:	ff 15 97 5c 00 00    	call   QWORD PTR [rip+0x5c97]        # 4081e4 <__imp_EnterCriticalSection>
  40254d:	48 8b 05 8c 53 00 00 	mov    rax,QWORD PTR [rip+0x538c]        # 4078e0 <key_dtor_list>
  402554:	48 85 c0             	test   rax,rax
  402557:	74 1a                	je     402573 <___w64_mingwthr_remove_key_dtor+0x53>
  402559:	8b 10                	mov    edx,DWORD PTR [rax]
  40255b:	39 d3                	cmp    ebx,edx
  40255d:	75 0b                	jne    40256a <___w64_mingwthr_remove_key_dtor+0x4a>
  40255f:	eb 4f                	jmp    4025b0 <___w64_mingwthr_remove_key_dtor+0x90>
  402561:	8b 11                	mov    edx,DWORD PTR [rcx]
  402563:	39 da                	cmp    edx,ebx
  402565:	74 29                	je     402590 <___w64_mingwthr_remove_key_dtor+0x70>
  402567:	48 89 c8             	mov    rax,rcx
  40256a:	48 8b 48 10          	mov    rcx,QWORD PTR [rax+0x10]
  40256e:	48 85 c9             	test   rcx,rcx
  402571:	75 ee                	jne    402561 <___w64_mingwthr_remove_key_dtor+0x41>
  402573:	48 8d 0d 86 53 00 00 	lea    rcx,[rip+0x5386]        # 407900 <__mingwthr_cs>
  40257a:	ff 15 ac 5c 00 00    	call   QWORD PTR [rip+0x5cac]        # 40822c <__imp_LeaveCriticalSection>
  402580:	31 c0                	xor    eax,eax
  402582:	48 83 c4 20          	add    rsp,0x20
  402586:	5b                   	pop    rbx
  402587:	c3                   	ret    
  402588:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40258f:	00 
  402590:	48 8b 51 10          	mov    rdx,QWORD PTR [rcx+0x10]
  402594:	48 89 50 10          	mov    QWORD PTR [rax+0x10],rdx
  402598:	e8 6b 05 00 00       	call   402b08 <free>
  40259d:	48 8d 0d 5c 53 00 00 	lea    rcx,[rip+0x535c]        # 407900 <__mingwthr_cs>
  4025a4:	ff 15 82 5c 00 00    	call   QWORD PTR [rip+0x5c82]        # 40822c <__imp_LeaveCriticalSection>
  4025aa:	eb d4                	jmp    402580 <___w64_mingwthr_remove_key_dtor+0x60>
  4025ac:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4025b0:	48 8b 50 10          	mov    rdx,QWORD PTR [rax+0x10]
  4025b4:	48 89 c1             	mov    rcx,rax
  4025b7:	48 89 15 22 53 00 00 	mov    QWORD PTR [rip+0x5322],rdx        # 4078e0 <key_dtor_list>
  4025be:	eb d8                	jmp    402598 <___w64_mingwthr_remove_key_dtor+0x78>

00000000004025c0 <__mingw_TLScallback>:
  4025c0:	53                   	push   rbx
  4025c1:	48 83 ec 20          	sub    rsp,0x20
  4025c5:	83 fa 01             	cmp    edx,0x1
  4025c8:	0f 84 92 00 00 00    	je     402660 <__mingw_TLScallback+0xa0>
  4025ce:	72 30                	jb     402600 <__mingw_TLScallback+0x40>
  4025d0:	83 fa 02             	cmp    edx,0x2
  4025d3:	74 1b                	je     4025f0 <__mingw_TLScallback+0x30>
  4025d5:	83 fa 03             	cmp    edx,0x3
  4025d8:	75 1b                	jne    4025f5 <__mingw_TLScallback+0x35>
  4025da:	8b 05 08 53 00 00    	mov    eax,DWORD PTR [rip+0x5308]        # 4078e8 <__mingwthr_cs_init>
  4025e0:	85 c0                	test   eax,eax
  4025e2:	74 11                	je     4025f5 <__mingw_TLScallback+0x35>
  4025e4:	e8 47 fe ff ff       	call   402430 <__mingwthr_run_key_dtors.part.0>
  4025e9:	eb 0a                	jmp    4025f5 <__mingw_TLScallback+0x35>
  4025eb:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  4025f0:	e8 fb f4 ff ff       	call   401af0 <_fpreset>
  4025f5:	b8 01 00 00 00       	mov    eax,0x1
  4025fa:	48 83 c4 20          	add    rsp,0x20
  4025fe:	5b                   	pop    rbx
  4025ff:	c3                   	ret    
  402600:	8b 05 e2 52 00 00    	mov    eax,DWORD PTR [rip+0x52e2]        # 4078e8 <__mingwthr_cs_init>
  402606:	85 c0                	test   eax,eax
  402608:	0f 85 82 00 00 00    	jne    402690 <__mingw_TLScallback+0xd0>
  40260e:	8b 05 d4 52 00 00    	mov    eax,DWORD PTR [rip+0x52d4]        # 4078e8 <__mingwthr_cs_init>
  402614:	83 f8 01             	cmp    eax,0x1
  402617:	75 dc                	jne    4025f5 <__mingw_TLScallback+0x35>
  402619:	48 8b 0d c0 52 00 00 	mov    rcx,QWORD PTR [rip+0x52c0]        # 4078e0 <key_dtor_list>
  402620:	48 85 c9             	test   rcx,rcx
  402623:	74 11                	je     402636 <__mingw_TLScallback+0x76>
  402625:	48 8b 59 10          	mov    rbx,QWORD PTR [rcx+0x10]
  402629:	e8 da 04 00 00       	call   402b08 <free>
  40262e:	48 85 db             	test   rbx,rbx
  402631:	48 89 d9             	mov    rcx,rbx
  402634:	75 ef                	jne    402625 <__mingw_TLScallback+0x65>
  402636:	48 8d 0d c3 52 00 00 	lea    rcx,[rip+0x52c3]        # 407900 <__mingwthr_cs>
  40263d:	48 c7 05 98 52 00 00 	mov    QWORD PTR [rip+0x5298],0x0        # 4078e0 <key_dtor_list>
  402644:	00 00 00 00 
  402648:	c7 05 96 52 00 00 00 	mov    DWORD PTR [rip+0x5296],0x0        # 4078e8 <__mingwthr_cs_init>
  40264f:	00 00 00 
  402652:	ff 15 84 5b 00 00    	call   QWORD PTR [rip+0x5b84]        # 4081dc <__IAT_start__>
  402658:	eb 9b                	jmp    4025f5 <__mingw_TLScallback+0x35>
  40265a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  402660:	8b 05 82 52 00 00    	mov    eax,DWORD PTR [rip+0x5282]        # 4078e8 <__mingwthr_cs_init>
  402666:	85 c0                	test   eax,eax
  402668:	74 16                	je     402680 <__mingw_TLScallback+0xc0>
  40266a:	c7 05 74 52 00 00 01 	mov    DWORD PTR [rip+0x5274],0x1        # 4078e8 <__mingwthr_cs_init>
  402671:	00 00 00 
  402674:	b8 01 00 00 00       	mov    eax,0x1
  402679:	48 83 c4 20          	add    rsp,0x20
  40267d:	5b                   	pop    rbx
  40267e:	c3                   	ret    
  40267f:	90                   	nop
  402680:	48 8d 0d 79 52 00 00 	lea    rcx,[rip+0x5279]        # 407900 <__mingwthr_cs>
  402687:	ff 15 97 5b 00 00    	call   QWORD PTR [rip+0x5b97]        # 408224 <__imp_InitializeCriticalSection>
  40268d:	eb db                	jmp    40266a <__mingw_TLScallback+0xaa>
  40268f:	90                   	nop
  402690:	e8 9b fd ff ff       	call   402430 <__mingwthr_run_key_dtors.part.0>
  402695:	e9 74 ff ff ff       	jmp    40260e <__mingw_TLScallback+0x4e>
  40269a:	90                   	nop
  40269b:	90                   	nop
  40269c:	90                   	nop
  40269d:	90                   	nop
  40269e:	90                   	nop
  40269f:	90                   	nop

00000000004026a0 <_ValidateImageBase.part.0>:
  4026a0:	48 63 41 3c          	movsxd rax,DWORD PTR [rcx+0x3c]
  4026a4:	48 01 c1             	add    rcx,rax
  4026a7:	31 c0                	xor    eax,eax
  4026a9:	81 39 50 45 00 00    	cmp    DWORD PTR [rcx],0x4550
  4026af:	74 01                	je     4026b2 <_ValidateImageBase.part.0+0x12>
  4026b1:	c3                   	ret    
  4026b2:	31 c0                	xor    eax,eax
  4026b4:	66 81 79 18 0b 02    	cmp    WORD PTR [rcx+0x18],0x20b
  4026ba:	0f 94 c0             	sete   al
  4026bd:	c3                   	ret    
  4026be:	66 90                	xchg   ax,ax

00000000004026c0 <_ValidateImageBase>:
  4026c0:	66 81 39 4d 5a       	cmp    WORD PTR [rcx],0x5a4d
  4026c5:	74 09                	je     4026d0 <_ValidateImageBase+0x10>
  4026c7:	31 c0                	xor    eax,eax
  4026c9:	c3                   	ret    
  4026ca:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  4026d0:	eb ce                	jmp    4026a0 <_ValidateImageBase.part.0>
  4026d2:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  4026d6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4026dd:	00 00 00 

00000000004026e0 <_FindPESection>:
  4026e0:	48 63 41 3c          	movsxd rax,DWORD PTR [rcx+0x3c]
  4026e4:	48 01 c1             	add    rcx,rax
  4026e7:	0f b7 41 14          	movzx  eax,WORD PTR [rcx+0x14]
  4026eb:	48 8d 44 01 18       	lea    rax,[rcx+rax*1+0x18]
  4026f0:	0f b7 49 06          	movzx  ecx,WORD PTR [rcx+0x6]
  4026f4:	85 c9                	test   ecx,ecx
  4026f6:	74 29                	je     402721 <_FindPESection+0x41>
  4026f8:	83 e9 01             	sub    ecx,0x1
  4026fb:	48 8d 0c 89          	lea    rcx,[rcx+rcx*4]
  4026ff:	4c 8d 4c c8 28       	lea    r9,[rax+rcx*8+0x28]
  402704:	44 8b 40 0c          	mov    r8d,DWORD PTR [rax+0xc]
  402708:	49 39 d0             	cmp    r8,rdx
  40270b:	4c 89 c1             	mov    rcx,r8
  40270e:	77 08                	ja     402718 <_FindPESection+0x38>
  402710:	03 48 08             	add    ecx,DWORD PTR [rax+0x8]
  402713:	48 39 d1             	cmp    rcx,rdx
  402716:	77 0b                	ja     402723 <_FindPESection+0x43>
  402718:	48 83 c0 28          	add    rax,0x28
  40271c:	4c 39 c8             	cmp    rax,r9
  40271f:	75 e3                	jne    402704 <_FindPESection+0x24>
  402721:	31 c0                	xor    eax,eax
  402723:	c3                   	ret    
  402724:	66 90                	xchg   ax,ax
  402726:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40272d:	00 00 00 

0000000000402730 <_FindPESectionByName>:
  402730:	57                   	push   rdi
  402731:	56                   	push   rsi
  402732:	53                   	push   rbx
  402733:	48 83 ec 20          	sub    rsp,0x20
  402737:	48 89 ce             	mov    rsi,rcx
  40273a:	e8 91 03 00 00       	call   402ad0 <strlen>
  40273f:	48 83 f8 08          	cmp    rax,0x8
  402743:	77 6b                	ja     4027b0 <_FindPESectionByName+0x80>
  402745:	48 8b 15 f4 1b 00 00 	mov    rdx,QWORD PTR [rip+0x1bf4]        # 404340 <.refptr.__image_base__>
  40274c:	66 81 3a 4d 5a       	cmp    WORD PTR [rdx],0x5a4d
  402751:	75 5d                	jne    4027b0 <_FindPESectionByName+0x80>
  402753:	48 89 d1             	mov    rcx,rdx
  402756:	e8 45 ff ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  40275b:	85 c0                	test   eax,eax
  40275d:	74 51                	je     4027b0 <_FindPESectionByName+0x80>
  40275f:	48 63 4a 3c          	movsxd rcx,DWORD PTR [rdx+0x3c]
  402763:	48 01 d1             	add    rcx,rdx
  402766:	0f b7 41 14          	movzx  eax,WORD PTR [rcx+0x14]
  40276a:	48 8d 5c 01 18       	lea    rbx,[rcx+rax*1+0x18]
  40276f:	0f b7 41 06          	movzx  eax,WORD PTR [rcx+0x6]
  402773:	85 c0                	test   eax,eax
  402775:	74 39                	je     4027b0 <_FindPESectionByName+0x80>
  402777:	83 e8 01             	sub    eax,0x1
  40277a:	48 8d 04 80          	lea    rax,[rax+rax*4]
  40277e:	48 8d 7c c3 28       	lea    rdi,[rbx+rax*8+0x28]
  402783:	eb 09                	jmp    40278e <_FindPESectionByName+0x5e>
  402785:	48 83 c3 28          	add    rbx,0x28
  402789:	48 39 fb             	cmp    rbx,rdi
  40278c:	74 22                	je     4027b0 <_FindPESectionByName+0x80>
  40278e:	41 b8 08 00 00 00    	mov    r8d,0x8
  402794:	48 89 f2             	mov    rdx,rsi
  402797:	48 89 d9             	mov    rcx,rbx
  40279a:	e8 29 03 00 00       	call   402ac8 <strncmp>
  40279f:	85 c0                	test   eax,eax
  4027a1:	75 e2                	jne    402785 <_FindPESectionByName+0x55>
  4027a3:	48 89 d8             	mov    rax,rbx
  4027a6:	48 83 c4 20          	add    rsp,0x20
  4027aa:	5b                   	pop    rbx
  4027ab:	5e                   	pop    rsi
  4027ac:	5f                   	pop    rdi
  4027ad:	c3                   	ret    
  4027ae:	66 90                	xchg   ax,ax
  4027b0:	31 db                	xor    ebx,ebx
  4027b2:	48 89 d8             	mov    rax,rbx
  4027b5:	48 83 c4 20          	add    rsp,0x20
  4027b9:	5b                   	pop    rbx
  4027ba:	5e                   	pop    rsi
  4027bb:	5f                   	pop    rdi
  4027bc:	c3                   	ret    
  4027bd:	0f 1f 00             	nop    DWORD PTR [rax]

00000000004027c0 <__mingw_GetSectionForAddress>:
  4027c0:	48 83 ec 28          	sub    rsp,0x28
  4027c4:	4c 8b 05 75 1b 00 00 	mov    r8,QWORD PTR [rip+0x1b75]        # 404340 <.refptr.__image_base__>
  4027cb:	66 41 81 38 4d 5a    	cmp    WORD PTR [r8],0x5a4d
  4027d1:	48 89 ca             	mov    rdx,rcx
  4027d4:	75 57                	jne    40282d <__mingw_GetSectionForAddress+0x6d>
  4027d6:	4c 89 c1             	mov    rcx,r8
  4027d9:	e8 c2 fe ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  4027de:	85 c0                	test   eax,eax
  4027e0:	74 4b                	je     40282d <__mingw_GetSectionForAddress+0x6d>
  4027e2:	49 63 40 3c          	movsxd rax,DWORD PTR [r8+0x3c]
  4027e6:	48 89 d1             	mov    rcx,rdx
  4027e9:	4c 29 c1             	sub    rcx,r8
  4027ec:	49 01 c0             	add    r8,rax
  4027ef:	41 0f b7 50 06       	movzx  edx,WORD PTR [r8+0x6]
  4027f4:	41 0f b7 40 14       	movzx  eax,WORD PTR [r8+0x14]
  4027f9:	85 d2                	test   edx,edx
  4027fb:	49 8d 44 00 18       	lea    rax,[r8+rax*1+0x18]
  402800:	74 2b                	je     40282d <__mingw_GetSectionForAddress+0x6d>
  402802:	83 ea 01             	sub    edx,0x1
  402805:	48 8d 14 92          	lea    rdx,[rdx+rdx*4]
  402809:	4c 8d 4c d0 28       	lea    r9,[rax+rdx*8+0x28]
  40280e:	66 90                	xchg   ax,ax
  402810:	44 8b 40 0c          	mov    r8d,DWORD PTR [rax+0xc]
  402814:	4c 39 c1             	cmp    rcx,r8
  402817:	4c 89 c2             	mov    rdx,r8
  40281a:	72 08                	jb     402824 <__mingw_GetSectionForAddress+0x64>
  40281c:	03 50 08             	add    edx,DWORD PTR [rax+0x8]
  40281f:	48 39 d1             	cmp    rcx,rdx
  402822:	72 0b                	jb     40282f <__mingw_GetSectionForAddress+0x6f>
  402824:	48 83 c0 28          	add    rax,0x28
  402828:	4c 39 c8             	cmp    rax,r9
  40282b:	75 e3                	jne    402810 <__mingw_GetSectionForAddress+0x50>
  40282d:	31 c0                	xor    eax,eax
  40282f:	48 83 c4 28          	add    rsp,0x28
  402833:	c3                   	ret    
  402834:	66 90                	xchg   ax,ax
  402836:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  40283d:	00 00 00 

0000000000402840 <__mingw_GetSectionCount>:
  402840:	48 83 ec 28          	sub    rsp,0x28
  402844:	48 8b 15 f5 1a 00 00 	mov    rdx,QWORD PTR [rip+0x1af5]        # 404340 <.refptr.__image_base__>
  40284b:	45 31 c0             	xor    r8d,r8d
  40284e:	66 81 3a 4d 5a       	cmp    WORD PTR [rdx],0x5a4d
  402853:	74 0b                	je     402860 <__mingw_GetSectionCount+0x20>
  402855:	44 89 c0             	mov    eax,r8d
  402858:	48 83 c4 28          	add    rsp,0x28
  40285c:	c3                   	ret    
  40285d:	0f 1f 00             	nop    DWORD PTR [rax]
  402860:	48 89 d1             	mov    rcx,rdx
  402863:	e8 38 fe ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  402868:	85 c0                	test   eax,eax
  40286a:	74 e9                	je     402855 <__mingw_GetSectionCount+0x15>
  40286c:	48 63 42 3c          	movsxd rax,DWORD PTR [rdx+0x3c]
  402870:	44 0f b7 44 10 06    	movzx  r8d,WORD PTR [rax+rdx*1+0x6]
  402876:	44 89 c0             	mov    eax,r8d
  402879:	48 83 c4 28          	add    rsp,0x28
  40287d:	c3                   	ret    
  40287e:	66 90                	xchg   ax,ax

0000000000402880 <_FindPESectionExec>:
  402880:	48 83 ec 28          	sub    rsp,0x28
  402884:	4c 8b 05 b5 1a 00 00 	mov    r8,QWORD PTR [rip+0x1ab5]        # 404340 <.refptr.__image_base__>
  40288b:	66 41 81 38 4d 5a    	cmp    WORD PTR [r8],0x5a4d
  402891:	48 89 ca             	mov    rdx,rcx
  402894:	75 52                	jne    4028e8 <_FindPESectionExec+0x68>
  402896:	4c 89 c1             	mov    rcx,r8
  402899:	e8 02 fe ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  40289e:	85 c0                	test   eax,eax
  4028a0:	74 46                	je     4028e8 <_FindPESectionExec+0x68>
  4028a2:	49 63 48 3c          	movsxd rcx,DWORD PTR [r8+0x3c]
  4028a6:	4c 01 c1             	add    rcx,r8
  4028a9:	0f b7 41 14          	movzx  eax,WORD PTR [rcx+0x14]
  4028ad:	48 8d 44 01 18       	lea    rax,[rcx+rax*1+0x18]
  4028b2:	0f b7 49 06          	movzx  ecx,WORD PTR [rcx+0x6]
  4028b6:	85 c9                	test   ecx,ecx
  4028b8:	74 2e                	je     4028e8 <_FindPESectionExec+0x68>
  4028ba:	83 e9 01             	sub    ecx,0x1
  4028bd:	48 8d 0c 89          	lea    rcx,[rcx+rcx*4]
  4028c1:	48 8d 4c c8 28       	lea    rcx,[rax+rcx*8+0x28]
  4028c6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4028cd:	00 00 00 
  4028d0:	f6 40 27 20          	test   BYTE PTR [rax+0x27],0x20
  4028d4:	74 09                	je     4028df <_FindPESectionExec+0x5f>
  4028d6:	48 85 d2             	test   rdx,rdx
  4028d9:	74 0f                	je     4028ea <_FindPESectionExec+0x6a>
  4028db:	48 83 ea 01          	sub    rdx,0x1
  4028df:	48 83 c0 28          	add    rax,0x28
  4028e3:	48 39 c8             	cmp    rax,rcx
  4028e6:	75 e8                	jne    4028d0 <_FindPESectionExec+0x50>
  4028e8:	31 c0                	xor    eax,eax
  4028ea:	48 83 c4 28          	add    rsp,0x28
  4028ee:	c3                   	ret    
  4028ef:	90                   	nop

00000000004028f0 <_GetPEImageBase>:
  4028f0:	48 83 ec 28          	sub    rsp,0x28
  4028f4:	48 8b 15 45 1a 00 00 	mov    rdx,QWORD PTR [rip+0x1a45]        # 404340 <.refptr.__image_base__>
  4028fb:	66 81 3a 4d 5a       	cmp    WORD PTR [rdx],0x5a4d
  402900:	75 1e                	jne    402920 <_GetPEImageBase+0x30>
  402902:	48 89 d1             	mov    rcx,rdx
  402905:	e8 96 fd ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  40290a:	85 c0                	test   eax,eax
  40290c:	b8 00 00 00 00       	mov    eax,0x0
  402911:	48 0f 45 c2          	cmovne rax,rdx
  402915:	48 83 c4 28          	add    rsp,0x28
  402919:	c3                   	ret    
  40291a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
  402920:	31 c0                	xor    eax,eax
  402922:	48 83 c4 28          	add    rsp,0x28
  402926:	c3                   	ret    
  402927:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
  40292e:	00 00 

0000000000402930 <_IsNonwritableInCurrentImage>:
  402930:	48 83 ec 28          	sub    rsp,0x28
  402934:	4c 8b 05 05 1a 00 00 	mov    r8,QWORD PTR [rip+0x1a05]        # 404340 <.refptr.__image_base__>
  40293b:	31 c0                	xor    eax,eax
  40293d:	66 41 81 38 4d 5a    	cmp    WORD PTR [r8],0x5a4d
  402943:	48 89 ca             	mov    rdx,rcx
  402946:	74 08                	je     402950 <_IsNonwritableInCurrentImage+0x20>
  402948:	48 83 c4 28          	add    rsp,0x28
  40294c:	c3                   	ret    
  40294d:	0f 1f 00             	nop    DWORD PTR [rax]
  402950:	4c 89 c1             	mov    rcx,r8
  402953:	e8 48 fd ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  402958:	85 c0                	test   eax,eax
  40295a:	74 ec                	je     402948 <_IsNonwritableInCurrentImage+0x18>
  40295c:	49 63 40 3c          	movsxd rax,DWORD PTR [r8+0x3c]
  402960:	48 89 d1             	mov    rcx,rdx
  402963:	4c 29 c1             	sub    rcx,r8
  402966:	49 01 c0             	add    r8,rax
  402969:	41 0f b7 50 06       	movzx  edx,WORD PTR [r8+0x6]
  40296e:	41 0f b7 40 14       	movzx  eax,WORD PTR [r8+0x14]
  402973:	85 d2                	test   edx,edx
  402975:	49 8d 44 00 18       	lea    rax,[r8+rax*1+0x18]
  40297a:	74 31                	je     4029ad <_IsNonwritableInCurrentImage+0x7d>
  40297c:	83 ea 01             	sub    edx,0x1
  40297f:	48 8d 14 92          	lea    rdx,[rdx+rdx*4]
  402983:	4c 8d 4c d0 28       	lea    r9,[rax+rdx*8+0x28]
  402988:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  40298f:	00 
  402990:	44 8b 40 0c          	mov    r8d,DWORD PTR [rax+0xc]
  402994:	4c 39 c1             	cmp    rcx,r8
  402997:	4c 89 c2             	mov    rdx,r8
  40299a:	72 08                	jb     4029a4 <_IsNonwritableInCurrentImage+0x74>
  40299c:	03 50 08             	add    edx,DWORD PTR [rax+0x8]
  40299f:	48 39 d1             	cmp    rcx,rdx
  4029a2:	72 10                	jb     4029b4 <_IsNonwritableInCurrentImage+0x84>
  4029a4:	48 83 c0 28          	add    rax,0x28
  4029a8:	4c 39 c8             	cmp    rax,r9
  4029ab:	75 e3                	jne    402990 <_IsNonwritableInCurrentImage+0x60>
  4029ad:	31 c0                	xor    eax,eax
  4029af:	48 83 c4 28          	add    rsp,0x28
  4029b3:	c3                   	ret    
  4029b4:	8b 40 24             	mov    eax,DWORD PTR [rax+0x24]
  4029b7:	f7 d0                	not    eax
  4029b9:	c1 e8 1f             	shr    eax,0x1f
  4029bc:	48 83 c4 28          	add    rsp,0x28
  4029c0:	c3                   	ret    
  4029c1:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]
  4029c6:	66 2e 0f 1f 84 00 00 	nop    WORD PTR cs:[rax+rax*1+0x0]
  4029cd:	00 00 00 

00000000004029d0 <__mingw_enum_import_library_names>:
  4029d0:	48 83 ec 28          	sub    rsp,0x28
  4029d4:	4c 8b 1d 65 19 00 00 	mov    r11,QWORD PTR [rip+0x1965]        # 404340 <.refptr.__image_base__>
  4029db:	66 41 81 3b 4d 5a    	cmp    WORD PTR [r11],0x5a4d
  4029e1:	41 89 c9             	mov    r9d,ecx
  4029e4:	75 58                	jne    402a3e <__mingw_enum_import_library_names+0x6e>
  4029e6:	4c 89 d9             	mov    rcx,r11
  4029e9:	e8 b2 fc ff ff       	call   4026a0 <_ValidateImageBase.part.0>
  4029ee:	85 c0                	test   eax,eax
  4029f0:	74 4c                	je     402a3e <__mingw_enum_import_library_names+0x6e>
  4029f2:	49 63 43 3c          	movsxd rax,DWORD PTR [r11+0x3c]
  4029f6:	4c 01 d8             	add    rax,r11
  4029f9:	8b 90 90 00 00 00    	mov    edx,DWORD PTR [rax+0x90]
  4029ff:	85 d2                	test   edx,edx
  402a01:	74 3b                	je     402a3e <__mingw_enum_import_library_names+0x6e>
  402a03:	0f b7 48 14          	movzx  ecx,WORD PTR [rax+0x14]
  402a07:	48 8d 4c 08 18       	lea    rcx,[rax+rcx*1+0x18]
  402a0c:	0f b7 40 06          	movzx  eax,WORD PTR [rax+0x6]
  402a10:	85 c0                	test   eax,eax
  402a12:	74 2a                	je     402a3e <__mingw_enum_import_library_names+0x6e>
  402a14:	83 e8 01             	sub    eax,0x1
  402a17:	48 8d 04 80          	lea    rax,[rax+rax*4]
  402a1b:	48 8d 44 c1 28       	lea    rax,[rcx+rax*8+0x28]
  402a20:	44 8b 51 0c          	mov    r10d,DWORD PTR [rcx+0xc]
  402a24:	4c 39 d2             	cmp    rdx,r10
  402a27:	4d 89 d0             	mov    r8,r10
  402a2a:	72 09                	jb     402a35 <__mingw_enum_import_library_names+0x65>
  402a2c:	44 03 41 08          	add    r8d,DWORD PTR [rcx+0x8]
  402a30:	4c 39 c2             	cmp    rdx,r8
  402a33:	72 10                	jb     402a45 <__mingw_enum_import_library_names+0x75>
  402a35:	48 83 c1 28          	add    rcx,0x28
  402a39:	48 39 c1             	cmp    rcx,rax
  402a3c:	75 e2                	jne    402a20 <__mingw_enum_import_library_names+0x50>
  402a3e:	31 c0                	xor    eax,eax
  402a40:	48 83 c4 28          	add    rsp,0x28
  402a44:	c3                   	ret    
  402a45:	4c 01 da             	add    rdx,r11
  402a48:	75 0e                	jne    402a58 <__mingw_enum_import_library_names+0x88>
  402a4a:	eb f2                	jmp    402a3e <__mingw_enum_import_library_names+0x6e>
  402a4c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
  402a50:	41 83 e9 01          	sub    r9d,0x1
  402a54:	48 83 c2 14          	add    rdx,0x14
  402a58:	8b 4a 04             	mov    ecx,DWORD PTR [rdx+0x4]
  402a5b:	85 c9                	test   ecx,ecx
  402a5d:	75 07                	jne    402a66 <__mingw_enum_import_library_names+0x96>
  402a5f:	8b 42 0c             	mov    eax,DWORD PTR [rdx+0xc]
  402a62:	85 c0                	test   eax,eax
  402a64:	74 d8                	je     402a3e <__mingw_enum_import_library_names+0x6e>
  402a66:	45 85 c9             	test   r9d,r9d
  402a69:	7f e5                	jg     402a50 <__mingw_enum_import_library_names+0x80>
  402a6b:	8b 42 0c             	mov    eax,DWORD PTR [rdx+0xc]
  402a6e:	4c 01 d8             	add    rax,r11
  402a71:	48 83 c4 28          	add    rsp,0x28
  402a75:	c3                   	ret    
  402a76:	90                   	nop
  402a77:	90                   	nop
  402a78:	90                   	nop
  402a79:	90                   	nop
  402a7a:	90                   	nop
  402a7b:	90                   	nop
  402a7c:	90                   	nop
  402a7d:	90                   	nop
  402a7e:	90                   	nop
  402a7f:	90                   	nop

0000000000402a80 <___chkstk_ms>:
  402a80:	51                   	push   rcx
  402a81:	50                   	push   rax
  402a82:	48 3d 00 10 00 00    	cmp    rax,0x1000
  402a88:	48 8d 4c 24 18       	lea    rcx,[rsp+0x18]
  402a8d:	72 19                	jb     402aa8 <___chkstk_ms+0x28>
  402a8f:	48 81 e9 00 10 00 00 	sub    rcx,0x1000
  402a96:	48 83 09 00          	or     QWORD PTR [rcx],0x0
  402a9a:	48 2d 00 10 00 00    	sub    rax,0x1000
  402aa0:	48 3d 00 10 00 00    	cmp    rax,0x1000
  402aa6:	77 e7                	ja     402a8f <___chkstk_ms+0xf>
  402aa8:	48 29 c1             	sub    rcx,rax
  402aab:	48 83 09 00          	or     QWORD PTR [rcx],0x0
  402aaf:	58                   	pop    rax
  402ab0:	59                   	pop    rcx
  402ab1:	c3                   	ret    
  402ab2:	90                   	nop
  402ab3:	90                   	nop
  402ab4:	90                   	nop
  402ab5:	90                   	nop
  402ab6:	90                   	nop
  402ab7:	90                   	nop
  402ab8:	90                   	nop
  402ab9:	90                   	nop
  402aba:	90                   	nop
  402abb:	90                   	nop
  402abc:	90                   	nop
  402abd:	90                   	nop
  402abe:	90                   	nop
  402abf:	90                   	nop

0000000000402ac0 <vfprintf>:
  402ac0:	ff 25 a6 58 00 00    	jmp    QWORD PTR [rip+0x58a6]        # 40836c <__imp_vfprintf>
  402ac6:	90                   	nop
  402ac7:	90                   	nop

0000000000402ac8 <strncmp>:
  402ac8:	ff 25 96 58 00 00    	jmp    QWORD PTR [rip+0x5896]        # 408364 <__imp_strncmp>
  402ace:	90                   	nop
  402acf:	90                   	nop

0000000000402ad0 <strlen>:
  402ad0:	ff 25 86 58 00 00    	jmp    QWORD PTR [rip+0x5886]        # 40835c <__imp_strlen>
  402ad6:	90                   	nop
  402ad7:	90                   	nop

0000000000402ad8 <signal>:
  402ad8:	ff 25 76 58 00 00    	jmp    QWORD PTR [rip+0x5876]        # 408354 <__imp_signal>
  402ade:	90                   	nop
  402adf:	90                   	nop

0000000000402ae0 <puts>:
  402ae0:	ff 25 66 58 00 00    	jmp    QWORD PTR [rip+0x5866]        # 40834c <__imp_puts>
  402ae6:	90                   	nop
  402ae7:	90                   	nop

0000000000402ae8 <memcpy>:
  402ae8:	ff 25 56 58 00 00    	jmp    QWORD PTR [rip+0x5856]        # 408344 <__imp_memcpy>
  402aee:	90                   	nop
  402aef:	90                   	nop

0000000000402af0 <malloc>:
  402af0:	ff 25 46 58 00 00    	jmp    QWORD PTR [rip+0x5846]        # 40833c <__imp_malloc>
  402af6:	90                   	nop
  402af7:	90                   	nop

0000000000402af8 <getchar>:
  402af8:	ff 25 36 58 00 00    	jmp    QWORD PTR [rip+0x5836]        # 408334 <__imp_getchar>
  402afe:	90                   	nop
  402aff:	90                   	nop

0000000000402b00 <fwrite>:
  402b00:	ff 25 26 58 00 00    	jmp    QWORD PTR [rip+0x5826]        # 40832c <__imp_fwrite>
  402b06:	90                   	nop
  402b07:	90                   	nop

0000000000402b08 <free>:
  402b08:	ff 25 16 58 00 00    	jmp    QWORD PTR [rip+0x5816]        # 408324 <__imp_free>
  402b0e:	90                   	nop
  402b0f:	90                   	nop

0000000000402b10 <fprintf>:
  402b10:	ff 25 06 58 00 00    	jmp    QWORD PTR [rip+0x5806]        # 40831c <__imp_fprintf>
  402b16:	90                   	nop
  402b17:	90                   	nop

0000000000402b18 <exit>:
  402b18:	ff 25 f6 57 00 00    	jmp    QWORD PTR [rip+0x57f6]        # 408314 <__imp_exit>
  402b1e:	90                   	nop
  402b1f:	90                   	nop

0000000000402b20 <calloc>:
  402b20:	ff 25 e6 57 00 00    	jmp    QWORD PTR [rip+0x57e6]        # 40830c <__imp_calloc>
  402b26:	90                   	nop
  402b27:	90                   	nop

0000000000402b28 <abort>:
  402b28:	ff 25 d6 57 00 00    	jmp    QWORD PTR [rip+0x57d6]        # 408304 <__imp_abort>
  402b2e:	90                   	nop
  402b2f:	90                   	nop

0000000000402b30 <_onexit>:
  402b30:	ff 25 c6 57 00 00    	jmp    QWORD PTR [rip+0x57c6]        # 4082fc <__imp__onexit>
  402b36:	90                   	nop
  402b37:	90                   	nop

0000000000402b38 <_initterm>:
  402b38:	ff 25 b6 57 00 00    	jmp    QWORD PTR [rip+0x57b6]        # 4082f4 <__imp__initterm>
  402b3e:	90                   	nop
  402b3f:	90                   	nop

0000000000402b40 <_cexit>:
  402b40:	ff 25 9e 57 00 00    	jmp    QWORD PTR [rip+0x579e]        # 4082e4 <__imp__cexit>
  402b46:	90                   	nop
  402b47:	90                   	nop

0000000000402b48 <_amsg_exit>:
  402b48:	ff 25 8e 57 00 00    	jmp    QWORD PTR [rip+0x578e]        # 4082dc <__imp__amsg_exit>
  402b4e:	90                   	nop
  402b4f:	90                   	nop

0000000000402b50 <__setusermatherr>:
  402b50:	ff 25 76 57 00 00    	jmp    QWORD PTR [rip+0x5776]        # 4082cc <__imp___setusermatherr>
  402b56:	90                   	nop
  402b57:	90                   	nop

0000000000402b58 <__set_app_type>:
  402b58:	ff 25 66 57 00 00    	jmp    QWORD PTR [rip+0x5766]        # 4082c4 <__imp___set_app_type>
  402b5e:	90                   	nop
  402b5f:	90                   	nop

0000000000402b60 <__lconv_init>:
  402b60:	ff 25 56 57 00 00    	jmp    QWORD PTR [rip+0x5756]        # 4082bc <__imp___lconv_init>
  402b66:	90                   	nop
  402b67:	90                   	nop

0000000000402b68 <__getmainargs>:
  402b68:	ff 25 36 57 00 00    	jmp    QWORD PTR [rip+0x5736]        # 4082a4 <__imp___getmainargs>
  402b6e:	90                   	nop
  402b6f:	90                   	nop

0000000000402b70 <__C_specific_handler>:
  402b70:	ff 25 26 57 00 00    	jmp    QWORD PTR [rip+0x5726]        # 40829c <__imp___C_specific_handler>
  402b76:	90                   	nop
  402b77:	90                   	nop
  402b78:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  402b7f:	00 

0000000000402b80 <__acrt_iob_func>:
  402b80:	53                   	push   rbx
  402b81:	48 83 ec 20          	sub    rsp,0x20
  402b85:	89 cb                	mov    ebx,ecx
  402b87:	e8 54 00 00 00       	call   402be0 <__iob_func>
  402b8c:	89 d9                	mov    ecx,ebx
  402b8e:	48 8d 14 49          	lea    rdx,[rcx+rcx*2]
  402b92:	48 c1 e2 04          	shl    rdx,0x4
  402b96:	48 01 d0             	add    rax,rdx
  402b99:	48 83 c4 20          	add    rsp,0x20
  402b9d:	5b                   	pop    rbx
  402b9e:	c3                   	ret    
  402b9f:	90                   	nop

0000000000402ba0 <_get_invalid_parameter_handler>:
  402ba0:	48 8b 05 a9 4d 00 00 	mov    rax,QWORD PTR [rip+0x4da9]        # 407950 <handler>
  402ba7:	c3                   	ret    
  402ba8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  402baf:	00 

0000000000402bb0 <_set_invalid_parameter_handler>:
  402bb0:	48 89 c8             	mov    rax,rcx
  402bb3:	48 87 05 96 4d 00 00 	xchg   QWORD PTR [rip+0x4d96],rax        # 407950 <handler>
  402bba:	c3                   	ret    
  402bbb:	90                   	nop
  402bbc:	90                   	nop
  402bbd:	90                   	nop
  402bbe:	90                   	nop
  402bbf:	90                   	nop

0000000000402bc0 <__p__acmdln>:
  402bc0:	48 8b 05 99 17 00 00 	mov    rax,QWORD PTR [rip+0x1799]        # 404360 <.refptr.__imp__acmdln>
  402bc7:	48 8b 00             	mov    rax,QWORD PTR [rax]
  402bca:	c3                   	ret    
  402bcb:	90                   	nop
  402bcc:	90                   	nop
  402bcd:	90                   	nop
  402bce:	90                   	nop
  402bcf:	90                   	nop

0000000000402bd0 <__p__fmode>:
  402bd0:	48 8b 05 99 17 00 00 	mov    rax,QWORD PTR [rip+0x1799]        # 404370 <.refptr.__imp__fmode>
  402bd7:	48 8b 00             	mov    rax,QWORD PTR [rax]
  402bda:	c3                   	ret    
  402bdb:	90                   	nop
  402bdc:	90                   	nop
  402bdd:	90                   	nop
  402bde:	90                   	nop
  402bdf:	90                   	nop

0000000000402be0 <__iob_func>:
  402be0:	ff 25 ce 56 00 00    	jmp    QWORD PTR [rip+0x56ce]        # 4082b4 <__imp___iob_func>
  402be6:	90                   	nop
  402be7:	90                   	nop
  402be8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  402bef:	00 

0000000000402bf0 <VirtualQuery>:
  402bf0:	ff 25 96 56 00 00    	jmp    QWORD PTR [rip+0x5696]        # 40828c <__imp_VirtualQuery>
  402bf6:	90                   	nop
  402bf7:	90                   	nop

0000000000402bf8 <VirtualProtect>:
  402bf8:	ff 25 86 56 00 00    	jmp    QWORD PTR [rip+0x5686]        # 408284 <__imp_VirtualProtect>
  402bfe:	90                   	nop
  402bff:	90                   	nop

0000000000402c00 <UnhandledExceptionFilter>:
  402c00:	ff 25 76 56 00 00    	jmp    QWORD PTR [rip+0x5676]        # 40827c <__imp_UnhandledExceptionFilter>
  402c06:	90                   	nop
  402c07:	90                   	nop

0000000000402c08 <TlsGetValue>:
  402c08:	ff 25 66 56 00 00    	jmp    QWORD PTR [rip+0x5666]        # 408274 <__imp_TlsGetValue>
  402c0e:	90                   	nop
  402c0f:	90                   	nop

0000000000402c10 <TerminateProcess>:
  402c10:	ff 25 56 56 00 00    	jmp    QWORD PTR [rip+0x5656]        # 40826c <__imp_TerminateProcess>
  402c16:	90                   	nop
  402c17:	90                   	nop

0000000000402c18 <Sleep>:
  402c18:	ff 25 46 56 00 00    	jmp    QWORD PTR [rip+0x5646]        # 408264 <__imp_Sleep>
  402c1e:	90                   	nop
  402c1f:	90                   	nop

0000000000402c20 <SetUnhandledExceptionFilter>:
  402c20:	ff 25 36 56 00 00    	jmp    QWORD PTR [rip+0x5636]        # 40825c <__imp_SetUnhandledExceptionFilter>
  402c26:	90                   	nop
  402c27:	90                   	nop

0000000000402c28 <RtlVirtualUnwind>:
  402c28:	ff 25 26 56 00 00    	jmp    QWORD PTR [rip+0x5626]        # 408254 <__imp_RtlVirtualUnwind>
  402c2e:	90                   	nop
  402c2f:	90                   	nop

0000000000402c30 <RtlLookupFunctionEntry>:
  402c30:	ff 25 16 56 00 00    	jmp    QWORD PTR [rip+0x5616]        # 40824c <__imp_RtlLookupFunctionEntry>
  402c36:	90                   	nop
  402c37:	90                   	nop

0000000000402c38 <RtlCaptureContext>:
  402c38:	ff 25 06 56 00 00    	jmp    QWORD PTR [rip+0x5606]        # 408244 <__imp_RtlCaptureContext>
  402c3e:	90                   	nop
  402c3f:	90                   	nop

0000000000402c40 <RtlAddFunctionTable>:
  402c40:	ff 25 f6 55 00 00    	jmp    QWORD PTR [rip+0x55f6]        # 40823c <__imp_RtlAddFunctionTable>
  402c46:	90                   	nop
  402c47:	90                   	nop

0000000000402c48 <QueryPerformanceCounter>:
  402c48:	ff 25 e6 55 00 00    	jmp    QWORD PTR [rip+0x55e6]        # 408234 <__imp_QueryPerformanceCounter>
  402c4e:	90                   	nop
  402c4f:	90                   	nop

0000000000402c50 <LeaveCriticalSection>:
  402c50:	ff 25 d6 55 00 00    	jmp    QWORD PTR [rip+0x55d6]        # 40822c <__imp_LeaveCriticalSection>
  402c56:	90                   	nop
  402c57:	90                   	nop

0000000000402c58 <InitializeCriticalSection>:
  402c58:	ff 25 c6 55 00 00    	jmp    QWORD PTR [rip+0x55c6]        # 408224 <__imp_InitializeCriticalSection>
  402c5e:	90                   	nop
  402c5f:	90                   	nop

0000000000402c60 <GetTickCount>:
  402c60:	ff 25 b6 55 00 00    	jmp    QWORD PTR [rip+0x55b6]        # 40821c <__imp_GetTickCount>
  402c66:	90                   	nop
  402c67:	90                   	nop

0000000000402c68 <GetSystemTimeAsFileTime>:
  402c68:	ff 25 a6 55 00 00    	jmp    QWORD PTR [rip+0x55a6]        # 408214 <__imp_GetSystemTimeAsFileTime>
  402c6e:	90                   	nop
  402c6f:	90                   	nop

0000000000402c70 <GetStartupInfoA>:
  402c70:	ff 25 96 55 00 00    	jmp    QWORD PTR [rip+0x5596]        # 40820c <__imp_GetStartupInfoA>
  402c76:	90                   	nop
  402c77:	90                   	nop

0000000000402c78 <GetLastError>:
  402c78:	ff 25 86 55 00 00    	jmp    QWORD PTR [rip+0x5586]        # 408204 <__imp_GetLastError>
  402c7e:	90                   	nop
  402c7f:	90                   	nop

0000000000402c80 <GetCurrentThreadId>:
  402c80:	ff 25 76 55 00 00    	jmp    QWORD PTR [rip+0x5576]        # 4081fc <__imp_GetCurrentThreadId>
  402c86:	90                   	nop
  402c87:	90                   	nop

0000000000402c88 <GetCurrentProcessId>:
  402c88:	ff 25 66 55 00 00    	jmp    QWORD PTR [rip+0x5566]        # 4081f4 <__imp_GetCurrentProcessId>
  402c8e:	90                   	nop
  402c8f:	90                   	nop

0000000000402c90 <GetCurrentProcess>:
  402c90:	ff 25 56 55 00 00    	jmp    QWORD PTR [rip+0x5556]        # 4081ec <__imp_GetCurrentProcess>
  402c96:	90                   	nop
  402c97:	90                   	nop

0000000000402c98 <EnterCriticalSection>:
  402c98:	ff 25 46 55 00 00    	jmp    QWORD PTR [rip+0x5546]        # 4081e4 <__imp_EnterCriticalSection>
  402c9e:	90                   	nop
  402c9f:	90                   	nop

0000000000402ca0 <DeleteCriticalSection>:
  402ca0:	ff 25 36 55 00 00    	jmp    QWORD PTR [rip+0x5536]        # 4081dc <__IAT_start__>
  402ca6:	90                   	nop
  402ca7:	90                   	nop
  402ca8:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  402caf:	00 

0000000000402cb0 <__report_error>:
  402cb0:	56                   	push   rsi
  402cb1:	53                   	push   rbx
  402cb2:	48 83 ec 38          	sub    rsp,0x38
  402cb6:	48 8d 44 24 58       	lea    rax,[rsp+0x58]
  402cbb:	48 89 cb             	mov    rbx,rcx
  402cbe:	b9 02 00 00 00       	mov    ecx,0x2
  402cc3:	48 89 54 24 58       	mov    QWORD PTR [rsp+0x58],rdx
  402cc8:	4c 89 44 24 60       	mov    QWORD PTR [rsp+0x60],r8
  402ccd:	4c 89 4c 24 68       	mov    QWORD PTR [rsp+0x68],r9
  402cd2:	48 89 44 24 28       	mov    QWORD PTR [rsp+0x28],rax
  402cd7:	e8 a4 fe ff ff       	call   402b80 <__acrt_iob_func>
  402cdc:	41 b8 1b 00 00 00    	mov    r8d,0x1b
  402ce2:	ba 01 00 00 00       	mov    edx,0x1
  402ce7:	48 8d 0d d2 14 00 00 	lea    rcx,[rip+0x14d2]        # 4041c0 <.rdata>
  402cee:	49 89 c1             	mov    r9,rax
  402cf1:	e8 0a fe ff ff       	call   402b00 <fwrite>
  402cf6:	48 8b 74 24 28       	mov    rsi,QWORD PTR [rsp+0x28]
  402cfb:	b9 02 00 00 00       	mov    ecx,0x2
  402d00:	e8 7b fe ff ff       	call   402b80 <__acrt_iob_func>
  402d05:	48 89 da             	mov    rdx,rbx
  402d08:	48 89 c1             	mov    rcx,rax
  402d0b:	49 89 f0             	mov    r8,rsi
  402d0e:	e8 ad fd ff ff       	call   402ac0 <vfprintf>
  402d13:	e8 10 fe ff ff       	call   402b28 <abort>
  402d18:	90                   	nop
  402d19:	90                   	nop
  402d1a:	90                   	nop
  402d1b:	90                   	nop
  402d1c:	90                   	nop
  402d1d:	90                   	nop
  402d1e:	90                   	nop
  402d1f:	90                   	nop

0000000000402d20 <register_frame_ctor>:
  402d20:	e9 0b e8 ff ff       	jmp    401530 <__gcc_register_frame>
  402d25:	90                   	nop
  402d26:	90                   	nop
  402d27:	90                   	nop
  402d28:	90                   	nop
  402d29:	90                   	nop
  402d2a:	90                   	nop
  402d2b:	90                   	nop
  402d2c:	90                   	nop
  402d2d:	90                   	nop
  402d2e:	90                   	nop
  402d2f:	90                   	nop

0000000000402d30 <__CTOR_LIST__>:
  402d30:	ff                   	(bad)  
  402d31:	ff                   	(bad)  
  402d32:	ff                   	(bad)  
  402d33:	ff                   	(bad)  
  402d34:	ff                   	(bad)  
  402d35:	ff                   	(bad)  
  402d36:	ff                   	(bad)  
  402d37:	ff                   	.byte 0xff

0000000000402d38 <.ctors.65535>:
  402d38:	20 2d 40 00 00 00    	and    BYTE PTR [rip+0x40],ch        # 402d7e <__DTOR_LIST__+0x36>
	...

0000000000402d48 <__DTOR_LIST__>:
  402d48:	ff                   	(bad)  
  402d49:	ff                   	(bad)  
  402d4a:	ff                   	(bad)  
  402d4b:	ff                   	(bad)  
  402d4c:	ff                   	(bad)  
  402d4d:	ff                   	(bad)  
  402d4e:	ff                   	(bad)  
  402d4f:	ff 00                	inc    DWORD PTR [rax]
  402d51:	00 00                	add    BYTE PTR [rax],al
  402d53:	00 00                	add    BYTE PTR [rax],al
  402d55:	00 00                	add    BYTE PTR [rax],al
	...
