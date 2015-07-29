#include "FlashAndRam.h"
#define DATA_LENGTH (1<<20)
#define BUF_SIZE (1<<10)

FlashAndRam::FlashAndRam(char* com_name, char* filename,unsigned int address,unsigned int final_address,int mode){    
    this->com_name=com_name;
    this->file_name=filename;
    this->mode=mode;
    this->com=INVALID_HANDLE_VALUE;
    this->load_file=NULL;
    this->store_file=NULL;
    this->addr = address;
    this->f_addr = final_address;

    int modex=-1;
    if(address>=0 && address<=0x003FFFFF)
        modex=0;
    else if(address<=0x007FFFFF)
        modex=1;
    else if(address>=0x1E000000 && address<=0x1EFFFFFF)
        ;
    else
    {
        fprintf(stderr, "invalid address! exit!\n");
        exit(-1);
    }

    if(mode ==3 or mode == 4)
        printf("address range: 0x%08x to 0x%08x\n",address,final_address);

    unsigned char* p;
    p =(unsigned char*)&address;
    //swap(p[0],p[3]);
    //swap(p[1],p[2]);
    
    if(mode == 3 or mode == 4)                       //check
        kernel_data.push(0x03);
    else if(mode == 0)
        kernel_data.push(0x02);         //flash
    else if(modex==0)
        kernel_data.push(0x00);         //ram1
    else                                //ram2
        kernel_data.push(0x01);    

    for(int i=0;i<4;i++)
        kernel_data.push(p[i]);
    p = (unsigned char*)&final_address;
    if(mode == 3 or mode == 4)
    {
        for(int i=0;i<4;i++)
            kernel_data.push(p[i]);
    }
    else
        readKernel();    

    DCB dcb;
    com=CreateFileA(com_name,GENERIC_READ|GENERIC_WRITE,0,NULL,OPEN_EXISTING,0,NULL);
    if(com == INVALID_HANDLE_VALUE){
        printf("\n Can not open %s\n",com_name);
        return;
    }else{
        printf("connect successfully\n");
    }
    GetCommState(com,&dcb);
    dcb.BaudRate = 9600;
    dcb.ByteSize = 8;
    dcb.StopBits = ONESTOPBIT;
    SetCommState(com,&dcb);
    dcb.ByteSize = 8;
    dcb.Parity = ODDPARITY;//奇校验
    dcb.StopBits = ONESTOPBIT;
    dcb.fBinary = TRUE;
    dcb.fParity = FALSE;
    SetCommState(com,&dcb);

    if(mode==0 || mode == 1)
        send_com();
    else if(mode ==3 or mode == 4)
        read_com();
}

FlashAndRam::~FlashAndRam(){
    if(load_file!=NULL)
        fclose(load_file);
    if(store_file!=NULL)
        fclose(store_file);
}

void FlashAndRam::send_com(){
    unsigned char ch;
    DWORD size;
    printf("writing.....\n");
    int i=1;
    while(true){
        if(com==INVALID_HANDLE_VALUE){
            printf("COM lost\n");
            return;
        }
        if(kernel_data.size()>0){
            ch=kernel_data.front();
            ch=ch&0x00ff;
            size=0;
            //printf("%x\tsend %02x\n",i-5,ch);
            //if(i%0x1b60==0)
            //   Sleep(3000);
            while(size==0)
            {                
                WriteFile(com,&ch,1,&size,NULL);               
            }
            kernel_data.pop();
            i++;
        }else{
            printf("write successfully\n");
            return;
        }
        while(ch!=0x23){
            ReadFile(com,&ch,1,&size,NULL);            
         }
         //printf("recv %02x\n",ch);
    }
}

void FlashAndRam::read_com(){    
    unsigned char ch;
    DWORD size;
    send_com();
    if(file_name)
        readKernel();  
    for(unsigned int i=addr;i<f_addr;i++)
    {
        ReadFile(com,&ch,1,&size,NULL);
        if(mode == 3)
            printf("%02x ",ch);
        if(file_name)
        {            
            if(ch != kernel_data.front())
            {
                printf("\ncheck error in address %08x\n",i);
                printf("kernel_data: %02x\n",kernel_data.front());
                printf("error_data: %02x\n",ch);
                exit(-1);
            }
            kernel_data.pop();
        }
    }
    if(file_name)
        printf("\ncorrect!\n");
}

int FlashAndRam::readKernel(){
    printf("%s\n",file_name);
    if((load_file=fopen(file_name,"rb"))==NULL){
        printf("error in open %s\n",file_name);
        getch();
        exit(-1);
    }
    unsigned char* buf = new unsigned char[BUF_SIZE+1];
    int tot;
    int total_sum = 0;
    while((tot=fread(buf,1,BUF_SIZE,load_file))!=0)
    {        
        for(int i=0;i<tot;i++)
            kernel_data.push(buf[i]);
        total_sum+=tot;
    }

    delete[] buf;
    printf("file total size: %u bytes\n",total_sum);
    
    return total_sum;
}
