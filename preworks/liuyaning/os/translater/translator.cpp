#include <stdio.h>
#include <string.h>
#include "translator.h"

#define BUFSIZE (1<<5)

static unsigned int opcode_keys[]={0x24000000,0x00000021,0x0000002a,0x28000000,0x2c000000,0x0000002b,
									0x00000023,0x00000018,0x00000012,0x00000010,0x00000013,0x00000011,
									0x10000000,0x04010000,0x1c000000,0x18000000,0x04000000,0x14000000,
									0x08000000,0x0c000000,0x00000009,0x00000008,0x8c000000,0xac000000,
									0x80000000,0x90000000,0xa0000000,0x00000024,0x30000000,0x3c000000,									
									0x00000027,0x00000025,0x34000000,0x00000026,0x38000000,0x00000000,
									0x00000004,0x00000003,0x00000007,0x00000002,0x00000006,0x0000000c,
									0xbc000000,0x42000018,0x40000000,0x40800000,0x42000002,0x94000000};

Translator::Translator()
{
	op_table["addiu"] = 0x24000000;
	op_table["addu"]  = 0x00000021;
	op_table["slt"]   = 0x0000002a;
	op_table["slti"]  = 0x28000000;
	op_table["sltiu"] = 0x2c000000;
	op_table["sltu"]  = 0x0000002b;
	op_table["subu"]  = 0x00000023;
	op_table["mult"]  = 0x00000018;
	op_table["mflo"]  = 0x00000012;
	op_table["mfhi"]  = 0x00000010;
	op_table["mtlo"]  = 0x00000013;
	op_table["mthi"]  = 0x00000011;
	op_table["beq"]   = 0x10000000;
	op_table["bgez"]  = 0x04010000;
	op_table["bgtz"]  = 0x1c000000;
	op_table["blez"]  = 0x18000000;
	op_table["bltz"]  = 0x04000000;
	op_table["bne"]   = 0x14000000;
	op_table["j"]     = 0x08000000;
	op_table["jal"]   = 0x0c000000;
	op_table["jalr"]  = 0x00000009;
	op_table["jr"]    = 0x00000008;
	op_table["lw"]    = 0x8c000000;//
	op_table["sw"]    = 0xac000000;
	op_table["lb"]    = 0x80000000;
	op_table["lbu"]   = 0x90000000;
	op_table["sb"]    = 0xa0000000;
	op_table["and"]   = 0x00000024;
	op_table["andi"]  = 0x30000000;
	op_table["lui"]   = 0x3c000000;
	op_table["nor"]   = 0x00000027;
	op_table["or"]    = 0x00000025;
	op_table["ori"]   = 0x34000000;
	op_table["xor"]   = 0x00000026;
	op_table["xori"]  = 0x38000000;
	op_table["sll"]   = 0x00000000;
	op_table["sllv"]  = 0x00000004;
	op_table["sra"]   = 0x00000003;
	op_table["srav"]  = 0x00000007;
	op_table["srl"]   = 0x00000002;
	op_table["srlv"]  = 0x00000006;
	op_table["syscall"]=0x0000000c;
	op_table["nop"]   = 0xbc000000;
	op_table["eret"]  = 0x42000018;
	op_table["mfc0"]  = 0x40000000;
	op_table["mtc0"]  = 0x40800000;
	op_table["tlbwi"] = 0x42000002;
	op_table["lhu"]   = 0x94000000;

	disas_table[0x24000000u] = "addiu";
	disas_table[0x00000021u] = "addu";
	disas_table[0x0000002au] = "slt";
	disas_table[0x28000000u] = "slti";
	disas_table[0x2c000000u] = "sltiu";
	disas_table[0x0000002bu] = "sltu";
	disas_table[0x00000023u] = "subu";
	disas_table[0x00000018u] = "mult";
	disas_table[0x00000012u] = "mflo";
    disas_table[0x00000010u] = "mfhi";
	disas_table[0x00000013u] = "mtlo";
	disas_table[0x00000011u] = "mthi";
	disas_table[0x10000000u] = "beq";
	disas_table[0x04010000u] = "bgez";
	disas_table[0x1c000000u] = "bgtz";
	disas_table[0x18000000u] = "blez";
	disas_table[0x04000000u] = "bltz";
	disas_table[0x14000000u] = "bne";
	disas_table[0x08000000u] = "j";
	disas_table[0x0c000000u] = "jal";
	disas_table[0x00000009u] = "jalr";
	disas_table[0x00000008u] = "jr";
	disas_table[0x8c000000u] = "lw";
	disas_table[0xac000000u] = "sw";
	disas_table[0x80000000u] = "lb";
	disas_table[0x90000000u] = "lbu";
	disas_table[0xa0000000u] = "sb";
	disas_table[0x00000024u] = "and";
	disas_table[0x30000000u] = "andi";
	disas_table[0x3c000000u] = "lui";
	disas_table[0x00000027u] = "nor";
	disas_table[0x00000025u] = "or";
	disas_table[0x34000000u] = "ori";
	disas_table[0x00000026u] = "xor";
	disas_table[0x38000000u] = "xori";
	disas_table[0x00000000u] = "sll";
	disas_table[0x00000004u] = "sllv";
	disas_table[0x00000003u] = "sra";
	disas_table[0x00000007u] = "srav";
	disas_table[0x00000002u] = "srl";
	disas_table[0x00000006u] = "srlv";
	disas_table[0x0000000cu] = "syscall";
	disas_table[0xbc000000u] = "nop";
	disas_table[0x42000018u] = "eret";
	disas_table[0x40000000u] = "mfc0";
	disas_table[0x40800000u] = "mtc0";
	disas_table[0x42000002u] = "tlbwi";
	disas_table[0x94000000u] = "lhu";
}

