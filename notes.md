# 汇编与接口笔记

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

## 3.1 介绍

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



## 3.2 寄存器寻址

- 寄存器寻址：The most **common** form of data addressing

  注意长度匹配：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223231607951.png" alt="image-20231223231607951" style="zoom:50%;" /> 



## 3.3 立即数寻址

- 立即数寻址：

  - 立即数是`constant`的，从寄存器或内存传输数据是变量

  - 可能产生歧义，不知道是立即数还是标签 => 加前导0

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231223232307230.png" alt="image-20231223232307230" style="zoom:50%;" /> 

  - 二进制数 => 后面加`B`

  -  ASCII码 => 加单引号



## 3.4 内存寻址

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



## 3.5 其他

- **Canonical Addressing and Canonical Form** （规范寻址）：没有用的高位地址不能随便赋值，只能用**符号位**填充

  – **canonical** address: FFFF8010BC001000,；00007C80B8102040

  – **non-canonical** address: 1122334455667788, 3375DA44B5667788 

  If the memory address is a non-canonical form, a general-protection **exception** (#GP) is generated

  EX：`MOV RAX, [1122334455667788H]`



- **AT&T和 Intel** 的差异：

  AT&T更**复杂**，冗余更多，**显式**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214454941.png" alt="image-20231224214454941" style="zoom:40%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231224214514330.png" alt="image-20231224214514330" style="zoom:40%;" />  



## 3.6 **总结**

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



## 3.7 代码寻址

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

    

## 3.8 栈寻址

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

## 4–1 MOV 指令

### 4.1.1 指令模式

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



### 4.1.2 Opcode—1 byte

基本格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221117179.png" alt="image-20231226221117179" style="zoom:50%;" /> 

- **D**位：1表示数据**流入**寄存器；0表示**流出**

  即：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221324675.png" alt="image-20231226221324675" style="zoom:50%;" /> 

- **W**位：1,表示data size 是 **word 或 doubleword**；0表示data size 是 **byte**

  - 当16位模式需要访问**32位**寄存器时要加**67H address prefix**

  - 当32位模式需要访问**16位**寄存器时要加**66H operand prefix**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226221648322.png" alt="image-20231226221648322" style="zoom:50%;" /> 



### 4.1.3 MOD Field—2 bytes

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



### 4.1.4 Scaled-Index—1 byte

基本格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223151495.png" alt="image-20231226223151495" style="zoom:50%;" /> 

- **ss**只有2 bit，所以系数只能如下：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223240669.png" alt="image-20231226223240669" style="zoom:50%;" /> 

- **EX：**（很清晰）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226223320517.png" alt="image-20231226223320517" style="zoom:50%;" /> 



### 4.1.5 64位模式下的扩展

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



### 4.1.6 Legacy Prefixes

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



### 4.1.7 **Escape Sequence**

6位的Opcode不够了，因此要进行扩展

=>using one escape opcode byte (**0FH**) or two-byte escape (**0F38H, 0F3AH**)

**EX：**

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231226232120562.png" alt="image-20231226232120562" style="zoom: 67%;" /> 



## 4.2 **LOAD**指令

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



## 4.3 STRING DATA TRANSFERS

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



### 4.3.1 **LODS**

- 作用： transfers a byte, word or doublewordfrom the source location **DS:SI** to **AL, AX or EAX**

  – LODSB : ±1 is added to DS: SI/ESI

  – LODSW: ±2 is added to DS: SI/ESI

  – LODSD : ±4 is added to DS: SI/ESI

- 使用 **implicit operands** (AL, AX, EAX)，根据写入的字节数选择

- **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227001930843.png" alt="image-20231227001930843" style="zoom:50%;" /> 

- 特殊性：**唯一不用加repre前缀**（目的寄存器只有一个）

  

### 4.3.2 **STOS** 

- 作用：store **AL, AX, or EAX** to the destination location ES:DI

  – STOSB : ±1 is added to ES: DI/EDI

  – STOSW: ±2 is added to ES：DI/EDI

  – STOSD : ±4 is added to ES：DI/EDI

- 可以加repre前缀（比如初始化一片内存）

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227002552594.png" alt="image-20231227002552594" style="zoom:50%;" /> 



### 4.3.3 **MOVS** 

- 唯一内存到内存的传输

- 作用： transfers a byte, word, or doubleword from **DS: SI** to **ES: DI** and updates SI and DI 

  – MOVSB : ±1 is added to DS: SI and ES: DI

  – MOVSW: ±2 is added to DS: SI and ES: DI

  – MOVSD : ±4 is added to DS: SI and ES: DI

- **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227002836083.png" alt="image-20231227002836083" style="zoom:50%;" /> 



### 4.3.4 **INS**/**OUTS** 

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



## 4.4 其他数据传输指令

### 4.4.1 **XCHG**

- 交换两个寄存器/一个**通用**寄存器和内存的值（不能是段寄存器和内存交换）

- 交换粒度： byte-, word-, or doubleword

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227004248956.png" alt="image-20231227004248956" style="zoom:50%;" /> 

### 4.4.2 **LAHF and SAHF** 

- LAHF instruction transfers the **lower 8 bits** of the **EFLAGS** register into the **AH** register.

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227004613007.png" alt="image-20231227004613007" style="zoom:50%;" /> 

- SAHF相反

  注意会忽略 **bits 1, 3, and 5** ，因为这些位是保留的

- 使用时要通过检测：

  **CPUID.80000001H: ECX.LAHFSAHF[bit 0] = 1.**



### 4.4.3 **XLAT**

-  implicit operands (**AL, BX**)

- 等价于**MOV AL, [seg:BX + AL]**

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231227005225174.png" alt="image-20231227005225174" style="zoom:50%;" /> 



### 4.4.4 **Input Ports and Output Ports**

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



### 4.4.5 新mov指令

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



### 4.4.6 条件移动指令

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

## 4.5 **ASSEMBLER DETAIL**

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

## 4.6 **Memory Organization** （定义段）

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



# 第五章、算术和逻辑指令

## **5.1** 加减及比较 

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

    **EX：**使用**xor**将两条进位链都清零；使用**dec**以及**lea**不影响**CF flag**（但是会改**OF flag**，所以还是错的）

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

  **EX：**更新版本号的同时保存旧版本号，比较保存的旧版本号与之前加载的版本号，相同说明正确（没有并发的操作在这个过程中改变版本号），不同则要retry（要进行回退，这些额外的操作会降低性能，所以乐观锁适用于冲突较少的情况）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229000120931.png" alt="image-20231229000120931" style="zoom:50%;" /> 
  
- **SUB**：基本与加法相同

  **DEC**：递减1（同样**CF** flag不变，所以后面如果有跳转指令可能不止依赖于DEC）

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229214507096.png" alt="image-20231229214507096" style="zoom:50%;" /> 

- comparison instruction (**CMP**)：a **subtraction** that changes only the **flag** bits.

  - 操作数为寄存器或内存都可以

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229215136970.png" alt="image-20231229215136970" style="zoom:50%;" /> 

- **CMPXCHG**：比较后交换

  - implicit operand：CMPXCHG CX,DX (**AL/AX/EAX**)

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229220212413.png" alt="image-20231229220212413" style="zoom:50%;" /> 

  - 扩展到64位及更多：**CMPXCHG8B/CMPXCHG16B**

    需要**implicit operand**

    64位：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229221522843.png" alt="image-20231229221522843" style="zoom:50%;" /> 

    128位：换成**RDX:RAX**，**RCX:RBX**

## 5.2 乘除法

### 5.2.1 乘法

 unsigned integer (**MUL**)：

- implicit operand放在**A**系列寄存器中（结果长度要是乘数的2倍）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229222709233.png" alt="image-20231229222709233" style="zoom:50%;" /> 

- 无符号数乘法**不能**直接乘**立即数**（unless the two or three-operand form of IMUL multiplication）

- 8位：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229223235974.png" alt="image-20231229223235974" style="zoom:50%;" /> 

- **16-Bit Multiplication**：

  - **AX**做被乘数
  - 结果放在DX–AX（拼起来，DX放高16位；AX放低16位）

- **32-Bit Multiplication**：

  - **EAX**做被乘数
  - 结果放在EDX–EAX（拼起来，EDX放高32位；EAX放低32位）

- **64-Bit Multiplication**：

  - **RAX**做被乘数
  - 结果放在RDX–RAX（拼起来，RDX放高32位；RAX放低32位）



 signed integer (**IMUL**)：

- 三种形式：

  - **one-operand** form: 和无符号相同

  - **two-operand** form: 由于要把结果放到目的操作数中，如果有进位就会出现**截断**；可以乘立即数

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229224135206.png" alt="image-20231229224135206" style="zoom:50%;" /> 

  - **three-operand** form: the first source operand is multiplied by the second source operand；同样可能阶段；可以乘立即数

     <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229224435094.png" alt="image-20231229224435094" style="zoom:50%;" /> 



- 有符号乘法和无符号乘法的区别：

  **高位扩展**不同

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229224724711.png" alt="image-20231229224724711" style="zoom:50%;" /> 

  **无符号**乘法对标志位的改变：（高位全0则CF和OF都置0；否则都置1）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229224949852.png" alt="image-20231229224949852" style="zoom:50%;" /> 

  **有符号**乘法对标志位的改变：（高位和低位的符号位相同则CF和OF都置0；否则都置1）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229225235592.png" alt="image-20231229225235592" style="zoom:50%;" /> 

  =>根据CF和OF可以判断多操作数相乘时是否**截断**



### 5.2.2 除法

- There is no immediate division instruction available to any microprocessor（不能有立即数）

- **8-Bit Division**：

  - 被除数放在AX中（implicit operand）

  - AL := quotient, AH := remainder

    为什么反过来放？

    =>对余数补0继续除比较方便（AL置0就可以）

  - 余数的符号：保持与被除数相同

  **EX：**注意要先0扩展

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229231452594.png" alt="image-20231229231452594" style="zoom:50%;" /> 

- 其余16/32/64位类似

- 符号扩展方法：

  - **CBW/CWDE/CDQE**是将**A**系列寄存器带符号扩展一级

  - **CWD/CDQ/CQO**将**A**系列寄存器中的符号位复制到**D**系列寄存器的所有位（除法被除数用的）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229232123290.png" alt="image-20231229232123290" style="zoom:50%;" /> 

  - **MOVSX/MOVSXD**： 符号扩展将源操作数（寄存器或内存）复制到目标操作数（寄存器）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231229232438040.png" alt="image-20231229232438040" style="zoom:50%;" /> 

  - **MOVZX** ：0扩展
  
- **The Remainder**：三种舍入方式：

  - dropped to truncate the quotient（直接截断）
  - round the quotient（四舍五入）
  - fractional remainder（保存成小数）

  **EX：**余数×2和除数比较进行四舍五入

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230152623307.png" alt="image-20231230152623307" style="zoom:50%;" /> 

  对余数补0继续除得到分数结果

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230152804514.png" alt="image-20231230152804514" style="zoom:50%;" /> 



## 5.3 **BCD and ASCII** 

在64位模式下**无效**。在64位中使用这些指令将生成一个无效操作码（**#UD**）异常

### 5.3.1 **BCD**

- DAA (**decimal adjust after addition**) instruction follows BCD addition

  DAS (**decimal adjust after subtraction**) follows BCD subtraction

  在加减操作后把结果调整为BCD码格式：

  在出现不是0~9或者AF = 1时将结果+6

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230153324249.png" alt="image-20231230153324249" style="zoom:50%;" /> 



### 5.3.2 **ASCII** 

Four instructions in ASCII arithmetic operations（将寄存器**AX**作为源和目标寄存器）:

– AAA (**ASCII adjust after addition**)

– AAS (**ASCII adjust after subtraction**)

– AAM (**ASCII adjust after multiplication**)

– AAD (**ASCII adjust before division**)

- AAA instruction adjusts the value in **AL** register to an **unpacked BCD** result

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230153822754.png" alt="image-20231230153822754" style="zoom:50%;" /> 

- 其他类似



## 5.4 逻辑指令

- 所有的逻辑指令都会影响**标志**位，除了**NOT**

  怎么影响:

  – clear the **OF and CF** flags

  – change the SF, ZF, and PF flags to reflect the result

  – the state of the AF flag is undefined

### 5.4.1 **Test and Bit Test Instructions** 

- **TEST**：执行**与**操作，但不返回结果，只改变**标志**位（类似CMP）

  **EX：**判断最高位和最低位是否为1

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230154329203.png" alt="image-20231230154329203" style="zoom:50%;" /> 

- **TEST same,same**用于确定有符号的数字是否大于零（比CMP编码更短，没有后面的立即数）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230154517182.png" alt="image-20231230154517182" style="zoom:50%;" /> 

- **Bit Test**用于置位：

  BTC：取补

  BTR：清除

  BTS：置位

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230154706975.png" alt="image-20231230154706975" style="zoom:50%;" /> 

  

### 5.4.2 **NOT and NEG**

- NOT和NEG（取补码）可以使用除**段寄存器**寻址以外的任何寻址模式

- NEG对标志位的影响：

  – if the operand = 0, then CF = 0, otherwise CF = 1.

  – the OF, SF, ZF, AF, and PF flags are set according to the result

  **EX：**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155114931.png" alt="image-20231230155114931" style="zoom:50%;" /> 



## 5.5 **Shift and Rotate** 

格式：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155211564.png" alt="image-20231230155211564" style="zoom:50%;" /> 

- 算术左移和逻辑左移没有区别：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155325903.png" alt="image-20231230155325903" style="zoom:50%;" /> 

- 算术右移和逻辑右移：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155400847.png" alt="image-20231230155400847" style="zoom:50%;" /> 

- count可以放在**CL**寄存器中

- **SRA**和**IDIV**的舍入是不一致的

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155545656.png" alt="image-20231230155545656" style="zoom:50%;" /> 

  =>为了解决，让**SRA**向**IDIV**看齐

  **EX：**提前补偿，如果被除数是负的，那么被除数+7（如果有余数说明原来被除数后三位不是全0，+7后会进位使商+1）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155641911.png" alt="image-20231230155641911" style="zoom:50%;" /> 



- **Double-Precision Shifts**：移动时source寄存器不会变

  格式：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155912099.png" alt="image-20231230155912099" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230155949890.png" alt="image-20231230155949890" style="zoom:50%;" /> 

  **EX：**注意reg2在高位

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230160141330.png" alt="image-20231230160141330" style="zoom:50%;" /> 



- **Rotate**：循环移位

  格式：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230160245775.png" alt="image-20231230160245775" style="zoom:50%;" /> 

  - O表示不会将CF移进来（会移出去）；C表示会将CF移进来，如下图：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230160440706.png" alt="image-20231230160440706" style="zoom:50%;" /> 

  **EX：**低位使用**RCR**因为需要高位移到CF的值

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231230160556419.png" alt="image-20231230160556419" style="zoom:50%;" /> 



## 5.6 **Bit Scan Instructions**

- **BSF** (bit scan forward) ：从**低位到高位**扫描寄存器/内存，将1的位置放到目标寄存器（必须是**寄存器**）中

- **BSR** (bit scan reverse)： 从**高位到低位**扫描寄存器/内存，将1的位置放到目标寄存器（必须是**寄存器**）中

  扫描到1的话**ZF = 0**

  没有扫描到1的话**ZF = 1**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231175151890.png" alt="image-20231231175151890" style="zoom:50%;" /> 

  - 没有扫描到1的话目标寄存器放入的数未定义

  解决方式=>扩展指令：

  **TZCNT** (trailing zero count) ：计数末尾连续零的数量

  **LZCNT** (leading zero count) ：计数开头连续零的数量

  还要置**CF**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231175418941.png" alt="image-20231231175418941" style="zoom:50%;" /> 



## 5.7 **STRING COMPARISONS** 

- **SCAS**

  - 比较隐含寄存器（**AL, AX, or EAX**）和内存中的（**ES:(E)DI**）寻址内容
  -  direction flag (**D**)选择**ES:(E)DI**的方向
  - 要加**后缀**（SCASB, SCASW, SCASD ）表示比较的大小
  - 可以用条件重复前缀**REPE**（相等时继续比较）或REPNE（不相等时继续比较）

  **EX：**比较一款内存有没有清0

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231180759563.png" alt="image-20231231180759563" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231181206200.png" alt="image-20231231181206200" style="zoom: 50%;" /> 

- **CMPS**：

  将**SI/ESI**寻址的数据段存储器位置的内容与**DI/EDI**寻址的额外段存储器的内容进行比较

  其他与SCAS类似

  



# 第六章、控制指令

（控制指令主要读Flag但不改写）

## 6.1 无条件跳转

unconditional ：

1. short jump：+127 and –128 bytes

2. near jump：±32K bytes

3. far jump：： any memory 

对应的编码如下：

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231181720309.png" alt="image-20231231181720309" style="zoom:50%;" /> 

- **short jump和near jump**的offset是相对于**当前PC**的

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231182037889.png" alt="image-20231231182037889" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231183736779.png" alt="image-20231231183736779" style="zoom:50%;" /> 

- **near jump**编译出来后面用一个**R**表示未确定（实际跳转的数量要到link之后才能确定）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231183304507.png" alt="image-20231231183304507" style="zoom:50%;" /> 

- **far jump**后面是跳转的地方（段的基地址需要**2次**重定位，在link后还是不确定）

  Two ways to obtain a **far** jump

  – uses a FAR PTR directive, e.g., JMP **FAR** PTR START.

  – defines a far label, e.g., **EXTRN** START:FAR.；START::（**两个冒号**）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231185215891.png" alt="image-20231231185215891" style="zoom:50%;" /> 

- **Jumps with Register Operands**：使用一个16位或32位的寄存器作为一个操作数

  - 直接跳到寄存器内容的地址
  - 将寄存器写到IP（当前PC）中

- **Indirect Jumps Using an Index**：跳转指令也可以使用[]寻址形式（例如，JMP TABLE[SI])来直接跳转到TABLE + SI的地方



