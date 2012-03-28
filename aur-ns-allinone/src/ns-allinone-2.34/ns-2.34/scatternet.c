#include <stdio.h>
#include <string.h>
#define MASTER 'm'
#define SLAVE 's'
#define BRIDGE 'b'
//void tt();
struct nodeinfo
{
   int  node_id;
   int  addr;
  int  mobile_id;
   char type;
};

struct nodeinfo nodes[11];
 main()
{
int i,j,m[10],n,ip[10],k,no,pr[10],a,temp,b,c;
int id[12];
char ch;
int rn=0;
int bid[12]= {0,1,2,3,4,5,6,7,8,9,10};
int address[12]= {100,101,102,103,104,105,106,107,108,109,110};
  FILE *f1,*f2,*f3,*f4,*f5,*p1,*p2,*p3,*p4,*p5;
  int s=0;
  f1=fopen("type1","w");
  f2=fopen("type2","w");
  f3=fopen("ip","w");
  f4=fopen("type3","w");
  f5=fopen("type4","w");
  
printf("Create New (Y/N)=");
scanf("%c",&ch);
if (ch == 'Y') 
{
p1=fopen("pic","w");
for(i=0;i<=10;i++)
{
fprintf(p1,"%d\n",i);
}
fclose(p1);
s = i;
}
else
{
s=0;
p1 = fopen("pic","r");
while(!feof(p1))
{   
   fscanf(p1,"%d",rn);
   s = s + 1;  
} 
fclose(p1);
}
for(i=0;i<11;i++)
{
fprintf(f3,"%d\n",address[i]);
}

for(i=0;i<11;i++)
  {
     nodes[i].addr=address[i];
     nodes[i].mobile_id=bid[i];
     id[i]=i;
     nodes[i].node_id = id[i];
     if(i == 1 || i == 2 ||i == 3 || i == 4 || i ==6 || i == 7 || i==8 || i==9)
          nodes[i].type = SLAVE;
     else if(i == 0 || i == 10)
          nodes[i].type = MASTER;
     else if(i == 5 || i == 7)
          nodes[i].type = BRIDGE;
  }   
printf("node\t  mobile_id\t type\t ip address\n");
 

for(j=0;j<11;j++)
 {
    printf("%d\t%d\t\t",nodes[j].node_id,nodes[j].mobile_id);
    if(nodes[j].type == 'm')
        printf("MASTER\t");
    else if(nodes[j].type == 'b')
        printf("SLAVEBRIDGE\t");
    else if(nodes[j].type == 's')
        printf("SLAVE\t");
    printf("\t%d\n",nodes[j].addr);
  } 

//printf("\nEnter the mobile id of the intruder object:");
//scanf("%d",&m);


//if(m == 0 || m == 1 || m == 2 || m == 3 || m == 4 || m == 5 || m ==6 || m == 7 || m == 8 || m == 9 || m == 10)
//{
  printf("\nEnter the no of objects");
  scanf("%d",&no);
  fprintf(f5,"%d\n",no);
  p1 =fopen("pic","a+");
   for(k=0;k<no;k++)
  {   
//  printf("\nEnter the mobile id of the intruder object:");
//  scanf("%d",&m[k]);
  printf("\nEnter the ip address of intruder object:",k);
  scanf("%d",&ip[k]);
  printf("\nEnter the priority");
  scanf("%d",&pr[k]);
  printf("s = %d",s);
  fprintf(p1,"%d\n",s);
  s = s +1;
  }
  fclose(p1);
for(a=0;a<no;a++)
{
//   if(ip[a]==address[m[a]])
//   {
//   printf("\nIt is an object in the Network.\n");
//   fprintf(f4,"%d\n",m);
//   }
   for(b=a+1;b<no;b++)
     {
       if(pr[a]>pr[b])
	{
	  temp=ip[a];
          ip[a]=ip[b];
	  ip[b]=temp;
//          temp=m[b];
//          m[b]=m[b+1];
//          m[b+1]=temp;
          temp=pr[a];
          pr[a]=pr[b];
          pr[b]=temp;
        }
    }
}
for(b=0;b<no;b++)
{
//        fprintf(f2,"%d\n",m[b]);
        fprintf(f2,"%d\n",ip[b]);
        fprintf(f2,"%d\n",pr[b]);
     } 
   
//else
//{
//fprintf(f1,"%d\n",m);
//printf("\nName the device to be replaced by the intruder object(0-10)):");
//scanf("%d",&n);
//fprintf(f1,"%d\n",n);
//}

printf("Data transfer from which node to node pls enter the node from piconet to piconet");
printf("From node = ");
scanf("%d",&n);
fprintf(f5,"%d\n",n);
printf("\n To  node =");
scanf("%d",&n);
fprintf(f5,"%d\n",n);
printf("Run scatternet.tcl\n");
}


/*void tt()
{
printf("Run isao.tcl\n");
printf(".....\n");
}*/
