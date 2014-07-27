#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "quiz.h"


void main() {
    int i;
//    int runs = pow(2,((sizeof(i) - 1) * 8));
    int runs = 1024;
    printf("run: %d\n",runs);
    for (i = 1; i <= runs; i++) {
        if ( symmetrical(i) > 0 ) {
            printf("symmetrical method: %d -> %d\n",i,reverse(i));
        }
    }
}

// O(N)
int reverse(int n) {
    int rev = 0;
    do {
        rev = rev * 10 + n % 10;
    } while ( n /= 10 );
    return rev;
}

// O(N)
int symmetrical(int n) {
    int rev = 0;
    int fwd = 0;
    int org = n;
    int size = (int)log10(n);
    do {
        rev = rev * 10 + n % 10;
        fwd = org / (int)pow(10,size);
        if ( fwd != rev ) { return 0; };
        size--;
    } while ( n /= 10 );
    return 1;
}