## 6.2 条件跳转

Conditional jump instructions test flag bits:

– **sign (S), zero (Z), carry (C)**

– **parity (P), overflow (O)** 

**EX：** **JC** will jump if the carry bit is set

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231190954560.png" alt="image-20231231190954560" style="zoom:50%;" /> 

- 有符号比较：

  **JG, JL, JGE, JLE, JE, JNE** instructions.

- 无符号比较：

  **JA, JB, JAE, JBE, JE,  JNE**（above and below）

总结：(注意最下三条指令的条件的C系列寄存器为0,也就是计算器是否为0)

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20231231191435574.png" alt="image-20231231191435574" style="zoom:50%;" /> 



## 6.3 条件设置指令

**SETcc**指根据EFLAGS状态位进行条件判断

- 如果满足指定的条件（cc），则将**指定的8位内存位置或寄存器**的值设置为1。
- 如果标志不满足指定的条件，则SETcc将内存位置或寄存器清零为0。
- 用途：不立即跳转，做一些判断后再跳转（保存此时的判断，后面再用）/设置函数的返回值

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113211926835.png" alt="image-20240113211926835" style="zoom:50%;" /> 

情况由条件跳转得出

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113211616298.png" alt="image-20240113211616298" style="zoom:50%;" /> 



- **LOOP**：循环（使用**RCX/ECX/CX**作为计数器）

  - LOOP指令相当于以下两条指令的组合：

    - DEC RCX/ECX/CX：将**计数器减1**（老师说这里只是近似，因为DEC不改变FLAG所以不对？但是DEC不是只不影响CF吗？所以没什么问题？

      ----------几分钟后老师说刚才讲错了）

    - JNZ label：检查计数器是否不等于0，如果不等于0，则进行近跳转到指定的label，否则跳出循环

  - 可以加后缀：LOOPE  = LOOPZ/ LOOPNE =  LOOPNZ（判断**Z** flag）



