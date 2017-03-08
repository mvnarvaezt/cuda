
//    gcc importedCFile.c mainCode.c -O3 -lm -Wall -o mainCode -lrt
//    nvcc -lm -Xcompiler -Wall importedCFile.c mainCode.cu -o mainCode

// If lines 10 to 13 and 54 are commented it works ok


#include <stdio.h>
#include <stdlib.h>
extern "C" {
	#include "importedCFile.h"
}

int *n, *device_n;                 

/**
* Return a dynamic allocated vector of n integer elements
**/
int *getVector(int n)  {
    int *Ptr = (int *)malloc(n * sizeof(int));
    if (Ptr == NULL) { fprintf(stderr,"Memory error in getVector!\n"); exit(-1); }
    return Ptr;
}

// A simple kernel
__global__
void aKernel(int n, int a, int *x)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) x[i] += i ;
}

/**
* Main Program
**/
int main(int argc, char *argv[])  
{   int N = 256;
	
	n = getVector(N);								//	Host array
    
	cudaMalloc(&device_n, N*sizeof(int)); 			//	Device arrays

	for (int i = 0; i < N; i++) {					//	Initialize array
	    n[i] = 1;
	}

	cudaMemcpy(device_n, n, N*sizeof(int), cudaMemcpyHostToDevice);		//	Copy host array to device array

	///KERNEL_NAME <<< N_BLOCKS, N_THREAD_PER_BLOCK >>> PARAMS 
	aKernel<<<1, 256>>>(N, 2, device_n);

	cudaMemcpy(n, device_n, N*sizeof(int), cudaMemcpyDeviceToHost);		//	Copy device array to host array

    anExample();

	for (int i = 0; i < N; i++) {					//	Initialize array
	   printf("%d\n", n[i] );
	}

	cudaFree(device_n);
	free(n);    

    return 0;

}