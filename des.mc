

	
#include <libmap.h>

void subr (	uint64_t Datain[], 
		uint64_t Dataout[],
		uint64_t Key, 
		uint64_t *tin,
		uint64_t *tcomp,
		uint64_t *tout,
		int mapnum)
{
	OBM_BANK_A  (A1, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_B  (A2, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_C  (A3, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_D  (A4, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_A1 (A5, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_B1 (A6, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_C1 (A7, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_D1 (A8, uint64_t, MAX_OBM_SIZE)

	OBM_BANK_E  (D1, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_F  (D2, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_G  (D3, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_H  (D4, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_E1 (D5, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_F1 (D6, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_G1 (D7, uint64_t, MAX_OBM_SIZE)
	OBM_BANK_H1 (D8, uint64_t, MAX_OBM_SIZE)

	int i;
	uint64_t start, end;
	start_timer();
	
	read_timer(&start);
	#pragma src parallel sections
	{
		#pragma src section
		{
   			buffered_dma_cpu(CM2OBM, PATH_0, A1, MAP_OBM_stripe(1,"A,B,C,D"), Datain, 1, 4*MAX_OBM_SIZE*8);
		}
		#pragma src section
		{
   			buffered_dma_cpu(CM2OBM, PATH_1, A5, MAP_OBM_stripe(1,"A1,B1,C1,D1"), Datain+4*MAX_OBM_SIZE, 1, 4*MAX_OBM_SIZE*8);
		}
	}

	read_timer(&end);
	*tin = end - start;

	read_timer(&start);
	#pragma src parallel sections
	{
		#pragma src section
		{
			for (i=0; i<MAX_OBM_SIZE; i++)
			{
				my_operator( 0, Key, A1[i], 1,  &D1[i]);
				my_operator( 0, Key, A5[i], 1,  &D5[i]);
			}
		}
		#pragma src section
		{
			for (i=0; i<MAX_OBM_SIZE; i++)
			{
				my_operator( 0, Key, A2[i], 1, &D2[i]);
				my_operator( 0, Key, A6[i], 1, &D6[i]);
			}
		}
		#pragma src section
		{
			for (i=0; i<MAX_OBM_SIZE; i++)
			{
				my_operator( 0, Key, A3[i], 1,  &D3[i]);
				my_operator( 0, Key, A7[i], 1,  &D7[i]);
			}
		}
		#pragma src section
		{
			for (i=0; i<MAX_OBM_SIZE; i++)
			{
				my_operator( 0, Key, A4[i], 1,  &D4[i]);
				my_operator( 0, Key, A8[i], 1,  &D8[i]);
			}
		}
	}
	read_timer(&end);
	*tcomp = end - start;
	
	read_timer(&start);
	#pragma src parallel sections
	{
		#pragma src section
		{
   			buffered_dma_cpu (OBM2CM, PATH_0, D1, MAP_OBM_stripe(1,"E,F,G,H"), Dataout, 1, 4*MAX_OBM_SIZE*8);
		}
		#pragma src section
		{
   			buffered_dma_cpu (OBM2CM, PATH_1, D5, MAP_OBM_stripe(1,"E1,F1,G1,H1"), Dataout+4*MAX_OBM_SIZE, 1, 4*MAX_OBM_SIZE*8);
		}
	}
	read_timer(&end);
	*tout = end - start;
}
