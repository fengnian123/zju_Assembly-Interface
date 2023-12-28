# 1. 背景说明

在学习计算机视觉课程时，对于**图像的处理**是必不可少的，而在图像处理中，我们往往要对图像的每个像素点进行循环的一些计算，因此我感觉如果使用向量化的指令并行地去做一些计算有可能会提高图像处理的效率，因此我准备对一些典型的图像处理操作进行向量化处理，最后比较使用向量化指令之后的性能变化



# 2. 探索过程

首先我选择**SSE2**指令集用于向量化处理，SSE2包括了SIMD的浮点和整型运算的指令以及整型和浮点数据之间的转换[^1]

## 2.1 图像亮度调节向量化处理

### 2.1.1 代码实现

亮度调节是一个比较简单的图像处理方式，只需要对图像的每个像素点进行相同的RGB值改变就可以，下面是相关的代码

- 没有向量化指令的版本：

  遍历输入图像的每个像素，根据指定的亮度调整值`adjustment`像素的亮度，并确保调整后的像素值在合理的范围内（0 到 255之间），然后将结果存储在输出图像中

  ```verilog
  void adjust_brightness_standard(unsigned char *image, unsigned char *output, int size, int adjustment) {
      for (int i = 0; i < size; ++i) {
          int temp = image[i] + adjustment;
          if (temp > 255)
              output[i] = 255;
          else if (temp < 0)
              output[i] = 0;
          else
              output[i] = temp;
      }
  }
  ```

- 使用SSE2指令集的版本：

  首先将输入图像和输出图像转换为SSE数据类型，使用`_mm_set1_epi8`创建一个包含`adjustment`的向量，遍历每个16字节的图像向量，并将亮度调整参数加到图像向量上，调用`_mm_adds_epu8`进行加法操作

  最后，使用`_mm_storeu_si128`将结果向量存储到输出图像中

  如果`size`不是16的倍数，剩余的像素通过之前的方法来处理

  ```c
  void adjust_brightness_SSE(unsigned char *image, unsigned char *output, int size, int adjustment) {
      __m128i *image_vector = (__m128i *)image;
      __m128i *output_vector = (__m128i *)output;
      __m128i adjust_vector = _mm_set1_epi8((char)adjustment);
  
      for (int i = 0; i < size / 16; i++) {
          __m128i temp = _mm_loadu_si128(&image_vector[i]);
          temp = _mm_adds_epu8(temp, adjust_vector);
          _mm_storeu_si128(&output_vector[i], temp);
      }
  
      // 处理剩余的像素
      for (int i = (size / 16) * 16; i < size; i++) {
          int temp = image[i] + adjustment;
          output[i] = (unsigned char)(temp > 255 ? 255 : (temp < 0 ? 0 : temp));
      }
  }
  ```

  

- 进行运行时间的计算以及判断两种方法的结果是否一致

  ```c
  	clock_t start_std = clock();
      adjust_brightness_standard(image, output_standard, size, adjustment);
      clock_t end_std = clock();
  
      clock_t start_sse = clock();
      adjust_brightness_SSE(image, output_SSE, size, adjustment);
      clock_t end_sse = clock();
  
      printf("Standard Time: %f seconds\n", (double)(end_std - start_std) / CLOCKS_PER_SEC);
      printf("SSE Time: %f seconds\n", (double)(end_sse - start_sse) / CLOCKS_PER_SEC);
      int judge = 1;
      for(long long i = 0 ; i < size ; i++){
          if(output_SSE[i] != output_standard[i]){
              judge = 0;
          }
      }
      if(judge == 0){
          printf("wrongThe results of both methods are different\n");
      }
      else{
          printf("The results of both methods are the same\n");
      }            
  ```



- 运行代码后可以得到如下的结果（使用默认）：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228191249676.png" alt="image-20231228191249676" style="zoom:50%;" />  

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228191309741.png" alt="image-20231228191309741" style="zoom:50%;" /> 

  

##  2.2 源码分析

- 然后我想通过调用函数的源码来分析，于是找到C语言的库文件，在命令行中输入`git clone git://sourceware.org/git/glibc.git`将其下载下来，如图2.2.1所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231112095844141.png" alt="image-20231112095844141" style="zoom: 50%;" /> 

  ​                                    图2.2.1

