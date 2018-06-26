
#include <stdio.h>
#include <stdlib.h>

void addVector(int N, float *pt_a, float *pt_b, float *pt_c ){

  int i;
  for(i = 0; i < N; ++i){
    pt_c[i] = pt_a[i] - pt_b[i];
  }
  
}

int main () {

  /* specify number of entries */
  int N = 10;

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

  addVector(N, pt_a, pt_b, pt_c);
  
  for  (i = 0; i < N; i++){  
    printf("c[i]=%f\n", pt_c[i]);	   
  }

  return 0;
						
}