- **高级语言**loop转换：

  - **Do-while**-loop：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113215838600.png" alt="image-20240113215838600" style="zoom:50%;" /> 

  - **While**-loop ：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113215941661.png" alt="image-20240113215941661" style="zoom:50%;" /> 

  - **For**-loop in ：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113220116304.png" alt="image-20240113220116304" style="zoom:50%;" /> 

## 6.4 控制流伪指令

- .WHILE；–.ENDW； .REPEAT； .UNTIL；.UNTILCXZ；.BREAK；.CONTINUE；.IF；.ENDIF；.ELSE；.ELSEIF（前面有个`.`）

- **Operators for Conditional Control Flow**

   <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113220543549.png" alt="image-20240113220543549" style="zoom:50%;" /> 

  EX :把数字的ASCLL码转成16进制，但是A~F和数字之间有一些其他符号的间隔，所以减7后再减'0'

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113220921351.png" alt="image-20240113220921351" style="zoom:50%;" /> 

- **WHILE Loops**：

  .WHILE； .ENDW ；.BREAK ； .CONTINUE

- **REPEAT-UNTIL Loops** ：

  .REPEAT；.UNTIL（+ 条件）；.UNTILCXZ（检查CX来判断）



## 6.5 **PROCEDURES**

### 6.5.1 PROC

