
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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

#include <emmintrin.h>  // SSE2头文件

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

int main() {
    // Test different image sizes
    int sizes[] = {320*240, 640*480, 800*600, 1024*768, 1280*720, 1920*1080, 2560*1440};
    int numSizes = sizeof(sizes) / sizeof(sizes[0]);

    // Set adjustment value
    int adjustment = 50;

    for (int k = 0; k < numSizes; k++) {
        int size = sizes[k];
        unsigned char *image = malloc(size);
        unsigned char *output_standard = malloc(size);
        unsigned char *output_SSE = malloc(size);

        // Initialize image with random values
        for(long long i = 0 ; i < size ; i++){
            image[i] = rand();
        }

        clock_t start_std = clock();
        adjust_brightness_standard(image, output_standard, size, adjustment);
        clock_t end_std = clock();

        clock_t start_sse = clock();
        adjust_brightness_SSE(image, output_SSE, size, adjustment);
        clock_t end_sse = clock();

        // Check if the results of both methods are the same
        int judge = 1;
        for(long long i = 0 ; i < size ; i++){
            if(output_SSE[i] != output_standard[i]){
                judge = 0;
                break;
            }
        }

        if(judge == 0){
            printf("Size: %dx%d\n", sizes[k]/320, sizes[k]/240);
            printf("Standard Time: %f seconds\n", (double)(end_std - start_std) / CLOCKS_PER_SEC);
            printf("SSE Time: %f seconds\n", (double)(end_sse - start_sse) / CLOCKS_PER_SEC);
            printf("The results of both methods are different\n");
        }
        else{
            printf("Size: %dx%d\n", sizes[k]/320, sizes[k]/240);
            printf("Standard Time: %f seconds\n", (double)(end_std - start_std) / CLOCKS_PER_SEC);
            printf("SSE Time: %f seconds\n", (double)(end_sse - start_sse) / CLOCKS_PER_SEC);
            printf("The results of both methods are the same\n");
        }

        free(image);
        free(output_standard);
        free(output_SSE);

        printf("\n");
    }

    return 0;
}
