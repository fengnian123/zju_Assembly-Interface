[TOC]

# 第一章 介绍

## 1.1 数字系统

### 1.1.1 ASCII and Unicode

- ASCII码（8位）：

  - 7位数据 + **1位校验**

  - 使用打印机时如果**最高位**为0，打印字符；最高位为1，打印图形

  - 在PC中，通过**最左边**的位中选择是否使用**扩展**ASCII（256位），包括： 

    – some foreign letters and punctuation(标点)

    – Greek & mathematical characters

    – box-drawing(框图) & other special characters

  - 控制字符执行控制功能（回车、清除等）

- Unicode（16位）：

  - **0000H–00FFH** 和ASCII码相同
  - 更多特殊字符，可以在更多国家使用



### 1.1.2 **Binary Coded Decimal (BCD)**

- 范围：$0000_2$ to $1001_2$（1~9）

- 两种形式：

  - **packed** BCD：two digits per byte；直接计算
  - **unpacked** BCD：one digit per byte；相对浪费存储空间，但更方便对每个十进制位进行处理。当需要从键盘或按键获取用户输入时使用

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217115602930.png" alt="image-20231217115602930" style="zoom: 50%;" /> 

> 应用程序在需要进行简单算术运算、可以使用BCD数据。这些设备一般需要对货币金额、商品数量等进行计数和处理，因此BCD编码提供了更精确的表示方式。
>
> 当系统需要进行较复杂的算术运算时，很少使用BCD数据。因为在执行复杂的BCD算术运算时，缺乏简单高效的方法（使用浮点数）



### 1.1.3 **Byte-Sized Data** 

-  **unsigned** and **signed** integers：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217120620568.png" alt="image-20231217120620568" style="zoom:50%;" /> 

- 小端（Intel）与大端：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217120857040.png" alt="image-20231217120857040" style="zoom:50%;" /> 

  字符串**先来先放**（刚好与小端的高对高相反）

> **Doubleword-Sized Data**：双字数据需要占用四个字节（32位）内存空间。通常作为乘法运算的结果或者除法运算之前的被除数出现。
>
> 为了定义和分配双字大小的数据，在汇编语言中可以使用汇编指令来实现。最常用的指令是“define doubleword(s)”或者DD。这个指令告诉汇编器为指定的双字数据保留四个字节的内存空间。
>
> 此外，DWORD指令也可以用来代替DD。这两个指令都会告诉汇编器分配足够的内存空间以存储一个32位的数值。



### 1.1.4 浮点数

- 两个部分:

  - a mantissa（尾数）, significand（精度）, or fraction（小数）

  - an exponent.

- 两种类型：

  - **single-precision**：4字节

  - **double-precision**：8字节

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217122121831.png" alt="image-20231217122121831" style="zoom:50%;" /> 

- 汇编定义浮点数：

  - **DD**：single-precision 32-bit numbers 
  - **DQ**（**define quadword(s)**）：64-bit double-precision real numbers
  - 其他扩展格式：REAL4, REAL8, and REAL10

> X86数字定义：
>
> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217122640390.png" alt="image-20231217122640390" style="zoom:50%;" /> 



- **IEEE 754 Format**：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217123010476.png" alt="image-20231217123010476" style="zoom:50%;" /> 

  扩展标准：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217123200089.png" alt="image-20231217123200089" style="zoom:50%;" /> 

  - 特殊数字：

    **0**：符号位 + 全0

    **infinite** ：符号位 + 指数全1 + 尾数全0

    **NaN** (Not-A-Number):：符号位 + 指数全1 + 尾数不全为0

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217123659714.png" alt="image-20231217123659714" style="zoom:50%;" /> 

  - 舍入：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217123801153.png" alt="image-20231217123801153" style="zoom:50%;" /> 

  - 精度问题：大数吃小数

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217124043274.png" alt="image-20231217124043274" style="zoom:30%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217124114685.png" alt="image-20231217124114685" style="zoom:20%;" /> 

  - **NaN-Boxing Technology**：52 bit patterns that represent NaN can be 

    encoded to carry data

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217124414415.png" alt="image-20231217124414415" style="zoom:50%;" /> 





# 第二章、X86架构

## 2.1 内部架构

### 2.1.1 寄存器简介

- 两大类寄存器：

  - **program** **visible**：编程时可以访问使用，包括：

    EAX\~ESP（8个通用寄存器）、CS\~GS（6个段寄存器）

    X87 R0(MM0)~R7(MM7)（浮点协处理器/向量处理寄存器，可切换状态，**80位**）

  - **program invisible**：内部寄存器，反应状态，包括：

    EFLAGS（状态寄存器，表示是否溢出、进位等，6个bit表示状态；其余进行运行控制，比如字符串操作的扫描顺序）

    EIP（≈ PC）

    X87 Control，status，and Tag Registers（浮点状态/控制寄存器，表示溢出、进位，控制进位方式等）

  如下图（32位）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217182514460.png" alt="image-20231217182514460" style="zoom:50%;" /> 

  64位：

  XMM—YMM—ZMM（扩展）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217184053931.png" alt="image-20231217184053931" style="zoom:50%;" /> 



### 2.1.2 通用寄存器

A：累加

B：数据基地址

C：计数器（循环变量）

D：数据寄存器（A精度不够，乘法之后多出的位）

BP：堆栈基地址

SP：栈顶地址

SI：源字符串地址，SI+DI可用于字符串处理

DI：目的字符串地址

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217184303788.png" alt="image-20231217184303788" style="zoom:50%;" /> 

- A系列寄存器：

  RAX（64位下），可以以**不同的位宽**来访问。RAX可以作为64位寄存器（RAX本身），32位寄存器（EAX），16位寄存器（AX），或者两个8位寄存器（AH和AL）之一来使用

  A系列**效率**最高（如下图，其他系列需要两个字节确定目的寄存器C3和操作符81，A系列只需要一个）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217185337876.png" alt="image-20231217185337876" style="zoom:50%;" /> 

-  B、C、D略

  ABCD都可以多粒度访问，比如 CH or CL 可以访问最低的和次低的字节

  RBP、RBP、RDI、RSI**只能**访问四个、两个字节

- 五种**粒度**：

  - X + L（最低字节，R8~R15用B）
  - X + H（次低字节）
  - X + X（16位，R8~R15用W）
  - E + X（32位，R8~R15用D）
  - R + X（64位）

- **partial register**：64位赋值低32位后，前面的位自动**清零**；其他情况**不影响**后32位中没赋值的位（因为这些位可以单独操作）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217190800039.png" alt="image-20231217190800039" style="zoom:50%;" /> 

  后果：做乱序的时候，右边无法重命名（因为AX可能有没清的数据，有可能的数据依赖），最后导致性能下降

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217191354006.png" alt="image-20231217191354006" style="zoom:50%;" /> 

  