- **PROC**开始，**ENDP**结束。
  - 每个指令都包含过程的名称。
- 指定了过程的类型：NEAR或FAR。
- **RET**退出（必须要有）
- PROC + **USES** + register可以自动保存和恢复register（类似临时变量）

EX：near return和far return的机器码不同（far return需要去堆栈读段的数据）

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113222323285.png" alt="image-20240113222323285" style="zoom:50%;" /> 

### 6.5.2 CALL

**CALL**将后面的返回地址（可以是寄存器中的值或偏移量）推入栈

**RET**从栈中弹出返回地址

缺点：连接到过程并返回过程所需的**时间**

四种不同类型的call：

- **Near call** (intrasegment call): 在当前代码段内调用过程。

  两种方式

  - a relative offset (加相对当前**PC**的偏移量).

  - absolute offset in the code segment (加相对于当前**段**的偏移量）

  EX：注意要push返回地址

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113223453261.png" alt="image-20240113223453261" style="zoom:50%;" /> 

-  **Far call** (intersegment call): 调用位于与当前代码段**不同段**中的过程。

  一个5字节的指令，**opcode + IP + CS**

  - 第2和第3字节为IP的新内容
  - 第4和第5字节为CS的新内容（ 在跳转到指定的地址之前，将IP和CS的内容都压入栈中）

  EX：注意返回地址push的是段地址+pc

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113223731300.png" alt="image-20240113223731300" style="zoom:50%;" /> 

- **Inter-privilege-level far call**：对当前执行程序的**特权级别不同**的段中的过程进行远调用。

- **Task switch**：调用位于不同任务中的过程。

- **RET n**：返回时清理栈里面的n个字节

  EX：很清晰

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240113224245563.png" alt="image-20240113224245563" style="zoom:50%;" /> 
  
  

-  调用**不同权限**的内容（ inter-privilege-level far call）

  三种方法：（一定是**far call**）

  - 定义代码段(描述符)的时候标记**conforming code segments**来共享库

  - **Gates**：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115110729068.png" alt="image-20240115110729068" style="zoom:50%;" /> 

  - **syscall**



### 6.5.3 **INTERRUPTS** 

- service procedure (**ISP**)：中断处理程序

- 中断事件发生→产生**interrupt vector**→索引interrupt vector table（实模式）or interrupt descriptor table （保护模式）

- 外部中断（I/O设备发出）：

  分为可屏蔽中断和不可屏蔽：

  - 可屏蔽中断通过**INTR**引脚触发，当**FLAGS.IF=1**时才触发。FLAGS.IF为0将屏蔽。
  - 不可屏蔽中断总会触发。

  开中断指令： set interrupt flag instruction (**STI**) →enables  INTR

  关中断指令： clear interrupt flag instruction (**CLI)**→disable INTR

- 内部异常

  三种异常：

  - Program-Error ：除0
  - Software-Generated：越界检测
  - Machine-Check ：内部芯片‘

  另一种分类：

  - Precise exception：精确知道异常位置，要返回重新正确执行
  - Imprecise exceptions：异步、无法重启修复

  功能分类：

  - Faults：precise exceptions，返回异常指令
  - Traps：precise exceptions，返回下一条指令
  - Abort：Imprecise exception

- 介绍一个有趣的异常**Double Fault**：

  就是异常处理程序再抛出异常，但是有条件：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115113450924.png" alt="image-20240115113450924" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115113136797.png" alt="image-20240115113136797" style="zoom:50%;" /> 

  如果Double Fault处理时在出现异常→triple fault→系统挂了

- **Error Code**：报告一些异常的错误和状态信息。

  - 在控制转移到异常处理程序期间，异常机制将Error Code压入堆栈中。
  - 两种格式：
    - selector format：用于报告错误的异常。
    - page-fault format：用于页面故障。

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115113819978.png" alt="image-20240115113819978" style="zoom:50%;" /> 

- 中断有优先级

- **Real-Mode**的中断：

  interrupt vector table (IVT)：基地址是0（初始化时就建立好）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115114159380.png" alt="image-20240115114159380" style="zoom:50%;" /> 

  流程：

  - FLAGS压栈
  - FLAGS.IF 置0关闭中断
  -  CS and IP 压栈stack（返回地址）
  - 在中断向量表找对应ISP
  - 进入中断向量程序（通过CS:IP in the IDT）
  - 返回： **IRET**（far return；入栈的FLAG会恢复）/ 保护模式用**IRETD**



- **Interrupt Instructions**:

  INT N(中断向量号), INT1, INT3 and INTO（overflow）

  - **INT N**：实模式下$N \in 0 \to 255$，每个中断向量**4字节**，所以在中断向量表中的地址是**N×4**

    相当与far call +  pushes the flags onto the stack + 关闭中断

    与far call对比：

    - INT N 2个字节，far call5个字节
    - EFLAGS
    - IRET

    **考题**: INT 100 在中断向量表的地址：190H–193H (64H 乘 4)

  - **INT3**：1-byte instruction (**0xCC**)

    **EX：**假设原始指令为0x8345fc01（ADD DWORD PTR[ebp-0x4]，0x1，当在GDB中break个地址（打断点），它将记住这个指令的第一个字节（0x83），并将这个字节更改为（0xcc45fc01）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115121428685.png" alt="image-20240115121428685" style="zoom:50%;" /> 

    程序运行到这个CC会发生异常，将控制器交给GDB来实现断点，之后恢复时要在把CC换成83，同时把返回的地址设为这条指令（这个中断是**trap**）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115121835253.png" alt="image-20240115121835253" style="zoom:50%;" /> 

    **为什么要用INT3（单字节） 而不是 INT 3（双字节）**：如果第二个字节有label，那么你打断点的时候改了这个地方，如果程序调转到这里就会出错

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115122118098.png" alt="image-20240115122118098" style="zoom:50%;" /> 

  - **INTO**：主动测试overflow

    -If O = 1 an overflow trap is generated via vector type number **4**

    – If O = 0, INTO performs no operation

## 6.6 其他控制指令

- 控制**Carry Flag**：

  STC (set carry), CLC (clear carry), and CMC(complement carry)

- **HLT**：主动停机

  恢复运行方式：

  – an enabled interrupt (NMI and SMI)

  – a debug exception

  – a hardware reset (BINIT#, INIT# or RESET# signal) 

- **NOP**：空操作

  **Multi-byte NOP**：用来对齐

- **LOCK Prefix**

  要求必须是写指令（目的操作数是内存）：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115123218612.png" alt="image-20240115123218612" style="zoom:50%;" /> 

  LOCK不正确的地方会产生 undefined opcode exception (#UD)，三种情况：

  - LOCK + 非算术或逻辑指令
  - 目的操作数不是内存
  - 源操作数是内存（想想为什么）

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115123625651.png" alt="image-20240115123625651" style="zoom:50%;" /> 

- **BOUND**：检测索引是否在内存中

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115123829741.png" alt="image-20240115123829741" style="zoom: 50%;" /> 

  EX:

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115124443335.png" alt="image-20240115124443335" style="zoom:50%;" /> 

- **ENTER and LEAVE**

   **stack frame**：嵌套调用时每个函数开辟一个stack frame；运行时产生，内容包括：

  – Argument parameters

  – Return address

  – Local variables

  – Saved copies of registers modified by the called procedures (the *callee*) that need restoration

  EX：ENTER代替蓝色部分，LEAVE代替黄色部分

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115125051362.png" alt="image-20240115125051362" style="zoom:50%;" /> 

  ENTER语法：<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115125225052.png" alt="image-20240115125225052" style="zoom:50%;" /> 

   nesting level ：确定在调整堆栈指针之前从前一帧**复制到新堆栈帧的堆栈帧指针的数量**，这允许从被调用的函数访问多个父帧

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115125420284.png" alt="image-20240115125420284" style="zoom:50%;" /> 

 

# 第七章 、向量化

- **Promises of Vectorization**：speedup与vector width.成正比；Serial portions of code 和 memory bandwidth会有限制

- **vs Parallelism**：指令级并行；单线程

- **Lane and Slot**：一个寄存器中的多条并行通道

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115135901900.png" alt="image-20240115135901900" style="zoom:50%;" /> 

- **Vectorization Factor**：向量的最大的元素数量

- **Stride**：向量的元素间的跨度

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115140242678.png" alt="image-20240115140242678" style="zoom:50%;" /> 

- **SIMD**方法：

  – a vectorizing compiler（编译器自动）

  - SLP-based vectorization (SLP)：非循环，挖掘同构指令

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115140759063.png" alt="image-20240115140759063" style="zoom:50%;" /> 

  - Loop-based vectorization (LV)：循环展开

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115140821125.png" alt="image-20240115140821125" style="zoom:50%;" /> 

  EX：二者相结合

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115141005408.png" alt="image-20240115141005408" style="zoom:50%;" /> 

  - 主要问题：编译器不知道数据依赖的具体信息

    解决方式：添加伪指令告诉编译器没有数据依赖、三元运算符、适合向量化的数据结构

  - 优点：简单地实现向量化、代码可移植、没有依赖性

  - 要求：

    - 知道循环计数（处理尾巴）
    - 不要分支
    - 减少数据依赖
    - Non-unit stride access会阻碍向量化
    - 只能做内层循环
    - 调用I/O不容易向量化（内联函数可以）

  - **Auto-vectorization Fails**怎么办：

    -  compiler directive

      EX：K≥0时可以向量化

      <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115142850156.png" alt="image-20240115142850156" style="zoom:50%;" /> 

      How to tell the compiler that k ≥ 0 ？

      加上 **\#pragma ivdep**

      <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115143013843.png" alt="image-20240115143013843" style="zoom:50%;" /> 

    - **Pointer Aliasing**：传进来的指针之间可能有数据依赖

      <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115145139318.png" alt="image-20240115145139318" style="zoom:50%;" /> 

      可以在指针前加 “restrict” 告诉编译器做向量化

    - **Data Alignment**：使编译器需要的判断减少

  – SIMD intrinsics（向量化指令）

  - 原则：编译器自动替换汇编指令；隐藏汇编指令但一对一映射；本质上在写汇编

  - 优点：使用简单；发挥全部性能

  - 缺点：很长，太底层；要针对不同处理器

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115150501495.png" alt="image-20240115150501495" style="zoom:50%;" /> 

  - 格式：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115150834827.png" alt="image-20240115150834827" style="zoom:50%;" /> 

  - **Permute instructions**：重排向量元素

    根据mask排序（注意小端的排序，可以重复一个部分，高位和低位分别重排）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115152117781.png" alt="image-20240115152117781" style="zoom:50%;" /> 

  - **Shuffle intrinsics**：混合重排两个向量到一个向量

    向量的lane只能取一次

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115152843651.png" alt="image-20240115152843651" style="zoom:50%;" /> 

  - **Pack and unpack instructions**：

    从后缀lo/hi选择从高/低位开始依次重排两个向量

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115153052865.png" alt="image-20240115153052865" style="zoom: 50%;" /> 

  - **AVX** instructions are defined as **in-lane**：把256位的操作分成128位来做

    注意比如lo是将两个128位部分的低位进行unpack

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115154938627.png" alt="image-20240115154938627" style="zoom:50%;" /> 

  **EX：**矩阵转置

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115161056630.png" alt="image-20240115161056630" style="zoom:50%;" /> 

  - **SVE**：可伸缩向量化指令（长度可以不固定）=> 向量长度无关编程

    predicate register：可以开放和关闭lane

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115161812477.png" alt="image-20240115161812477" style="zoom:50%;" /> 

  – vector library (库)

  – assembly language

- 向量化的先决条件：

  - 同构指令(Feasibility)
  - 没有数据依赖 (Validity/Correctness)
  - 数据对齐 (Efficiency)

- 向量化的挑战

  - Conditional Statements
  - Data Dependences
  - Pointer Aliasing
  - Data Alignment
  - Non-unit Strides
  - Profitability Analysis

- **Data Dependence Analysis**

  statement S依赖于statement T（T在S之前）如果发生：

  - 访问同一个目标

  - 至少有一个在写

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115164107851.png" alt="image-20240115164107851" style="zoom:50%;" /> 

  三种依赖：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115164228013.png" alt="image-20240115164228013" style="zoom:50%;" /> 

  四种依赖情况：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165124670.png" alt="image-20240115165124670" style="zoom:50%;" /> 

  - **Loop-independent Dependence**：依赖在循环之中，去掉循环还是依赖

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165528060.png" alt="image-20240115165528060" style="zoom:50%;" /> 

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165547556.png" alt="image-20240115165547556" style="zoom:50%;" /> 

  - **Loop-carried Dependence**

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165658333.png" alt="image-20240115165658333" style="zoom:50%;" /> 

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165724438.png" alt="image-20240115165724438" style="zoom:50%;" /> 

  EX:

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115165945268.png" alt="image-20240115165945268" style="zoom:50%;" /> 

  - 图里有环可能不能向量化；没有环可能可以做向量化

- 数据依赖测试：

  - 依次测试每个维度的下标是否有依赖，如果有没有依赖的维度就说明可以向量化

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115171630627.png" alt="image-20240115171630627" style="zoom:50%;" /> 

  - 测试的结果：No dependence；Dependence；Not sure（a dependence test exact if it only reports 

    answers 1 or 2. Otherwise, it is inexact.

  - 测试方法：

    1. △测试（exact test）：分别假设 a[i+1] 和 a[i] 是源，用目的加上△等于源算出△，如果△可能出现说明有对应的依赖

       <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115172348028.png" alt="image-20240115172348028" style="zoom:50%;" /> 

       <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115172544057.png" alt="image-20240115172544057" style="zoom:50%;" /> 

       多维失效（方程数不够产生Diophantine equation）

    2. **GCD Test**（ inexact test,可以判断一些一定有数据依赖的情况）：

       Diophantine equation `a1×i1 + a2×i2 +...+ an ×in = c`有整数解等价于gcd(a1 ,a2 ,...,an ) 整除 c

       <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115173140896.png" alt="image-20240115173140896" style="zoom:50%;" /> 

       <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115173309533.png" alt="image-20240115173309533" style="zoom:50%;" /> 

    3. **Banerjee Test**（ inexact test,可以判断出可能有依赖） :

       就是相减算最大值和最小值，如果范围中有0说明可能有依赖

       <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115173531793.png" alt="image-20240115173531793" style="zoom:50%;" /> 

- **向量化代码变换**（不考且没时间写了）



# 第八章 8086/8088硬件技术规范

## 8.1 **PIN-OUTS AND THE PIN FUNCTIONS** 

### 8.1.1 **Pin-Out** 

- 8086：16-bit microprocessor ；16-bit data bus（AD0 –AD15）

  Minimum Mode

  – The **simplest and least** **expensive** mode.

  – 只有一个CPU作为主CPU，其他都是外部设备

  Maximum Mode:

  – Allows the system to use an **external coprocessor** such as 8087 (floating-point coprocessor) .

  – Some of the control signals must be **externally generated** (通过总结交互)

  如下所示：

  - VCC (+5 V的电压)
  - GND(两头接地：防止引线过长；分担电流强度；分开模拟信号和数字信号，否则数字信号会破坏模拟信号)
  - 引脚33置1表示最小模式（影响31\~24，变成粉色的控制信号）；置1表示最大模式（31\~24是内部状态信号）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115181853557.png" alt="image-20240115181853557" style="zoom:50%;" /> 

  8086 **address/data bus** lines are **time** multiplexed address and data bus lines（数据和地址的时钟不同）

  - **ALE**置1：内存地址或I/O端口号（复用的）

    ALE置0：数据

  - **M/IO**置1：地址信号

    M/IO置0：端口号（8088相反）

  - **BHE**：**bus high enable** pin，设置高字节是否有效

  -  **RD**/**WR**：读写信号，低电平有效（低电平更稳定）

  -  **INTR**：中断请求（要看FLAG再进中断）

     **INTA**：响应INTR

  - **NMI**：不可屏蔽中断

  -  **LOCK**：锁定系统上的外设

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115182528658.png" alt="image-20240115182528658" style="zoom:50%;" /> 

- 8088：16-bit microprocessor ；8-bit  data bus （AD0 –AD7）

- DRAM：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115183706248.png" alt="image-20240115183706248" style="zoom:50%;" /> 

- **Memory Bank**：8086可以以字节粒度访问是由于Bank的组织方式按字节

  同时访问两个Bank表示双字节访问；一个Bank就是单字节

  A0判断偶Bank是否有效；BHE判断奇Bank是否有效

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115184117675.png" alt="image-20240115184117675" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115184456403.png" alt="image-20240115184456403" style="zoom:50%;" /> 

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115184640924.png" alt="image-20240115184640924" style="zoom:50%;" /> 

  非对齐内存访问：两个周期分别写（效率下降）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115185709199.png" alt="image-20240115185709199" style="zoom:50%;" /> 



# 第九章 接口

硬件接口是指不同设备的连接和通信

要处理：内外速度不同（缓存）；信号规则不同；功率驱动不同

- 分类：

  Directions of information flow

  – Input interface

  – Output interface

  Types of signal

  – Analog interface

  – Digital interface

  Types of data transmission

  – Serial interface

  – Parallel interface

- 接口内容：

  - Data Bus Buffer（存数据）
  - chip select（选择使能用到的chip）
  - Control and Status register（控制接口，返回状态给CPU）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115210114246.png" alt="image-20240115210114246" style="zoom:50%;" /> 

- How to connect I/O devices with CPU？

  – Latches for output interface（输出时放到锁存器然后去做其他事）

  – Three state buffers for input interface（通过三态门做总线的隔离）

  Several solutions:

  - unconditional transfer for always-on devices（对于没有时序的外设比如开关）
  - strobing 
  - handshaking and polling
  - interrupt-driven I/O
  - channel-based I/O (e.g., DMA)

- How to provide address space for I/O devices?

  – Two schemes: **Isolated** I/O or **Memory mapped** I/O.

  -  Isolated I/O：外设端口独立编址

    好处：端口是独立的

    坏处：需要额外空间，以及额外的控制信号

  - Memory mapped I/O

    好处：任何内存传输指令都可以访问I/O设备

    坏处：消耗内存空间

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115212313792.png" alt="image-20240115212313792" style="zoom:50%;" /> 

- How to perform I/O port decoding?

  – Signal involved: memory address, #BHE and #BLE, \#IORC and #IOWC



- **TTL Signal**：

  输入输出电平标准不同（外部的电平可能受干扰大）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115212559268.png" alt="image-20240115212559268" style="zoom:50%;" />  

  要求：

  –输入设备在连接到微处理器时应**兼容**TTL

  –噪声应减少或从输入设备上去除

  - 减少方法（减少抖动）：

    – double-throw switch with flip-flop（会保持信号）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115213256785.png" alt="image-20240115213256785" style="zoom:50%;" /> 

    – double-throw switch with NOT gates（不会状态翻转，会进入高组态）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115213309831.png" alt="image-20240115213309831" style="zoom:50%;" /> 

    – low-pass filter and schmitt trigger

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115213445835.png" alt="image-20240115213445835" style="zoom:50%;" /> 

    – multiple stages shift register sampling（三次采样如果发生震荡，上下结果不一样，触发器不置位）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115213512118.png" alt="image-20240115213512118" style="zoom:50%;" /> 

    – software sampling

- 输出设备的接口电路

  - 需要放大电流驱动输出设备（用三极管联级）
  - 连接转动线圈可能因为电流突然截止产生反向电动势击穿线圈（接带二极管的稳压电路）

- **Basic Input and Output Interfaces** 

  - 基本输入设备是一组连接到数据总线的**三状态缓冲器**

    **IN**指令会使能SEL激活三态门

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115223354119.png" alt="image-20240115223354119" style="zoom: 50%;" /> 

  - 基本输出设备是一组从数据总线存储值的数据**锁存器**

    **OUT**指令提供锁存器的采样信号

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115223612304.png" alt="image-20240115223612304" style="zoom:50%;" /> 

- **Asynchronous Data Transfer** ：

  - strobing (one control signal)：选通信号

    缺点：信号时间长度不确定（选择最长采样时间的设备会降低效率）

    两种方式：

    – source-initiated transfer：源启动数据选通信号，持续一定时间（目的端在这段时间内采样）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115224049339.png" alt="image-20240115224049339" style="zoom:50%;" /> 

    – destination-initiated transfer：目的端向源传递选通信号，源收到后开始传输数据

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115224151514.png" alt="image-20240115224151514" style="zoom:50%;" /> 

  - **handshaking method**：

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115224442012.png" alt="image-20240115224442012" style="zoom: 50%;" /> 



## 9.2 地址译码

主要过程：高5位激活译码器，低三位选择通道；需要控制信号WR（out指令）和IO/M信号；把数据传到锁存器

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115224702276.png" alt="image-20240115224702276" style="zoom:50%;" /> 

- **Decoding 8-Bit I/O Port Addresses**：

  高5位激活译码器，低三位选择通道

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115231647758.png" alt="image-20240115231647758" style="zoom:50%;" /> 

- **Decoding 16-Bit I/O Port Addresses** ：

  部分位做控制信号

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115231728805.png" alt="image-20240115231728805" style="zoom:50%;" /> 

- **8- and 16-Bit Wide I/O Ports** ：

  非对齐访问：requires separate write strobes (BHE and BLE)

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115231902430.png" alt="image-20240115231902430" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115232038751.png" alt="image-20240115232038751" style="zoom:50%;" /> 

- **16-bit-wide port**不需要A0、Bank控制信号；**32-bit-wide port**不需要A0、A1



## 9.3 可编程芯片

### 9.3.1 82C55

- 82C55（C表示低功耗版本）：与TTL兼容

  CS：片选信号（地址的高位做）

  A0/A1：选择端口（PA、PB、PC、命令寄存器）

  D0~D7：数据接口

  PA、PB：纯数据；PC：可以做控制信号

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115233022940.png" alt="image-20240115233022940" style="zoom:50%;" /> 

  60H–63H：controlling **keyboard**, **timer** or speaker  

  378H–37BH： for the **parallel printer**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115234145594.png" alt="image-20240115234145594" style="zoom:50%;" /> 

  - Port A, B, C

    – Port A: one 8-bit data output latch and one data input latch

    – Port B: one 8-bit data input/output latch and data input buffer

    – Port C: one 8-bit data output latch and one data input buffer

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240115234653489.png" alt="image-20240115234653489" style="zoom:50%;" /> 

  - Group A and Group B

    – Group A: Port **A** and high order 4 bits of port C (**PC7~PC4**)

    – Group B: Port **B** and low order 4 bits of port C (**PC3~PC0**)

  - Mode 0, 1, 2 

    – Mode 0: **Basic** input/output operation (for group A and B)，不握手、选通等

    – Mode 1: **Strobe** input/output operation (for group A and B)，选通、握手（C端口分别提供4个控制信号）

    A端口读的流程：STB握手信号传给PC4→PC5回复信号给IBF表示把数据锁存了→PC3向CPU发送中断信号INTR→CPU响应后发出RD读信号开始读（为什么用PC3？ 因为组A还有模式2需要两组握手信号）

    **INTR**：置位条件;INTE is a “1”, STB is a “1” and IBF is a “1”.(读完了)

    **INTE**：写PC4 (port A) or PC2 (port B)（读数据）；PC6 (port A) or PC2 (port B)（写数据）

    **PC7, PC6**读的时候没有用；**PC5, PC4**写的时候没有用

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116003032892.png" alt="image-20240116003032892" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116004751685.png" alt="image-20240116004751685" style="zoom:50%;" /> 

    不向CPU发中断的方式：轮询查看C的状态（看IBF/OBF是否为1，此时没有中断所以其他位没什么用）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116004458264.png" alt="image-20240116004458264" style="zoom:50%;" /> 

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116005350131.png" alt="image-20240116005350131" style="zoom:50%;" /> 

    – Mode 2: **Bidirectional bus** operation (for group **A only**)，双向信息交互（A需要C的更多控制信号至少5，所以B无法工作）

    端口是输入输出握手的结合；Port A和Port C 3~7（控制字4、3）不用设输入还是输出

    如何区分中断INTR是输入还是输出：CPU接到中断时必须做**Port C查询**（PC7和PC5）
    
    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116105836046.png" alt="image-20240116105836046" style="zoom:50%;" /> 
    
    **Single** bit set/reset for port C (in mode **1 and 2**)，部分引脚被A或B占用 

- **Programming the 82C55** 

  command byte A：programs functions of group **A and B**

  最高位为1 + **两位**mode（A）+ Port A + Port C（4~7）+  **一位**mode（B）+ Port B +  Port C（0~3）

  command byte B： **sets (1) or resets (0)** bits of port **C** only if the 82C55 is programmed in **mode 1 or 2**

  最高位为0 + 3位空 + 三位选择bit + 一位sets (1) or resets (0)

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116000125935.png" alt="image-20240116000125935" style="zoom:50%;" /> 

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116001028013.png" alt="image-20240116001028013" style="zoom:50%;" /> 
  
- **Combinations of Mode 1**：Port A 和 Port B分别工作

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116105346925.png" alt="image-20240116105346925" style="zoom:50%;" />  

  满负荷：A在mode 2，B在mode 1

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116110909562.png" alt="image-20240116110909562" style="zoom:50%;" /> 



### 9.3.2 8254

- **8254**简介：可编程计时器（三个独立的16位可编程计数器）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116111153322.png" alt="image-20240116111153322" style="zoom:50%;" /> 

- 六种模式：

  – Three independent 16-bit counters

  – Binary or BCD counting

  – Six programmable counter modes

  – Counter latch command

  – Multiple latch command for easy monitoring

  – Handles inputs from DC to 10 MHz

- 每个定时器有三个引脚:

  - **clk**时钟输入：提供真正的时钟频率
  - **GATE**门控输入：控制定时器的时钟block或复位
  - **OUT**输出

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116111750829.png" alt="image-20240116111750829" style="zoom:50%;" /> <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116111920315.png" alt="image-20240116111920315" style="zoom:50%;" /> 

- 内部结构：共用一个控制字寄存器，其他各有一个；两个初始计数寄存器（内部数据是16位的，外部输出是8位的）和锁存寄存器（写两次）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116112324451.png" alt="image-20240116112324451" style="zoom:50%;" /> 

- 控制字：先写控制字，再写初始值

  - SC1、SC0：选择计数器（11表示回读计数器）
  - RW1、RW2：01表示低八位；10表示高八位；11表示16位（先写低位）；00表示锁存当前计数来读
  - M：三种工作模式
  - BCD：0表示二进制；1表示BCD

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116112908165.png" alt="image-20240116112908165" style="zoom:50%;" /> 

- 计数范围：

  最大初始计数是0

  二进制计数范围$2^{16}$; BCD计数$10^4$

  最小初始计数：

  - 模式0,1,4,5：1

  - 模式2,3：2（周期计数）

  一个新的初始计数可以在**任何时候**被写入一个计数器

  一个计数器设置16位初始值时不能被打断（初始化低8位后只能继续初始化高8位，不能对该计数器做其他操作）

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116114258176.png" alt="image-20240116114258176" style="zoom:50%;" /> 

- mode1、2：计数时低电平，结束高电平（INTR高电平有效）；mode2、3、4、5：相反

  mode2、3：周期计数；mode 1、0、1、4、5不是

  mode1、5：硬件触发周期计数；mode 0、4软件触发(重新写计数初值)

  共性问题：

  - 当一个控制字被写入一个计数器时**OUT** goes to a known initial state.
  - 在CLK的**下降沿**加载新的计数，计数器减少
  - 对于模式0-4，在CLK的上升沿采样，以启用计数。对于模式5，计数由GATE输入的上升沿触发
  - 计数器在达到零时不会停止（ Modes 0, 1, 4, and 5 the counter ‘‘wraps around’’ to the **highest count (**FFFF or 9999)；Modes 2 and 3 **reload**s itself with the initial count and continues counting from there）

  – Mode 0: interrupt at the end of count

  - 当控制字被写入时，**OUT**置0，保持到计数结束
  - 门(G)输入必须**保持**逻辑1，以允许计数器计数
  - 如果G在计数的中间成为逻辑0，计数器将停止，直到G再次成为逻辑1（在断点处继续计数）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116120542055.png" alt="image-20240116120542055" style="zoom:50%;" />   

  计数结束时重新装载：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116120827549.png" alt="image-20240116120827549" style="zoom:50%;" /> 

  – Mode 1: hardware **retriggerable** one-shot

  - 在时钟上升沿再次采样到1次GATE为高电平就重复计数
  - GATE不用一直保持高电平

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116121210309.png" alt="image-20240116121210309" style="zoom:50%;" /> 

  – Mode 2: rate generator (**periodic)**

  - OUT 在计数时是1（和前面反的）

  - **rate generator**

  - GATE =1启用计数。如果期间GATE变低，OUT立即设置为高，下一个CLK的初始计数**重新加载**计数器

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116121647784.png" alt="image-20240116121647784" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116121830216.png" alt="image-20240116121830216" style="zoom:50%;" /> 

  重新加载计算器：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116122008500.png" alt="image-20240116122008500" style="zoom:50%;" /> 

  – Mode 3: square wave generator (**periodic**)

  - 方波<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116122137209.png" alt="image-20240116122137209" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116122232927.png" alt="image-20240116122232927" style="zoom:50%;" /> 

  – Mode 4: software-triggered strobe

  – Mode 5: hardware-triggered strobe (**retriggerable**)

  - 计数是由门的上升沿触发的（任何时间）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116122555352.png" alt="image-20240116122555352" style="zoom:50%;" /> 

- **Reading a Counter**：

  – a simple read operation（不锁存，不稳定、先低后高）

  – the counter latch command（读一个）

  D5、D4设0；D7、D6为选择的计数器（11是下一种方式）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116124249497.png" alt="image-20240116124249497" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116124517807.png" alt="image-20240116124517807" style="zoom:50%;" /> 

  – the read-back command （读多个、更多信息）

  D5：是否要读计数的值

  D4：是否读计数器状态

  D3、D2、D1：三个计数器选择

  D0：保留值，必须为0

  如果D5D4都有效，**先读状态再读计数**

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116124543945.png" alt="image-20240116124543945" style="zoom:50%;" /> 



### 9.3.3 16550

- **Three Modes of Transmission**：单工、半双工、双工
-  two clock timing solutions: synchronous（相同时钟global clock /phase-locked loop） and asynchronous（同步信号、不准确）

- **UART（异步） and USART（同步或异步）**：将并行数据转为串行数据

- **Baud Rate Divisor**：接受的频率通常更高

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116130816945.png" alt="image-20240116130816945" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116130921124.png" alt="image-20240116130921124" style="zoom:50%;" /> 

- 16550简介：串行通信

  - A start bit, always ‘0’
  - 5 to 8 bits of data（由低到高）
  - A parity bit 
  -  1 or more stop bits 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116135505001.png" alt="image-20240116135505001" style="zoom:50%;" /> 

  Baud Rate Divisor = **16**

  - DMA信号：发出中断

  - 读写信号两组：兼容不同芯片
  - **ADS**：锁存地址和片选（Intel不用）
  - **XIN, XOUT** ：外部时钟
  - **SIN, SOUT** ：输入输出串行数据

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116135659717.png" alt="image-20240116135659717" style="zoom:50%;" /> 

  A0、A1、A2：选择端口（复用选择10个寄存器，拼一个内部寄存器DLAB的扩展位选择12个寄存器）

  复用原因：读写分离；时序分离

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116140451476.png" alt="image-20240116140451476" style="zoom:50%;" />  

- 两阶段编程：

  - 初始化（使能）：产生正确的波特率时钟→设置数据参数（stop, data, and parity bits, etc）
  - **Clear** the transmitter & receiver FIFOs

- 控制字：

  - L1、L2：有效数据多少位（5~8）
  - S：0表示结束位是1位；1表示结束位是1.5（data=5位，拉长结束位到1.5个时钟）或2位（data>5位）
  - PE：奇偶校验使能
  - P：0是奇校验；1是偶校验
  - ST：固定校验位（就是数据变化时不影响校验位）
  - SB：causes a break（2帧）
  - DL：使能DLAB分频

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116141625989.png" alt="image-20240116141625989" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116142234869.png" alt="image-20240116142234869" style="zoom:50%;" /> 

  EX：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116142437622.png" alt="image-20240116142437622" style="zoom:50%;" /> 

- FIFO控制寄存器仍必须在端口**010**处进行编程：低三位全1

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116142805648.png" alt="image-20240116142805648" style="zoom:50%;" /> 

- 初始化流程：

  - 访问端口011对线路控制器最高位设1

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116143632337.png" alt="image-20240116143632337" style="zoom:50%;" /> 

  - 可以通过000、001设置分频系数的低位和高位

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116143649014.png" alt="image-20240116143649014" style="zoom:50%;" /> 

  - 设置实际数据格式

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116143704899.png" alt="image-20240116143704899" style="zoom:50%;" /> 

  - 使能FIFO（低三位）

    <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116143718242.png" alt="image-20240116143718242" style="zoom:50%;" /> 

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116142926118.png" alt="image-20240116142926118" style="zoom:50%;" /> 

- **Sending Serial Data**：检测状态寄存器看上一次数据是否发送完

  - 0**DR**：设0表示目前没有接受到数据
  - 3~1：校验的错误
  - 4：是否收到break
  - 5**TH**：目前能不能发送数据（0表示上一次还没有发送完，1说明可以写，已经空了）

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116144008920.png" alt="image-20240116144008920" style="zoom:50%;" /> 

  检测代码：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116144409235.png" alt="image-20240116144409235" style="zoom:50%;" /> 

- **Receiving Serial Data Example**：检测3个错误

  检测代码：

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240116144714391.png" alt="image-20240116144714391" style="zoom:50%;" /> 
