#include <iostream>
#include <chrono>

// 计算数组元素之和（有数据依赖）
long long sumWithDependency(int* array, int size) {
    long long sum = 0;
    for (int i = 0; i < size; i++) {
        sum += array[i];
    }
    return sum;
}


int sumWithoutDependency(int* array, int size) {
    int sum = 0;
    #pragma simd
    for (int i = 0; i < size; i++) {
        sum += array[i];
    }
    return sum;
}

int main() {
    int array[50000];
    for(int i = 0 ; i < 50000 ; i++){
        array[i] = rand();
    }
    long long size = sizeof(array) / sizeof(array[0]);

    auto start = std::chrono::steady_clock::now(); // 记录开始时间

    long long result = sumWithDependency(array, size);

    auto end = std::chrono::steady_clock::now(); // 记录结束时间
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start); // 计算执行时间

    std::cout << "Sum with dependency: " << result << std::endl;
    std::cout << "Execution time: " << duration.count() << " microseconds" << std::endl;

    return 0;
}