- **RFLAGS**： indicate the **condition** of the microprocessor and control its operation.

  以32为EFLAGS为例分析（空白为保留位）：

  蓝色箭头为**状态位**

  - 奇偶校验位（parity flag）：对最低有效字节做奇校验
  - 辅助进位位（auxiliary flag）：BCD码计算时是否要+6（在两个很大数字相加时进位后留下看起来合法的数字，实际上需要+6）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217192551494.png" alt="image-20231217192551494" style="zoom:35%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217194025031.png" alt="image-20231217194025031" style="zoom:33%;" /> 

  **考题**（计算4个位）：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217192808169.png" alt="image-20231217192808169" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231217192946442.png" alt="image-20231217192946442" style="zoom:50%;" /> 

  
  
  其他是**控制位**：
  
  - **D (direction)**： selects increment or decrement mode for the DI and/or SI registers（控制字符串增长方向）
  
  - **T (trap)** ：enables trapping through an on-chip debugging feature. （打开单步中断调试）
  
  - **I (interrupt)**：controls operation of the INTR (interrupt request) input pin（是否打开外部中断）
  
  - **VM (virtual mode)** ：selects virtual mode operation in a protected mode system. （开启虚拟化）
  
  - **ID (identification)** ：indicates that the Pentium microprocessors support the CPUID instruction. （是否支持`CPUID`）
  
    – CPUID：provides the system with information about the Pentium microprocessor（提供硬件信息，给出处理器型号）

### 2.1.3 段寄存器

分区：代码、数据、堆栈、其他

- **CS (code)** 代码基地址

  **DS (data)** 数据基地址（数据通过偏移地址访问）

  **ES (extra)** 其他数据地址

  **SS (stack)** 堆栈基地址

  **FS and GS** 附加段（进程切换的临时数据）

- 64位改成分页：为兼容将一些段清0（CS只有基地址有效）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218143132028.png" alt="image-20231218143132028" style="zoom:50%;" /> 



### 2.1.4 系统寄存器

包括System-Flags、Debug等

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218143709189.png" alt="image-20231218143709189" style="zoom:50%;" /> 



两种模式：

- Long Mode：只能分页
  - 64-Bit Mode（不兼容32位，Intel叫 “IA-32e”）
  - Compatibility Mode（兼容32位）：寻址为32位
- Legacy Mode
  - 虚拟8086：保护模式下更好地跑实模式
  - Protected Mode：实模式进一步扩展，可以选择分段或分页
  - Real Mode：16位，只能分段

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218143828695.png" alt="image-20231218143828695" style="zoom:40%;" /> 

- **System management mode** (SMM)：调硬件板



总结：

**实模式**→CR0.PE置1→**保护模式**→CR4.PAE置1(分页)/EFERLME置1/CR0.PG置1(大页)→**兼容模式**→CS.1置1→

**64-bit模式**

**SMI#**：硬件中断，进入**SMM模式**（比如做状态刷新）

**RSM**：返回原状态

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218144728505.png" alt="image-20231218144728505" style="zoom:50%;" /> 



## 2.2 内存管理

三个要求：

1. Relocation（代码重定位）
2. Protection（代码之间的隔离）
3. Sharing

### 2.2.1 管理方式

两个方式：

1. 分段：用户的偏移地址不动，加上高位地址（基地址，比如数据段和代码段不同）

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218222339413.png" alt="image-20231218222339413" style="zoom: 40%;" /> 

   整块放到空的地方：

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218222537760.png" alt="image-20231218222537760" style="zoom:40%;" /> 

2. 分页：逻辑地址映射物理地址

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218222706639.png" alt="image-20231218222706639" style="zoom:40%;" /> 

   切割映射：

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218222803185.png" alt="image-20231218222803185" style="zoom:40%;" /> 

区别: 

- 段的大小不固定；页的大小固定
- 内存浪费上：Segmentation leads to **external fragmentation**；Paging is subject to **internal fragmentation.**
- 映射表不同



### 2.2.2 管理方式的改变

**Legacy-Mode**：分段管理（16位Selector寄存器类似指针，用来选择32位基地址）

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218223324813.png" alt="image-20231218223324813" style="zoom:40%;" /> 



**Long-Mode**：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218223637265.png" alt="image-20231218223637265" style="zoom:40%;" /> 



- 实模式：**segment address**（16位再左移4位形成20位的基地址）+ **offset address**（16位偏移地址，selects any location within the **64K byte** memory segment）

  即：**Linear Address = Segment Address << 4+ Effective Address (offset)**

  EX：16位偏移地址为F000 + 基地址为1000<<4 = 1F00

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218224221945.png" alt="image-20231218224221945" style="zoom:40%;" /> 

=>The operating system can assign the segment addresses at **run time**（动态分配段地址）

- **Address Wrapping Problem**

  地址内卷问题：加出进位**溢出**了，舍去高位后得到之前的一些位置，导致更高级的机器（直接访问）和之前的就**无法兼容**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218225353750.png" alt="image-20231218225353750" style="zoom:40%;" /> 

- **Protected mode**：段寄存器包含一个**selector**，指向一个表（包括段的描述符，有32位基地址、权限等）

  即：**Linear Address = Base Address + Effective Address (offset)**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218230054143.png" alt="image-20231218230054143" style="zoom:40%;" /> 

  **Descriptor tables** 包括:

  - The **global**-descriptor table holds descriptors ，available to all programs （required）

    （系统相关资源）

    第一个描述符为全零**null descriptor**，进行占位（在描述符表未完善时，如果指向这个null descriptor那么触发一个异常/在上下文切换时可能需要重新设置选择子，此时指向这个null descriptor）

    > - 空描述符不会在加载到数据段寄存器（DS、ES、FS或GS）时引发异常，但如果使用空选择器访问内存，它将始终生成常规保护异常（#GP）。
    > - 空选择器还可以充当指示64位模式下存在嵌套中断处理程序或特权软件的标志

  - The **local**-descriptor table holds descriptors ，used by a single program (**optional**)

    （应用相关资源）

  - The **interrupt**-descriptor table holds only gate ，descriptors （required）

  计算最大进程数：全局描述符表的大小$/$两个描述符的大小（代码段和数据段）

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218231510954.png" alt="image-20231218231510954" style="zoom:40%;" /> 



- 描述符变化：

  80286：基地址（limit：16位；Base：24位；权限：4位）

  80386：基地址（limit：20位；Base：32位；权限：4位）

  80486：全0，废弃分段（保留权限，增加L位表示进入Long Mode）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218231815162.png" alt="image-20231218231815162" style="zoom:40%;" /> 



