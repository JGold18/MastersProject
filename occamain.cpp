#include <iosstream>
#include <occa.hpp>

int main(int argc, char **argv){
  //Doesn't want to implement
  occa::printModeInfo(); 
    int N = 10

    float* h_a = (float*) malloc(sizeof(float)*N);
    float* h_b = (float*) malloc(sizeof(float)*N);
    float* h_c = (float*) malloc(sizeof(float)*N);

    int i;

    for (i = 0; i < N; i++){
        h_a[i] = i; 
        h_b[i] = i - 1;
         
    }
	// instantiating three vectors for use on the device  
	occa::device device;
	occa::kernel vectorMult;
	occa::memory d_a, d_b, d_c;

	device.setup("mode: 'CUDA'");
	//not sure about device id
	
	
	//Allocating memory onto the GPU 
	
    d_a = device.malloc(N*sizeof(float));
    d_b = device.malloc(N*sizeof(float));
    d_c = device.malloc(N*sizeof(float));
	
	//To compile the kernel 
	vectorMult = device.buildKernel("vectorMult.okl", "vectorMult");
	
	//Copying memory from host to device 
	d_a.copyFrom(h_a);
	d_b.copyFrom(h_b);
	
	//Calling kernel on device
	vectorMult(N, d_a, d_b, d_c);
	
	//moving result from device to host 
	h_c.copyFrom(d_c);
	
	//Printing values of h_c
	for (int i = 0; i < N; i++) {
    std::cout << i << ": " << h_c[i] << '\n';
  }
  delete [] h_a;
  delete [] h_b;
  delete [] h_c;

  return 0;
	
}