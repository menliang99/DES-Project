static char const cvsid[] = "$Id: main.c,v 1.2 2009/12/08 20:11:01 lak Exp $";



#include <libmap.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <math.h>
#include <stdbool.h>

#include <stdio.h>
#define ITERATION 1
#define SIZE	 8*MAX_OBM_SIZE * ITERATION
#define FPGAfreq 150000000


const static int ip[] = {                   
    58, 50, 42, 34, 26, 18, 10,  2,
    60, 52, 44, 36, 28, 20, 12,  4,
    62, 54, 46, 38, 30, 22, 14,  6,
    64, 56, 48, 40, 32, 24, 16,  8,
    57, 49, 41, 33, 25, 17,  9,  1,
    59, 51, 43, 35, 27, 19, 11,  3,
    61, 53, 45, 37, 29, 21, 13,  5,
    63, 55, 47, 39, 31, 23, 15,  7
};                                          
const static int fp[] = {     //zuizhongzhihuan 
    40,  8, 48, 16, 56, 24, 64, 32,
    39,  7, 47, 15, 55, 23, 63, 31,
    38,  6, 46, 14, 54, 22, 62, 30,
    37,  5, 45, 13, 53, 21, 61, 29,
    36,  4, 44, 12, 52, 20, 60, 28,
    35,  3, 43, 11, 51, 19, 59, 27,
    34,  2, 42, 10, 50, 18, 58, 26,
    33,  1, 41,  9, 49, 17, 57, 25
};
const static int sbox[8][64] = {    //s_box
    /* S1 */
    14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7,
  0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8,
  4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0,
    15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13,

    /* S2 */
    15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10,
  3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5,
  0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15,
    13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9,

    /* S3 */
    10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8,
    13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1,
    13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7,
  1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12,

    /* S4 */
  7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15,
    13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9,
    10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4,
  3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14,

    /* S5 */
  2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9,
    14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6,
  4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14,
    11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3,

    /* S6 */
    12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11,
    10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8,
  9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6,
  4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13,

    /* S7 */
  4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1,
    13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6,
  1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2,
  6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12,

    /* S8 */
    13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7,
  1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2,
  7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8,
  2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11
};
const static int rar[] = {    //ya suo zhi huan
    14, 17, 11, 24,  1,  5,
    3, 28, 15,  6, 21, 10,
    23, 19, 12,  4, 26,  8,
    16,  7, 27, 20, 13,  2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53,
    46, 42, 50, 36, 29, 32
};
const static int ei[] = {    //kuo zhan zhi huan
    32,  1,  2,  3,  4,  5,
    4,  5,  6,  7,  8,  9,
    8,  9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32,  1
};
const static int Pzh[]={     
    16,  7, 20, 21,
    29, 12, 28, 17,
  1, 15, 23, 26,
  5, 18, 31, 10,
  2,  8, 24, 14,
    32, 27,  3,  9,
    19, 13, 30,  6,
    22, 11,  4, 25
};
const static int Keyrar[]={
     57, 49, 41, 33, 25, 17,  9,
     1, 58, 50, 42, 34, 26, 18,
    10,  2, 59, 51, 43, 35, 27,
    19, 11,  3, 60, 52, 44, 36,

    63, 55, 47, 39, 31, 23, 15,
    7, 62, 54, 46, 38, 30, 22,
    14,  6, 61, 53, 45, 37, 29,
    21, 13,  5, 28, 20, 12,  4
};

const static unsigned long BinTable[] = {

0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80, 
0x100,0x200,0x400,0x800,0x1000,0x2000,0x4000,0x8000, 
0x10000,0x20000,0x40000,0x80000,0x100000,0x200000,0x400000,0x800000, 
0x1000000,0x2000000,0x4000000,0x8000000,0x10000000,0x20000000,0x40000000,0x80000000, 
0x100000000,0x200000000,0x400000000,0x800000000,0x1000000000,0x2000000000,0x4000000000,0x8000000000, 
0x10000000000,0x20000000000,0x40000000000,0x80000000000,0x100000000000,0x200000000000,0x400000000000,0x800000000000, 
0x1000000000000,0x2000000000000,0x4000000000000,0x8000000000000,0x10000000000000,0x20000000000000,0x40000000000000,0x80000000000000, 
0x100000000000000,0x200000000000000,0x400000000000000,0x800000000000000,0x1000000000000000,0x2000000000000000,0x4000000000000000,0x8000000000000000

};