- **Segment limit field**：可以访问的最后一个地址（不是长度）

   granularity (G) bit ：粒度位，0表示以字节为单位；1表示以4k为单位（刚好可以访问32位所有4G内存）

  即：<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231218232756616.png" alt="image-20231218232756616" style="zoom:40%;" />

  **考题**：

  - [ ] Problem 1: For a descriptor with a base address of 10000000H, a limit of 001FFH, and **G=0**, what is the starting and ending locations?

  – starting location: 10000000H

  – ending location : 10000000H+001FFH=100001FFH

  - [ ] Problem 2: For a descriptor with a base address of 10000000H, a limit of 001FFH, and **G=1**, what is the starting and ending locations?

  – starting location: 10000000H

  – ending location: 10000000H + 001FFFFFH= 101FFFFFH（**limit后面加FFF**）



### 2.2.3 描述符权限

- 描述符的权限位设置，如下图所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231221185321449.png" alt="image-20231221185321449" style="zoom:40%;" /> 

  - S位：描述符是否是系统级，如果是系统级的，那么可以设置不同段（Code、data、stack等）的权限（TYPE）
  - TYPE位：各段的读写等权限，见上图
  - DPL位：两个位表示这一段需要多高的权限（权限有四级所以用两个位）才能访问
  - P位：描述符是否定义完成
  - A位：这一段是否被访问过



### 2.2.4 选择子

**Segment Selector Format**如下图：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231221190342668.png" alt="image-20231221190342668" style="zoom:40%;" /> 

- 为了兼容实模式定义为16位，因此存的是**描述符**的选择子而不是段的地址，即描述符在描述符表的index，通过一个全局寄存器获得描述符表加上这个index找到真正的描述符，在从描述符中得到段的基地址、界限等信息
- 描述符有8个字节，因此是8字节对齐，也就是说选择子的低三位只能为0。那么就可以用选择子没有用的低3位做其他事：
  - TI位：表示描述符在全局描述符表（共享资源）还是局部描述符表
  - RPL位：表示当前程序访问描述符的动作所拥有的权限（与描述符权限不同，描述符权限表示谁能访问）

> 区分三个权限：
>
> - Descriptor Privilege-Level (DPL): The DPL is the privilege level that OS assigns to individual segments.（操作系统设置）
> - Requestor Privilege-Level (RPL): The RPL reflects the privilege level of the program that created the selector.（应用程序设置）
> - Current Privilege-Level (CPL): CS register has a 2-bit CPL field maintained by CPU. The CPL is always equal to the CPU's current privilege level.（根据运行状态确定，运行在什么态）

- 确定是否能够访问：

  根据RPL 和 CPL**权限更低**（取最大值）的与DPL比较判断是否有权限访问 。下面是两个例子：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231221192905463.png" alt="image-20231221192905463" style="zoom:40%;" /> 

  **访问堆栈**：必须满足**RPL == CPL == DPL**

> **为什么既要RPL又要CPL?**
>
> 如果没有RPL，应用程序调syscall之后可以做任何事（显示不能这样）



### 2.2.5 描述符的存储及访问流程

- 分为三类描述符表：
  1. GDT：全局描述符表，操作系统决定
  2. LDT：局部描述符表，应用程序相关的私有描述符，随应用程序切换改变，基地址放在LDTR (**local descriptor table register**)中
  3. IDT：中断描述符表，全局资源

- 访问流程：

  - 逻辑地址分为两部分：16位选择子和32位偏移量

  - 读选择子TI位判断描述符在哪个描述符表中，如果是**全局描述符**：

  - 在对应描述符表寄存器找到描述符表的基地址

  - 根据选择子有效地址位（×8对齐）在描述符表中找到描述符

  - 做权限检测和界限检测

  - 拿到描述符中的基地址和offset相加得到线性地址

  - 需要分页的话做分页处理；不需要的话线性地址就是物理地址

    > ​    如果是**局部描述符**：
  >
    > - 在应用程序设置时，如果有局部描述符，那么会在设置一个局部描述符基地址（在一个寄存器中），这个地址实际上是局部描述符表**实际**基地址在全局描述符表中的offset，然后在全局描述符表中找到这个**局部描述符表实际基地址**，在内存的另一块地方去找局部描述符表
  > - 后面与全局相同                                               
  

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231221194231233.png" alt="image-20231221194231233" style="zoom:40%;" /> 



### 2.2.5 分页

- 四种地址：

  – Effective addresses, or segment offsets

  – Logical addresses

  – Linear (virtual) addresses

  –Physical addresses

  关系如下图：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222222220796.png" alt="image-20231222222220796" style="zoom:50%;" /> 



- **Why 4KB Page Size?**

  - 2的次方: 硬件性能更好
  - 不能太大: 页内碎片少
  - 不能太小: 页表占内存小，缺页miss少

- **Why Multi-level Paging ？**

  页表项太多，如下图：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222223544950.png" alt="image-20231222223544950" style="zoom:50%;" /> 

  为了把页表放在一个页内，需要 52/10 = 6级页表（但是性能下降）

  如果上一级页表的某项是**空**的，那么下一级就不用建立pgt，如下图所示：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222224017035.png" alt="image-20231222224017035" style="zoom:50%;" /> 

  

**考题**：Problem: consider a system using multi-level paging scheme. The page size is 4 KB. The physical memory is 16 TB and virtual address is 32 bits long. The page table entry size is 4 bytes

Find-

– How many levels of page table will be required?

答：<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222224513086.png" alt="image-20231222224513086" style="zoom:50%;" /> 

– Give the divided physical address and virtual address

答：<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222224753329.png" alt="image-20231222224753329" style="zoom:50%;" /> 



- 分页的优点：

  1. 代码可重定位 （**Relocation**）

  2. 在虚拟地址空间中互相隔离实现保护性（**Protection**）

     pgt得到基地址后低十二位可以做权限设置：

     - `bit[2]`：访问者的权限要求
     - `bit[1]`：读写权限（0只能读，1可以写）
     - `bit[0]`：这一页是否已经有实际内存分配

     <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222225843957.png" alt="image-20231222225843957" style="zoom:50%;" /> 

     多级页表最后的权限（越上层，拥有的权限可能越多）：相**与**后的结果，

     比如 Page attribute = PDE attribute **&** PTE attribute

  3. 多个应用程序可以使用共享物理内存（**Sharing**）



### 2.2.6 分页寄存器

-  **CR0~ CR4**（CR1保留）

  - **CR0**：最高位表示**启用分页**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222230915302.png" alt="image-20231222230915302" style="zoom:50%;" /> 

  - **CR3**：高20位地址表示系统**第一级页表基地址**（操作系统维护，不同应用程序会切换）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222231008610.png" alt="image-20231222231008610" style="zoom:50%;" /> 

  - **CR4**：

    `bit[5]`：物理地址扩展（虚拟地址和物理地址可以不同，比如虚拟内存）

    `bit[4]`：页表大小切换使能

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222231144778.png" alt="image-20231222231144778" style="zoom:50%;" /> 

  - **CR2**：发生`page fault`后储存缺页的地址

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222231404294.png" alt="image-20231222231404294" style="zoom:50%;" /> 



