#include <stdio.h>
#include <math.h>
#include<complex.h>
#include "svdpi.h"

void RadarDataGen(double *data,int range){
	//data为产生数据所存储数组指针
	//range为目标距离
	//产生目标距离为range的单目标回波数据
	double c,B,Tr,fc,Fs,f0,K,td,PI;
	double t[512];
	double complex st,s[512];
	int i;
	int N = 512;
	c = 3e8;
	B = 106.7e6;
	Tr = 0.8e-6;
	fc = 37.6e9;
	Fs = 6*B;
	f0 = B*2.73;
	K = B/Tr;
	td = 2*range/c;
	PI = acos(-1);
	for( i = 0; i < N ; i++){
	 	t[i] = (i-N/2+1)/Fs;
	 	if(fabs(t[i]-td)>Tr/2){
			 //
			 st = cexp(2*I*PI*f0*t[i]);
			 }
	 	else{
	 		st = cexp(2*I*PI*fc*(t[i]-td))*cexp(I*PI*K*pow(t[i]-td,2))+cexp(2*I*PI*f0*t[i]);
	 	}
	 		s[i] = st*cexp(-2*I*PI*fc*t[i]); //下变频
			*(data+i)   = creal(s[i]);	//real
			*(data+N+i) = cimag(s[i]);	//imag
	}
	printf("**********range = %d*****************\n", range);
}