bool key[16][48]; /*rekey[16][48],*/

void ByteToBit(bool *Out, unsigned long In,int bits) 
{
 int i;
 unsigned long j;
 for(i=0;i<bits;i++)
{
  //j = pow(2,i);
  //Out[i]=( In / BinTable[i] ) % 2;
  Out[i]=( In >> i ) % 2;
}

}


unsigned long BitToByte(bool *In,int bits)   

{
  int i;

  unsigned long Out1 = 0;
  unsigned long Out2 = 0;
  for(i=bits;i>=32;i--)
  { 
    if(In[i] == true )
       //Out1 +=  pow(2, i);  
       Out1 += BinTable[i];
   }

  for(i=31;i>=0;i--)
  { 
    if(In[i] == true )
       //Out2 +=  pow(2, i); 
	Out2 += BinTable[i]; 
   }

 return (Out1 + Out2);
}

void Xor(bool *InA,const bool *InB,int len)    
{
  int i;
 for(i=0;i<len;i++)
  InA[i]^=InB[i];
}



void keyfc(unsigned long In)             
{
 int i,j=0,mov,k;
int m;
 bool key0[56],temp,keyin[64];

 
 ByteToBit(keyin,In,64);         

   /* printf ("Keyin 64: %lx---------------.  \n", In);
   for (j = 63; j>=0; j--)
   { if (keyin[j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
 for(i=0;i<56;i++)                     
  key0[i]=keyin[Keyrar[i]-1];
/*
    printf ("Key 56bit: %d---------------.  \n", i);
   for (j = 55; j>=0; j--)
   { if (key0[j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n\n");

*/

 for(i=0;i<16;i++)       
 {
  if(i==0||i==1||i==8||i==15)
   mov=1;
  else
   mov=2;
  for(k=0;k<mov;k++)    
  {
//   for(int m=0;m<8;m++)
//   {
//    temp=key0[m*7];
//    for(j=m*7;j<m*7+7;j++)
//     key0[j]=key0[j+1];
//    key0[m*7+6]=temp;
//   }//

//suppose k is big ediant
   temp=key0[27];

   for(m=27;m > 0;m--)
    key0[m]=key0[m-1];

   key0[0]=temp;
   temp=key0[55];

   for(m=55;m>28;m--)
    key0[m]=key0[m-1];

   key0[28]=temp;
  }
/*
    printf ("Key %d after generate: --------------.  \n", i);
   for (j = 55; j>=0; j--)
   { if (key0[j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
  for(j=0;j<48;j++)         
    key[i][j]=key0[rar[j]-1];

/*
    printf ("Key %d after change2: ---------------.  \n", i);
   for (j = 47; j>=0; j--)
   { if (key[i][j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n\n");
   */


 }




}

