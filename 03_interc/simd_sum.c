//
// Created by Saadat Baig on 29.09.24.
//
#include <immintrin.h>
#include <stdio.h>
#include <stdlib.h>


int sum_ints_simd8(int* input_array, int length) {
    if (input_array == NULL) {
        printf("Error: Received a NULL pointer for input_array.\n");
        return -1;
    }

    printf("Length received: %d\n", length);
    for (int j = 0; j < length; j++) {
        printf("Input[%d] = %d\n", j, input_array[j]);
    }

    int* aligned_input_array = (int*)_mm_malloc(length * sizeof(int), 16);
    if (aligned_input_array == NULL) {
        printf("Error: Failed to allocate aligned memory.\n");
        return -1;
    }
    for (int j = 0; j < length; j++) {
        aligned_input_array[j] = input_array[j];
    }

    // Process 8 integers (two blocks of 4) at a time
    __m128i sum_vec = _mm_setzero_si128();
    for (int i = 0; i < length; i += 8) {
        __m128i vec1 = _mm_loadu_si128((__m128i*)&aligned_input_array[i]);
        sum_vec = _mm_add_epi32(sum_vec, vec1);

        __m128i vec2 = _mm_loadu_si128((__m128i*)&aligned_input_array[i + 4]);
        sum_vec = _mm_add_epi32(sum_vec, vec2);
    }

    // Horizontal addition to sum all elements within the register - to god I hope this is still right in my memory.
    sum_vec = _mm_hadd_epi32(sum_vec, sum_vec);
    sum_vec = _mm_hadd_epi32(sum_vec, sum_vec);

    int total_sum = _mm_cvtsi128_si32(sum_vec);

    // if I wouldn't do this, I'd have to face the "your language unsafe"-committee
    _mm_free(aligned_input_array);

    return total_sum;
}
