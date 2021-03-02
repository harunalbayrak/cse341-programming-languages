#ifndef __GPP_INTERPRETER_H__
#define __GPP_INTERPRETER_H__

struct Map {
    char* key;
    int value;
};

int* initialList(int num);
int* secondInitialList(int* list,int num);
int initialIdentifier(char* identf);
int setIdentifier(char* identf, int* list);
int* appendList(int* values, int* list);
int* concatList(int* list1, int* list2);
int* printList(int* list);
int additionList(int* list);
int substractionList(int* list);
int multiplicationList(int* list);
int divisionList(int* list);
int dbMultList(int* list);
int equalList(int* list);
int lessList(int* list);
int ifList(int boolean, int* list);
int ifList2(int boolean, int* list);
int ifList3(int boolean, int* list1, int* list3);
int forList(int for1, int for2, int* list);
void printList2(int* list);
void funcDefiniton1(int* list);
void funcDefiniton2(char* identf, int* list);
void funcDefiniton3(char* identf1, char* identf2,int* list);

#endif