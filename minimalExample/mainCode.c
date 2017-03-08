
//    nvcc importedCFile.c mainCode.c -O3 -lm -Wall -o mainCode 
//    nvcc -lrt -lm -Xcompiler -Wall importedCFile.c mainCode.cu -o mainCode


#include <stdio.h>
#include <stdlib.h>

#include "importedCFile.h"


int *n;					

/**
* Return a dynamic allocated vector of n integer elements
**/
int *getVector(int n)  {
    int *Ptr = (int *)malloc(n * sizeof(int));
    if (Ptr == NULL) { fprintf(stderr,"Memory error in getVector!\n"); exit(-1); }
    return Ptr;
}

/**
* Main Program
**/
int main(int argc, char *argv[])  
{	n = getVector(4);
    n[0] = 234;
    anExample();
    return 0;
}