unsigned long DES(unsigned long In)
{
 int i, j, lun;
 unsigned long out;

 bool MW[64],tmp[32],PMW[64];

 bool kzmw[48],keytem[48],ss[32];

 int hang,lie;

 ByteToBit(PMW,In,64);
/*
    printf ("DATA IN put: **********.  \n");
   for (j = 63; j>=0; j--)
   { if (PMW[j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n\n");
*/
 for(j=0;j<64;j++)
 {
  MW[j]=PMW[ip[j]-1];        
 }


 bool *Li=&MW[0],*Ri=&MW[32];

  for( lun=0;lun<16;lun++)
  {

/*
    printf ("DATA in each LOOP %d : **********.  \n", lun);
   for (j = 63; j>=0; j--)
   { if (MW[j] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n\n");
*/
   for(i=0;i<32;i++)
    ss[i]=Ri[i];
/*
   printf ("Before the LOOP: %d  \n", lun);
   for (i = 31; i>=0; i--)
   { if (Ri[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
   for(i=0;i<48;i++)       
    kzmw[i]=Ri[ei[i]-1];     
/*
    printf ("LOOP: %d--After the data change.  \n", lun);
   for (i = 47; i>=0; i--)
   { if (kzmw[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
   for(i=0;i<48;i++)
    keytem[i]=key[lun][i];      

   Xor(kzmw,keytem,48);
 //S-box
   for(i=0;i<8;i++)
   {
    hang=kzmw[i*6+5]*2+kzmw[i*6];
    lie =kzmw[i*6+4]*8+kzmw[i*6+3]*4+kzmw[i*6+2]*2+kzmw[i*6+1];
    tmp[i*4]=sbox[i][(hang)*16+lie]%2;
    tmp[i*4+1]=(sbox[i][(hang)*16+lie]/2)%2;
    tmp[i*4+2]=(sbox[i][(hang)*16+lie]/4)%2;
    tmp[i*4+3]=(sbox[i][(hang)*16+lie]/8)%2;
   }
/*
    printf ("LOOP: %d--After S change\n", lun);
   for (i = 31; i>=0; i--)
   { if (tmp[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
   for( i=0;i<32;i++)    
    Ri[i]=tmp[Pzh[i]-1]; 
/*
    printf ("LOOP: %d After P change\n", lun);
   for (i = 31; i>=0; i--)
   { if (Ri[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/
   Xor(Ri,Li,32);    
   for(i=0;i<32;i++)  
   {
    Li[i]=ss[i];
   }

   //printf("\n\n");
 }

/*
    printf ("Before LP change #######\n");
   for (i = 63; i>=0; i--)
   { if (MW[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }

  printf("\n");
*/

  for(i=0;i<64;i++)
   PMW[i]=MW[fp[i]-1];

/*
    printf ("Final Data\n");
   for (i = 63; i>=0; i--)
   { if (PMW[i] == true )
       printf ("1 ");
     else 
        printf ("0 ");
   }
   printf("\n");
*/

  out = BitToByte(PMW,64);  
  return out;
 }



uint64_t Computing_CPU(uint64_t key, uint64_t datain)
{
	keyfc(key);
	return (DES(datain));
}



void randomize(uint64_t array[])
{
    uint64_t i;
    int k;
    unsigned char cbuf[8];
    uint64_t *key;


    for (i = 0; i < SIZE; i++)
	{
	  for(k= 0; k< 8; k++)
	   {
		cbuf[k] = rand();
        	//printf("%x  ", cbuf[k]);
	  }

	  key = (uint64_t *)cbuf;
	  array[i] = *key;

	}
}

double walltime()
{
	struct timeval currenttime;
	gettimeofday(&currenttime, 0);
	return currenttime.tv_sec*1000000+currenttime.tv_usec;
}

void subr (uint64_t Datain[], uint64_t Dataout[], uint64_t Key, uint64_t *tin, uint64_t *tcomp, uint64_t *tout, int mapnum);

int main (int argc, const char * argv[])
{

	uint64_t i,j;
	int err=0;
	double sw_start,sw_end,sw_time;
	srand ( time(NULL) );
	uint64_t tin, tcomp, tout;
	uint64_t total_tin, total_tcomp, total_tout;
	double in_time, cal_time, out_time;

	uint64_t *Datain;
	uint64_t *Dout_sw;
	uint64_t *Dout_hw;
        FILE *filename;
	filename = fopen(argv[1], "w");


	uint64_t Key;
	uint64_t *key;
	int k;

	unsigned char cbuf[8];

	  for(k= 0; k< 8; k++)
	   {
		cbuf[k] = rand();
        	//printf("%x  ", cbuf[k]);
	  }

	key = (uint64_t *)cbuf;
	 Key = *key;

	Datain	= (uint64_t*)(uint64_t *)Cache_Aligned_Allocate (SIZE * sizeof(uint64_t));
	Dout_sw = (uint64_t*)(uint64_t *)Cache_Aligned_Allocate (SIZE * sizeof(uint64_t));
	Dout_hw = (uint64_t*)(uint64_t *)Cache_Aligned_Allocate (SIZE * sizeof(uint64_t));




	randomize(Datain);

	total_tin   = 0;
	total_tcomp = 0;
	total_tout  = 0;

	map_allocate (1);


	for (i = 0; i < ITERATION; i++) {
		subr (Datain + i*8*MAX_OBM_SIZE, Dout_hw + i*8*MAX_OBM_SIZE, Key, &tin, &tcomp, &tout, 0);
		total_tin   += tin;
		total_tcomp += tcomp;
		total_tout  += tout;
	}
	in_time  = total_tin /((float) FPGAfreq);
	cal_time = total_tcomp /((float) FPGAfreq);
	out_time = total_tout / ((float)FPGAfreq);


	printf("\nData input FPGA time:    %f s.  \n", in_time);
	printf("FPGA computation time:  %f s.\n", cal_time);
	printf("Data output time:    %f s.\n", out_time);
	printf("FPGA Total time:    %f s. \n\n", in_time + cal_time + out_time);


	printf("Data input FPGA bandwidth:  %f MB/s.\n", (long long)SIZE*8/in_time/1000000);
	printf("Data output FPGA bandwidth:  %f MB/s.\n\n",(long long)SIZE*8/out_time/1000000);

	fprintf(filename, "\nData input FPGA time:    %f s.  \n", in_time);
	fprintf(filename, "FPGA computation time:  %f s.\n", cal_time);
	fprintf(filename, "Data output time:    %f s.\n", out_time);
	fprintf(filename, "FPGA Total time:    %f s. \n\n", in_time + cal_time + out_time);


	fprintf(filename, "Data input FPGA bandwidth:  %f MB/s.\n", (long long)SIZE*8/in_time/1000000);
	fprintf(filename, "Data output FPGA bandwidth:  %f MB/s.\n\n",(long long)SIZE*8/out_time/1000000);


	map_free (1);

	sw_start = walltime();

	for (i=0; i<SIZE; i++)
	{
		Dout_sw[i] = Computing_CPU(Key, Datain[i]);

	}
	sw_end = walltime();
	sw_time = (sw_end - sw_start) / 1000000;

	fprintf(filename, "CPU Total time:   %f  s  \n\n", sw_time);
	fprintf(filename, "Total SpeedUp:    %f  \n", sw_time / (in_time + cal_time + out_time) ); 
	fprintf(filename, "Computation SpeedUp:  %f  \n", sw_time / cal_time);

	printf("CPU Total time:   %f  s  \n\n", sw_time);
	printf("Total SpeedUp:    %f  \n", sw_time / (in_time + cal_time + out_time) ); 
	printf("Computation SpeedUp:  %f  \n\n", sw_time / cal_time);

	fprintf(filename, "Key is \n[%6lx]\n\t\t Datain\t\t    CPUdata\t\t  FPGAdata\n", Key);
	//printf("Key is \n[%6lx]\n\t\t Datain\t\t    CPUdata\t\t  FPGAdata\n", Key);
	for (i=0; i<SIZE; i++)
	{      

                if (i < 40)
		fprintf(filename, "[%6ld]  0x%16lx  0x%16lx    0x%16lx  \n", i, Datain[i], Dout_sw[i], Dout_hw[i]);
                
		if (Dout_sw[i] != Dout_hw[i])
               { 
		err = 1;
                printf("[%6lx]  0x%16lx  :0x%16lx  :  0x%16lx  \n", i, Datain[i], Dout_sw[i], Dout_hw[i]);
		break;
		}
	}


	if (err)
		printf ("  Failed\n");
	else
	       printf ("  PASSED\n");

	Cache_Aligned_Free((char *)Datain);
	Cache_Aligned_Free((char *)Dout_sw);
	Cache_Aligned_Free((char *)Dout_hw);
         fclose(filename);
	return 0;
}






