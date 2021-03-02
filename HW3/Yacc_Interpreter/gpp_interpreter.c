#include <stdio.h>    
#include <stdlib.h>    
#include <string.h>    
#include <ctype.h>
#include <math.h>
#include "gpp_interpreter.h"

struct Map* map = NULL;

int* initialList(int num){
    int *d = (int *) malloc(2*sizeof(int));
    d[0] = 1;
    d[1] = num;
    return d;
}

int* secondInitialList(int* list,int num){
    int *d = (int *) malloc((2+list[0])*sizeof(int));
    d[0] = list[0] + 1;
    int i = 1;
    while(i < d[0]){
        d[i] = list[i];
        i++;
    }
    d[i] = num;
    return d;
}

int initialIdentifier(char* identf){
    /*struct Map *d = (struct Map*)malloc(sizeof(struct Map));
    strcpy(d->key, identf);
    d->value = 0;*/  
}

int setIdentifier(char* identf, int* list){
    int i = 0;
    /*for(i=0;i<counter;i++){
        if(strcmp(_map[i].key, identf) == 0){
            _map[i].value = list[1];
            printf("%d",list[i]);
            return _map[i].value;
        }
    }
    _map[counter].key = identf; 
    _map[counter].value = 0;
    counter++;
    return _map[counter-1].value;*/
}

int* appendList(int* values, int* list){
    int *d = (int *) malloc((list[0]+1)*sizeof(int));
    d[0] = list[0] + 1;
    d[1] = values[1];

    int i = 2;
    while(i <= list[0]+1){
        d[i] = list[i-1];
        i++;
    }
    return d;
}

int* concatList(int* list1, int* list2){
    int *d = (int *) malloc((list1[0]+list2[0]+1)*sizeof(int));
    d[0] = list1[0] + list2[0];

    int i = 1;
    while(i <= list1[0]+1){
        d[i] = list1[i];
        i++;
    }

    i = 1;
    while(i <= list2[0]+1){
        d[i+list1[0]] = list2[i];
        i++;
    }
    return d;
}

int* printList(int *list){
    return list;
}

int additionList(int *list){
    int sum = 0;
    int i = 1;
    while(i <= list[0]){
        sum += list[i];
        i++;
    }
    return sum;
}

int substractionList(int *list){
    int sum = list[1];
    int i = 2;
    while(i <= list[0]){
        sum -= list[i];
        i++;
    }
    return sum;
}

int multiplicationList(int *list){
    int sum = list[1];
    int i = 2;
    while(i <= list[0]){
        sum *= list[i];
        i++;
    }
    return sum;
}

int divisionList(int *list){
    int sum = list[1];
    int i = 2;
    while(i <= list[0]){
        sum /= list[i];
        i++;
    }
    return sum;
}

int dbMultList(int *list){
    return (pow(list[1],list[2]));
}

int equalList(int *list){
    return list[1] == list[2];
}

int lessList(int *list){
    return list[1] < list[2];
}

int ifList(int boolean, int *list){
    if(list[0] == 1){
        if(boolean == 1){
            return list[1];
        } else{
            return 0;
        }
    } else if(list[0] == 2){
        if(boolean == 1){
            return list[1];
        } else{
            return list[2];
        }
    } else{
        return 0;
    }
}

int ifList2(int boolean, int *list){
    if(list[0] == 1){
        if(boolean == 1){
            return list[1];
        } else{
            return 0;
        }
    } else if(list[0] == 2){
        if(boolean == 1){
            return list[1];
        } else{
            return list[2];
        }
    } else{
        return 0;
    }
}

int ifList3(int boolean, int *list1, int *list2){
    if(boolean == 1){
        printList2(list1);
    } else{
        printList2(list2);
    }
    return 0;
}

int forList(int for1, int for2, int* list){
    int i = for1;
    if(for2 >= list[0]){
        printf("Error: Unexpected bounds(for) : %d %d\n",for1,for2);
        exit(-1);
    }
    for(i;i<for2;i++){
        printf("%d\n",list[i+1]);
    }
    return list[for2+1];
}

void printList2(int *list){
    int i = 1;
    if(list != NULL){
        printf("(");
        while(i < list[0]){
            printf("%d ",list[i]);
            i++;
        }
        printf("%d)",list[i]);
        printf("\n");
    } else {
        printf("()\n");
    }
}

void funcDefiniton1(int* list){
    printList2(list);
}

void funcDefiniton2(char* identf, int* list){
    printList2(list);
}

void funcDefiniton3(char* identf1, char* identf2,int* list){
    printList2(list);
}