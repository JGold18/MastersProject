
#include <stdio.h>
#include <cuda.h>

__global__ void addVector(int N, float* c_a, float* c_b, float* c_c ){

   int point_id = threadIdx.x +blockIdx.x*blockDim.x;
   if (point_id<N)
   {
        c_c[point_id] = c_a[point_id] - c_b[point_id];
   }
}

int main () {
 
  /* specify number of entries */
  int N = 10000;

  /* allocate enough memory to store N floats */
  /* malloc is a standard library call */
  /* malloc accepts one argument, specifying the number of bytes of memory to be  allocated */
  /* malloc does not initialize values in the array */
  float* pt_a = (float*) malloc(sizeof(float)*N);
  float* pt_b = (float*) malloc(sizeof(float)*N);
  float* pt_c = (float*) malloc(sizeof(float)*N);
  
  int i;

  for (i = 0; i < N; i=i+1){
    pt_a[i] = 7.7;
    pt_b[i] = 5.2;
  }

 //cuda mem allocation to gpu

    float* c_a;
    float* c_b;
    float* c_c;
 
    cudaMalloc(&c_a, N*sizeof(float));
    cudaMalloc(&c_b, N*sizeof(float));
    cudaMalloc(&c_c, N*sizeof(float));
 
  //copying data from CPU(host) to GPU(Device)
 
    cudaMemcpy(c_a, pt_a, N*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(c_b, pt_b, N*sizeof(float), cudaMemcpyHostToDevice);


    int T=32;
    int B=(N + T-1)/T;
    dim3 NthreadsPerBlock(T);
    dim3 NBlocks(B);
    
    addVector<<<NBlocks,NthreadsPerBlock>>>(N, c_a, c_b, c_c);

//copying data from device to host
    cudaMemcpy(pt_c, c_c, N*sizeof(float), cudaMemcpyDeviceToHost);

  for(i = N - 100; i < N; i++){  
    printf("c[%d]=%f\n", i, pt_c[i]);	   
  }

  return 0;
						
}
