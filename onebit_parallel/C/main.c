#include <stdio.h>
#include <math.h>
#include <complex.h>
//#include "svdpi.h"

void RadarDataGen(double range){
    double c,B,Tr,fc,Fs,f0,K,td,PI;
    double t[512];
    double complex st,s[512];
    double s_re_im[1024];
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
    for (i = 0; i < N; i++)
    {
        t[i] = (i-N/2+1)/Fs;
        if (fabs(t[i] - td) > Tr/2)
        {
            st = cexp(2*I*PI*f0*t[i]);//发送天线干扰
        }
        else
        {
            //回波信号+发送天线干扰
            st = cexp(2*I*PI*fc*(t[i]-td))*cexp(I*PI*K*pow(t[i]-td,2)) + cexp(2*I*PI*f0*t[i]);
        }
        //下变频
        s[i] = st*cexp(-2*I*PI*fc*t[i]);
        s_re_im[i] = creal(s[i]);
        s_re_im[i] = cimag(s[i]);
        printf("s[%d] = %f + i%f \n",i,creal(s[i]),cimag(s[i]));
    }  
}

int main(void) {
    RadarDataGen(10);
    return 0;
}