- 但随后在库文件中的`stdio`库里我始终没有找到`gets()`函数的定义，在网上搜索后了解到

  > 可能没有原代码，该函数的实体应该在某个.dll或者.obj文件中。如果该函数是在.dll文件中，链接的时候，链接程序会根据函数声明在相应的.lib文件（可能就是标准库里面）里面找到该函数所在的dll；如果是在.obj文件中，那么链接程序会在该.obj文件中找到已经编译好函数实体直接链入你的程序。[^1]

  如图2.2.2所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231112100615001.png" alt="image-20231112100615001" style="zoom:50%;" /> 

  ​                                  图2.2.2

- 最后我找到了网上的`gets()`函数的的一个实现，那么调用这个函数的代码如下：

  ```c
  //test.c
  #include<stdio.h>
  char *gets(char *input){
      char *ret = input;
      int cnt;
      while ((cnt = getchar()) != '\n' && cnt != EOF){
          *ret++ = cnt;
      }
      *ret++ = '\0';
      return ret;
  }
  void test(){
      char input[1];
      gets(input);
      puts(input);
  }
  int main(){
      test();
  }
  ```

  这个函数从`stdin`中依次读取字符并写到`input`的位置直到回车，然后像C语言所做的在最后加上`'\0'`后返回

- 在之后调试该程序的时候发现，与调用库函数的现象基本一致

  按正常逻辑来说，`gets()`函数应该只能写到`*input`的一个地址，但实际上并没有限制它，使得它可以继续往后面的地址写入，如下图所示，显然已经超过了`gets()`应该访问的地方，并且在更后面的地址中写入了一些奇怪的东西"\307"\023@"等，如图2.2.3所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231112105235100.png" alt="image-20231112105235100" style="zoom:67%;" />  

  ​                       图2.2.3

  到了这一步，虽然我还是并不知道这个程序具体发生了什么，因此需要更通过编译器编译后的汇编代码来进一步分析

 	

## 2.3 反汇编代码分析

- 在命令行中输入`gcc -S test.c -o test.s`，让GCC读取 `test.c` 文件并将其编译为 `test.s` 汇编代码文件，该文件包含与输入源代码等效的汇编指令，如图2.3.1所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231112141600674.png" alt="image-20231112141600674" style="zoom:67%;" /> 

  ​                    图2.3.1

- 打开生成的`test.s`汇编文件，我们先定位到`test`函数看看在调用`gets()`函数前做了什么，代码如下：

  ```assembly
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
  ```

  可以看到GCC首先为`test()`函数设置了48个字节的栈帧（通过`subq $48, %rsp`指令），将栈顶指针`%rsp`赋值给`%rbp`，在将这个值减一当做`gets()`和`puts()`的参数地址，也就是说，`test()`函数栈上为`gets()`保留的空间也只有1个字节

  ```assembly
    40156a:	48 8d 50 01          	lea    rdx,[rax+0x1]
    40156e:	48 89 55 f8          	mov    QWORD PTR [rbp-0x8],rdx
    401572:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    401575:	88 10                	mov    BYTE PTR [rax],dl
  ```

  我们在关注`gets()`函数中写字符的部分写入地址是`rax+0x1`, 也就是往上增长的（与栈增长相反），那么当写入更多字符的时候就应该超过了`test()`函数的栈，这时那么就应该会写到调用它的`main()`的函数栈上，产生溢出后的覆盖

  

## 2.4 GDB调试

之后我用GDB对生成的可执行文件进行调试，主要关注在函数调用前后栈顶指针`rsp`和栈基指针`rbp`的值

- 首先在`main()`函数处打上断点并运行到这里，如图2.4.1所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113105100096.png" alt="image-20231113105100096" style="zoom: 50%;" /> 

​                         图2.4.1

- 查看当前的寄存器，如图 2.4.2所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113105237721.png" alt="image-20231113105237721" style="zoom:50%;" /> 

  ​             图2.4.1

  可以看到，此时`rsp`的值为0x61fe00

- 进入`test()`函数之后，在查看此时`rbp`的值为0x61fdf0，如图 2.4.2所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113111558406.png" alt="image-20231113111558406" style="zoom:50%;" /> 

  ​              图 2.4.2

  二者相减可以得到是16个字节，也就是说这16个字节可能有一些并没有使用过（或者说写到这些地方可能没有问题）

- 为了验证我就查看了这个地址范围的数据 ，如图 2.4.3所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113112219677.png" alt="image-20231113112219677" style="zoom:50%;" /> 

  ​        图 2.4.3

  我发现前几个字节地址全都为0，没有被使用，而后几个字节的地址被赋了一些值。也就是说，当我们越界写入这些没有被使用的地址对现在整个程序的运行其实是没有影响的，但是当输入的字符过多，就会覆盖一些有用的地址甚至达到`main()`函数的栈，如果不进行保护就会影响返回地址、局部变量等等参数。至于这些使用了的地址具体在做什么，我没有得到结论。