### 2.2.7 32位的两种分页管理模式

- **Two-level Paging: 10-10-12 Model**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222231700135.png" alt="image-20231222231700135" style="zoom:50%;" /> 

  - 做**页扩展**（**PSE**位置1）：合并offset和第二级页地址得到22位的**4MB page**

    = 一级分页

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222232513929.png" alt="image-20231222232513929" style="zoom:50%;" /> 

    怎么开启：**CR4.PSE = 1 and PDE.PS = 1**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222232704728.png" alt="image-20231222232704728" style="zoom:50%;" /> 

    一般内核用大页，应用程序用小页

  - 做物理地址扩展（**PAE**）：Page address extension (PAE) allows **32-bit** apps access to more than **4GB** of memory space.

    怎么开启：**CR4.PAE = 1 **

    操作：pgt entries from **4** bytes to **8** bytes, entry的数量变成512，逻辑地址切分改变

    =>引出第二类分页管理模式

   

- **2-9-9-12 Model**（主要用于服务器）：

  第一级页表只有4个（浪费）

  A new entry Page Directory Pointer Table (**PDPT**) is added

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222233855485.png" alt="image-20231222233855485" style="zoom:50%;" /> 

  - 做大页（**PSE**位置1）：合并offset和第二级页地址得到21位的**2MB page**



- 优先级：`PAE` > `PSE`
  - PAE置1，不用PSE置1就可以开启大页（相当于PSE自动置1）



### 2.2.8 64位  **Long Mode Paging Mode**

> **Paging Modes in AMD64**：
>
> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222235401155.png" alt="image-20231222235401155" style="zoom:50%;" /> 

- **4-Level Paging with 4KB Page**

  48位转换位52位

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222235620453.png" alt="image-20231222235620453" style="zoom:50%;" /> 

  做大页：

  - 合并一级页表：**2MB页**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231222235920801.png" alt="image-20231222235920801" style="zoom:50%;" /> 

  - 合并两级页表：**1GB页**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223000014057.png" alt="image-20231223000014057" style="zoom:50%;" /> 
    
    

### 2.2.9 MMU

与OS相同，略

### 2.2.10 **Self-Referencing Entry Trick** 

核心问题：如何修改**维护页表**（开启虚拟地址后，有可能找不到）？

解决方法：

- 页表内存一个指向自己的`entry`

  一个例子（将`va`右移12位再左移两位 + 一次恒等映射）：

  第一次walk不继续向下一级找，指回根页表基地址

  第二次walk可以找到走到`PT`，从而实现页表的修改

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223223355372.png" alt="image-20231223223355372" style="zoom:40%;" /> 

  如果将`va`右移22位再左移两位，可以得到`PD`的基地址： 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223225437072.png" alt="image-20231223225437072" style="zoom:40%;" /> 



# 第三章、寻址方式

### 3.1 介绍

- x86寻址方式：
  - 16-bit modes (real, vm86, protected): default address and operand-size are 16-bit
  - 32-bit protected mode (protected): default address and operand-size are 32-bit
  - 64-bit mode: default address size is 64-bit, default **operand-size is 32-bit**
- 寻址模式分类：
  - Data-Addressing Modes：数据传输（EX：`MOV AX, DX`）
  - Stack Memory-Addressing Modes：堆栈寻址（EX：`PUSH AX`）
  - Program Memory-Addressing Modes：跳转指令（EX：`JMP or CALL`）

- Intel 汇编的标签**不允许出现数字**

  All labels must begin with a letter or one of the following special characters: **@, $, -, or ?**

  – e.g., begin, data$, here@, etc.

  – a label may any length from **1 to 35** characters 



> x86各种寻址：
>
> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223231259088.png" alt="image-20231223231259088" style="zoom:50%;" /> 



### 3.2 寄存器寻址

- 寄存器寻址：The most **common** form of data addressing

  注意长度匹配：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223231607951.png" alt="image-20231223231607951" style="zoom:50%;" /> 



### 3.3 立即数寻址

- 立即数寻址：

  - 立即数是`constant`的，从寄存器或内存传输数据是变量

  - 可能产生歧义，不知道是立即数还是标签 => 加前导0

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223232307230.png" alt="image-20231223232307230" style="zoom:50%;" /> 

  - 二进制数 => 后面加`B`

  -  ASCII码 => 加单引号



### 3.4 内存寻址

- 内存寻址：

  $Effective Address = Base + (Scale×Index) + Disp$

  - **Displacement Addressing**：只有一个`Disp`

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224211044492.png" alt="image-20231224211044492" style="zoom:50%;" /> 

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223233125500.png" alt="image-20231223233125500" style="zoom:40%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223233214153.png" alt="image-20231223233214153" style="zoom:40%;" /> 

    编译器使用**直接**数据寻址模式来访问在编译时确定的**静态地址**（例如，全局变量）。例如：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223233553933.png" alt="image-20231223233553933" style="zoom:50%;" /> 

  - **Register Indirect Addressing**：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224211119916.png" alt="image-20231224211119916" style="zoom:50%;" /> 

    In the 64-bit mode, segment registers are **not used** in address calculation.

    如下图：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223233934129.png" alt="image-20231223233934129" style="zoom:40%;" /> 
  
    - 不能两个操作数都是基地址（x86不允许内存直接访问内存），除了字符串指令：
    
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223234125749.png" alt="image-20231223234125749" style="zoom:50%;" /> 
  
  
  
  - **Base-Plus-Index Addressing**：
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224211012212.png" alt="image-20231224211012212" style="zoom:50%;" /> 
  
    80286必须使用：
  
    base register (BP or BX) 
  
    index register (DI or SI)，EX：
  
    ```assembly
    MOV DX,[BX + DI]
    ```
  
    
  
    80386**任意**两个32位寄存器都可以（除了**ESP**），EX：
  
    ```assembly
    MOV DL,[EAX+EBX]
    ```
  
    具体过程：假设DS=0100H（**注意加DS**）, BX=1000H and DI=0010H，运行`MOV DX, [BX + DI] `后如下图：
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224210414322.png" alt="image-20231224210414322" style="zoom:50%;" /> 
  
  - **Register Relative Addressing**：右边可以是基地址或索引地址
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224210950823.png" alt="image-20231224210950823" style="zoom:50%;" /> 
  
    EX：
  
    ```assembly
    MOV AX,[DI+100H] #80286 
    MOV DL,[EAX+10H] #80386,条件同上
    ```
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224211733086.png" alt="image-20231224211733086" style="zoom:50%;" /> 
  
  
  
  - **Base Relative-Plus-Index Addressing** ：
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224211811657.png" alt="image-20231224211811657" style="zoom:50%;" /> 
  
    EX：
  
    ```assembly
    MOV AX,[BX + SI + 100H]
    ```
  
    可也用来寻址结构体数组：
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224212059746.png" alt="image-20231224212059746" style="zoom:50%;" /> 
  
  
  
  - **Scaled-Index Addressing** ：索引再乘一个系数
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224212303159.png" alt="image-20231224212303159" style="zoom:50%;" /> 
  
    the scaling factor can be **1x, 2x, 4x, 8x** （只有这四种，因为只有两位）
  
    **EX**：**ARRAY[4*ECX] =   4\*ECX + ARRAY**
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224212545375.png" alt="image-20231224212545375" style="zoom:50%;" /> 
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224212808166.png" alt="image-20231224212808166" style="zoom:50%;" /> 
  
    
  
  - 补充：**RIP Relative Addressing** （和当前指令相关，可以以**当前指令的位置**做**基地址**）
  
    可以做到**地址无关代码**，提高代码的**可移植性**
  
    **EX：**`rip`是基地址；`var[]`是偏移
  
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224213116854.png" alt="image-20231224213116854" style="zoom:50%;" /> 



