#include<stdio.h>
#include<stdlib.h>
#include<dirent.h>
#include<string.h>
#define bool int
#define true 1
#define false 0

struct strvec{
	char str[100];
	struct strvec* next;
};

char* stradd(char*a,char*b){
	char*c=(char*)malloc(1+strlen(a)+strlen(b));
	strcpy(c,a);
	strcat(c,b);
	return c;
}
void fskiptoc(FILE*f,char c){
	char t;
	while((t=fgetc(f))!=EOF&&t!=c);
}
bool fscomp(FILE*f,char*s){
	char t;
	while((t=fgetc(f))!=EOF){
		if(t!=s[0])return false;
		s++;
		if(!s[0])return true;
	}
	return t==EOF;
}
int main(){
	char**DIRS=(char**)malloc(3*sizeof(char*));
	char*HOME=getenv("HOME");
	const char*POSTFIX=".desktop";
	DIRS[0]="/usr/share/applications/";
	DIRS[1]="/var/lib/flatpak/exports/share/applications/";
	DIRS[2]=stradd(HOME,"/.local/share/applications/");
	int postfix_len=strlen(POSTFIX);
	
	char input[100];
	fgets(input,100,stdin);
	for(int i=0;i<3;i++){
		DIR*dir=opendir(DIRS[i]);
		if(dir==NULL)continue;
		struct dirent*de;
		while((de=readdir(dir))!=NULL){
			bool postfix_matches=true;
			int len=strlen(de->d_name);
			for(int i=0;i<postfix_len;i++){
				if(de->d_name[i+len-postfix_len]==POSTFIX[i])continue;
				postfix_matches=false;
				break;
			}
			if(!postfix_matches)continue;
			FILE*file=fopen(stradd(DIRS[i],de->d_name),"r");
			if(file==NULL)continue;
			char c;
			char name[100];
#define cont {fskiptoc(file,'\n');continue;}
			//printf("%s\n",de->d_name);
			while((c=fgetc(file))!=EOF){
				if(c=='\n')continue;
				if(c=='#') cont;
				if(c=='['){
					if(fscomp(file,"Desktop Entry")) cont;
					fskiptoc(file,'[');
					fseek(file,-1,SEEK_CUR);
					continue;
				}
				if(c!='N') cont;
				if(!fscomp(file,"ame=")) cont;
				fgets(name, 100, file);
				if(!strcmp(name,input)){
					printf("%s%s\n",DIRS[i],de->d_name);
					return 0;
				}
			}
#undef cont
		}
	}
}
