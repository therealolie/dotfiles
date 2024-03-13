#include<stdio.h>
#include<stdlib.h>
#include<dirent.h>
#include<string.h>
#define bool int
#define true 1
#define false 0

struct strvec
{
	char str[100];
	struct strvec* next;
};

char* stradd(char*a,char*b)
{
	char*c=(char*)malloc(1+strlen(a)+strlen(b));
	strcpy(c,a);
	strcat(c,b);
	return c;
}

void fskiptoc(FILE*f,char c)
{
	char t;
	while((t=fgetc(f))!=EOF&&t!=c);
}

bool fscomp(FILE*f,char*s)
{
	char t;
	while((t=fgetc(f))!=EOF){
		if(t!=s[0])return false;
		s++;
		if(!s[0])return true;
	}
	return t==EOF;
}

struct strvec process_file(struct strvec entries, FILE* file)
{
	char c;
	char name[100] = "";
	bool displayed=true;
#define cont {fskiptoc(file,'\n');continue;}
	/*
	*/
	while((c=fgetc(file)) != EOF){
		if(c=='\n')
			continue;
		if(c=='#')
			cont;
		if(c=='['){
			if(fscomp(file,"Desktop Entry"))
				cont;
			fskiptoc(file,'[');
			fseek(file,-1,SEEK_CUR);
			continue;
		}
		if(c!='N')
			cont;
		c = fgetc(file);
		if(c == 'o'){
			if(!fscomp(file,"Display="))
				cont;
			c = fgetc(file);
			if(c == 't')
				displayed = false;
			cont;
		}
		if(!fscomp(file,"me="))
			cont;
		if(name[0])
			cont;
		fgets(name, 100, file);
		name[strlen(name)-1] = '\0';
	}
#undef cont
	struct strvec* it = &entries;
	if(displayed){
		while(strcmp(it->str,name)){
			if(it->str[0]){
				it=it->next;
				continue;
			}
			strcpy(it->str, name);
			it->next = malloc(sizeof(struct strvec));
			it->next->str[0] = '\0';
		}
		return entries;
	}
	while(it->next){
		if(!strcmp(it->next->str, name)){
			struct strvec*tmp = it->next->next;
			free(it->next);
			it->next = tmp;
			break;
		}
		it=it->next;
	}
	return entries;

}

int main()
{
	char* DIRS[3];
	const char* HOME = getenv("HOME");
	const char* POSTFIX = ".desktop";
	DIRS[0] = "/usr/share/applications/";
	DIRS[1] = "/var/lib/flatpak/exports/share/applications/";
	DIRS[2] = stradd(HOME,"/.local/share/applications/");
	struct strvec entries;
	entries.str[0] = '\1';
	entries.str[1] = '\0';
	entries.next = malloc(sizeof(struct strvec));
	entries.next->str[0] = '\0';
	int postfix_len = strlen(POSTFIX);
	for(int i=0;i<3;i++){
		DIR*dir=opendir(DIRS[i]);
		if(dir==NULL)continue;
		struct dirent*de;
		while((de=readdir(dir))!=NULL){
			bool postfix_matches = true;
			int len = strlen(de->d_name);
			for(int i = 0; i < postfix_len; i++){
				if(de->d_name[i + len - postfix_len] == POSTFIX[i])
					continue;
				postfix_matches=false;
				break;
			}
			if(!postfix_matches)
				continue;
			FILE* file = fopen(stradd(DIRS[i], de->d_name), "r");
			if(file == NULL)
				continue;
			//printf("f: %s\n",de->d_name);
			entries = process_file(entries, file);
		}
	}
	struct strvec*it = entries.next;
	while(it->next){
		printf("%s\n",it->str);
		it=it->next;
	}
}