void Translator::parse(char* filename)
{
	FILE* fin = fopen(filename,"r");
	std::map<std::string,int> label;
	if(fin==NULL)
	{
		fprintf(stderr, "error in open %s\n",filename);
		return;
	}
	char buf[BUFSIZE];		
	int lines=0;
	while(fgets(buf,BUFSIZE,fin))
	{		
		lines++;		
		int n;		
		for(n=(int)strlen(buf)-1;n>=0;n--)
		{
			if(buf[n]=='\n')
				buf[n]='\0';
			else
				break;
		}		
		if(n>=1 && buf[n]==':')
		{		
			for(int i=n-1;i>=0;i--)
			{
				if(buf[i]==':')
				{
					fprintf(stderr, "parse error in %d line\n",lines);
					return;
				}
			}	
			label[buf] = lines;			
		}		
	}

	FILE* fout = fopen("ans.dat","wb");
	fseek(fin,0,SEEK_SET);
	lines=0;
	char op_code[10];
	unsigned int code;
	int op1;
    int op2;
	int op3;
	std::map<std::string,unsigned int>::iterator it;
	std::map<std::string,int>::iterator it2;
	while(fgets(buf,BUFSIZE,fin))
	{		
		lines++;
		sscanf(buf,"%s",op_code);	
		it = op_table.find(op_code);
		if(it==op_table.end())
		{
			if((it2=label.find(op_code))==label.end())
				goto Error;
			else
				continue;
		}
		code = it->second;
		char *p =buf;		
		if(strcmp(op_code,"addiu")==0 || strcmp(op_code,"slti")==0 || strcmp(op_code,"sltiu")==0 \
			|| strcmp(op_code,"beq")==0 || strcmp(op_code,"bne")==0 || strcmp(op_code,"lw")==0 \
			|| strcmp(op_code,"sw")==0 || strcmp(op_code,"lb")==0 || strcmp(op_code,"lbu")==0  \
			|| strcmp(op_code,"sb")==0 || strcmp(op_code,"andi")==0 || strcmp(op_code,"ori")==0 \
			|| strcmp(op_code,"xori")==0 || strcmp(op_code,"lhu")==0)
		{			
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;
						
			if(strcmp(op_code,"beq")==0 || strcmp(op_code,"bne")==0)
			{				
				op1<<=21;
				op2<<=16;

				p = strchr(p,',');
				char la[32];
				sscanf(++p,"%s",la);

				strcat(la,":");				
				if((it2 = label.find(la))!=label.end())
				{
					int line0 = it2->second;
				//	printf("%d\n",line0);
				//	printf("%d\n",lines);
					op3 = line0 - lines;
				//	printf("%d\n",op3);
				}
				else
				{					
					if(sscanf(p,"%x",&op3)==EOF)
			 			goto Error;	
				}
			}
			else
			{
				p = strchr(p,',');			
				if(sscanf(++p,"%x",&op3)==EOF)
			 		goto Error;
				op1<<=16;
				op2<<=21;				
			}
			op3 &= 0xFFFF;
			//printf("%08x\n",op3);			
			code |= op1 | op2 | op3;							
		}	
		else if(strcmp(op_code,"mult")==0)	
		{
			//printf("*****************2\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;

			op1<<=21;
			op2<<=16;
			code |= op1 | op2;			
		}
		else if(strcmp(op_code,"mflo")==0 || strcmp(op_code,"mfhi")==0)
		{
			//printf("*****************3\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op3)==EOF)
			 	goto Error;	

			op3<<=11;
			code |= op3;			
		}
		else if(strcmp(op_code,"mtlo")==0 || strcmp(op_code,"mthi")==0)
		{
			//printf("*****************4\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;			

			op1<<=21;
			code |= op1;			
		}
		else if(strcmp(op_code,"bgez")==0 || strcmp(op_code,"bgtz")==0 || strcmp(op_code,"blez")==0 \
			|| strcmp(op_code,"bltz")==0)
		{
			//printf("*****************5\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;			
			
			p = strchr(p,',');
			char la[32];
			sscanf(++p,"%s",la);

			strcat(la,":");				
			if((it2 = label.find(la))!=label.end())
			{
				int line0 = it2->second;
				//printf("%d\n",line0);
				//printf("%d\n",lines);
				op3 = line0 - lines;
				//printf("%d\n",op3);
			}
			else
			{					
				if(sscanf(p,"%x",&op3)==EOF)
		 			goto Error;	
			}	

			op1<<=21;
			op3&= 0xFFFF;
			code |= op1 | op3;			
		}
		else if(strcmp(op_code,"j")==0 || strcmp(op_code, "jal")==0)
		{
			//printf("*****************6\n");
			p = strchr(buf,' ');			
			if(sscanf(++p,"%x",&op3)==EOF)
			 	goto Error;	
			 op3 &= 0x03ffffff;
			code |= op3;
		}
		else if(strcmp(op_code,"jalr")==0)
		{
			//printf("*****************7\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op3)==EOF)
			 	goto Error;
			 
			op1<<=21;
			op3<<=11;	
			code |= op1 | op3;					
		}
		else if(strcmp(op_code,"jr")==0)
		{
			//printf("*****************8\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			op1<<=21;
			code |= op1;
		}
		else if(strcmp(op_code,"lui")==0)
		{
			//printf("*****************9\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;				
			
			p = strchr(p,',');			
			if(sscanf(++p,"%x",&op3)==EOF)
			 	goto Error;

			op2<<=16;
			op3 &= 0xFFFF;
			code |= op2 | op3;
		}
		else if(strcmp(op_code,"sll")==0 || strcmp(op_code,"sra")==0 || strcmp(op_code,"srl")==0)
		{
			//printf("*****************10\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;
			
			p = strchr(p,',');			
			if(sscanf(++p,"%x",&op3)==EOF)
			 	goto Error;

			op1<<=11;
			op2<<=16;
			op3 &= 0x1F;
			op3<<=6;			
			code |= op1 | op2 | op3;
		}			
		else if(strcmp(op_code,"mfc0")==0 || strcmp(op_code,"mtc0")==0)
		{
			//printf("*****************11\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;
			
			if(strcmp(op_code,"mfc0")==0)	
			{
				op1<<=16;
				op2<<=11;
			}
			else
			{
				op1<<=11;
				op2<<=16;
			}
			code |= op1 | op2;			
		}
		else if(strcmp(op_code,"addu")==0 || strcmp(op_code,"slt")==0 || strcmp(op_code,"sltu")==0 \
			|| strcmp(op_code,"subu")==0 || strcmp(op_code,"and")==0 || strcmp(op_code,"nor")==0 \
			|| strcmp(op_code,"or")==0 || strcmp(op_code,"xor")==0)
		{
			//printf("*****************12\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;
			
			p = strchr(p,'$');			
			if(sscanf(++p,"%d",&op3)==EOF)
			 	goto Error;

			op1<<=11;
			op2<<=21;
			op3<<=16;
			code |= op1 | op2 | op3;			
		}
		else if(strcmp(op_code,"sllv")==0 || strcmp(op_code,"srav")==0 || strcmp(op_code,"srlv")==0)
		{
			//printf("*****************13\n");
			p = strchr(buf,'$');			
			if(sscanf(++p,"%d",&op1)==EOF)
			 	goto Error;	

			p = strchr(p,'$');
			if(sscanf(++p,"%d",&op2)==EOF)
			 	goto Error;
			
			p = strchr(p,'$');			
			if(sscanf(++p,"%d",&op3)==EOF)
			 	goto Error;

			op1<<=11;
			op2<<=16;
			op3<<=21;
			code |= op1 | op2 | op3;			
		}
		else if(strcmp(op_code,"nop")==0 || strcmp(op_code,"syscall")==0 || strcmp(op_code,"eret")==0 \
				|| strcmp(op_code,"tlbwi")==0)
		{
			//printf("*****************15\n");
		}
		else
			goto Error;				
		printf("%08x\n",code);
		fwrite((void*)&code,sizeof(unsigned int),1,fout);	
	}		
	fclose(fin);
	fclose(fout);
	return;

Error:
	fprintf(stderr, "parse error in %d\n",lines);
	fclose(fin);
	fclose(fout);
	return;
}

void Translator::disas(char* filename)
{
	FILE* fp = fopen(filename,"rb");
	if(fp == NULL)
	{
		fprintf(stderr, "error in open %s\n",filename);
		return;
	}
	int lines = 0;
	unsigned int opcode;
	while((fread(&opcode,sizeof(unsigned int),1,fp))!=0)
	{
		lines++;
		// unsigned int op_code;
		// for(unsigned int i=0;i<sizeof(opcode_keys)/sizeof(unsigned int);i++)		
		// {
		// 	op_code = opcode & opcode_keys[i];
		// 	printf("%08x\n",op_code);
		// 	if(op_code == opcode_keys[i])
		// 	{
		// 		printf("%s\n",&disas_table[op_code][0]);
		// 		break;
		// 	}
		// }
		printf("%08x\n",opcode);
	}
	printf("%08x\n",0x24000000 | 0xbc000000 );
	printf("%d\n",lines);
	fclose(fp);
}