- **Size Directives**：如下图，在向内存写10H时不确定要写的数据的长度，因此需要

   `size` + `PTR`的形式（比如：BYTE PTR, WORD PTR, DWORD PTR or QWORD PTR）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223234604258.png" alt="image-20231223234604258" style="zoom:40%;" /> .

  所以指令可以改成：

  ```assembly
  MOV BYTE PTR [DI],10H
  MOV DWORD PTR [DI],10H
  ```

  具体的操作如下：
  
  第一条：两个操作数都是基址，**错误**
  
  第二条~第四条：opcode变为**C7**；默认情况下内存中的数是**32位**的，所以在二、四指令前面有一个**前缀**（相当于重载），三不用
  
  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224204806661.png" alt="image-20231224204806661" style="zoom:50%;" /> 



### 3.5 其他

- **Canonical Addressing and Canonical Form** （规范寻址）：没有用的高位地址不能随便赋值，只能用**符号位**填充

  – **canonical** address: FFFF8010BC001000,；00007C80B8102040

  – **non-canonical** address: 1122334455667788, 3375DA44B5667788 

  If the memory address is a non-canonical form, a general-protection **exception** (#GP) is generated

  EX：`MOV RAX, [1122334455667788H]`



- **AT&T和 Intel** 的差异：

  AT&T更**复杂**，冗余更多，**显式**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214454941.png" alt="image-20231224214454941" style="zoom:40%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214514330.png" alt="image-20231224214514330" style="zoom:40%;" />  



### 3.6 **总结**

- **Memory Addressing Mode**：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214709445.png" alt="image-20231224214709445" style="zoom:40%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214800897.png" alt="image-20231224214800897" style="zoom:40%;" /> 



-  **Effective Address Computation**：

  **8086-80286**：

  – Base: BX/BP

  – Index: SI/DI

  – Disp: 8-bit/16-bit

  **80386 and above：**

  – Base: any 32-bit register

  – Index: any 32-bit register **except ESP**

  – Disp: 8-bit/16-bit/32-bit

  

**考题**：考`ESP`不能做`index`（当它前面乘系数的时候）

​		<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224215105706.png" alt="image-20231224215105706" style="zoom:50%;" /> 



### 3.7 代码寻址

- 根据跳转的距离分为：

  - Short jump—A near jump where the jump range is limited to **–128 to +127** （**一个字节**）from the current EIP value
  - Near jump—A jump to an instruction within the current code segment (the segment pointed to by the CS register), referred to as an intrasegment jump（段内）
  - Far jump—A jump to an instruction located in a different segment than the current code segment but at the same privilege level, referred to as an intersegment jump（跨段）
  - Task switch—A jump to an instruction located in a different task (in protected mode only)（切换任务）

- **Direct Program Memory Addressing**：主要为**Far jump**，**模式切换**的时候需要

  **EX：CODE_SEG（段） + init_pm（偏移）**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224220015063.png" alt="image-20231224220015063" style="zoom:50%;" /> 

  或者使用**FAR PTR**

  EX：`JMP FAR PTR START`

- **Relative Program Memory Addressing**（根据`rip`）

  能进行段内跳转（JMP指令是一个1字节的指令，有一个1字节或2字节的位移，添加到指令指针）

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224221524107.png" alt="image-20231224221524107" style="zoom:40%;" /> 

- **Indirect Program Memory Addressing**：

  跳转指令中可以放地址的寄存器：

  - **8086 ~ 80286**：

     (AX, BX, CX, DX, SP, BP, DI, or SI), 以及可以做**偏移**的([BP], [BX], [DI], or [SI]) 

    **EX**：`JMP NEAR PTR[DI+2]`

  - **80386**：没有限制

  **EX:** <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224222144460.png" alt="image-20231224222144460" style="zoom:50%;" /> 

  -  **jump table** ：`Table`基地址加上索引`BX`

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224222253566.png" alt="image-20231224222253566" style="zoom:50%;" /> 

    

### 3.8 栈寻址

- **push**：栈的基地址`ss`偏移后加上栈顶`ESP`

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224222601615.png" alt="image-20231224222601615" style="zoom:50%;" /> 

  - 8086 ~ 80286：一次只能`push`**2**个字节

    80386：**2, 4 or 8** bytes

  - **PUSHA**：将**除段寄存器**之外的内部寄存器集的内容push到栈

  - **PUSHAD** (push all double) instruction pushes **32-bit** registers in 80386 

  - **PUSHF** (**push flags**) ：把`eflag`寄存器标志位push到堆栈

- **pop**：相同

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224222807402.png" alt="image-20231224222807402" style="zoom:50%;" /> 



- 定义栈：

  ```assembly
  STACK_SEG SEGMENT STACK
  	初始化内容
  STACK_SEG ENDS
  ```



# 第四章、数据移动指令

### 4–1 MOV 指令

#### 4.1.1 指令模式

指令模式判断：

- [ ] L=1 for **64-bit** instruction mode
- [ ] L=0 and D =1 for **32-bit** instruction mode
- [ ] L=0 and D =0 for **16-bit** instruction mode

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224223635414.png" alt="image-20231224223635414" style="zoom:50%;" /> 

- 指令模式

  - 16位指令（至少有1 byte **Opcode**），return只需要1 byte

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224223854255.png" alt="image-20231224223854255" style="zoom:50%;" /> 

  - 32位：最长**15**个字节，超过会触发**general-protection exception**

    The **operand-size prefix** 66H selects the nondefault **operand size** （默认32位，改成16位要加前缀）

    **address-size prefix** 67H changes the default **address size** for memory operands（默认64位，改成32位要加前缀）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224224036514.png" alt="image-20231224224036514" style="zoom:50%;" /> 

    **EX**：其中ModR/M（指定寻址方式以及有没有displacement）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224224301036.png" alt="image-20231224224301036" style="zoom:50%;" /> 



#### 4.1.2 Opcode—1 byte

基本格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221117179.png" alt="image-20231226221117179" style="zoom:50%;" /> 

- **D**位：1表示数据**流入**寄存器；0表示**流出**

  即：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221324675.png" alt="image-20231226221324675" style="zoom:50%;" /> 

- **W**位：1,表示data size 是 **word 或 doubleword**；0表示data size 是 **byte**

  - 当16位模式需要访问**32位**寄存器时要加**67H address prefix**

  - 当32位模式需要访问**16位**寄存器时要加**66H operand prefix**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221648322.png" alt="image-20231226221648322" style="zoom:50%;" /> 



#### 4.1.3 MOD Field—2 bytes

基本格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226222118389.png" alt="image-20231226222118389" style="zoom:50%;" /> 

- **MOD**：确定内存寻址方式，具体如下：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226222212978.png" alt="image-20231226222212978" style="zoom:50%;" /> 

- **R/M**：确定具体访问的寄存器

  - 16位模式下：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226222537589.png" alt="image-20231226222537589" style="zoom:40%;" /> 

  - 32位模式下：

    当**R/M = 100**时表示加上一个**scaled-index**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226222656901.png" alt="image-20231226222656901" style="zoom:50%;" /> 



#### 4.1.4 Scaled-Index—1 byte

基本格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223151495.png" alt="image-20231226223151495" style="zoom:50%;" /> 

- **ss**只有2 bit，所以系数只能如下：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223240669.png" alt="image-20231226223240669" style="zoom:50%;" /> 

- **EX：**（很清晰）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223320517.png" alt="image-20231226223320517" style="zoom:50%;" /> 



#### 4.1.5 64位模式下的扩展

由于寄存器增加，前面一些表示寄存器的位显然不够用，所以加入**REX (registerextension)**

基本格式如下：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223711760.png" alt="image-20231226223711760" style="zoom:50%;" /> 

- **前4位**：保留位（保持0100）
- **W**：64位使能（要打开64位模式要置1）
- **R**：拼一位给**REG**
- **X**：拼一位给**scaled-index**中的**index**
- **B**：拼一位给**scaled-index**中的**base**（开启的情况），否则拼给**R/M**

看图就明白了：

**不开启scaled-index**的情况：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226224453140.png" alt="image-20231226224453140" style="zoom:50%;" /> 

**开启scaled-index**的情况：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226224531915.png" alt="image-20231226224531915" style="zoom:50%;" /> 



#### 4.1.6 Legacy Prefixes

- **Lock Prefix**：互斥锁前缀，使指令执行原子操作

  只能在如下指令添加：（ **undefined opcode exception (#UD)** occurs if the LOCK prefix is used with any other instruction）

  - 位操作：BTC, BTR, BTS
  - 逻辑运算：ADC, ADD, AND, DEC, INC, NEG, NOT, OR, SBB, SUB, XOR
  - 字符串比较：CMPXCHG, CMPXCHG8B, CMPXCHG16B, XADD and XCHG

- **Segment Override Prefix**：修改默认的段基址

  - 默认情况的段基址：

    – Instructions: CS

    – Local Data: DS

    – Stack: SS

    – Destination Strings: ES

  - **EX：**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226225132549.png" alt="image-20231226225132549" style="zoom:50%;" /> 

- **Operand-Size Override Prefix**

  如下图：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226225235188.png" alt="image-20231226225235188" style="zoom:50%;" /> 

  **EX：**64位情况下，第一条指令要写16位数据，所以加前缀66H；第三条指令要写64位数据，所以加48H前缀（operand还是默认的32位，但是加上这个前缀表示要放到一个64位的内存中）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226225720647.png" alt="image-20231226225720647" style="zoom:50%;" /> 

  如果是写**byte**，那么Opcode会变（**W**位变为0）

- **Address-Size Override Prefix**：

  寻址最少**16位**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226230615897.png" alt="image-20231226230615897" style="zoom:50%;" /> 

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226231022458.png" alt="image-20231226231022458" style="zoom:50%;" /> 



#### 4.1.7 **Escape Sequence**

6位的Opcode不够了，因此要进行扩展

=>using one escape opcode byte (**0FH**) or two-byte escape (**0F38H, 0F3AH**)

**EX：**

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226232120562.png" alt="image-20231226232120562" style="zoom: 67%;" /> 



### 4.2 **LOAD**指令

两类：

– **LEA**: Loads a near pointer (**offset**)

– **LDS**, LES, LFS, LGS, and LSS: Loads a far pointer (**segment selector and offset**)

- **LEA**：取一个偏移地址

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226232819408.png" alt="image-20231226232819408" style="zoom:50%;" /> 

  - **OFFSET**伪指令：类似LEA，LEA指令在**运行时计算**并加载地址到寄存器中，而OFFSET伪指令在**编译时**获取偏移地址，并将其嵌入到指令中（OFFSET性能更好）；OFFSET后面只能加**标签**，而LEA可以加**寄存器**的地址（例如`LEA SI, [BX+DI]` OFFSET就做不了）
  - **LEA**主要用来做运算（比如EBX + 8*EAX + 4这种复杂运算用一条指令就能完成）

- **LDS and LES**：取偏移地址和对应段地址

  **EX：** **LDS BX,[DI]** 将DS与EDI相加得到物理地址，找到对应的4个字节，低二字节写入BX、高二字节写入DS

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226234539186.png" alt="image-20231226234539186" style="zoom:50%;" /> 

  - 16位模式：32-bit far pointer: 16-bit segment + 16-bit offset
  - 32为模式：48-bit far pointer: 16-bit selector + 32-bit offset

- **LSS**：同时更新**sp**偏移和**sp**，**堆栈切换**常用

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226235406411.png" alt="image-20231226235406411" style="zoom:50%;" /> 



### 4.3 STRING DATA TRANSFERS

包括：

1. Five string data transfer instructions

   – LODS, STOS, MOVS, INS, OUTS

2. Two string comparison instructions

   – SCAS, CMPS

**EX：**

 CMPS指令：

- **DI/SI**分别指向两个字符串的基地址

  – DI **不能重载**

  – SI 可以重载

- 加上前缀**REPE**表示重复操作；**CX**寄存器保存重复**次数**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227001122153.png" alt="image-20231227001122153" style="zoom:50%;" /> 

- 后缀**B**表示一次比较1个byte

- **DF**寄存器保存比较**方向**（**CLD** instruction **clears ** DF and the **STD** instruction **sets** it ）

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227000012297.png" alt="image-20231227000012297" style="zoom:50%;" /> 



- **EX：**拷贝字符串

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227001305301.png" alt="image-20231227001305301" style="zoom:50%;" /> 



#### 4.3.1 **LODS**

- 作用： transfers a byte, word or doublewordfrom the source location **DS:SI** to **AL, AX or EAX**

  – LODSB : ±1 is added to DS: SI/ESI

  – LODSW: ±2 is added to DS: SI/ESI

  – LODSD : ±4 is added to DS: SI/ESI

- 使用 **implicit operands** (AL, AX, EAX)，根据写入的字节数选择

- **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227001930843.png" alt="image-20231227001930843" style="zoom:50%;" /> 

- 特殊性：**唯一不用加repre前缀**（目的寄存器只有一个）

  

#### 4.3.2 **STOS** 

- 作用：store **AL, AX, or EAX** to the destination location ES:DI

  – STOSB : ±1 is added to ES: DI/EDI

  – STOSW: ±2 is added to ES：DI/EDI

  – STOSD : ±4 is added to ES：DI/EDI

- 可以加repre前缀（比如初始化一片内存）

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227002552594.png" alt="image-20231227002552594" style="zoom:50%;" /> 



#### 4.3.3 **MOVS** 

- 唯一内存到内存的传输

- 作用： transfers a byte, word, or doubleword from **DS: SI** to **ES: DI** and updates SI and DI 

  – MOVSB : ±1 is added to DS: SI and ES: DI

  – MOVSW: ±2 is added to DS: SI and ES: DI

  – MOVSD : ±4 is added to DS: SI and ES: DI

- **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227002836083.png" alt="image-20231227002836083" style="zoom:50%;" /> 



#### 4.3.4 **INS**/**OUTS** 

**INS**：

- 作用：Transfers a byte, word, or doubleword of data from an **I/O device** into the extra segment **memory** location.

- I/O使用端口寻址，**D**系列寄存器会保存对应I/O的地址

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227003037452.png" alt="image-20231227003037452" style="zoom:50%;" /> 

- 两种方式：

  - 显示：**INS WORD PTR [DI], DX**

    必须有WORD等表示长度（因为取内存的长度不确定）

  - 隐式：先要把DI和DX设置好

    – INSB inputs data from an 8-bit I/O device and stores it in a memory location indexed by DI. 

    – INSW instruction inputs 16-bit I/O data and stores it in a word-sized memory location. 

    – INSD instruction inputs 32-bit I/O data and stores it in a doubleword-sized memory location

- 可以加repre前缀（外设的数据在变化）

- **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227003555831.png" alt="image-20231227003555831" style="zoom:50%;" /> 

**outs**类似



### 4.4 其他数据传输指令

#### 4.4.1 **XCHG**

- 交换两个寄存器/一个**通用**寄存器和内存的值（不能是段寄存器和内存交换）

- 交换粒度： byte-, word-, or doubleword

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227004248956.png" alt="image-20231227004248956" style="zoom:50%;" /> 

#### 4.4.2 **LAHF and SAHF** 

- LAHF instruction transfers the **lower 8 bits** of the **EFLAGS** register into the **AH** register.

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227004613007.png" alt="image-20231227004613007" style="zoom:50%;" /> 

- SAHF相反

  注意会忽略 **bits 1, 3, and 5** ，因为这些位是保留的

- 使用时要通过检测：

  **CPUID.80000001H: ECX.LAHFSAHF[bit 0] = 1.**



#### 4.4.3 **XLAT**

-  implicit operands (**AL, BX**)

- 等价于**MOV AL, [seg:BX + AL]**

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227005225174.png" alt="image-20231227005225174" style="zoom:50%;" /> 



#### 4.4.4 **Input Ports and Output Ports**

- 内存→外设：主要有三部分流程

  - 内存地址（有一部分对应外设**端口**）：

    通过**比较器**译码判断是否对应外设

  - 控制信号：来自控制**总线**（对端口的写信号）

  - **锁存器**传递数据：因为外设比cpu**慢**很多

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227200623144.png" alt="image-20231227200623144" style="zoom:50%;" /> 

- 外设→内存：主要有三部分流程

  - 内存地址（有一部分对应外设**端口**）：

    通过**比较器**译码判断是否对应外设

  - 控制信号：来自控制**总线**（对端口的读信号）

  - **三态门**传递数据：通过三态门将数据传到总线

  - 外设可以**自己做锁存**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227200930915.png" alt="image-20231227200930915" style="zoom:50%;" /> 

- 方法：

  - 内存映射：外设内存和主机内存用**相同**方式编码地址（**不需要**额外读写指令）
  - 部分映射：外设内存只用**部分**内存地址（**需要**额外读写指令）

  =>Intel的**in/out**指令：

  - 在I/O设备和cpu之间传输只有 **AL, AX, or EAX**寄存器

    **EX：**` IN AL, 19H`（后面加**端口号**）

  - 端口号只能放在**D系列**寄存器

    **EX：**` IN AL, DX`（长度**不匹配**但是DX只放端口号所以可以）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227201649407.png" alt="image-20231227201649407" style="zoom:50%;" /> 



#### 4.4.5 新mov指令

 在传数据时**不用**要求两个寄存器长度一定一样（小寄存器/或内存地址写入宽寄存器）

- **MOVZX**：0扩展

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227202229162.png" alt="image-20231227202229162" style="zoom:50%;" /> 

- **MOVSX**：符号扩展

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227202254038.png" alt="image-20231227202254038" style="zoom:50%;" /> 



- **BSWAP** ：字节序调整指令

  - 调整**32位和64位**（16位可以用**XCHG**交换）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227202903862.png" alt="image-20231227202903862" style="zoom:50%;" /> 

  - 如果没有**BSWAP** 需要三条指令，如下图：（**ROR**是循环右移）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227202952823.png" alt="image-20231227202952823" style="zoom:50%;" /> 

  - 编码方式：

    **0F**：表示是扩展的逃逸指令

    **C8**：只需要一个操作码，那么要换的寄存器怎么确定；寄存器位数怎么确定
    => **+rd**表示Opcode**最右边的3位**显然没有用，加上**逃逸前缀**的1位，所以用这3位编码寄存器

    => 64位有**前缀**；所以没有前缀就是32位

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227203209541.png" alt="image-20231227203209541" style="zoom:50%;" /> 

    64位如下图：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227204112504.png" alt="image-20231227204112504" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227204321668.png" alt="image-20231227204321668" style="zoom:50%;" /> 



#### 4.4.6 条件移动指令

- 满足条件才能移动数据 ，如下图：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227205836062.png" alt="image-20231227205836062" style="zoom:50%;" /> 

- 目的必须是寄存器，源操作数可以是内存/寄存器

  作用：avoid a **branch** （不会进行预测，避免预测失败的代价）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227210137764.png" alt="image-20231227210137764" style="zoom:50%;" /> 

  作用：只用一个代码块，以利于**编译优化**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227210612266.png" alt="image-20231227210612266" style="zoom:50%;" /> 



### 4.4.7 **SEGMENT OVERRIDE PREFIX** 

- 不能带**SEGMENT OVERRIDE PREFIX**的指令是**跳转**和使用代码段寄存器生成地址的跳转和调用指令

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227211503199.png" alt="image-20231227211503199" style="zoom:50%;" /> 

### 4.5 **ASSEMBLER DETAIL**

- 有很多伪指令

  - Directives: tell **assembler** how to do
  - Instructions: tell **CPU** what to do

- **Storing Data in a Memory Segment**：

  DB (**define byte**)

  DW (**define word**)

  DD (**define doubleword**) are most **often** used with MASM to define and store memory data.

  DQ (**define quadword**) 

  DT (**define ten bytes**) 

  **DUP**指令：对相同的值进行多个初始化（**100 DUP(6)** reserves 100 bytes of 6）

  - 后面加**(?)**表示还未定义具体大小

  **ALIGN**：对齐长度

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227212525976.png" alt="image-20231227212525976" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227211911696.png" alt="image-20231227211911696" style="zoom:50%;" /> 



**考题**：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227213411602.png" alt="image-20231227213411602" style="zoom:50%;" /> 



- **ASSUME：EQU, and ORG**：宏定义

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227214424042.png" alt="image-20231227214424042" style="zoom:50%;" /> 

- **This**： assign a byte label to a word（对**单个**字节进行重新分配）

- **ORG** (origin) ：change the **starting offset** address of the data in the data segment or code in the code segment.

- **ASSUME** tells the assembler what names have been chosen for the code, **data, extra, and stack segments.** 

- **EX：** **ASSUM**确定CS段是CODE段；DS是DATA段

  结果是**AX = BH + BL**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227215933890.png" alt="image-20231227215933890" style="zoom:50%;" /> 

- **PROC and ENDP**：定义过程

  - 必须跟着一个近或远的后缀

    近程序与程序位于**同一代码段**，通常被认为是本地的

    FAR过程可以位于内存系统的**任何**位置，被认为是全局的

  - **没有参数列表**（要用的要提前在寄存器中准备好）
  
  **EX：**类似函数调用
  
  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228224242303.png" alt="image-20231228224242303" style="zoom:50%;" /> 
  
- **MACRO and ENDM**：定义宏

  - 可以有**参数**
  -  不用**call**，直接用名字+参数

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228224831442.png" alt="image-20231228224831442" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228224843018.png" alt="image-20231228224843018" style="zoom:50%;" /> 

- **INCLUDE**
  - 可以把宏全部放到一个单独的INCLUDE文件
  - 调用时直接用**INCLUDE + filename**

### 4.6 **Memory Organization** （定义段）

- 两种方式：

  - 自己定义各段信息（**full-segment definitions**）
  - 使用宏汇编提供的统一模式（**models**）

- **Full-Segment Definitions**：需要

  - SEGMENT
  - ENDS
  - ASSUME ：一般放在代码段**第一条**，表示属于什么段
  - END：后面可以加一个**label**指示当前段的入口

  段的属性：读写权限；对齐方式；是否允许合并相同名字的段（**combine**）；使用什么操作模式（**use**）；

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228225530412.png" alt="image-20231228225530412" style="zoom:50%;" /> 

  

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228230039685.png" alt="image-20231228230039685" style="zoom:50%;" /> 

  完整代码示例：（段的名称可以做**段地址**）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228230509046.png" alt="image-20231228230509046" style="zoom:50%;" /> 

- **.model**指令包括实模式的6个内存模型，即tiny, small, compact, medium, large, and huge.；以及保护模式的flat

  - **tiny**：代码段、数据段、堆栈段在一起
  - **small**：代码段和数据段、堆栈段在一起
  - **medium**：代码段可以**多个**，数据段、堆栈段在一起
  - **compact**：代码段一个，数据段可以多个
  - **large**：多个代码段、多个数据段
  - **huge**：多个代码段、多个数据段 + 数据可以大于一个数据段的长度

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228230922432.png" alt="image-20231228230922432" style="zoom:50%;" /> 

  **EX：**

  段不需要ENDS；使用类似**@DATA** 来表示段的名称和基地址；不需要**ASSUME**

  **@DATA**实际上是**立即数**（不能load到段寄存器）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228231329659.png" alt="image-20231228231329659" style="zoom:50%;" /> 



## 第五章、算术和逻辑指令

### **5.1** 加减及比较 

- **ADD**：两操作数

  **EX：**（可以加内存中的数据）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228232818217.png" alt="image-20231228232818217" style="zoom:50%;" /> 

- **ADC**：两操作数 + **EFLAGS中的进位**（三操作数）

  - 加数很长结果不能使用一个寄存器保存，需要切开相加，此时用ADC可以加上低位部分的进位（低位相加前要用**CLC**指令清除进位）

  **EX：**（数据是32位对齐）

  下面的代码是不对的（**CMP**会修改进位）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228234028084.png" alt="image-20231228234028084" style="zoom:50%;" /> 

  - 可能影响并行（**CF** flag链可能被乱序的指令打破）

    =>新增**ADCX** and **ADOX**指令

    **ADOX**会加上**Overflow flag**而不是**CF flag**

    **ADCX**会加上**CF flag**

    =>**ADCX** and **ADOX**可以并行

    **EX：**使用**xor**将两条进位链都清零；使用**dec**以及**lea**不影响**CF flag**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228235124312.png" alt="image-20231228235124312" style="zoom:50%;" /> 

- **INC**：加一操作

  - **INC**之后会更新状态寄存器（但**CF** flag不变）

    Why do the INC instruction not affect the Carry Flag (CF)?

    在循环中使用INC（i++）如果修改进位，可能会打断实际计算在每轮循环的**进位传递**，这样的话需要额外保存进位信息

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228233507778.png" alt="image-20231228233507778" style="zoom:50%;" /> 

  - 指令比ADD更**短**

  - 递增内存指令必须加上长度伪指令（指定递增数字的字节数）

- **XADD**（**80486**指令）：

  – **exchanges** the des operand with the src operand

   **src ⇔ des**

  – loads the sum of the two values into the des operand

   **des = des + src**

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231228235831574.png" alt="image-20231228235831574" style="zoom:50%;" /> 

  可以用来做**optimistic locking**（高并发、低数据冲突情况）

  **EX：**更新版本号的同时保存旧版本号，比较保存的旧版本号与之前加载的版本号，相同说明正确（没有并发的操作在这个过程中改变版本号），不同则要retry

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229000120931.png" alt="image-20231229000120931" style="zoom:50%;" /> 