## 2.5 进一步验证和分析

- 在上一步结束之后，我又想试一下改变写入数组的大小，看看会有什么变化，于是我改变了`input[size]`数组的大小，发现在汇编中为`test()`函数分配的栈空间是离散增长的，而且在$size>16$之后，传入`gets()`的参数不再是`%rbp-size`, 而是`%rbp-constant`, 其中`constant`是一个也是离散增长的值。如下表所示

  | size=1~16  | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113120902598.png" alt="image-20231113120902598" style="zoom:50%;" />size=5/栈大小=0x30/*input=%rbp-5 | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113120955829.png" alt="image-20231113120955829" style="zoom:50%;" />size=10/栈大小=0x30/*input=%rbp-10 | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113120552275.png" alt="image-20231113120552275" style="zoom:50%;" /> size=16/栈大小=0x30/*input=%rbp-16 |
  | ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | size=17~33 | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113121813567.png" alt="image-20231113121813567" style="zoom:50%;" />**size=17/栈大小=0x40/*input=%rbp-32** | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113121843768.png" alt="image-20231113121843768" style="zoom:50%;" />**size=25/栈大小=0x40/*input=%rbp-32** | <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113121723213.png" alt="image-20231113121723213" style="zoom:50%;" />**size=33/栈大小=0x50/*input=%rbp-48** |

  我们可以得到如下的规律：

  | size         | 栈大小         | 传入的参数*input      |
  | ------------ | -------------- | --------------------- |
  | n（n∈0~16）  | 0x30+n/16*0x10 | %rbp－n               |
  | n（n＞0~16） | 0x30+n/16*0x10 | %rbp－（n/16+1）*0x10 |

- 我们可以看到在$n>16$ 的时候，可以越界写入的字节数不仅是栈之间的空闲位置，还要加上`test()`函数栈中的未使用的地址。因此，我终于得到了一个最终的结论，如下表所示：

  | size         | gets()可以正常写入的字符数（constant表示一个常数） |
  | ------------ | -------------------------------------------------- |
  | n（n∈0~16）  | n + constant                                       |
  | n（n＞0~16） | （n/16+1）*16 + constant                           |

  经过我的反复尝试，这个 constant值为7, 带入上面的表格就可以得到`input[size]`为n时`gets()`可以正常写入的字符数

## 2.6 其他编译器的比较

在上面的过程中，我一直使用的都是GCC的编译器，所以我想探索一下在不同的编译器上，程序的栈的设置，于是我使用`Compiler Explorer`网站来模拟其他编译器的处理

### 2.6.1 clang 

clang编译器生成的汇编代码如图2.6.1所示，clang的机制与GCC基本一致，只是在栈大小的设置上较小，从最初的16→32→48……并且经过我的测试（这里就省略过程了，和前面基本一样），clang中`gets()`可以正常写入的字符数没有GCC里的`constant`（栈之间没有可写的字节），其余与GCC相同

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113130205992.png" alt="image-20231113130205992" style="zoom:50%;" />  

​                                                                              图2.6.1

### 2.6.2 icc

icc编译器生成的汇编代码如图2.6.2所示，可以看到icc在`input[size] < 16`的时候就将`rbp - 32`作为参数传入`gets()`，这里的32就是`test`栈的大小，也就是说`gets()`可以正常写入的字符数应该就是`2.5`中的结论不分类讨论，直接用`n>16`的情况（由于icc编译器并不免费且配置较复杂，这里只是一个猜测，没有验证）

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113131116070.png" alt="image-20231113131116070" style="zoom:50%;" /> 



## 3. 效果分析

通过上面的探索过程，我们可以得到：

1. 在C语言调用函数的时候，会为函数分配对应的栈，这个栈根据不同编译器的处理，大小也不同，例如在前面的程序运行时栈的大小gcc > icc > clang

2. 在为`gets()`函数传入参数的时候不同编译器的处理也不同，例如在`input[size] < 16`时clang和gcc都是按需分配，将`rdp-size`传入，而icc直接传入`rsp`

3. 在`gets()`函数进行读写的时候，实际上并没有对它的写入地址做足够的限制，导致字符数即使超过缓冲区的大小，依然可以正常读写，`gets()`函数在这种情况下会写入还未使用的栈空间甚至越过栈空间，这也许会导致一些错误。

4. 对于这种越界写入，GCC的表现为：

   | size        | gets()可以正常写入的字符数（constant表示一个常数） |
   | ----------- | -------------------------------------------------- |
   | n（n∈0~16） | n + constant                                       |
   | n（n＞16）  | （n/16+1）*16 + constant                           |

5. 但是不同的IDE可能会对这种越界进行保护，比如当我使用`clion`进行运行时，只要超过缓冲区范围，就会抛出异常，如图3.1所示，当缓冲区为5时，输入6个字符就会显示`Stack smashing detected`表示检测到了检测到栈破坏（stack smashing）或缓冲区溢出（buffer overflow）。经过查阅资料了解到，

   > 当编译器启用了栈保护（stack protection）功能时，它会在堆栈上放置一些特殊的辅助值（称为"canary"），并在函数返回前检查这些值是否被修改。如果发现这些值被改变，就表明发生了栈破坏。[^2]

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113134047122.png" alt="image-20231113134047122" style="zoom:50%;" /> 

   ​                      图3.1

## 4.实验体会

这次实验的过程对我来说是一个全新的体验，因为以前的实验从本质上来讲都是大致知道答案或者方向来一步步接近，但这次实验在探索时我并不知道最后的答案应该是什么，在网上搜索到的解答或讨论都十分模糊甚至是错误的，并且由于不同的编译器、不同的硬件配置等也可能影响得到的结果。因此我只能根据汇编代码和调试工具自己探索代码运行的时候到底发生了什么，比如函数调用的时候栈是怎么分配的、`gets()`函数具体是怎么运行的、读到的数据可以写到哪里等等，从汇编角度去分析才能知道程序的很多步骤到底在干什么。

此外，我还体会到汇编与高级语言之间一个很大的不同点就在于很多准备工作是在高级语言程序中看不到的，比如栈的分配、地址传参等等，尤其在不同的编译器也许会有不同的处理，这更加体现出理解汇编代码的重要性。

在探索过程中，对于之前学过的一些课程知识的应用也使我感受到课程内容之间的联系和结合，比如对于函数的调用以及栈的分配正好是操作系统刚讲过的内容，如下图所示：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113141715578.png" alt="image-20231113141715578" style="zoom:50%;" /> 

而缓冲区溢出则让我想到了网络安全导论课程大作业对于`Heartbleed`漏洞的复现，如下图所示：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231113141928588.png" alt="image-20231113141928588" style="zoom:50%;" /> 

最后，虽然我这次探索实验只是研究了一个很简单的函数`gets()`, 也只分析了一些很简单的汇编代码，但是复杂问题或错误往往来自简单的漏洞，缓冲区溢出漏洞的原理就可以在`gets()`函数的溢出上体现，当你成功地捕捉到这种溢出并且设置攻击代码覆盖返回地址的话，就可以注入病毒、错误信息等等对程序运行乃至系统运行产生威胁的东西来造成巨大的破坏。因此，在探索的过程中我更加理解了缓冲区溢出、栈溢出的机制，获益匪浅。



## 5.经验教训

在实验过程中，我也遇到了一些问题，总结如下：

1. 不要迷信书本，我在上网搜索上发现《深入理解计算机系统》书中有对这个函数的分析，但通过对汇编代码的分析，我发现现在的编译器的处理与书中的内容并不相同，书中的结论也和我运行程序后的结果不同，因此由于编译器等的改变，具体的情况还是要以自己得到汇编代码和运行结果为准

2. 在分析汇编代码时，一定要进行调试，查看一些寄存器和地址的值，才能得到结果，因为汇编是在操纵硬件，知道各寄存器的值可以更好地理解代码运行过程

3. 在探索过程中，我还有很多问题没有具体解决，比如GCC在栈之间的一些地址为什么可以写入；icc编译器是否提供栈保护，还是也可以越界访问（了解到icc编译器更倾向于性能而导致很多bug，我倾向于可以）等等问题还没有解决

4. 最后就是既然我们知道了缓冲区溢出会导致很多问题，那么在之后编写代码的时候就要尽量避免，不再用`gets()`等函数，对栈进行更好的保护

   

## 6.参考文献

[^1]: C/C++指令集介绍以及优化（主要针对SSE优化）：https://zhuanlan.zhihu.com/p/325632066 
[^2]: 浅析栈保护机制：https://blog.csdn.net/najdhdfh/article/details/109202138 